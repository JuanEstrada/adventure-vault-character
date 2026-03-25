import 'dart:io';

import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

void main() {
  group('AppDatabase migrations', () {
    test('upgrades a v1 database to v7 and preserves character data', () async {
      final file = await _createTempDatabaseFile();
      addTearDown(() async {
        if (await file.exists()) {
          await file.delete();
        }
      });

      final legacy = sqlite.sqlite3.open(file.path);

      legacy.execute('''
        CREATE TABLE characters (
          id TEXT NOT NULL PRIMARY KEY,
          name TEXT NOT NULL,
          race_name TEXT NOT NULL,
          class_name TEXT NOT NULL,
          level INTEGER NOT NULL,
          created_at INTEGER NOT NULL,
          updated_at INTEGER NOT NULL,
          portrait_asset_path TEXT NULL
        )
      ''');
      legacy.execute('''
        INSERT INTO characters (
          id, name, race_name, class_name, level, created_at, updated_at, portrait_asset_path
        ) VALUES (
          'char-1', 'Aelar', 'Human', 'Fighter', 1, 1710000000000, 1710000001000, NULL
        )
      ''');
      legacy.execute('PRAGMA user_version = 1');
      legacy.close();

      final database = AppDatabase.executor(NativeDatabase(file));
      addTearDown(database.close);

      final character = await (database.select(
        database.characters,
      )..where((table) => table.id.equals('char-1'))).getSingle();
      final abilityScores = await (database.select(
        database.characterAbilityScores,
      )..where((table) => table.characterId.equals('char-1'))).getSingle();
      final provenance = await (database.select(
        database.characterAbilityScoreProvenances,
      )..where((table) => table.characterId.equals('char-1'))).getSingle();
      final hitPoints = await (database.select(
        database.characterHitPoints,
      )..where((table) => table.characterId.equals('char-1'))).getSingle();
      final finishingDetails = await (database.select(
        database.characterFinishingDetails,
      )..where((table) => table.characterId.equals('char-1'))).getSingle();
      final currency = await (database.select(
        database.characterCurrency,
      )..where((table) => table.characterId.equals('char-1'))).getSingle();
      final savingThrows = await (database.select(
        database.characterSavingThrows,
      )..where((table) => table.characterId.equals('char-1'))).get();

      expect(character.equipmentLoadoutId, isNull);
      expect(abilityScores.strengthScore, 0);
      expect(abilityScores.charismaModifier, -5);
      expect(provenance.methodKey, isNull);
      expect(hitPoints.current, 0);
      expect(finishingDetails.portraitAssetPath, isNull);
      expect(currency.summarySnapshot, isNull);
      expect(savingThrows, hasLength(6));
      expect(
        savingThrows.map((row) => row.abilityKey),
        containsAll(<String>['STR', 'DEX', 'CON', 'INT', 'WIS', 'CHA']),
      );
    });

    test(
      'upgrades a v4 database to v7, preserves normalized data, migrates provenance, and drops redundant snapshot columns',
      () async {
        final file = await _createTempDatabaseFile();
        addTearDown(() async {
          if (await file.exists()) {
            await file.delete();
          }
        });

        final legacy = sqlite.sqlite3.open(file.path);

        legacy.execute('''
        CREATE TABLE characters (
          id TEXT NOT NULL PRIMARY KEY,
          name TEXT NOT NULL,
          race_name TEXT NOT NULL,
          class_definition_id TEXT NULL,
          background_definition_ref_id TEXT NULL,
          background_id TEXT NULL,
          background_name TEXT NULL,
          background_summary TEXT NULL,
          ability_score_method TEXT NULL,
          ability_score_provenance TEXT NULL,
          strength INTEGER NULL,
          dexterity INTEGER NULL,
          constitution INTEGER NULL,
          intelligence INTEGER NULL,
          wisdom INTEGER NULL,
          charisma INTEGER NULL,
          class_name TEXT NOT NULL,
          level INTEGER NOT NULL,
          experience INTEGER NULL,
          proficiency_bonus INTEGER NULL,
          equipment_loadout_id TEXT NULL,
          equipment_loadout_label TEXT NULL,
          starting_money_summary TEXT NULL,
          selected_equipment_items TEXT NULL,
          current_hit_points INTEGER NULL,
          maximum_hit_points INTEGER NULL,
          temporary_hit_points INTEGER NULL,
          portrait_asset_path TEXT NULL,
          alignment TEXT NULL,
          appearance_details TEXT NULL,
          narrative_details TEXT NULL,
          created_at INTEGER NOT NULL,
          updated_at INTEGER NOT NULL
        )
      ''');
        legacy.execute(r'''
        CREATE TABLE character_ability_scores (
          character_id TEXT NOT NULL PRIMARY KEY,
          strength_score INTEGER NOT NULL,
          dexterity_score INTEGER NOT NULL,
          constitution_score INTEGER NOT NULL,
          intelligence_score INTEGER NOT NULL,
          wisdom_score INTEGER NOT NULL,
          charisma_score INTEGER NOT NULL,
          strength_modifier INTEGER NULL,
          dexterity_modifier INTEGER NULL,
          constitution_modifier INTEGER NULL,
          intelligence_modifier INTEGER NULL,
          wisdom_modifier INTEGER NULL,
          charisma_modifier INTEGER NULL,
          FOREIGN KEY(character_id) REFERENCES characters(id)
        )
      ''');
        legacy.execute('''
        CREATE TABLE character_skills (
          character_id TEXT NOT NULL,
          skill_definition_id TEXT NOT NULL,
          is_proficient INTEGER NOT NULL DEFAULT 0,
          has_expertise INTEGER NOT NULL DEFAULT 0,
          misc_bonus INTEGER NOT NULL DEFAULT 0,
          total_bonus INTEGER NULL,
          PRIMARY KEY(character_id, skill_definition_id),
          FOREIGN KEY(character_id) REFERENCES characters(id)
        )
      ''');
        legacy.execute('''
        CREATE TABLE character_saving_throws (
          character_id TEXT NOT NULL,
          ability_key TEXT NOT NULL,
          is_proficient INTEGER NOT NULL DEFAULT 0,
          misc_bonus INTEGER NOT NULL DEFAULT 0,
          total_bonus INTEGER NULL,
          PRIMARY KEY(character_id, ability_key),
          FOREIGN KEY(character_id) REFERENCES characters(id)
        )
      ''');
        legacy.execute('''
        CREATE TABLE character_currency (
          character_id TEXT NOT NULL PRIMARY KEY,
          copper INTEGER NOT NULL DEFAULT 0,
          silver INTEGER NOT NULL DEFAULT 0,
          electrum INTEGER NOT NULL DEFAULT 0,
          gold INTEGER NOT NULL DEFAULT 0,
          platinum INTEGER NOT NULL DEFAULT 0,
          summary_snapshot TEXT NULL,
          FOREIGN KEY(character_id) REFERENCES characters(id)
        )
      ''');
        legacy.execute('''
        CREATE TABLE character_inventory (
          id TEXT NOT NULL PRIMARY KEY,
          character_id TEXT NOT NULL,
          equipment_definition_id TEXT NULL,
          trinket_definition_id TEXT NULL,
          display_name_snapshot TEXT NULL,
          quantity INTEGER NOT NULL DEFAULT 1,
          is_equipped INTEGER NOT NULL DEFAULT 0,
          is_carried INTEGER NOT NULL DEFAULT 1,
          is_favorite INTEGER NOT NULL DEFAULT 0,
          charges_current INTEGER NULL,
          charges_max INTEGER NULL,
          container_inventory_item_id TEXT NULL,
          notes TEXT NULL,
          FOREIGN KEY(character_id) REFERENCES characters(id)
        )
      ''');
        legacy.execute('''
        CREATE TABLE character_proficiencies (
          id TEXT NOT NULL PRIMARY KEY,
          character_id TEXT NOT NULL,
          proficiency_type TEXT NOT NULL,
          reference_key TEXT NOT NULL,
          source_type TEXT NULL,
          source_id TEXT NULL,
          is_expertise INTEGER NOT NULL DEFAULT 0,
          FOREIGN KEY(character_id) REFERENCES characters(id)
        )
      ''');
        legacy.execute('''
        CREATE TABLE background_definitions (
          id TEXT NOT NULL PRIMARY KEY,
          key TEXT NOT NULL,
          name TEXT NOT NULL,
          summary TEXT NULL,
          feature_name TEXT NULL,
          feature_description TEXT NULL,
          granted_skill_keys_json TEXT NULL,
          granted_tool_keys_json TEXT NULL,
          granted_language_keys_json TEXT NULL,
          starting_equipment_json TEXT NULL
        )
      ''');
        legacy.execute(r'''
        INSERT INTO characters (
          id, name, race_name, class_definition_id, background_definition_ref_id,
          background_id, background_name, background_summary,
          ability_score_method, ability_score_provenance, strength, dexterity,
          constitution, intelligence, wisdom, charisma, class_name, level, experience,
          proficiency_bonus, equipment_loadout_id, equipment_loadout_label,
          starting_money_summary, selected_equipment_items, current_hit_points,
          maximum_hit_points, temporary_hit_points, portrait_asset_path, alignment,
          appearance_details, narrative_details, created_at, updated_at
        ) VALUES (
          'char-2', 'Meris', 'Elf', 'class-wizard', NULL,
          'acolyte', 'Acolyte', 'Temple acolyte',
          'generatedSetAssignment',
          'method=generatedSetAssignment;Strength=8;Dexterity=12;Constitution=13;Intelligence=15;Wisdom=14;Charisma=10', 8, 12,
          13, 15, 14, 10, 'Wizard', 5, 6500,
          3, 'wizard-focus', 'Arcane focus kit', '15 gp, 4 sp',
          '["Quarterstaff","Component pouch","Scholar pack"]', 28, 28, 0,
          NULL, 'Neutral', 'Tall and quiet',
          'Keeps careful notes.', 1710000002000, 1710000003000
        )
      ''');
        legacy.execute(r'''
        INSERT INTO character_ability_scores (
          character_id, strength_score, dexterity_score, constitution_score,
          intelligence_score, wisdom_score, charisma_score, strength_modifier,
          dexterity_modifier, constitution_modifier, intelligence_modifier,
          wisdom_modifier, charisma_modifier
        ) VALUES (
          'char-2', 8, 12, 13, 15, 14, 10, -1, 1, 1, 2, 2, 0
        )
      ''');
        legacy.execute(r'''
        INSERT INTO character_currency (
          character_id, copper, silver, electrum, gold, platinum, summary_snapshot
        ) VALUES (
          'char-2', 0, 4, 0, 15, 0, '15 gp, 4 sp'
        )
      ''');
        legacy.execute(r'''
        INSERT INTO character_inventory (
          id, character_id, equipment_definition_id, trinket_definition_id,
          display_name_snapshot, quantity, is_equipped, is_carried, is_favorite,
          charges_current, charges_max, container_inventory_item_id, notes
        ) VALUES (
          'char-2-item-1', 'char-2', NULL, NULL, 'Quarterstaff', 1, 1, 1, 0,
          NULL, NULL, NULL, NULL
        )
      ''');
        legacy.execute(r'''
        INSERT INTO background_definitions (
          id, key, name, summary, feature_name, feature_description,
          granted_skill_keys_json, granted_tool_keys_json,
          granted_language_keys_json, starting_equipment_json
        ) VALUES (
          'acolyte', 'acolyte', 'Acolyte', 'Temple acolyte',
          'Shelter of the Faithful', 'Temple support',
          '["insight","religion"]', NULL, '["any-two"]', '[]'
        )
      ''');
        legacy.execute('PRAGMA user_version = 4');
        legacy.close();

        final database = AppDatabase.executor(NativeDatabase(file));
        addTearDown(database.close);

        final character = await (database.select(
          database.characters,
        )..where((table) => table.id.equals('char-2'))).getSingle();
        final abilityScores = await (database.select(
          database.characterAbilityScores,
        )..where((table) => table.characterId.equals('char-2'))).getSingle();
        final provenance = await (database.select(
          database.characterAbilityScoreProvenances,
        )..where((table) => table.characterId.equals('char-2'))).getSingle();
        final hitPoints = await (database.select(
          database.characterHitPoints,
        )..where((table) => table.characterId.equals('char-2'))).getSingle();
        final finishingDetails = await (database.select(
          database.characterFinishingDetails,
        )..where((table) => table.characterId.equals('char-2'))).getSingle();
        final currency = await (database.select(
          database.characterCurrency,
        )..where((table) => table.characterId.equals('char-2'))).getSingle();
        final inventory = await (database.select(
          database.characterInventory,
        )..where((table) => table.characterId.equals('char-2'))).get();
        final columns = await database
            .customSelect('PRAGMA table_info(characters)')
            .get();
        final columnNames = columns
            .map((row) => row.data['name'] as String)
            .toSet();

        expect(character.classDefinitionId, 'class-wizard');
        expect(character.backgroundDefinitionRefId, 'acolyte');
        expect(abilityScores.intelligenceScore, 15);
        expect(abilityScores.intelligenceModifier, 2);
        expect(provenance.methodKey, 'generatedSetAssignment');
        expect(provenance.intelligenceAssignedScore, 15);
        expect(hitPoints.current, 28);
        expect(hitPoints.maximum, 28);
        expect(finishingDetails.alignment, 'Neutral');
        expect(finishingDetails.appearanceDetails, 'Tall and quiet');
        expect(finishingDetails.narrativeDetails, 'Keeps careful notes.');
        expect(currency.summarySnapshot, '15 gp, 4 sp');
        expect(inventory.single.displayNameSnapshot, 'Quarterstaff');
        expect(columnNames, isNot(contains('background_id')));
        expect(columnNames, isNot(contains('background_name')));
        expect(columnNames, isNot(contains('background_summary')));
        expect(columnNames, isNot(contains('strength')));
        expect(columnNames, isNot(contains('proficiency_bonus')));
        expect(columnNames, isNot(contains('ability_score_method')));
        expect(columnNames, isNot(contains('ability_score_provenance')));
        expect(columnNames, isNot(contains('starting_money_summary')));
        expect(columnNames, isNot(contains('selected_equipment_items')));
        expect(columnNames, isNot(contains('current_hit_points')));
        expect(columnNames, isNot(contains('maximum_hit_points')));
        expect(columnNames, isNot(contains('temporary_hit_points')));
        expect(columnNames, isNot(contains('portrait_asset_path')));
        expect(columnNames, isNot(contains('alignment')));
        expect(columnNames, isNot(contains('appearance_details')));
        expect(columnNames, isNot(contains('narrative_details')));
      },
    );
  });
}

Future<File> _createTempDatabaseFile() async {
  final directory = await Directory.systemTemp.createTemp(
    'adventure-vault-migration-test-',
  );
  final file = File('${directory.path}${Platform.pathSeparator}app.sqlite');
  return file.create();
}
