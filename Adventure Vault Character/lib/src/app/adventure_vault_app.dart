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
import 'package:adventure_vault_character/src/features/main_menu/presentation/main_menu_screen.dart';
import 'package:flutter/material.dart';

class AdventureVaultApp extends StatefulWidget {
  const AdventureVaultApp({
    super.key,
    this.characterRepository,
    this.compendiumRepository,
  });

  final CharacterRepository? characterRepository;
  final CompendiumRepository? compendiumRepository;

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
    _controller = AppController(
      characterRepository: repository,
      compendiumRepository: compendiumRepository,
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
              onCreateCharacter: _controller.openCreateCharacter,
              onOpenCharacter: _controller.openCharacter,
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
              onBack: _controller.openMainMenu,
              onEdit: () => _controller.loadEditableCharacter(
                state.selectedCharacterSheet!.id,
              ),
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
