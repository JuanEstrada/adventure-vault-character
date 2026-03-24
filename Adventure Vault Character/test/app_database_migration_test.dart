import 'dart:io';

import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite;

void main() {
  group('AppDatabase migrations', () {
    test('upgrades a v1 database to v4 and preserves character data', () async {
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
      final currency = await (database.select(
        database.characterCurrency,
      )..where((table) => table.characterId.equals('char-1'))).getSingle();
      final savingThrows = await (database.select(
        database.characterSavingThrows,
      )..where((table) => table.characterId.equals('char-1'))).get();

      expect(character.backgroundId, isNull);
      expect(character.equipmentLoadoutId, isNull);
      expect(character.proficiencyBonus, 2);
      expect(abilityScores.strengthScore, 0);
      expect(abilityScores.charismaModifier, -5);
      expect(currency.summarySnapshot, isNull);
      expect(savingThrows, hasLength(6));
      expect(
        savingThrows.map((row) => row.abilityKey),
        containsAll(<String>['STR', 'DEX', 'CON', 'INT', 'WIS', 'CHA']),
      );
    });

    test(
      'upgrades a v3 database to v4 and backfills normalized tables',
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
        INSERT INTO characters (
          id, name, race_name, background_id, background_name, background_summary,
          ability_score_method, ability_score_provenance, strength, dexterity,
          constitution, intelligence, wisdom, charisma, class_name, level, experience,
          equipment_loadout_id, equipment_loadout_label, starting_money_summary,
          selected_equipment_items, current_hit_points, maximum_hit_points,
          temporary_hit_points, portrait_asset_path, alignment, appearance_details,
          narrative_details, created_at, updated_at
        ) VALUES (
          'char-2', 'Meris', 'Elf', 'acolyte', 'Acolyte', 'Temple acolyte',
          'generatedSetAssignment', 'method=generatedSetAssignment', 8, 12,
          13, 15, 14, 10, 'Wizard', 5, 6500,
          'wizard-focus', 'Arcane focus kit', '15 gp, 4 sp',
          '["Quarterstaff","Component pouch","Scholar pack"]', 28, 28,
          0, NULL, 'Neutral', 'Tall and quiet',
          'Keeps careful notes.', 1710000002000, 1710000003000
        )
      ''');
        legacy.execute('PRAGMA user_version = 3');
        legacy.close();

        final database = AppDatabase.executor(NativeDatabase(file));
        addTearDown(database.close);

        final character = await (database.select(
          database.characters,
        )..where((table) => table.id.equals('char-2'))).getSingle();
        final abilityScores = await (database.select(
          database.characterAbilityScores,
        )..where((table) => table.characterId.equals('char-2'))).getSingle();
        final currency = await (database.select(
          database.characterCurrency,
        )..where((table) => table.characterId.equals('char-2'))).getSingle();
        final savingThrows = await (database.select(
          database.characterSavingThrows,
        )..where((table) => table.characterId.equals('char-2'))).get();

        expect(character.classDefinitionId, isNull);
        expect(character.backgroundDefinitionRefId, 'acolyte');
        expect(character.proficiencyBonus, 3);
        expect(abilityScores.intelligenceScore, 15);
        expect(abilityScores.intelligenceModifier, 2);
        expect(currency.summarySnapshot, '15 gp, 4 sp');
        expect(savingThrows, hasLength(6));
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
