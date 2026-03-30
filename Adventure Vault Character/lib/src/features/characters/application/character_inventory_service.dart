import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:adventure_vault_character/src/features/characters/data/local/character_read_dao.dart';
import 'package:adventure_vault_character/src/features/characters/data/local/character_write_dao.dart';
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

  Future<void> setInventoryItemCharges(
    String id,
    String inventoryItemId, {
    int? chargesCurrent,
    int? chargesMax,
  }) {
    final normalizedMax = chargesMax?.clamp(0, 9999).toInt();
    final normalizedCurrent = normalizedMax == null
        ? null
        : chargesCurrent?.clamp(0, normalizedMax).toInt();
    return _updateInventoryItem(
      id,
      inventoryItemId,
      chargesCurrent: Value(normalizedCurrent),
      chargesMax: Value(normalizedMax),
    );
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
}

class CharacterInventoryValidationError implements Exception {
  const CharacterInventoryValidationError(this.code, this.message);

  final String code;
  final String message;

  @override
  String toString() => 'CharacterInventoryValidationError($code): $message';
}
