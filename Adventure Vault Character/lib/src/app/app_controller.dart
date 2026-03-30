import 'dart:async';

import 'package:adventure_vault_character/src/core/navigation/app_screen.dart';
import 'package:adventure_vault_character/src/features/characters/data/character_repository.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_draft_validator.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:adventure_vault_character/src/features/characters/domain/editable_character.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_summary.dart';
import 'package:adventure_vault_character/src/features/characters/presentation/character_editor_controller.dart';
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
    required this.selectedEditableCharacter,
    required this.characterEditorController,
    this.errorMessage,
  });

  const AppState.initial()
    : screen = AppScreen.bootstrap,
      isInitializing = true,
      isSavingCharacter = false,
      characterSummaries = const <CharacterSummary>[],
      compendiumCatalog = null,
      selectedCharacterSheet = null,
      selectedEditableCharacter = null,
      characterEditorController = null,
      errorMessage = null;

  final AppScreen screen;
  final bool isInitializing;
  final bool isSavingCharacter;
  final List<CharacterSummary> characterSummaries;
  final CompendiumCatalog? compendiumCatalog;
  final CharacterDomainModel? selectedCharacterSheet;
  final EditableCharacter? selectedEditableCharacter;
  final CharacterEditorController? characterEditorController;
  final String? errorMessage;

  AppState copyWith({
    AppScreen? screen,
    bool? isInitializing,
    bool? isSavingCharacter,
    List<CharacterSummary>? characterSummaries,
    CompendiumCatalog? compendiumCatalog,
    CharacterDomainModel? selectedCharacterSheet,
    EditableCharacter? selectedEditableCharacter,
    CharacterEditorController? characterEditorController,
    String? errorMessage,
    bool clearSelectedCharacter = false,
    bool clearSelectedEditableCharacter = false,
    bool clearCharacterEditorController = false,
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
      selectedEditableCharacter: clearSelectedEditableCharacter
          ? null
          : selectedEditableCharacter ?? this.selectedEditableCharacter,
      characterEditorController: clearCharacterEditorController
          ? null
          : characterEditorController ?? this.characterEditorController,
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
        errorMessage: 'Failed to load local app state.',
      );
    }

    notifyListeners();
  }

  void continueOffline() {
    _state = _state.copyWith(screen: AppScreen.mainMenu, clearError: true);
    notifyListeners();
  }

  void openCompendium() {
    _disposeCharacterEditorController();
    _state = _state.copyWith(
      screen: AppScreen.compendium,
      clearSelectedCharacter: true,
      clearSelectedEditableCharacter: true,
      clearCharacterEditorController: true,
      clearError: true,
    );
    notifyListeners();
  }

  void openCompendiumPacks() {
    _disposeCharacterEditorController();
    _state = _state.copyWith(
      screen: AppScreen.compendiumPacks,
      clearSelectedCharacter: true,
      clearSelectedEditableCharacter: true,
      clearCharacterEditorController: true,
      clearError: true,
    );
    notifyListeners();
  }

  void openCompendiumImport() {
    _disposeCharacterEditorController();
    _state = _state.copyWith(
      screen: AppScreen.compendiumImport,
      clearSelectedCharacter: true,
      clearSelectedEditableCharacter: true,
      clearCharacterEditorController: true,
      clearError: true,
    );
    notifyListeners();
  }

  void openCreateCharacter() {
    _disposeCharacterEditorController();
    _state = _state.copyWith(
      screen: AppScreen.createCharacter,
      clearSelectedCharacter: true,
      clearSelectedEditableCharacter: true,
      clearCharacterEditorController: true,
      clearError: true,
    );
    notifyListeners();
  }

  void openMainMenu() {
    _disposeCharacterEditorController();
    _state = _state.copyWith(
      screen: AppScreen.mainMenu,
      clearSelectedCharacter: true,
      clearSelectedEditableCharacter: true,
      clearCharacterEditorController: true,
      clearError: true,
    );
    notifyListeners();
  }

  Future<void> setCompendiumPackActive(String packId, bool isActive) async {
    final catalog = _state.compendiumCatalog;
    if (catalog == null) {
      return;
    }

    try {
      final updatedCatalog = await _compendiumRepository.setPackActive(
        packId,
        isActive,
      );
      _state = _state.copyWith(
        compendiumCatalog: updatedCatalog,
        clearError: true,
      );
    } catch (_) {
      _state = _state.copyWith(
        errorMessage: 'Failed to update local pack state.',
      );
    }

    notifyListeners();
  }

  Future<String?> importCompendiumXml(String rawXml) async {
    try {
      final updatedCatalog = await _compendiumRepository.importXmlPack(rawXml);
      _state = _state.copyWith(
        compendiumCatalog: updatedCatalog,
        clearError: true,
      );
      notifyListeners();
      return null;
    } on FormatException catch (error) {
      final message = error.message;
      _state = _state.copyWith(errorMessage: message);
      notifyListeners();
      return message;
    } catch (_) {
      const message = 'Failed to register XML content locally.';
      _state = _state.copyWith(errorMessage: message);
      notifyListeners();
      return message;
    }
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
      _disposeCharacterEditorController();
      final sheet = await _characterRepository
          .watchCharacterSheetById(created.id)
          .first;
      _subscribeToSelectedCharacter(created.id);

      _state = _state.copyWith(
        screen: AppScreen.characterSheet,
        isSavingCharacter: false,
        selectedCharacterSheet: sheet,
        clearSelectedEditableCharacter: true,
        clearCharacterEditorController: true,
        clearError: true,
      );
    } catch (_) {
      _state = _state.copyWith(
        isSavingCharacter: false,
        errorMessage: 'Failed to save the character locally.',
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
          errorMessage: 'The selected character no longer exists.',
        );
      } else {
        _disposeCharacterEditorController();
        _subscribeToSelectedCharacter(characterId);
        _state = _state.copyWith(
          screen: AppScreen.characterSheet,
          selectedCharacterSheet: character,
          clearSelectedEditableCharacter: true,
          clearCharacterEditorController: true,
          clearError: true,
        );
      }
    } catch (_) {
      _state = _state.copyWith(
        errorMessage: 'Failed to open the selected character.',
      );
    }

    notifyListeners();
  }

  Future<void> loadEditableCharacter(String characterId) async {
    try {
      final editableCharacter = await _characterRepository
          .getEditableCharacterById(characterId);

      if (editableCharacter == null) {
        _disposeCharacterEditorController();
        _state = _state.copyWith(
          errorMessage: 'The selected character is no longer available.',
          clearSelectedEditableCharacter: true,
          clearCharacterEditorController: true,
        );
      } else {
        _disposeCharacterEditorController();
        _state = _state.copyWith(
          screen: AppScreen.editCharacter,
          selectedEditableCharacter: editableCharacter,
          characterEditorController: CharacterEditorController(
            characterId: characterId,
            catalog: _state.compendiumCatalog!,
            editableCharacter: editableCharacter,
          ),
          clearError: true,
        );
      }
    } catch (_) {
      _disposeCharacterEditorController();
      _state = _state.copyWith(
        errorMessage:
            'The selected character could not be prepared for editing.',
        clearSelectedEditableCharacter: true,
        clearCharacterEditorController: true,
      );
    }

    notifyListeners();
  }

  Future<void> saveEditedCharacter(CreateCharacterInput input) async {
    final editorController = _state.characterEditorController;
    if (editorController == null) {
      _state = _state.copyWith(
        errorMessage: 'No editable character is currently loaded.',
      );
      notifyListeners();
      return;
    }

    editorController.replaceDraft(input);
    _state = _state.copyWith(isSavingCharacter: true, clearError: true);
    notifyListeners();

    try {
      await _characterRepository.updateCharacter(
        editorController.characterId,
        input,
      );
      await _selectedCharacterSubscription?.cancel();
      _selectedCharacterSubscription = null;
      final sheet = await _characterRepository
          .watchCharacterSheetById(editorController.characterId)
          .first;

      if (sheet == null) {
        _state = _state.copyWith(
          isSavingCharacter: false,
          errorMessage: 'The selected character is no longer available.',
          clearSelectedEditableCharacter: true,
          clearCharacterEditorController: true,
        );
      } else {
        _subscribeToSelectedCharacter(editorController.characterId);
        _disposeCharacterEditorController();
        _state = _state.copyWith(
          screen: AppScreen.characterSheet,
          isSavingCharacter: false,
          selectedCharacterSheet: sheet,
          clearSelectedEditableCharacter: true,
          clearCharacterEditorController: true,
          clearError: true,
        );
      }
    } catch (_) {
      _state = _state.copyWith(
        isSavingCharacter: false,
        errorMessage: 'The character could not be updated locally.',
      );
    }

    notifyListeners();
  }

  @override
  void dispose() {
    _disposeCharacterEditorController();
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

  void _disposeCharacterEditorController() {
    _state.characterEditorController?.dispose();
  }
}
