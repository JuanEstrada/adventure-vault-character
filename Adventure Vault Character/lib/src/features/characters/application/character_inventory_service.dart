import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:adventure_vault_character/src/features/characters/data/local/character_read_dao.dart';
import 'package:adventure_vault_character/src/features/characters/data/local/character_write_dao.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_inventory_quantity_rules.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_inventory_stack_rules.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_inventory_validation_error.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:drift/drift.dart';

class CharacterInventoryService {
  CharacterInventoryService({
    required AppDatabase database,
    required CharacterReadDao readDao,
    required CharacterWriteDao writeDao,
  }) : _database = database,
       _readDao = readDao,
       _writeDao = writeDao;

  final AppDatabase _database;
  final CharacterReadDao _readDao;
  final CharacterWriteDao _writeDao;

  Future<void> setInventoryItemEquipped(
    String id,
    String inventoryItemId,
    bool isEquipped,
  ) {
    return _updateInventoryItem(
      id,
      inventoryItemId,
      isEquipped: Value(isEquipped),
    );
  }

  Future<void> setInventoryItemCarried(
    String id,
    String inventoryItemId,
    bool isCarried,
  ) {
    return _updateInventoryItem(
      id,
      inventoryItemId,
      isCarried: Value(isCarried),
    );
  }

  Future<void> setInventoryItemQuantity(
    String id,
    String inventoryItemId,
    int quantity,
  ) {
    return _updateInventoryItem(
      id,
      inventoryItemId,
      quantity: Value(quantity.clamp(0, 9999).toInt()),
    );
  }

  Future<void> spendInventoryItemQuantity(
    String id,
    String inventoryItemId, {
    int amount = 1,
  }) async {
    final item = await _requireInventoryItem(id, inventoryItemId);
    final nextQuantity = CharacterInventoryQuantityRules.spend(
      currentQuantity: item.quantity,
      amount: amount,
    );

    await _updateInventoryItem(
      id,
      inventoryItemId,
      quantity: Value(nextQuantity),
    );
  }

  Future<String> splitInventoryItemStack(
    String id,
    String inventoryItemId, {
    required int quantity,
  }) async {
    final source = await _requireInventoryItem(id, inventoryItemId);
    final sourceIsStackable = await _isStackable(source);
    final splitResult = CharacterInventoryStackRules.split(
      sourceQuantity: source.quantity,
      splitQuantity: quantity,
      isStackable: sourceIsStackable,
    );
    final existingItems = await _readDao.getInventoryByCharacterId(id);
    final newItemId = _nextInventoryItemId(id, existingItems);

    await _database.transaction(() async {
      final now = DateTime.now();
      await _writeDao.updateCharacter(
        id,
        CharactersCompanion(updatedAt: Value(now)),
      );
      await _writeDao.updateInventoryItem(
        source.id,
        CharacterInventoryCompanion(
          id: Value(source.id),
          quantity: Value(splitResult.sourceQuantity),
        ),
      );
      await _writeDao.insertInventoryItem(
        CharacterInventoryCompanion.insert(
          id: newItemId,
          characterId: id,
          equipmentDefinitionId: Value(source.equipmentDefinitionId),
          trinketDefinitionId: Value(source.trinketDefinitionId),
          displayNameSnapshot: Value(source.displayNameSnapshot),
          quantity: Value(splitResult.splitQuantity),
          isEquipped: Value(source.isEquipped),
          isCarried: Value(source.isCarried),
          isFavorite: Value(source.isFavorite),
          chargesCurrent: Value(source.chargesCurrent),
          chargesMax: Value(source.chargesMax),
          containerInventoryItemId: Value(source.containerInventoryItemId),
          notes: Value(source.notes),
        ),
      );
    });

    return newItemId;
  }

  Future<void> mergeInventoryItemStacks(
    String id,
    String sourceInventoryItemId,
    String targetInventoryItemId, {
    int? quantity,
  }) async {
    if (sourceInventoryItemId == targetInventoryItemId) {
      throw const CharacterInventoryValidationError(
        'invalid_target',
        'Cannot merge an inventory stack into itself.',
      );
    }

    final source = await _requireInventoryItem(id, sourceInventoryItemId);
    final target = await _requireInventoryItem(id, targetInventoryItemId);
    final sourceIsStackable = await _isStackable(source);
    final targetIsStackable = await _isStackable(target);
    final mergeResult = CharacterInventoryStackRules.merge(
      sourceQuantity: source.quantity,
      targetQuantity: target.quantity,
      mergeQuantity: quantity ?? source.quantity,
      sourceIsStackable: sourceIsStackable,
      targetIsStackable: targetIsStackable,
      isCompatible: _areStacksCompatible(source: source, target: target),
    );

    await _database.transaction(() async {
      final now = DateTime.now();
      await _writeDao.updateCharacter(
        id,
        CharactersCompanion(updatedAt: Value(now)),
      );
      await _writeDao.updateInventoryItem(
        target.id,
        CharacterInventoryCompanion(
          id: Value(target.id),
          quantity: Value(mergeResult.targetQuantity),
        ),
      );
      if (CharacterInventoryStackRules.shouldRetireZeroQuantityStack(
        mergeResult.sourceQuantity,
      )) {
        await _writeDao.deleteInventoryItemById(source.id);
      } else {
        await _writeDao.updateInventoryItem(
          source.id,
          CharacterInventoryCompanion(
            id: Value(source.id),
            quantity: Value(mergeResult.sourceQuantity),
          ),
        );
      }
    });
  }

  Future<int> retireZeroQuantityInventoryStacks(String id) async {
    final character = await _readDao.getCharacterRowById(id);
    if (character == null) {
      throw StateError('Character not found.');
    }

    return _database.transaction(() async {
      final removed = await _writeDao.deleteZeroQuantityInventoryByCharacterId(
        id,
      );
      if (removed > 0) {
        await _writeDao.updateCharacter(
          id,
          CharactersCompanion(updatedAt: Value(DateTime.now())),
        );
      }
      return removed;
    });
  }

  Future<void> setInventoryItemCharges(
    String id,
    String inventoryItemId, {
    int? chargesCurrent,
    int? chargesMax,
  }) async {
    if (chargesMax == null && chargesCurrent != null) {
      throw const CharacterInventoryValidationError(
        'invalid_charge_state',
        'Cannot set current charges without maximum charges.',
      );
    }

    final normalizedMax = chargesMax?.clamp(0, 9999).toInt();
    final normalizedCurrent = normalizedMax == null
        ? null
        : (chargesCurrent ?? normalizedMax).clamp(0, normalizedMax).toInt();
    await _updateInventoryItem(
      id,
      inventoryItemId,
      chargesCurrent: Value(normalizedCurrent),
      chargesMax: Value(normalizedMax),
    );
  }

  Future<void> spendInventoryItemCharges(
    String id,
    String inventoryItemId, {
    int amount = 1,
  }) async {
    if (amount <= 0) {
      throw const CharacterInventoryValidationError(
        'invalid_charge_state',
        'Charge spend amount must be greater than zero.',
      );
    }

    final item = await _requireInventoryItem(id, inventoryItemId);
    final max = item.chargesMax;
    final current = item.chargesCurrent;
    if (max == null || current == null) {
      throw const CharacterInventoryValidationError(
        'invalid_charge_state',
        'Item is not configured for charge tracking.',
      );
    }
    if (current < amount) {
      throw const CharacterInventoryValidationError(
        'insufficient_charges',
        'Item does not have enough charges for this action.',
      );
    }

    await _updateInventoryItem(
      id,
      inventoryItemId,
      chargesCurrent: Value((current - amount).clamp(0, max).toInt()),
      chargesMax: Value(max),
    );
  }

  Future<void> restoreInventoryItemCharges(
    String id,
    String inventoryItemId, {
    int amount = 1,
  }) async {
    if (amount <= 0) {
      throw const CharacterInventoryValidationError(
        'invalid_charge_state',
        'Charge restore amount must be greater than zero.',
      );
    }

    final item = await _requireInventoryItem(id, inventoryItemId);
    final max = item.chargesMax;
    final current = item.chargesCurrent;
    if (max == null || current == null) {
      throw const CharacterInventoryValidationError(
        'invalid_charge_state',
        'Item is not configured for charge tracking.',
      );
    }

    await _updateInventoryItem(
      id,
      inventoryItemId,
      chargesCurrent: Value((current + amount).clamp(0, max).toInt()),
      chargesMax: Value(max),
    );
  }

  Future<CharacterInventoryData> _requireInventoryItem(
    String characterId,
    String inventoryItemId,
  ) async {
    final item = await _readDao.getInventoryItemById(inventoryItemId);
    if (item == null || item.characterId != characterId) {
      throw const CharacterInventoryValidationError(
        'invalid_target',
        'Inventory item not found for this character.',
      );
    }
    return item;
  }

  Future<void> setInventoryItemContainer(
    String id,
    String inventoryItemId,
    String? containerInventoryItemId,
  ) async {
    final normalizedContainerId =
        containerInventoryItemId == null || containerInventoryItemId.isEmpty
        ? null
        : containerInventoryItemId;

    await _validateContainerAssignment(
      id,
      inventoryItemId,
      normalizedContainerId,
    );

    await _updateInventoryItem(
      id,
      inventoryItemId,
      containerInventoryItemId: Value(normalizedContainerId),
    );
  }

  Future<void> _validateContainerAssignment(
    String characterId,
    String inventoryItemId,
    String? containerInventoryItemId,
  ) async {
    if (containerInventoryItemId == null) {
      return;
    }

    if (inventoryItemId == containerInventoryItemId) {
      throw const CharacterInventoryValidationError(
        'invalid_structure',
        'Item cannot reference itself as a container.',
      );
    }

    final inventoryItems = await _readDao.getInventoryByCharacterId(
      characterId,
    );
    final itemById = <String, CharacterInventoryData>{
      for (final item in inventoryItems) item.id: item,
    };
    final inventoryItem = itemById[inventoryItemId];
    if (inventoryItem == null) {
      throw const CharacterInventoryValidationError(
        'invalid_target',
        'Inventory item not found for this character.',
      );
    }
    final targetContainer = itemById[containerInventoryItemId];
    if (targetContainer == null) {
      throw const CharacterInventoryValidationError(
        'invalid_target',
        'Container item not found for this character.',
      );
    }

    final definitionIds = inventoryItems
        .map((item) => item.equipmentDefinitionId)
        .whereType<String>();
    final definitions = await _readDao.getEquipmentDefinitionsByIds(
      definitionIds,
    );
    final definitionsById = <String, EquipmentDefinition>{
      for (final definition in definitions) definition.id: definition,
    };

    final displayNameById = <String, String>{
      for (final item in inventoryItems)
        item.id:
            item.displayNameSnapshot ??
            definitionsById[item.equipmentDefinitionId]?.name ??
            item.equipmentDefinitionId ??
            item.trinketDefinitionId ??
            'Unknown item',
    };

    final projectedItems = inventoryItems
        .map(
          (item) => CharacterEquipmentItemDomainModel(
            id: item.id,
            name: displayNameById[item.id] ?? 'Unknown item',
            quantity: item.quantity,
            isEquipped: item.isEquipped,
            isCarried: item.isCarried,
            isFavorite: item.isFavorite,
            weightPerUnit: definitionsById[item.equipmentDefinitionId]?.weight,
            isContainer:
                definitionsById[item.equipmentDefinitionId]?.isContainer ??
                false,
            chargesCurrent: item.chargesCurrent,
            chargesMax: item.chargesMax,
            containerInventoryItemId: item.id == inventoryItemId
                ? containerInventoryItemId
                : item.containerInventoryItemId,
            containerDisplayName: null,
          ),
        )
        .toList(growable: false);

    final report = const CharacterInventoryInvariantEvaluator().evaluate(
      projectedItems,
    );
    final structuralIssues = report.issues.where(
      (issue) =>
          issue.code == 'invalid_target' ||
          issue.code == 'invalid_structure' ||
          issue.code == 'capacity_exceeded',
    );
    if (structuralIssues.isEmpty) {
      return;
    }

    final firstIssue = structuralIssues.first;
    throw CharacterInventoryValidationError(
      firstIssue.code,
      firstIssue.message,
    );
  }

  Future<void> _updateInventoryItem(
    String id,
    String inventoryItemId, {
    Value<bool> isEquipped = const Value.absent(),
    Value<bool> isCarried = const Value.absent(),
    Value<int> quantity = const Value.absent(),
    Value<int?> chargesCurrent = const Value.absent(),
    Value<int?> chargesMax = const Value.absent(),
    Value<String?> containerInventoryItemId = const Value.absent(),
  }) async {
    final character = await _readDao.getCharacterRowById(id);
    if (character == null) {
      throw StateError('Character not found.');
    }

    final inventoryItem = await _readDao.getInventoryItemById(inventoryItemId);
    if (inventoryItem == null || inventoryItem.characterId != id) {
      throw StateError('Inventory item not found.');
    }

    await _database.transaction(() async {
      final now = DateTime.now();
      await _writeDao.updateCharacter(
        id,
        CharactersCompanion(updatedAt: Value(now)),
      );
      await _writeDao.updateInventoryItem(
        inventoryItemId,
        CharacterInventoryCompanion(
          id: Value(inventoryItemId),
          isEquipped: isEquipped,
          isCarried: isCarried,
          quantity: quantity,
          chargesCurrent: chargesCurrent,
          chargesMax: chargesMax,
          containerInventoryItemId: containerInventoryItemId,
        ),
      );
    });
  }

  Future<bool> _isStackable(CharacterInventoryData item) async {
    final equipmentId = item.equipmentDefinitionId;
    if (equipmentId == null || equipmentId.isEmpty) {
      return false;
    }
    final definition = await _readDao.getEquipmentDefinitionById(equipmentId);
    return definition?.isStackable ?? false;
  }

  bool _areStacksCompatible({
    required CharacterInventoryData source,
    required CharacterInventoryData target,
  }) {
    return source.equipmentDefinitionId == target.equipmentDefinitionId &&
        source.trinketDefinitionId == target.trinketDefinitionId &&
        source.displayNameSnapshot == target.displayNameSnapshot &&
        source.isEquipped == target.isEquipped &&
        source.isCarried == target.isCarried &&
        source.isFavorite == target.isFavorite &&
        source.chargesCurrent == target.chargesCurrent &&
        source.chargesMax == target.chargesMax &&
        source.containerInventoryItemId == target.containerInventoryItemId &&
        source.notes == target.notes;
  }

  String _nextInventoryItemId(
    String characterId,
    List<CharacterInventoryData> inventory,
  ) {
    var nextIndex = 1;
    final pattern = RegExp('^${RegExp.escape(characterId)}-inventory-(\\d+)');
    for (final item in inventory) {
      final match = pattern.firstMatch(item.id);
      if (match == null) {
        continue;
      }
      final parsed = int.tryParse(match.group(1) ?? '');
      if (parsed != null && parsed >= nextIndex) {
        nextIndex = parsed + 1;
      }
    }
    return '$characterId-inventory-$nextIndex';
  }
}
