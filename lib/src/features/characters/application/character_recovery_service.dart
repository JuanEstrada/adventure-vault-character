import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:adventure_vault_character/src/features/characters/data/local/character_read_dao.dart';
import 'package:adventure_vault_character/src/features/characters/data/local/character_write_dao.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_class_resource_rules.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_combat_rules.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_rest_rules.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_spell_rules.dart';
import 'package:drift/drift.dart';

class CharacterRecoveryService {
  CharacterRecoveryService({
    required AppDatabase database,
    required CharacterReadDao readDao,
    required CharacterWriteDao writeDao,
    CharacterRestRules characterRestRules = const CharacterRestRules(),
    CharacterSpellRules characterSpellRules = const CharacterSpellRules(),
    CharacterClassResourceRules characterClassResourceRules =
        const CharacterClassResourceRules(),
    CharacterCombatRules characterCombatRules = const CharacterCombatRules(),
  }) : _database = database,
       _readDao = readDao,
       _writeDao = writeDao,
       _characterRestRules = characterRestRules,
       _characterSpellRules = characterSpellRules,
       _characterClassResourceRules = characterClassResourceRules,
       _characterCombatRules = characterCombatRules;

  final AppDatabase _database;
  final CharacterReadDao _readDao;
  final CharacterWriteDao _writeDao;
  final CharacterRestRules _characterRestRules;
  final CharacterSpellRules _characterSpellRules;
  final CharacterClassResourceRules _characterClassResourceRules;
  final CharacterCombatRules _characterCombatRules;

  Future<void> applyShortRest(String id) {
    return _applyRecovery(id, isLongRest: false);
  }

  Future<void> applyLongRest(String id) {
    return _applyRecovery(id, isLongRest: true);
  }

  Future<void> setClassResourceUses(
    String id,
    String resourceKey,
    int currentUses,
  ) async {
    final row = await _readDao.getCharacterRowById(id);
    if (row == null) {
      throw StateError('Character not found.');
    }

    final classResourceDefinitions = _characterClassResourceRules.resourcesFor(
      className: row.className,
      level: row.level,
    );
    final hasResource = classResourceDefinitions.any(
      (resource) => resource.resourceKey == resourceKey,
    );
    if (!hasResource) {
      throw StateError('Class resource not found.');
    }

    final persistedRows = await _readDao.getClassResourcesByCharacterId(id);
    final persistedByKey = <String, int>{
      for (final persisted in persistedRows)
        persisted.resourceKey: persisted.currentUses,
    };

    await _database.transaction(() async {
      final now = DateTime.now();
      await _writeDao.updateCharacter(
        id,
        CharactersCompanion(updatedAt: Value(now)),
      );
      await _writeDao.deleteClassResourcesByCharacterId(id);

      final companions = classResourceDefinitions
          .map((resource) {
            final nextValue = resource.resourceKey == resourceKey
                ? currentUses
                : (persistedByKey[resource.resourceKey] ??
                      resource.maximumUses);
            return CharacterClassResourcesCompanion.insert(
              characterId: id,
              resourceKey: resource.resourceKey,
              currentUses: Value(
                nextValue.clamp(0, resource.maximumUses).toInt(),
              ),
              lastChangedSource: const Value('manual-adjustment'),
              lastChangedAt: Value(now),
            );
          })
          .toList(growable: false);
      await _writeDao.insertClassResources(companions);
    });
  }

  Future<void> spendSpellSlot(String id, {required int spellLevel}) async {
    final row = await _readDao.getCharacterRowById(id);
    if (row == null) {
      throw StateError('Character not found.');
    }

    final slotProgression = _characterSpellRules.slotProgressionFor(
      className: row.className,
      level: row.level,
    );
    final matchingSlot = slotProgression.where(
      (slot) => slot.spellLevel == spellLevel,
    ).firstOrNull;
    if (matchingSlot == null) {
      throw StateError('Spell slot level is not available for this character.');
    }

    final persistedUsages = await _readDao.getSpellSlotUsagesByCharacterId(id);
    final currentUsage = persistedUsages
      .where((usage) => usage.spellLevel == spellLevel)
      .map((usage) => usage.slotsExpended)
      .fold<int>(0, (_, value) => value);
    if (currentUsage < 0) {
      // This check should be impossible with current data, but protects against state corruption.
      throw StateError('Spell slot usage cannot be negative.');
    }

    await _database.transaction(() async {
      final now = DateTime.now();
      await _writeDao.updateCharacter(
        id,
        CharactersCompanion(updatedAt: Value(now)),
      );
      await _writeDao.upsertSpellSlotUsage(
        CharacterSpellSlotUsagesCompanion.insert(
          characterId: id,
          spellLevel: spellLevel,
          slotsExpended: Value(currentUsage + 1),
        ),
      );
    });
  }

  Future<void> restoreSpellSlot(String id, {required int spellLevel}) async {
    final row = await _readDao.getCharacterRowById(id);
    if (row == null) {
      throw StateError('Character not found.');
    }

    final slotProgression = _characterSpellRules.slotProgressionFor(
      className: row.className,
      level: row.level,
    );
    final matchingSlot = slotProgression.where(
      (slot) => slot.spellLevel == spellLevel,
    ).firstOrNull;
    if (matchingSlot == null) {
      throw StateError('Spell slot level is not available for this character.');
    }

    final persistedUsages = await _readDao.getSpellSlotUsagesByCharacterId(id);
    final currentUsage = persistedUsages
      .where((usage) => usage.spellLevel == spellLevel)
      .map((usage) => usage.slotsExpended)
      .fold<int>(0, (_, value) => value);
    if (currentUsage <= 0) {
      throw StateError('Spell slot usage is already at minimum for this level.');
    }

    await _database.transaction(() async {
      final now = DateTime.now();
      await _writeDao.updateCharacter(
        id,
        CharactersCompanion(updatedAt: Value(now)),
      );
      await _writeDao.upsertSpellSlotUsage(
        CharacterSpellSlotUsagesCompanion.insert(
          characterId: id,
          spellLevel: spellLevel,
          slotsExpended: Value(currentUsage - 1),
        ),
      );
    });
  }

  Future<void> _applyRecovery(String id, {required bool isLongRest}) async {
    final row = await _readDao.getCharacterRowById(id);
    if (row == null) {
      throw StateError('Character not found.');
    }

    final hitPoints = await _readDao.getHitPointsByCharacterId(id);
    final slotUsages = await _readDao.getSpellSlotUsagesByCharacterId(id);
    final classResources = await _readDao.getClassResourcesByCharacterId(id);
    final inventory = await _readDao.getInventoryByCharacterId(id);
    final slotUsagesByLevel = <int, int>{
      for (final slot in slotUsages) slot.spellLevel: slot.slotsExpended,
    };
    final persistedResourceCurrentByKey = <String, int>{
      for (final row in classResources) row.resourceKey: row.currentUses,
    };
    final classResourceDefinitions = _characterClassResourceRules.resourcesFor(
      className: row.className,
      level: row.level,
    );

    final maximumHitPoints = (hitPoints?.maximum ?? 0).clamp(0, 9999);
    final restResult = isLongRest
        ? _characterRestRules.applyLongRest(
            className: row.className,
            level: row.level,
            maximumHitPoints: maximumHitPoints,
          )
        : _characterRestRules.applyShortRest(
            className: row.className,
            level: row.level,
            currentHitPoints: (hitPoints?.current ?? maximumHitPoints).clamp(
              0,
              maximumHitPoints,
            ),
            maximumHitPoints: maximumHitPoints,
            temporaryHitPoints: (hitPoints?.temporary ?? 0).clamp(0, 9999),
            slotUsagesByLevel: slotUsagesByLevel,
          );

    await _database.transaction(() async {
      final now = DateTime.now();
      await _writeDao.updateCharacter(
        id,
        CharactersCompanion(updatedAt: Value(now)),
      );
      final hitPointCompanion = CharacterHitPointsCompanion(
        characterId: Value(id),
        current: Value(restResult.currentHitPoints),
        maximum: Value(restResult.maximumHitPoints),
        temporary: Value(restResult.temporaryHitPoints),
      );
      if (hitPoints == null) {
        await _writeDao.insertHitPoints(
          CharacterHitPointsCompanion.insert(
            characterId: id,
            current: restResult.currentHitPoints,
            maximum: restResult.maximumHitPoints,
            temporary: restResult.temporaryHitPoints,
          ),
        );
      } else {
        await _writeDao.replaceHitPoints(hitPointCompanion);
      }

      await _writeDao.deleteSpellSlotUsagesByCharacterId(id);
      final slotCompanions = restResult.slotUsagesByLevel.entries
          .map(
            (entry) => CharacterSpellSlotUsagesCompanion.insert(
              characterId: id,
              spellLevel: entry.key,
              slotsExpended: Value(entry.value),
            ),
          )
          .toList(growable: false);
      await _writeDao.insertSpellSlotUsages(slotCompanions);

      await _writeDao.deleteClassResourcesByCharacterId(id);
      final resourceCompanions = classResourceDefinitions
          .map((resource) {
            final current =
                persistedResourceCurrentByKey[resource.resourceKey] ??
                resource.maximumUses;
            final recoveredCurrent = isLongRest || resource.recoversOnShortRest
                ? resource.maximumUses
                : current.clamp(0, resource.maximumUses).toInt();
            return CharacterClassResourcesCompanion.insert(
              characterId: id,
              resourceKey: resource.resourceKey,
              currentUses: Value(recoveredCurrent),
              lastChangedSource: Value(isLongRest ? 'long-rest' : 'short-rest'),
              lastChangedAt: Value(now),
            );
          })
          .toList(growable: false);
      await _writeDao.insertClassResources(resourceCompanions);

      if (isLongRest) {
        final resetDeathSaves = _characterCombatRules.resetDeathSaves();
        await _writeDao.replaceDeathSaves(
          CharacterDeathSavesCompanion.insert(
            characterId: id,
            successCount: Value(resetDeathSaves.successCount),
            failureCount: Value(resetDeathSaves.failureCount),
            updatedAt: Value(now),
          ),
        );

        for (final item in inventory) {
          final chargesMax = item.chargesMax;
          if (chargesMax == null) {
            continue;
          }

          await _writeDao.updateInventoryItem(
            item.id,
            CharacterInventoryCompanion(
              chargesCurrent: Value(chargesMax.clamp(0, 9999).toInt()),
              chargesMax: Value(chargesMax.clamp(0, 9999).toInt()),
            ),
          );
        }
      }
    });
  }
}
