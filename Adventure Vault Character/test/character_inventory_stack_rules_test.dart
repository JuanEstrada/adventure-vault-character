import 'package:adventure_vault_character/src/features/characters/domain/character_inventory_stack_rules.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_inventory_validation_error.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('split returns deterministic source and split quantities', () {
    final result = CharacterInventoryStackRules.split(
      sourceQuantity: 6,
      splitQuantity: 2,
      isStackable: true,
    );

    expect(result.sourceQuantity, 4);
    expect(result.splitQuantity, 2);
  });

  test('split rejects non-stackable source item', () {
    expect(
      () => CharacterInventoryStackRules.split(
        sourceQuantity: 2,
        splitQuantity: 1,
        isStackable: false,
      ),
      throwsA(
        isA<CharacterInventoryValidationError>().having(
          (error) => error.code,
          'code',
          'invalid_stack_state',
        ),
      ),
    );
  });

  test('merge retires source when full amount is merged', () {
    final result = CharacterInventoryStackRules.merge(
      sourceQuantity: 2,
      targetQuantity: 3,
      mergeQuantity: 2,
      sourceIsStackable: true,
      targetIsStackable: true,
      isCompatible: true,
    );

    expect(result.sourceQuantity, 0);
    expect(result.targetQuantity, 5);
    expect(
      CharacterInventoryStackRules.shouldRetireZeroQuantityStack(0),
      isTrue,
    );
  });

  test('merge rejects incompatible stacks', () {
    expect(
      () => CharacterInventoryStackRules.merge(
        sourceQuantity: 2,
        targetQuantity: 1,
        mergeQuantity: 1,
        sourceIsStackable: true,
        targetIsStackable: true,
        isCompatible: false,
      ),
      throwsA(
        isA<CharacterInventoryValidationError>().having(
          (error) => error.code,
          'code',
          'invalid_stack_state',
        ),
      ),
    );
  });
}
