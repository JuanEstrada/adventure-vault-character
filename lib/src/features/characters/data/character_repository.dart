import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_summary.dart';
import 'package:adventure_vault_character/src/features/characters/domain/editable_character.dart';

abstract interface class CharacterRepository {
  Future<List<CharacterSummary>> getCharacterSummaries();

  Stream<List<CharacterSummary>> watchCharacterSummaries();

  Future<CharacterSummary> createCharacter(CreateCharacterInput input);

  Future<CharacterSummary> updateCharacter(
    String id,
    CreateCharacterInput input,
  );

  Future<CharacterSummary?> getCharacterSummaryById(String id);

  Future<void> applyShortRest(String id);

  Future<void> applyLongRest(String id);

  Future<void> setClassResourceUses(
    String id,
    String resourceKey,
    int currentUses,
  );

  Future<void> spendSpellSlot(String id, {required int spellLevel});

  Future<void> restoreSpellSlot(String id, {required int spellLevel});

  Future<void> setInventoryItemEquipped(
    String id,
    String inventoryItemId,
    bool isEquipped,
  );

  Future<void> setInventoryItemCarried(
    String id,
    String inventoryItemId,
    bool isCarried,
  );

  Future<void> setInventoryItemQuantity(
    String id,
    String inventoryItemId,
    int quantity,
  );

  Future<void> spendInventoryItemQuantity(
    String id,
    String inventoryItemId, {
    int amount,
  });

  Future<String> splitInventoryItemStack(
    String id,
    String inventoryItemId, {
    required int quantity,
  });

  Future<void> mergeInventoryItemStacks(
    String id,
    String sourceInventoryItemId,
    String targetInventoryItemId, {
    int? quantity,
  });

  Future<int> retireZeroQuantityInventoryStacks(String id);

  Future<String> transferInventoryItemStackToContainer(
    String id,
    String sourceInventoryItemId, {
    required String targetContainerInventoryItemId,
    int? quantity,
  });

  Future<void> setInventoryItemCharges(
    String id,
    String inventoryItemId, {
    int? chargesCurrent,
    int? chargesMax,
  });

  Future<void> spendInventoryItemCharges(
    String id,
    String inventoryItemId, {
    int amount,
  });

  Future<void> restoreInventoryItemCharges(
    String id,
    String inventoryItemId, {
    int amount,
  });

  Future<void> recordDeathSaveSuccess(String id);

  Future<void> recordDeathSaveFailure(String id);

  Future<void> resetDeathSaves(String id);

  Future<void> setInventoryItemContainer(
    String id,
    String inventoryItemId,
    String? containerInventoryItemId,
  );

  Future<CharacterDomainModel?> getCharacterSheetById(String id);

  Stream<CharacterDomainModel?> watchCharacterSheetById(String id);

  Future<EditableCharacter?> getEditableCharacterById(String id);
}
