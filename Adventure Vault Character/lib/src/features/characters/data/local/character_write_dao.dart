import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:drift/drift.dart';

class CharacterWriteDao {
  CharacterWriteDao(this._database);

  final AppDatabase _database;

  Future<void> insertCharacter(CharactersCompanion companion) {
    return _database.into(_database.characters).insert(companion);
  }

  Future<void> updateCharacter(String id, CharactersCompanion companion) async {
    await (_database.update(
      _database.characters,
    )..where((table) => table.id.equals(id))).write(companion);
  }

  Future<void> insertAbilityScores(CharacterAbilityScoresCompanion companion) {
    return _database.into(_database.characterAbilityScores).insert(companion);
  }

  Future<void> replaceAbilityScores(
    CharacterAbilityScoresCompanion companion,
  ) async {
    await _database
        .into(_database.characterAbilityScores)
        .insertOnConflictUpdate(companion);
  }

  Future<void> insertAbilityScoreProvenance(
    CharacterAbilityScoreProvenancesCompanion companion,
  ) {
    return _database
        .into(_database.characterAbilityScoreProvenances)
        .insert(companion);
  }

  Future<void> replaceAbilityScoreProvenance(
    CharacterAbilityScoreProvenancesCompanion companion,
  ) async {
    await _database
        .into(_database.characterAbilityScoreProvenances)
        .insertOnConflictUpdate(companion);
  }

  Future<void> insertHitPoints(CharacterHitPointsCompanion companion) {
    return _database.into(_database.characterHitPoints).insert(companion);
  }

  Future<void> replaceHitPoints(CharacterHitPointsCompanion companion) async {
    await _database
        .into(_database.characterHitPoints)
        .insertOnConflictUpdate(companion);
  }

  Future<void> insertFinishingDetails(
    CharacterFinishingDetailsCompanion companion,
  ) {
    return _database
        .into(_database.characterFinishingDetails)
        .insert(companion);
  }

  Future<void> replaceFinishingDetails(
    CharacterFinishingDetailsCompanion companion,
  ) async {
    await _database
        .into(_database.characterFinishingDetails)
        .insertOnConflictUpdate(companion);
  }

  Future<void> insertNarrativeSelections(
    List<CharacterNarrativeSelectionsCompanion> companions,
  ) async {
    if (companions.isEmpty) {
      return;
    }

    await _database.batch((Batch batch) {
      batch.insertAll(
        _database.characterNarrativeSelections,
        companions,
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Future<void> insertEquipmentLoadout(
    CharacterEquipmentLoadoutsCompanion companion,
  ) {
    return _database
        .into(_database.characterEquipmentLoadouts)
        .insert(companion);
  }

  Future<void> replaceEquipmentLoadout(
    CharacterEquipmentLoadoutsCompanion companion,
  ) async {
    await _database
        .into(_database.characterEquipmentLoadouts)
        .insertOnConflictUpdate(companion);
  }

  Future<void> insertSpellSelections(
    List<CharacterSpellSelectionsCompanion> companions,
  ) async {
    if (companions.isEmpty) {
      return;
    }

    await _database.batch((Batch batch) {
      batch.insertAll(
        _database.characterSpellSelections,
        companions,
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Future<void> insertSpellSlotUsages(
    List<CharacterSpellSlotUsagesCompanion> companions,
  ) async {
    if (companions.isEmpty) {
      return;
    }

    await _database.batch((Batch batch) {
      batch.insertAll(
        _database.characterSpellSlotUsages,
        companions,
        mode: InsertMode.insertOrReplace,
      );
    });
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

  Future<void> replaceCurrency(CharacterCurrencyCompanion companion) async {
    await _database
        .into(_database.characterCurrency)
        .insertOnConflictUpdate(companion);
  }

  Future<void> insertClassResources(
    List<CharacterClassResourcesCompanion> companions,
  ) async {
    if (companions.isEmpty) {
      return;
    }

    await _database.batch((Batch batch) {
      batch.insertAll(
        _database.characterClassResources,
        companions,
        mode: InsertMode.insertOrReplace,
      );
    });
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

  Future<void> deleteSkillsByCharacterId(String characterId) {
    return (_database.delete(
      _database.characterSkills,
    )..where((table) => table.characterId.equals(characterId))).go();
  }

  Future<void> deleteSavingThrowsByCharacterId(String characterId) {
    return (_database.delete(
      _database.characterSavingThrows,
    )..where((table) => table.characterId.equals(characterId))).go();
  }

  Future<void> deleteProficienciesByCharacterId(String characterId) {
    return (_database.delete(
      _database.characterProficiencies,
    )..where((table) => table.characterId.equals(characterId))).go();
  }

  Future<void> deleteInventoryByCharacterId(String characterId) {
    return (_database.delete(
      _database.characterInventory,
    )..where((table) => table.characterId.equals(characterId))).go();
  }

  Future<void> deleteNarrativeSelectionsByCharacterId(String characterId) {
    return (_database.delete(
      _database.characterNarrativeSelections,
    )..where((table) => table.characterId.equals(characterId))).go();
  }

  Future<void> deleteSpellSelectionsByCharacterId(String characterId) {
    return (_database.delete(
      _database.characterSpellSelections,
    )..where((table) => table.characterId.equals(characterId))).go();
  }

  Future<void> deleteSpellSlotUsagesByCharacterId(String characterId) {
    return (_database.delete(
      _database.characterSpellSlotUsages,
    )..where((table) => table.characterId.equals(characterId))).go();
  }

  Future<void> deleteClassResourcesByCharacterId(String characterId) {
    return (_database.delete(
      _database.characterClassResources,
    )..where((table) => table.characterId.equals(characterId))).go();
  }
}
