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

  Future<CharacterHitPoint?> getHitPointsByCharacterId(String id) {
    return (_database.select(
      _database.characterHitPoints,
    )..where((table) => table.characterId.equals(id))).getSingleOrNull();
  }

  Future<CharacterFinishingDetail?> getFinishingDetailsByCharacterId(
    String id,
  ) {
    return (_database.select(
      _database.characterFinishingDetails,
    )..where((table) => table.characterId.equals(id))).getSingleOrNull();
  }

  Future<List<CharacterNarrativeSelection>> getNarrativeSelectionsByCharacterId(
    String id,
  ) {
    return (_database.select(
      _database.characterNarrativeSelections,
    )..where((table) => table.characterId.equals(id))).get();
  }

  Future<CharacterEquipmentLoadout?> getEquipmentLoadoutByCharacterId(
    String id,
  ) {
    return (_database.select(
      _database.characterEquipmentLoadouts,
    )..where((table) => table.characterId.equals(id))).getSingleOrNull();
  }

  Future<List<CharacterSpellSelection>> getSpellSelectionsByCharacterId(
    String id,
  ) {
    return (_database.select(_database.characterSpellSelections)
          ..where((table) => table.characterId.equals(id))
          ..orderBy([(table) => OrderingTerm.asc(table.selectedAtOrder)]))
        .get();
  }

  Future<List<CharacterSpellSlotUsage>> getSpellSlotUsagesByCharacterId(
    String id,
  ) {
    return (_database.select(_database.characterSpellSlotUsages)
          ..where((table) => table.characterId.equals(id))
          ..orderBy([(table) => OrderingTerm.asc(table.spellLevel)]))
        .get();
  }

  Future<CharacterCurrencyData?> getCurrencyByCharacterId(String id) {
    return (_database.select(
      _database.characterCurrency,
    )..where((table) => table.characterId.equals(id))).getSingleOrNull();
  }

  Future<List<CharacterClassResource>> getClassResourcesByCharacterId(
    String id,
  ) {
    return (_database.select(
      _database.characterClassResources,
    )..where((table) => table.characterId.equals(id))).get();
  }

  Future<List<CharacterInventoryData>> getInventoryByCharacterId(String id) {
    return (_database.select(
      _database.characterInventory,
    )..where((table) => table.characterId.equals(id))).get();
  }

  Future<CharacterInventoryData?> getInventoryItemById(String id) {
    return (_database.select(
      _database.characterInventory,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
  }

  Future<List<EquipmentDefinition>> getEquipmentDefinitionsByIds(
    Iterable<String> ids,
  ) {
    final normalizedIds = ids.where((id) => id.isNotEmpty).toSet();
    if (normalizedIds.isEmpty) {
      return Future<List<EquipmentDefinition>>.value(
        const <EquipmentDefinition>[],
      );
    }

    return (_database.select(
      _database.equipmentDefinitions,
    )..where((table) => table.id.isIn(normalizedIds))).get();
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

  Future<ClassDefinition?> getClassDefinitionById(String id) {
    return (_database.select(
      _database.classDefinitions,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
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
