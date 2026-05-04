import 'dart:async';

import 'package:adventure_vault_character/src/core/navigation/app_screen.dart';
import 'package:adventure_vault_character/src/features/characters/data/character_repository.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_draft_validator.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_inventory_validation_error.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:adventure_vault_character/src/features/characters/domain/editable_character.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_summary.dart';
import 'package:adventure_vault_character/src/features/characters/presentation/character_editor_controller.dart';
import 'package:adventure_vault_character/src/features/compendium/data/compendium_repository.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';
import 'package:adventure_vault_character/src/features/settings/data/system_settings_repository.dart';
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
    required this.isSavingSettings,
    required this.includeCoinWeightInEncumbrance,
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
      isSavingSettings = false,
      includeCoinWeightInEncumbrance = false,
      errorMessage = null;

  final AppScreen screen;
  final bool isInitializing;
  final bool isSavingCharacter;
  final List<CharacterSummary> characterSummaries;
  final CompendiumCatalog? compendiumCatalog;
  final CharacterDomainModel? selectedCharacterSheet;
  final EditableCharacter? selectedEditableCharacter;
  final CharacterEditorController? characterEditorController;
  final bool isSavingSettings;
  final bool includeCoinWeightInEncumbrance;
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
    bool? isSavingSettings,
    bool? includeCoinWeightInEncumbrance,
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
      isSavingSettings: isSavingSettings ?? this.isSavingSettings,
      includeCoinWeightInEncumbrance:
          includeCoinWeightInEncumbrance ?? this.includeCoinWeightInEncumbrance,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}

class AppController extends ChangeNotifier {
  AppController({
    required CharacterRepository characterRepository,
    required CompendiumRepository compendiumRepository,
    required SystemSettingsRepository systemSettingsRepository,
    CharacterDraftValidator characterDraftValidator =
        const CharacterDraftValidator(),
  }) : _characterRepository = characterRepository,
       _compendiumRepository = compendiumRepository,
       _systemSettingsRepository = systemSettingsRepository,
       _characterDraftValidator = characterDraftValidator;

  final CharacterRepository _characterRepository;
  final CompendiumRepository _compendiumRepository;
  final SystemSettingsRepository _systemSettingsRepository;
  final CharacterDraftValidator _characterDraftValidator;
  StreamSubscription<List<CharacterSummary>>? _characterSummariesSubscription;
  StreamSubscription<CharacterDomainModel?>? _selectedCharacterSubscription;
  bool _isFullCompendiumCatalogLoaded = false;

  AppState _state = const AppState.initial();

  AppState get state => _state;

  Future<void> initialize() async {
    _state = _state.copyWith(isInitializing: true, clearError: true);
    notifyListeners();

    try {
      final compendiumCatalog = await _compendiumRepository
          .loadStartupCatalog();
      final includeCoinWeightInEncumbrance = await _systemSettingsRepository
          .getIncludeCoinWeightInEncumbrance();
      final summaries = await _characterRepository
          .watchCharacterSummaries()
          .first;
      _subscribeToCharacterSummaries();
      _state = _state.copyWith(
        screen: AppScreen.access,
        isInitializing: false,
        characterSummaries: summaries,
        compendiumCatalog: compendiumCatalog,
        includeCoinWeightInEncumbrance: includeCoinWeightInEncumbrance,
        clearError: true,
      );
      _isFullCompendiumCatalogLoaded = false;
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

  Future<void> openCompendium() async {
    if (!await _ensureFullCompendiumCatalogLoaded()) {
      return;
    }
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

  void openSettings() {
    _disposeCharacterEditorController();
    _state = _state.copyWith(
      screen: AppScreen.settings,
      clearSelectedCharacter: true,
      clearSelectedEditableCharacter: true,
      clearCharacterEditorController: true,
      clearError: true,
    );
    notifyListeners();
  }

  Future<void> openCompendiumPacks() async {
    if (!await _ensureFullCompendiumCatalogLoaded()) {
      return;
    }
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

  Future<void> openCompendiumImport() async {
    if (!await _ensureFullCompendiumCatalogLoaded()) {
      return;
    }
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

  Future<void> openCreateCharacter() async {
    if (!await _ensureFullCompendiumCatalogLoaded()) {
      return;
    }
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
    if (!await _ensureFullCompendiumCatalogLoaded()) {
      return;
    }
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
    if (!await _ensureFullCompendiumCatalogLoaded()) {
      return _state.errorMessage ??
          'Failed to prepare compendium data for import.';
    }

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
    if (!await _ensureFullCompendiumCatalogLoaded()) {
      return;
    }

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

  Future<void> applyShortRestToSelectedCharacter() async {
    final selected = _state.selectedCharacterSheet;
    if (selected == null) {
      _state = _state.copyWith(
        errorMessage: 'No character is currently selected.',
      );
      notifyListeners();
      return;
    }

    _state = _state.copyWith(isSavingCharacter: true, clearError: true);
    notifyListeners();

    try {
      await _characterRepository.applyShortRest(selected.id);
      _state = _state.copyWith(isSavingCharacter: false, clearError: true);
    } catch (_) {
      _state = _state.copyWith(
        isSavingCharacter: false,
        errorMessage: 'Failed to apply short rest recovery.',
      );
    }

    notifyListeners();
  }

  Future<void> applyLongRestToSelectedCharacter() async {
    final selected = _state.selectedCharacterSheet;
    if (selected == null) {
      _state = _state.copyWith(
        errorMessage: 'No character is currently selected.',
      );
      notifyListeners();
      return;
    }

    _state = _state.copyWith(isSavingCharacter: true, clearError: true);
    notifyListeners();

    try {
      await _characterRepository.applyLongRest(selected.id);
      _state = _state.copyWith(isSavingCharacter: false, clearError: true);
    } catch (_) {
      _state = _state.copyWith(
        isSavingCharacter: false,
        errorMessage: 'Failed to apply long rest recovery.',
      );
    }

    notifyListeners();
  }

  Future<void> setSelectedCharacterClassResourceUses(
    String resourceKey,
    int currentUses,
  ) async {
    final selected = _state.selectedCharacterSheet;
    if (selected == null) {
      _state = _state.copyWith(
        errorMessage: 'No character is currently selected.',
      );
      notifyListeners();
      return;
    }

    _state = _state.copyWith(isSavingCharacter: true, clearError: true);
    notifyListeners();

    try {
      await _characterRepository.setClassResourceUses(
        selected.id,
        resourceKey,
        currentUses,
      );
      _state = _state.copyWith(isSavingCharacter: false, clearError: true);
    } on StateError catch (error) {
      _state = _state.copyWith(
        isSavingCharacter: false,
        errorMessage: _stateErrorMessage(
          error,
          fallback: 'Failed to update class resource usage.',
        ),
      );
    } catch (_) {
      _state = _state.copyWith(
        isSavingCharacter: false,
        errorMessage: 'Failed to update class resource usage.',
      );
    }

    notifyListeners();
  }

  Future<void> spendSelectedCharacterSpellSlot({
    required int spellLevel,
    required int slotIndex,
  }) async {
    final selected = _state.selectedCharacterSheet;
    if (selected == null) {
      _state = _state.copyWith(
        errorMessage: 'No character is currently selected.',
      );
      notifyListeners();
      return;
    }

    _state = _state.copyWith(isSavingCharacter: true, clearError: true);
    notifyListeners();

    try {
      await _characterRepository.spendSpellSlot(
        selected.id,
        spellLevel: spellLevel,
        slotIndex: slotIndex,
      );
      final refreshed = await _characterRepository.getCharacterSheetById(
        selected.id,
      );
      _state = _state.copyWith(
        isSavingCharacter: false,
        selectedCharacterSheet: refreshed ?? selected,
        clearError: true,
      );
    } on StateError catch (error) {
      _state = _state.copyWith(
        isSavingCharacter: false,
        errorMessage: _stateErrorMessage(
          error,
          fallback: 'Failed to spend spell slot.',
        ),
      );
    } catch (_) {
      _state = _state.copyWith(
        isSavingCharacter: false,
        errorMessage: 'Failed to spend spell slot.',
      );
    }

    notifyListeners();
  }

  Future<void> restoreSelectedCharacterSpellSlot({
    required int spellLevel,
    required int slotIndex,
  }) async {
    final selected = _state.selectedCharacterSheet;
    if (selected == null) {
      _state = _state.copyWith(
        errorMessage: 'No character is currently selected.',
      );
      notifyListeners();
      return;
    }

    _state = _state.copyWith(isSavingCharacter: true, clearError: true);
    notifyListeners();

    try {
      await _characterRepository.restoreSpellSlot(
        selected.id,
        spellLevel: spellLevel,
        slotIndex: slotIndex,
      );
      final refreshed = await _characterRepository.getCharacterSheetById(
        selected.id,
      );
      _state = _state.copyWith(
        isSavingCharacter: false,
        selectedCharacterSheet: refreshed ?? selected,
        clearError: true,
      );
    } on StateError catch (error) {
      _state = _state.copyWith(
        isSavingCharacter: false,
        errorMessage: _stateErrorMessage(
          error,
          fallback: 'Failed to restore spell slot.',
        ),
      );
    } catch (_) {
      _state = _state.copyWith(
        isSavingCharacter: false,
        errorMessage: 'Failed to restore spell slot.',
      );
    }

    notifyListeners();
  }

  Future<void> recordSelectedCharacterDeathSaveSuccess() async {
    await _updateSelectedCharacterDeathSaves((id) {
      return _characterRepository.recordDeathSaveSuccess(id);
    });
  }

  Future<void> recordSelectedCharacterDeathSaveFailure() async {
    await _updateSelectedCharacterDeathSaves((id) {
      return _characterRepository.recordDeathSaveFailure(id);
    });
  }

  Future<void> resetSelectedCharacterDeathSaves() async {
    await _updateSelectedCharacterDeathSaves((id) {
      return _characterRepository.resetDeathSaves(id);
    });
  }

  Future<void> setSelectedCharacterInventoryItemEquipped(
    String inventoryItemId,
    bool isEquipped,
  ) async {
    await _updateSelectedCharacterInventory(
      inventoryItemId,
      (id) => _characterRepository.setInventoryItemEquipped(
        id,
        inventoryItemId,
        isEquipped,
      ),
    );
  }

  Future<void> setSelectedCharacterInventoryItemCarried(
    String inventoryItemId,
    bool isCarried,
  ) async {
    await _updateSelectedCharacterInventory(
      inventoryItemId,
      (id) => _characterRepository.setInventoryItemCarried(
        id,
        inventoryItemId,
        isCarried,
      ),
    );
  }

  Future<void> setSelectedCharacterInventoryItemQuantity(
    String inventoryItemId,
    int quantity,
  ) async {
    await _updateSelectedCharacterInventory(
      inventoryItemId,
      (id) => _characterRepository.setInventoryItemQuantity(
        id,
        inventoryItemId,
        quantity,
      ),
    );
  }

  Future<void> spendSelectedCharacterInventoryItemQuantity(
    String inventoryItemId, {
    int amount = 1,
  }) async {
    await _updateSelectedCharacterInventory(
      inventoryItemId,
      (id) => _characterRepository.spendInventoryItemQuantity(
        id,
        inventoryItemId,
        amount: amount,
      ),
    );
  }

  Future<void> setSelectedCharacterInventoryItemCharges(
    String inventoryItemId, {
    int? chargesCurrent,
    int? chargesMax,
  }) async {
    await _updateSelectedCharacterInventory(
      inventoryItemId,
      (id) => _characterRepository.setInventoryItemCharges(
        id,
        inventoryItemId,
        chargesCurrent: chargesCurrent,
        chargesMax: chargesMax,
      ),
    );
  }

  Future<void> setSelectedCharacterInventoryItemContainer(
    String inventoryItemId,
    String? containerInventoryItemId,
  ) async {
    await _updateSelectedCharacterInventory(
      inventoryItemId,
      (id) => _characterRepository.setInventoryItemContainer(
        id,
        inventoryItemId,
        containerInventoryItemId,
      ),
    );
  }

  Future<void> setIncludeCoinWeightInEncumbrance(bool value) async {
    _state = _state.copyWith(isSavingSettings: true, clearError: true);
    notifyListeners();

    try {
      await _systemSettingsRepository.setIncludeCoinWeightInEncumbrance(value);
      _state = _state.copyWith(
        isSavingSettings: false,
        includeCoinWeightInEncumbrance: value,
        clearError: true,
      );
    } catch (_) {
      _state = _state.copyWith(
        isSavingSettings: false,
        errorMessage: 'Failed to update system settings.',
      );
    }

    notifyListeners();
  }

  Future<void> _updateSelectedCharacterInventory(
    String inventoryItemId,
    Future<void> Function(String characterId) update,
  ) async {
    final selected = _state.selectedCharacterSheet;
    if (selected == null) {
      _state = _state.copyWith(
        errorMessage: 'No character is currently selected.',
      );
      notifyListeners();
      return;
    }

    _state = _state.copyWith(isSavingCharacter: true, clearError: true);
    notifyListeners();

    try {
      await update(selected.id);
      _state = _state.copyWith(isSavingCharacter: false, clearError: true);
    } on CharacterInventoryValidationError catch (error) {
      _state = _state.copyWith(
        isSavingCharacter: false,
        errorMessage: _inventoryValidationMessage(
          inventoryItemId: inventoryItemId,
          error: error,
        ),
      );
    } on StateError catch (error) {
      _state = _state.copyWith(
        isSavingCharacter: false,
        errorMessage: _stateErrorMessage(
          error,
          fallback: 'Failed to update inventory item: $inventoryItemId.',
        ),
      );
    } catch (_) {
      _state = _state.copyWith(
        isSavingCharacter: false,
        errorMessage: 'Failed to update inventory item: $inventoryItemId.',
      );
    }

    notifyListeners();
  }

  String _inventoryValidationMessage({
    required String inventoryItemId,
    required CharacterInventoryValidationError error,
  }) {
    final actionMessage = switch (error.code) {
      'invalid_target' =>
        'The selected container or item target is not valid for this character.',
      'invalid_structure' =>
        'The transfer would create an invalid container structure.',
      'capacity_exceeded' => 'The target container capacity would be exceeded.',
      'invalid_stack_state' =>
        'A same-item stack in the target container is incompatible with this transfer.',
      'invalid_quantity' =>
        'The requested quantity is outside the allowed range.',
      'insufficient_quantity' =>
        'The item does not have enough quantity for this action.',
      'invalid_charge_state' =>
        'Charge tracking is not in a valid state for this action.',
      'insufficient_charges' =>
        'The item does not have enough charges for this action.',
      _ => error.message,
    };
    return 'Inventory action rejected for $inventoryItemId: $actionMessage Current stack and container state were not changed.';
  }

  String _stateErrorMessage(Object error, {required String fallback}) {
    if (error is StateError) {
      final message = error.message.trim();
      if (message.isNotEmpty) {
        return message;
      }
    }
    return fallback;
  }

  Future<void> _updateSelectedCharacterDeathSaves(
    Future<void> Function(String characterId) update,
  ) async {
    final selected = _state.selectedCharacterSheet;
    if (selected == null) {
      _state = _state.copyWith(
        errorMessage: 'No character is currently selected.',
      );
      notifyListeners();
      return;
    }

    _state = _state.copyWith(isSavingCharacter: true, clearError: true);
    notifyListeners();

    try {
      await update(selected.id);
      _state = _state.copyWith(isSavingCharacter: false, clearError: true);
    } catch (_) {
      _state = _state.copyWith(
        isSavingCharacter: false,
        errorMessage: 'Failed to update death save state.',
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

  Future<bool> _ensureFullCompendiumCatalogLoaded() async {
    if (_isFullCompendiumCatalogLoaded) {
      return true;
    }

    try {
      final compendiumCatalog = await _compendiumRepository.loadCatalog();
      _isFullCompendiumCatalogLoaded = true;
      _state = _state.copyWith(
        compendiumCatalog: compendiumCatalog,
        clearError: true,
      );
      notifyListeners();
      return true;
    } catch (_) {
      _state = _state.copyWith(
        errorMessage: 'Failed to load full local compendium data.',
      );
      notifyListeners();
      return false;
    }
  }
}
