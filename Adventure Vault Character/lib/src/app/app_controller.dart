import 'package:adventure_vault_character/src/core/navigation/app_screen.dart';
import 'package:adventure_vault_character/src/features/characters/data/character_repository.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_summary.dart';
import 'package:flutter/foundation.dart';

@immutable
class AppState {
  const AppState({
    required this.screen,
    required this.isInitializing,
    required this.isSavingCharacter,
    required this.characterSummaries,
    required this.selectedCharacter,
    this.errorMessage,
  });

  const AppState.initial()
      : screen = AppScreen.bootstrap,
        isInitializing = true,
        isSavingCharacter = false,
        characterSummaries = const <CharacterSummary>[],
        selectedCharacter = null,
        errorMessage = null;

  final AppScreen screen;
  final bool isInitializing;
  final bool isSavingCharacter;
  final List<CharacterSummary> characterSummaries;
  final CharacterSummary? selectedCharacter;
  final String? errorMessage;

  AppState copyWith({
    AppScreen? screen,
    bool? isInitializing,
    bool? isSavingCharacter,
    List<CharacterSummary>? characterSummaries,
    CharacterSummary? selectedCharacter,
    String? errorMessage,
    bool clearSelectedCharacter = false,
    bool clearError = false,
  }) {
    return AppState(
      screen: screen ?? this.screen,
      isInitializing: isInitializing ?? this.isInitializing,
      isSavingCharacter: isSavingCharacter ?? this.isSavingCharacter,
      characterSummaries: characterSummaries ?? this.characterSummaries,
      selectedCharacter: clearSelectedCharacter
          ? null
          : selectedCharacter ?? this.selectedCharacter,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}

class AppController extends ChangeNotifier {
  AppController({required CharacterRepository characterRepository})
      : _characterRepository = characterRepository;

  final CharacterRepository _characterRepository;

  AppState _state = const AppState.initial();

  AppState get state => _state;

  Future<void> initialize() async {
    _state = _state.copyWith(isInitializing: true, clearError: true);
    notifyListeners();

    try {
      final summaries = await _characterRepository.getCharacterSummaries();
      _state = _state.copyWith(
        screen: AppScreen.access,
        isInitializing: false,
        characterSummaries: summaries,
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
    _state = _state.copyWith(isSavingCharacter: true, clearError: true);
    notifyListeners();

    try {
      final created = await _characterRepository.createCharacter(input);
      final summaries = await _characterRepository.getCharacterSummaries();

      _state = _state.copyWith(
        screen: AppScreen.characterSheet,
        isSavingCharacter: false,
        characterSummaries: summaries,
        selectedCharacter: created,
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
      final character = await _characterRepository.getCharacterSummaryById(
        characterId,
      );

      if (character == null) {
        _state = _state.copyWith(
          errorMessage: 'El personaje seleccionado ya no existe.',
        );
      } else {
        _state = _state.copyWith(
          screen: AppScreen.characterSheet,
          selectedCharacter: character,
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
}
