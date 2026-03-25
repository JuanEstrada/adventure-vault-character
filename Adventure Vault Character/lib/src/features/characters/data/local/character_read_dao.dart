import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:drift/drift.dart';

class CharacterReadDao {
  CharacterReadDao(this._database);

  final AppDatabase _database;

  Future<List<Character>> getCharacterRows() {
    return (_database.select(_database.characters)..orderBy([
          (table) => OrderingTerm.desc(table.updatedAt),
          (table) => OrderingTerm.asc(table.name),
        ]))
        .get();
  }

  Stream<List<Character>> watchCharacterRows() {
    return (_database.select(_database.characters)..orderBy([
          (table) => OrderingTerm.desc(table.updatedAt),
          (table) => OrderingTerm.asc(table.name),
        ]))
        .watch();
  }

  Future<Character?> getCharacterRowById(String id) {
    return (_database.select(
      _database.characters,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
  }

  Stream<Character?> watchCharacterRowById(String id) {
    return (_database.select(
      _database.characters,
    )..where((table) => table.id.equals(id))).watchSingleOrNull();
  }

  Future<CharacterAbilityScore?> getAbilityScoresByCharacterId(String id) {
    return (_database.select(
      _database.characterAbilityScores,
    )..where((table) => table.characterId.equals(id))).getSingleOrNull();
  }

  Future<CharacterAbilityScoreProvenance?>
  getAbilityScoreProvenanceByCharacterId(String id) {
    return (_database.select(
      _database.characterAbilityScoreProvenances,
    )..where((table) => table.characterId.equals(id))).getSingleOrNull();
  }

  Future<CharacterCurrencyData?> getCurrencyByCharacterId(String id) {
    return (_database.select(
      _database.characterCurrency,
    )..where((table) => table.characterId.equals(id))).getSingleOrNull();
  }

  Future<List<CharacterInventoryData>> getInventoryByCharacterId(String id) {
    return (_database.select(
      _database.characterInventory,
    )..where((table) => table.characterId.equals(id))).get();
  }

  Future<List<CharacterSavingThrow>> getSavingThrowsByCharacterId(String id) {
    return (_database.select(
      _database.characterSavingThrows,
    )..where((table) => table.characterId.equals(id))).get();
  }

  Future<List<CharacterSkill>> getSkillsByCharacterId(String id) {
    return (_database.select(
      _database.characterSkills,
    )..where((table) => table.characterId.equals(id))).get();
  }

  Future<List<SkillDefinition>> getSkillDefinitions() {
    return _database.select(_database.skillDefinitions).get();
  }

  Future<List<CharacterProficiency>> getProficienciesByCharacterId(String id) {
    return (_database.select(
      _database.characterProficiencies,
    )..where((table) => table.characterId.equals(id))).get();
  }

  Future<BackgroundDefinition?> getBackgroundDefinitionById(String id) {
    return (_database.select(
      _database.backgroundDefinitions,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
  }
}
