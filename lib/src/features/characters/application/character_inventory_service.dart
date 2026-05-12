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
    void Function(String characterId)? onCharacterChanged,
  }) : _database = database,
       _readDao = readDao,
       _writeDao = writeDao,
       _onCharacterChanged = onCharacterChanged;

  final AppDatabase _database;
  final CharacterReadDao _readDao;
  final CharacterWriteDao _writeDao;
  final void Function(String characterId)? _onCharacterChanged;

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

    final removed = await _database.transaction(() async {
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

    _onCharacterChanged?.call(id);
    return removed;
  }

  Future<String> transferInventoryItemStackToContainer(
    String id,
    String sourceInventoryItemId, {
    required String targetContainerInventoryItemId,
    int? quantity,
  }) async {
    final normalizedTargetContainerId = targetContainerInventoryItemId.trim();
    if (normalizedTargetContainerId.isEmpty) {
      throw const CharacterInventoryValidationError(
        'invalid_target',
        'Target container is required for stack transfer.',
      );
    }

    final source = await _requireInventoryItem(id, sourceInventoryItemId);
    final sourceIsStackable = await _isStackable(source);
    if (!sourceIsStackable) {
      throw const CharacterInventoryValidationError(
        'invalid_stack_state',
        'Only stackable items can be transferred between containers.',
      );
    }

    final requestedQuantity = quantity ?? source.quantity;
    if (requestedQuantity <= 0) {
      throw const CharacterInventoryValidationError(
        'invalid_quantity',
        'Transfer quantity must be greater than zero.',
      );
    }
    if (requestedQuantity > source.quantity) {
      throw const CharacterInventoryValidationError(
        'insufficient_quantity',
        'Source stack does not have enough quantity for this transfer.',
      );
    }

    final inventoryItems = await _readDao.getInventoryByCharacterId(id);
    final itemById = <String, CharacterInventoryData>{
      for (final item in inventoryItems) item.id: item,
    };
    final targetContainer = itemById[normalizedTargetContainerId];
    if (targetContainer == null) {
      throw const CharacterInventoryValidationError(
        'invalid_target',
        'Container item not found for this character.',
      );
    }

    final projectedItems = inventoryItems
        .map(_ProjectedInventoryItem.fromData)
        .toList(growable: true);
    final sourceIndex = projectedItems.indexWhere(
      (item) => item.id == source.id,
    );
    if (sourceIndex < 0) {
      throw const CharacterInventoryValidationError(
        'invalid_target',
        'Inventory item not found for this character.',
      );
    }

    final projectedSource = projectedItems[sourceIndex];
    final transferredShape = projectedSource.copyWith(
      quantity: requestedQuantity,
      containerInventoryItemId: normalizedTargetContainerId,
    );
    final identityCandidates =
        projectedItems
            .where(
              (item) =>
                  item.id != projectedSource.id &&
                  item.containerInventoryItemId ==
                      normalizedTargetContainerId &&
                  _hasSameStackIdentity(source: projectedSource, target: item),
            )
            .toList(growable: false)
          ..sort((left, right) => left.id.compareTo(right.id));
    final compatibleCandidates = identityCandidates
        .where(
          (candidate) => _areProjectedStacksCompatible(
            source: transferredShape,
            target: candidate,
          ),
        )
        .toList(growable: false);
    if (identityCandidates.isNotEmpty && compatibleCandidates.isEmpty) {
      throw const CharacterInventoryValidationError(
        'invalid_stack_state',
        'Stacks are not compatible for container transfer merge.',
      );
    }
    if (compatibleCandidates.isNotEmpty &&
        compatibleCandidates.length != identityCandidates.length) {
      throw const CharacterInventoryValidationError(
        'invalid_stack_state',
        'Target container has mixed same-item stack state. Normalize stacks before transfer.',
      );
    }
    final mergeTarget = compatibleCandidates.isEmpty
        ? null
        : compatibleCandidates.first;

    final definitionIds = inventoryItems
        .map((item) => item.equipmentDefinitionId)
        .whereType<String>();
    final definitions = await _readDao.getEquipmentDefinitionsByIds(
      definitionIds,
    );
    final definitionsById = <String, EquipmentDefinition>{
      for (final definition in definitions) definition.id: definition,
    };

    String transferredStackId;
    String? splitStackId;
    int? sourceQuantityAfterMerge;
    int? targetQuantityAfterMerge;

    if (mergeTarget != null) {
      final mergeResult = CharacterInventoryStackRules.merge(
        sourceQuantity: projectedSource.quantity,
        targetQuantity: mergeTarget.quantity,
        mergeQuantity: requestedQuantity,
        sourceIsStackable: true,
        targetIsStackable: true,
        isCompatible: true,
      );

      sourceQuantityAfterMerge = mergeResult.sourceQuantity;
      targetQuantityAfterMerge = mergeResult.targetQuantity;
      transferredStackId = mergeTarget.id;

      final targetIndex = projectedItems.indexWhere(
        (item) => item.id == mergeTarget.id,
      );
      projectedItems[targetIndex] = projectedItems[targetIndex].copyWith(
        quantity: mergeResult.targetQuantity,
      );
      if (CharacterInventoryStackRules.shouldRetireZeroQuantityStack(
        mergeResult.sourceQuantity,
      )) {
        projectedItems.removeAt(sourceIndex);
      } else {
        projectedItems[sourceIndex] = projectedSource.copyWith(
          quantity: mergeResult.sourceQuantity,
        );
      }
    } else if (requestedQuantity == projectedSource.quantity) {
      transferredStackId = projectedSource.id;
      projectedItems[sourceIndex] = projectedSource.copyWith(
        containerInventoryItemId: normalizedTargetContainerId,
      );
    } else {
      final splitResult = CharacterInventoryStackRules.split(
        sourceQuantity: projectedSource.quantity,
        splitQuantity: requestedQuantity,
        isStackable: true,
      );
      splitStackId = _nextInventoryItemId(id, inventoryItems);
      transferredStackId = splitStackId;

      projectedItems[sourceIndex] = projectedSource.copyWith(
        quantity: splitResult.sourceQuantity,
      );
      projectedItems.add(
        projectedSource.copyWith(
          id: splitStackId,
          quantity: splitResult.splitQuantity,
          containerInventoryItemId: normalizedTargetContainerId,
        ),
      );
    }

    _validateProjectedInventory(
      projectedItems,
      definitionsById: definitionsById,
    );

    await _database.transaction(() async {
      final now = DateTime.now();
      await _writeDao.updateCharacter(
        id,
        CharactersCompanion(updatedAt: Value(now)),
      );

      if (mergeTarget != null) {
        await _writeDao.updateInventoryItem(
          mergeTarget.id,
          CharacterInventoryCompanion(
            id: Value(mergeTarget.id),
            quantity: Value(targetQuantityAfterMerge!),
          ),
        );
        if (CharacterInventoryStackRules.shouldRetireZeroQuantityStack(
          sourceQuantityAfterMerge ?? 0,
        )) {
          await _writeDao.deleteInventoryItemById(source.id);
        } else {
          await _writeDao.updateInventoryItem(
            source.id,
            CharacterInventoryCompanion(
              id: Value(source.id),
              quantity: Value(sourceQuantityAfterMerge!),
            ),
          );
        }
        return;
      }

      if (splitStackId == null) {
        await _writeDao.updateInventoryItem(
          source.id,
          CharacterInventoryCompanion(
            id: Value(source.id),
            containerInventoryItemId: Value(normalizedTargetContainerId),
          ),
        );
        return;
      }

      final splitQuantity = requestedQuantity;
      final nextSourceQuantity = source.quantity - splitQuantity;
      await _writeDao.updateInventoryItem(
        source.id,
        CharacterInventoryCompanion(
          id: Value(source.id),
          quantity: Value(nextSourceQuantity),
        ),
      );
      await _writeDao.insertInventoryItem(
        CharacterInventoryCompanion.insert(
          id: splitStackId,
          characterId: id,
          equipmentDefinitionId: Value(source.equipmentDefinitionId),
          trinketDefinitionId: Value(source.trinketDefinitionId),
          displayNameSnapshot: Value(source.displayNameSnapshot),
          quantity: Value(splitQuantity),
          isEquipped: Value(source.isEquipped),
          isCarried: Value(source.isCarried),
          isFavorite: Value(source.isFavorite),
          chargesCurrent: Value(source.chargesCurrent),
          chargesMax: Value(source.chargesMax),
          containerInventoryItemId: Value(normalizedTargetContainerId),
          notes: Value(source.notes),
        ),
      );
    });

    _onCharacterChanged?.call(id);
    return transferredStackId;
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

  Future<String> createContainer(
    String id,
    String containerId,
    String name,
  ) async {
    await _validateContainerCreation(id, containerId, name);

    await _database.transaction(() async {
      final now = DateTime.now();
      await _writeDao.updateCharacter(
        id,
        CharactersCompanion(updatedAt: Value(now)),
      );
      await _writeDao.insertInventoryItem(
        CharacterInventoryCompanion.insert(
          id: containerId,
          characterId: id,
          equipmentDefinitionId: Value(null),
          trinketDefinitionId: Value(null),
          displayNameSnapshot: Value(name),
          quantity: Value(0),
          isEquipped: Value(false),
          isCarried: Value(false),
          isFavorite: Value(false),
          containerInventoryItemId: Value(null),
          chargesCurrent: Value(null),
          chargesMax: Value(null),
          notes: Value(''),
        ),
      );
    });

    _onCharacterChanged?.call(id);
    return containerId;
  }

  Future<void> deleteContainer(
    String id,
    String containerInventoryItemId,
  ) async {
    if (containerInventoryItemId.isEmpty) {
      throw const CharacterInventoryValidationError(
        'invalid_target',
        'Container ID cannot be empty.',
      );
    }

    final character = await _readDao.getCharacterRowById(id);
    if (character == null) {
      throw StateError('Character not found.');
    }

    final container = await _readDao.getInventoryItemById(
      containerInventoryItemId,
    );
    if (container == null || container.characterId != id) {
      throw StateError('Container not found for this character.');
    }

    await _database.transaction(() async {
      final now = DateTime.now();
      await _writeDao.updateCharacter(
        id,
        CharactersCompanion(updatedAt: Value(now)),
      );
      await _writeDao.deleteInventoryItemById(containerInventoryItemId);
    });

    _onCharacterChanged?.call(id);
  }

  Future<void> _validateContainerCreation(
    String id,
    String containerId,
    String name,
  ) async {
    if (containerId.isEmpty) {
      throw const CharacterInventoryValidationError(
        'invalid_target',
        'Container ID cannot be empty.',
      );
    }

    final normalizedContainerId = containerId.trim();
    if (normalizedContainerId.isEmpty) {
      throw const CharacterInventoryValidationError(
        'invalid_target',
        'Container name cannot be empty.',
      );
    }

    final inventoryItems = await _readDao.getInventoryByCharacterId(id);
    final itemById = <String, CharacterInventoryData>{
      for (final item in inventoryItems) item.id: item,
    };
    final existingItem = itemById[normalizedContainerId];
    if (existingItem != null) {
      throw const CharacterInventoryValidationError(
        'invalid_structure',
        'A container with this name already exists for this character.',
      );
    }
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

    _onCharacterChanged?.call(id);
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

  bool _hasSameStackIdentity({
    required _ProjectedInventoryItem source,
    required _ProjectedInventoryItem target,
  }) {
    return source.equipmentDefinitionId == target.equipmentDefinitionId &&
        source.trinketDefinitionId == target.trinketDefinitionId &&
        source.displayNameSnapshot == target.displayNameSnapshot;
  }

  bool _areProjectedStacksCompatible({
    required _ProjectedInventoryItem source,
    required _ProjectedInventoryItem target,
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

  void _validateProjectedInventory(
    List<_ProjectedInventoryItem> projectedItems, {
    required Map<String, EquipmentDefinition> definitionsById,
  }) {
    final displayNameById = <String, String>{
      for (final item in projectedItems)
        item.id:
            item.displayNameSnapshot ??
            definitionsById[item.equipmentDefinitionId]?.name ??
            item.equipmentDefinitionId ??
            item.trinketDefinitionId ??
            'Unknown item',
    };

    final report = const CharacterInventoryInvariantEvaluator().evaluate(
      projectedItems
          .map(
            (item) => CharacterEquipmentItemDomainModel(
              id: item.id,
              name: displayNameById[item.id] ?? 'Unknown item',
              quantity: item.quantity,
              isEquipped: item.isEquipped,
              isCarried: item.isCarried,
              isFavorite: item.isFavorite,
              weightPerUnit:
                  definitionsById[item.equipmentDefinitionId]?.weight,
              isContainer:
                  definitionsById[item.equipmentDefinitionId]?.isContainer ??
                  false,
              chargesCurrent: item.chargesCurrent,
              chargesMax: item.chargesMax,
              containerInventoryItemId: item.containerInventoryItemId,
              containerDisplayName: null,
            ),
          )
          .toList(growable: false),
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

class _ProjectedInventoryItem {
  const _ProjectedInventoryItem({
    required this.id,
    required this.characterId,
    required this.equipmentDefinitionId,
    required this.trinketDefinitionId,
    required this.displayNameSnapshot,
    required this.quantity,
    required this.isEquipped,
    required this.isCarried,
    required this.isFavorite,
    required this.chargesCurrent,
    required this.chargesMax,
    required this.containerInventoryItemId,
    required this.notes,
  });

  factory _ProjectedInventoryItem.fromData(CharacterInventoryData item) {
    return _ProjectedInventoryItem(
      id: item.id,
      characterId: item.characterId,
      equipmentDefinitionId: item.equipmentDefinitionId,
      trinketDefinitionId: item.trinketDefinitionId,
      displayNameSnapshot: item.displayNameSnapshot,
      quantity: item.quantity,
      isEquipped: item.isEquipped,
      isCarried: item.isCarried,
      isFavorite: item.isFavorite,
      chargesCurrent: item.chargesCurrent,
      chargesMax: item.chargesMax,
      containerInventoryItemId: item.containerInventoryItemId,
      notes: item.notes,
    );
  }

  final String id;
  final String characterId;
  final String? equipmentDefinitionId;
  final String? trinketDefinitionId;
  final String? displayNameSnapshot;
  final int quantity;
  final bool isEquipped;
  final bool isCarried;
  final bool isFavorite;
  final int? chargesCurrent;
  final int? chargesMax;
  final String? containerInventoryItemId;
  final String? notes;

  _ProjectedInventoryItem copyWith({
    String? id,
    int? quantity,
    String? containerInventoryItemId,
  }) {
    return _ProjectedInventoryItem(
      id: id ?? this.id,
      characterId: characterId,
      equipmentDefinitionId: equipmentDefinitionId,
      trinketDefinitionId: trinketDefinitionId,
      displayNameSnapshot: displayNameSnapshot,
      quantity: quantity ?? this.quantity,
      isEquipped: isEquipped,
      isCarried: isCarried,
      isFavorite: isFavorite,
      chargesCurrent: chargesCurrent,
      chargesMax: chargesMax,
      containerInventoryItemId:
          containerInventoryItemId ?? this.containerInventoryItemId,
      notes: notes,
    );
  }
}
