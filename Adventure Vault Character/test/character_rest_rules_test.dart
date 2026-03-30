import 'package:adventure_vault_character/src/features/characters/domain/character_rest_rules.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const rules = CharacterRestRules();

  test('short rest only resets warlock pact slots', () {
    final wizard = rules.applyShortRest(
      className: 'Wizard',
      level: 5,
      currentHitPoints: 19,
      maximumHitPoints: 23,
      temporaryHitPoints: 4,
      slotUsagesByLevel: <int, int>{1: 2, 2: 1, 3: 1},
    );
    expect(wizard.slotUsagesByLevel, <int, int>{1: 2, 2: 1, 3: 1});
    expect(wizard.currentHitPoints, 19);
    expect(wizard.temporaryHitPoints, 4);

    final warlock = rules.applyShortRest(
      className: 'Warlock',
      level: 5,
      currentHitPoints: 14,
      maximumHitPoints: 23,
      temporaryHitPoints: 2,
      slotUsagesByLevel: <int, int>{3: 2},
    );
    expect(warlock.slotUsagesByLevel, <int, int>{3: 0});
  });

  test('long rest resets slots and restores hp state', () {
    final wizard = rules.applyLongRest(
      className: 'Wizard',
      level: 5,
      maximumHitPoints: 23,
    );

    expect(wizard.currentHitPoints, 23);
    expect(wizard.temporaryHitPoints, 0);
    expect(wizard.slotUsagesByLevel, <int, int>{1: 0, 2: 0, 3: 0});
  });
}
