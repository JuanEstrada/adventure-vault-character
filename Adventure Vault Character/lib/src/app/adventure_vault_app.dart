import 'dart:async';

import 'package:adventure_vault_character/src/app/app_controller.dart';
import 'package:adventure_vault_character/src/core/navigation/app_screen.dart';
import 'package:adventure_vault_character/src/features/access/presentation/access_screen.dart';
import 'package:adventure_vault_character/src/features/bootstrap/presentation/bootstrap_screen.dart';
import 'package:adventure_vault_character/src/features/characters/data/character_repository.dart';
import 'package:adventure_vault_character/src/features/characters/data/drift_character_repository.dart';
import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:adventure_vault_character/src/features/characters/presentation/character_sheet_screen.dart';
import 'package:adventure_vault_character/src/features/characters/presentation/create_character_screen.dart';
import 'package:adventure_vault_character/src/features/characters/presentation/edit_character_screen.dart';
import 'package:adventure_vault_character/src/features/compendium/data/asset_compendium_repository.dart';
import 'package:adventure_vault_character/src/features/compendium/data/compendium_repository.dart';
import 'package:adventure_vault_character/src/features/compendium/presentation/compendium_import_screen.dart';
import 'package:adventure_vault_character/src/features/compendium/presentation/compendium_packs_screen.dart';
import 'package:adventure_vault_character/src/features/compendium/presentation/compendium_screen.dart';
import 'package:adventure_vault_character/src/features/main_menu/presentation/main_menu_screen.dart';
import 'package:adventure_vault_character/src/features/settings/data/drift_system_settings_repository.dart';
import 'package:adventure_vault_character/src/features/settings/data/in_memory_system_settings_repository.dart';
import 'package:adventure_vault_character/src/features/settings/data/system_settings_repository.dart';
import 'package:adventure_vault_character/src/features/settings/presentation/system_settings_screen.dart';
import 'package:flutter/material.dart';

class AdventureVaultApp extends StatefulWidget {
  const AdventureVaultApp({
    super.key,
    this.characterRepository,
    this.compendiumRepository,
    this.systemSettingsRepository,
  });

  final CharacterRepository? characterRepository;
  final CompendiumRepository? compendiumRepository;
  final SystemSettingsRepository? systemSettingsRepository;

  @override
  State<AdventureVaultApp> createState() => _AdventureVaultAppState();
}

class _AdventureVaultAppState extends State<AdventureVaultApp> {
  late final AppController _controller;
  AppDatabase? _ownedDatabase;

  @override
  void initState() {
    super.initState();
    final database = widget.characterRepository == null ? AppDatabase() : null;
    _ownedDatabase = database;
    final compendiumRepository =
        widget.compendiumRepository ??
        AssetCompendiumRepository(database: database);
    final repository =
        widget.characterRepository ??
        _createDefaultRepository(database!, compendiumRepository);
    final systemSettingsRepository =
        widget.systemSettingsRepository ??
        (database == null
            ? InMemorySystemSettingsRepository()
            : DriftSystemSettingsRepository(database: database));
    _controller = AppController(
      characterRepository: repository,
      compendiumRepository: compendiumRepository,
      systemSettingsRepository: systemSettingsRepository,
    );
    _controller.initialize();
  }

  CharacterRepository _createDefaultRepository(
    AppDatabase database,
    CompendiumRepository compendiumRepository,
  ) {
    return DriftCharacterRepository(
      database: database,
      compendiumRepository: compendiumRepository,
    );
  }

  @override
  void dispose() {
    final database = _ownedDatabase;
    if (database != null) {
      unawaited(database.close());
    }
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adventure Vault Character',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7C5C3B),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF4EFE6),
        useMaterial3: true,
      ),
      home: ListenableBuilder(
        listenable: _controller,
        builder: (context, _) {
          final state = _controller.state;
          return switch (state.screen) {
            AppScreen.bootstrap => BootstrapScreen(
              isLoading: state.isInitializing,
              errorMessage: state.errorMessage,
              onRetry: _controller.initialize,
            ),
            AppScreen.access => AccessScreen(
              onContinueOffline: _controller.continueOffline,
            ),
            AppScreen.mainMenu => MainMenuScreen(
              characterSummaries: state.characterSummaries,
              compendiumCatalog: state.compendiumCatalog!,
              onOpenCompendium: () {
                unawaited(_controller.openCompendium());
              },
              onOpenRules: () {
                unawaited(_controller.openCompendium());
              },
              onLoadXml: () {
                unawaited(_controller.openCompendiumImport());
              },
              onOpenSettings: _controller.openSettings,
              onCreateCharacter: () {
                unawaited(_controller.openCreateCharacter());
              },
              onOpenCharacter: _controller.openCharacter,
            ),
            AppScreen.settings => SystemSettingsScreen(
              includeCoinWeightInEncumbrance:
                  state.includeCoinWeightInEncumbrance,
              isSaving: state.isSavingSettings,
              onBack: _controller.openMainMenu,
              onToggleIncludeCoinWeight:
                  _controller.setIncludeCoinWeightInEncumbrance,
            ),
            AppScreen.compendium => CompendiumScreen(
              catalog: state.compendiumCatalog!,
              onBack: _controller.openMainMenu,
              onOpenCompendiumPacks: () {
                unawaited(_controller.openCompendiumPacks());
              },
              onOpenCompendiumImport: () {
                unawaited(_controller.openCompendiumImport());
              },
            ),
            AppScreen.compendiumPacks => CompendiumPacksScreen(
              catalog: state.compendiumCatalog!,
              onBack: () {
                unawaited(_controller.openCompendium());
              },
              onSetPackActive: _controller.setCompendiumPackActive,
            ),
            AppScreen.compendiumImport => CompendiumImportScreen(
              onBack: () {
                unawaited(_controller.openCompendium());
              },
              onOpenCompendiumPacks: () {
                unawaited(_controller.openCompendiumPacks());
              },
              onImportXml: _controller.importCompendiumXml,
            ),
            AppScreen.createCharacter => CreateCharacterScreen(
              catalog: state.compendiumCatalog!,
              isSaving: state.isSavingCharacter,
              errorMessage: state.errorMessage,
              onCancel: _controller.openMainMenu,
              onSave: _controller.createCharacter,
            ),
            AppScreen.characterSheet => CharacterSheetScreen(
              character: state.selectedCharacterSheet!,
              isApplyingRest: state.isSavingCharacter,
              errorMessage: state.errorMessage,
              onBack: _controller.openMainMenu,
              onEdit: () => _controller.loadEditableCharacter(
                state.selectedCharacterSheet!.id,
              ),
              onApplyShortRest: _controller.applyShortRestToSelectedCharacter,
              onApplyLongRest: _controller.applyLongRestToSelectedCharacter,
              onSetClassResourceUses:
                  _controller.setSelectedCharacterClassResourceUses,
              onRecordDeathSaveSuccess:
                  _controller.recordSelectedCharacterDeathSaveSuccess,
              onRecordDeathSaveFailure:
                  _controller.recordSelectedCharacterDeathSaveFailure,
              onResetDeathSaves: _controller.resetSelectedCharacterDeathSaves,
              onSetInventoryItemEquipped:
                  _controller.setSelectedCharacterInventoryItemEquipped,
              onSetInventoryItemCarried:
                  _controller.setSelectedCharacterInventoryItemCarried,
              onSetInventoryItemQuantity:
                  _controller.setSelectedCharacterInventoryItemQuantity,
              onSpendInventoryItemQuantity:
                  _controller.spendSelectedCharacterInventoryItemQuantity,
              onSetInventoryItemCharges:
                  _controller.setSelectedCharacterInventoryItemCharges,
              onSetInventoryItemContainer:
                  _controller.setSelectedCharacterInventoryItemContainer,
            ),
            AppScreen.editCharacter => EditCharacterScreen(
              controller: state.characterEditorController!,
              isSaving: state.isSavingCharacter,
              errorMessage: state.errorMessage,
              onCancel: () => _controller.openCharacter(
                state.characterEditorController!.characterId,
              ),
              onSave: _controller.saveEditedCharacter,
            ),
          };
        },
      ),
    );
  }
}
