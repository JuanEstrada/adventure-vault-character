import 'package:adventure_vault_character/src/features/characters/domain/character_spell_slot_usage_codec.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('parses legacy counts and explicit indices consistently', () {
    expect(CharacterSpellSlotUsageCodec.expendedCountFromSerialized(''), 0);
    expect(CharacterSpellSlotUsageCodec.expendedCountFromSerialized('   '), 0);
    expect(CharacterSpellSlotUsageCodec.expendedCountFromSerialized('0'), 0);
    expect(CharacterSpellSlotUsageCodec.expendedCountFromSerialized('-1'), 0);
    expect(CharacterSpellSlotUsageCodec.expendedCountFromSerialized('3'), 3);
    expect(
      CharacterSpellSlotUsageCodec.expendedCountFromSerialized('1, 2, 3'),
      3,
    );

    expect(CharacterSpellSlotUsageCodec.hasExplicitIndices('1, 2, 3'), isTrue);
    expect(CharacterSpellSlotUsageCodec.hasExplicitIndices('3'), isFalse);

    expect(
      CharacterSpellSlotUsageCodec.explicitIndicesFromSerialized(''),
      isEmpty,
    );
    expect(
      CharacterSpellSlotUsageCodec.explicitIndicesFromSerialized('0'),
      isEmpty,
    );
    expect(
      CharacterSpellSlotUsageCodec.explicitIndicesFromSerialized('3'),
      <String>['0', '1', '2'],
    );
    expect(
      CharacterSpellSlotUsageCodec.explicitIndicesFromSerialized(
        ' 4, 2 , 4 , 1 ',
      ),
      <String>['4', '2', '4', '1'],
    );
  });

  test('serializes cleaned input indices and preserves stable updates', () {
    expect(
      CharacterSpellSlotUsageCodec.serializeInputIndices(<String>['0']),
      '',
    );
    expect(
      CharacterSpellSlotUsageCodec.serializeInputIndices(<String>[
        ' 2 ',
        '1',
        '1',
        '',
        '0',
      ]),
      '0,1,2',
    );

    expect(
      CharacterSpellSlotUsageCodec.serializeUpdatedIndices(
        currentSerialized: '',
        expendedCount: 0,
      ),
      '',
    );
    expect(
      CharacterSpellSlotUsageCodec.serializeUpdatedIndices(
        currentSerialized: '',
        expendedCount: 1,
      ),
      '1',
    );
    expect(
      CharacterSpellSlotUsageCodec.serializeUpdatedIndices(
        currentSerialized: '0,2',
        expendedCount: 2,
      ),
      '0,2',
    );
    expect(
      CharacterSpellSlotUsageCodec.serializeUpdatedIndices(
        currentSerialized: '1',
        expendedCount: 2,
      ),
      '0,1',
    );
  });
}
