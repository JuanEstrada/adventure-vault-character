import 'package:adventure_vault_character/src/features/characters/domain/character_inventory_validation_error.dart';

class CharacterInventoryStackRules {
  const CharacterInventoryStackRules._();

  static ({int sourceQuantity, int splitQuantity}) split({
    required int sourceQuantity,
    required int splitQuantity,
    required bool isStackable,
    int maxQuantity = 9999,
  }) {
    if (!isStackable) {
      throw const CharacterInventoryValidationError(
        'invalid_stack_state',
        'Item is not stackable and cannot be split.',
      );
    }
    if (splitQuantity <= 0) {
      throw const CharacterInventoryValidationError(
        'invalid_quantity',
        'Split quantity must be greater than zero.',
      );
    }
    if (sourceQuantity <= splitQuantity) {
      throw const CharacterInventoryValidationError(
        'insufficient_quantity',
        'Split quantity must leave at least one item in the source stack.',
      );
    }

    final nextSource = sourceQuantity - splitQuantity;
    if (nextSource < 0 || splitQuantity > maxQuantity) {
      throw const CharacterInventoryValidationError(
        'invalid_quantity',
        'Split operation would produce an invalid quantity.',
      );
    }

    return (sourceQuantity: nextSource, splitQuantity: splitQuantity);
  }

  static ({int sourceQuantity, int targetQuantity}) merge({
    required int sourceQuantity,
    required int targetQuantity,
    required int mergeQuantity,
    required bool sourceIsStackable,
    required bool targetIsStackable,
    required bool isCompatible,
    int maxQuantity = 9999,
  }) {
    if (!sourceIsStackable || !targetIsStackable) {
      throw const CharacterInventoryValidationError(
        'invalid_stack_state',
        'Only stackable items can be merged.',
      );
    }
    if (!isCompatible) {
      throw const CharacterInventoryValidationError(
        'invalid_stack_state',
        'Stacks are not compatible for merge.',
      );
    }
    if (mergeQuantity <= 0) {
      throw const CharacterInventoryValidationError(
        'invalid_quantity',
        'Merge quantity must be greater than zero.',
      );
    }
    if (sourceQuantity < mergeQuantity) {
      throw const CharacterInventoryValidationError(
        'insufficient_quantity',
        'Source stack does not have enough quantity for this merge.',
      );
    }

    final nextTarget = targetQuantity + mergeQuantity;
    if (nextTarget > maxQuantity) {
      throw const CharacterInventoryValidationError(
        'invalid_quantity',
        'Merge would exceed the maximum allowed stack quantity.',
      );
    }

    return (
      sourceQuantity: (sourceQuantity - mergeQuantity).clamp(0, maxQuantity),
      targetQuantity: nextTarget,
    );
  }

  static bool shouldRetireZeroQuantityStack(int quantity) => quantity <= 0;
}
