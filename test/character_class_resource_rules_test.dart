import 'package:adventure_vault_character/src/features/characters/domain/character_class_resource_rules.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const rules = CharacterClassResourceRules();

  test('returns expected recoverable resources for supported classes', () {
    final barbarian = rules.resourcesFor(className: 'Barbarian', level: 5);
    expect(barbarian, hasLength(1));
    expect(barbarian.single.resourceKey, 'rage');
    expect(barbarian.single.maximumUses, 3);
    expect(barbarian.single.recoversOnShortRest, isFalse);

    final monk = rules.resourcesFor(className: 'Monk', level: 5);
    expect(monk, hasLength(1));
    expect(monk.single.resourceKey, 'ki-points');
    expect(monk.single.maximumUses, 5);
    expect(monk.single.recoversOnShortRest, isTrue);

    final cleric = rules.resourcesFor(className: 'Cleric', level: 12);
    expect(cleric, hasLength(1));
    expect(cleric.single.resourceKey, 'channel-divinity');
    expect(cleric.single.maximumUses, 2);
    expect(cleric.single.recoversOnShortRest, isTrue);
  });

  test('short-rest support reflects available class resource cadence', () {
    expect(
      rules.supportsShortRestRecovery(className: 'Monk', level: 2),
      isTrue,
    );
    expect(
      rules.supportsShortRestRecovery(className: 'Barbarian', level: 2),
      isFalse,
    );
    expect(
      rules.supportsShortRestRecovery(className: 'Wizard', level: 5),
      isFalse,
    );
  });
}
