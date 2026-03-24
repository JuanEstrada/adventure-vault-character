import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:drift/drift.dart';

class CharacterWriteDao {
  CharacterWriteDao(this._database);

  final AppDatabase _database;

  Future<void> insertCharacter(CharactersCompanion companion) {
    return _database.into(_database.characters).insert(companion);
  }

  Future<void> insertAbilityScores(CharacterAbilityScoresCompanion companion) {
    return _database.into(_database.characterAbilityScores).insert(companion);
  }

  Future<void> insertSkills(List<CharacterSkillsCompanion> companions) async {
    if (companions.isEmpty) {
      return;
    }

    await _database.batch((Batch batch) {
      batch.insertAll(
        _database.characterSkills,
        companions,
        mode: InsertMode.insertOrIgnore,
      );
    });
  }

  Future<void> insertSavingThrows(
    List<CharacterSavingThrowsCompanion> companions,
  ) async {
    if (companions.isEmpty) {
      return;
    }

    await _database.batch((Batch batch) {
      batch.insertAll(
        _database.characterSavingThrows,
        companions,
        mode: InsertMode.insertOrIgnore,
      );
    });
  }

  Future<void> insertProficiencies(
    List<CharacterProficienciesCompanion> companions,
  ) async {
    if (companions.isEmpty) {
      return;
    }

    await _database.batch((Batch batch) {
      batch.insertAll(
        _database.characterProficiencies,
        companions,
        mode: InsertMode.insertOrIgnore,
      );
    });
  }

  Future<void> insertCurrency(CharacterCurrencyCompanion companion) {
    return _database.into(_database.characterCurrency).insert(companion);
  }

  Future<void> insertInventory(
    List<CharacterInventoryCompanion> companions,
  ) async {
    if (companions.isEmpty) {
      return;
    }

    await _database.batch((Batch batch) {
      batch.insertAll(_database.characterInventory, companions);
    });
  }
}
