import 'package:adventure_vault_character/src/features/characters/domain/character_spell_rules.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const rules = CharacterSpellRules();

  test('warlock uses known-spell mode and supports persistent spell state', () {
    expect(rules.supportsPersistentSpellState('Warlock'), isTrue);
    expect(
      rules.selectionModeForClass('Warlock'),
      CharacterSpellSelectionMode.known,
    );
  });

  test('warlock known-spell limits follow level table', () {
    expect(
      rules.selectionLimitFor(
        className: 'Warlock',
        level: 1,
        abilityModifier: 3,
      ),
      2,
    );
    expect(
      rules.selectionLimitFor(
        className: 'Warlock',
        level: 10,
        abilityModifier: 3,
      ),
      10,
    );
    expect(
      rules.selectionLimitFor(
        className: 'Warlock',
        level: 20,
        abilityModifier: 5,
      ),
      15,
    );
  });

  test('warlock slot progression follows pact-magic progression', () {
    final level1 = rules.slotProgressionFor(className: 'Warlock', level: 1);
    expect(level1, hasLength(1));
    expect(level1.single.spellLevel, 1);
    expect(level1.single.slotsMax, 1);

    final level5 = rules.slotProgressionFor(className: 'Warlock', level: 5);
    expect(level5, hasLength(1));
    expect(level5.single.spellLevel, 3);
    expect(level5.single.slotsMax, 2);

    final level11 = rules.slotProgressionFor(className: 'Warlock', level: 11);
    expect(level11, hasLength(1));
    expect(level11.single.spellLevel, 5);
    expect(level11.single.slotsMax, 3);

    final level20 = rules.slotProgressionFor(className: 'Warlock', level: 20);
    expect(level20, hasLength(1));
    expect(level20.single.spellLevel, 5);
    expect(level20.single.slotsMax, 4);
  });

  test('warlock highest castable spell level follows pact slot level', () {
    expect(rules.highestCastableSpellLevel(className: 'Warlock', level: 1), 1);
    expect(rules.highestCastableSpellLevel(className: 'Warlock', level: 5), 3);
    expect(rules.highestCastableSpellLevel(className: 'Warlock', level: 17), 5);
  });
}
