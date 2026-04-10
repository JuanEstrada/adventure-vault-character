import 'package:adventure_vault_character/src/features/characters/domain/character_inventory_validation_error.dart';

class CharacterInventoryQuantityRules {
  const CharacterInventoryQuantityRules._();

  static int spend({required int currentQuantity, required int amount}) {
    if (amount <= 0) {
      throw const CharacterInventoryValidationError(
        'invalid_quantity',
        'Spend amount must be greater than zero.',
      );
    }

    if (currentQuantity < amount) {
      throw const CharacterInventoryValidationError(
        'insufficient_quantity',
        'Item does not have enough quantity for this action.',
      );
    }

    return (currentQuantity - amount).clamp(0, 9999).toInt();
  }
}
