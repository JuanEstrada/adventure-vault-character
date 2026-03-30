import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:adventure_vault_character/src/features/characters/data/local/character_read_dao.dart';
import 'package:adventure_vault_character/src/features/characters/data/local/character_write_dao.dart';
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
    if (containerInventoryItemId != null &&
        containerInventoryItemId.isNotEmpty) {
      if (containerInventoryItemId == inventoryItemId) {
        throw StateError('Item cannot contain itself.');
      }

      final containerItem = await _readDao.getInventoryItemById(
        containerInventoryItemId,
      );
      if (containerItem == null || containerItem.characterId != id) {
        throw StateError('Container item not found.');
      }

      final containerDefinitionId = containerItem.equipmentDefinitionId;
      final containerDefinition = containerDefinitionId == null
          ? null
          : await _readDao.getEquipmentDefinitionById(containerDefinitionId);
      if (containerDefinition?.isContainer != true) {
        throw StateError('Target item is not a container.');
      }

      final inventoryItems = await _readDao.getInventoryByCharacterId(id);
      final byId = <String, CharacterInventoryData>{
        for (final item in inventoryItems) item.id: item,
      };
      String? cursor = containerInventoryItemId;
      while (cursor != null) {
        if (cursor == inventoryItemId) {
          throw StateError('Container assignment would create a cycle.');
        }
        cursor = byId[cursor]?.containerInventoryItemId;
      }
    }

    await _updateInventoryItem(
      id,
      inventoryItemId,
      containerInventoryItemId: Value(
        containerInventoryItemId == null || containerInventoryItemId.isEmpty
            ? null
            : containerInventoryItemId,
      ),
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
