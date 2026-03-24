import 'dart:async';

import 'package:adventure_vault_character/src/core/navigation/app_screen.dart';
import 'package:adventure_vault_character/src/features/characters/data/character_repository.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_draft_validator.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_summary.dart';
import 'package:adventure_vault_character/src/features/compendium/data/compendium_repository.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';
import 'package:flutter/foundation.dart';

@immutable
class AppState {
  const AppState({
    required this.screen,
    required this.isInitializing,
    required this.isSavingCharacter,
    required this.characterSummaries,
    required this.compendiumCatalog,
    required this.selectedCharacterSheet,
    this.errorMessage,
  });

  const AppState.initial()
    : screen = AppScreen.bootstrap,
      isInitializing = true,
      isSavingCharacter = false,
      characterSummaries = const <CharacterSummary>[],
      compendiumCatalog = null,
      selectedCharacterSheet = null,
      errorMessage = null;

  final AppScreen screen;
  final bool isInitializing;
  final bool isSavingCharacter;
  final List<CharacterSummary> characterSummaries;
  final CompendiumCatalog? compendiumCatalog;
  final CharacterDomainModel? selectedCharacterSheet;
  final String? errorMessage;

  AppState copyWith({
    AppScreen? screen,
    bool? isInitializing,
    bool? isSavingCharacter,
    List<CharacterSummary>? characterSummaries,
    CompendiumCatalog? compendiumCatalog,
    CharacterDomainModel? selectedCharacterSheet,
    String? errorMessage,
    bool clearSelectedCharacter = false,
    bool clearError = false,
  }) {
    return AppState(
      screen: screen ?? this.screen,
      isInitializing: isInitializing ?? this.isInitializing,
      isSavingCharacter: isSavingCharacter ?? this.isSavingCharacter,
      characterSummaries: characterSummaries ?? this.characterSummaries,
      compendiumCatalog: compendiumCatalog ?? this.compendiumCatalog,
      selectedCharacterSheet: clearSelectedCharacter
          ? null
          : selectedCharacterSheet ?? this.selectedCharacterSheet,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}

class AppController extends ChangeNotifier {
  AppController({
    required CharacterRepository characterRepository,
    required CompendiumRepository compendiumRepository,
    CharacterDraftValidator characterDraftValidator =
        const CharacterDraftValidator(),
  }) : _characterRepository = characterRepository,
       _compendiumRepository = compendiumRepository,
       _characterDraftValidator = characterDraftValidator;

  final CharacterRepository _characterRepository;
  final CompendiumRepository _compendiumRepository;
  final CharacterDraftValidator _characterDraftValidator;
  StreamSubscription<List<CharacterSummary>>? _characterSummariesSubscription;
  StreamSubscription<CharacterDomainModel?>? _selectedCharacterSubscription;

  AppState _state = const AppState.initial();

  AppState get state => _state;

  Future<void> initialize() async {
    _state = _state.copyWith(isInitializing: true, clearError: true);
    notifyListeners();

    try {
      final compendiumCatalog = await _compendiumRepository.loadCatalog();
      final summaries = await _characterRepository
          .watchCharacterSummaries()
          .first;
      _subscribeToCharacterSummaries();
      _state = _state.copyWith(
        screen: AppScreen.access,
        isInitializing: false,
        characterSummaries: summaries,
        compendiumCatalog: compendiumCatalog,
        clearError: true,
      );
    } catch (_) {
      _state = _state.copyWith(
        isInitializing: false,
        errorMessage: 'No se pudo cargar el estado local de la app.',
      );
    }

    notifyListeners();
  }

  void continueOffline() {
    _state = _state.copyWith(screen: AppScreen.mainMenu, clearError: true);
    notifyListeners();
  }

  void openCreateCharacter() {
    _state = _state.copyWith(
      screen: AppScreen.createCharacter,
      clearSelectedCharacter: true,
      clearError: true,
    );
    notifyListeners();
  }

  void openMainMenu() {
    _state = _state.copyWith(
      screen: AppScreen.mainMenu,
      clearSelectedCharacter: true,
      clearError: true,
    );
    notifyListeners();
  }

  Future<void> createCharacter(CreateCharacterInput input) async {
    final validation = _characterDraftValidator.validate(input);
    if (!validation.isValid) {
      _state = _state.copyWith(errorMessage: validation.toUserMessage());
      notifyListeners();
      return;
    }

    _state = _state.copyWith(isSavingCharacter: true, clearError: true);
    notifyListeners();

    try {
      final created = await _characterRepository.createCharacter(input);
      await _selectedCharacterSubscription?.cancel();
      _selectedCharacterSubscription = null;
      final sheet = await _characterRepository
          .watchCharacterSheetById(created.id)
          .first;
      _subscribeToSelectedCharacter(created.id);

      _state = _state.copyWith(
        screen: AppScreen.characterSheet,
        isSavingCharacter: false,
        selectedCharacterSheet: sheet,
        clearError: true,
      );
    } catch (_) {
      _state = _state.copyWith(
        isSavingCharacter: false,
        errorMessage: 'No se pudo guardar el personaje localmente.',
      );
    }

    notifyListeners();
  }

  Future<void> openCharacter(String characterId) async {
    try {
      final character = await _characterRepository
          .watchCharacterSheetById(characterId)
          .first;

      if (character == null) {
        _state = _state.copyWith(
          errorMessage: 'El personaje seleccionado ya no existe.',
        );
      } else {
        _subscribeToSelectedCharacter(characterId);
        _state = _state.copyWith(
          screen: AppScreen.characterSheet,
          selectedCharacterSheet: character,
          clearError: true,
        );
      }
    } catch (_) {
      _state = _state.copyWith(
        errorMessage: 'No se pudo abrir el personaje seleccionado.',
      );
    }

    notifyListeners();
  }

  @override
  void dispose() {
    unawaited(_characterSummariesSubscription?.cancel());
    unawaited(_selectedCharacterSubscription?.cancel());
    super.dispose();
  }

  void _subscribeToCharacterSummaries() {
    unawaited(_characterSummariesSubscription?.cancel());
    _characterSummariesSubscription = _characterRepository
        .watchCharacterSummaries()
        .listen((summaries) {
          _state = _state.copyWith(characterSummaries: summaries);
          notifyListeners();
        });
  }

  void _subscribeToSelectedCharacter(String characterId) {
    unawaited(_selectedCharacterSubscription?.cancel());
    _selectedCharacterSubscription = _characterRepository
        .watchCharacterSheetById(characterId)
        .listen((character) {
          if (character == null) {
            return;
          }

          _state = _state.copyWith(selectedCharacterSheet: character);
          notifyListeners();
        });
  }
}
