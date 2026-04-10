import 'package:adventure_vault_character/src/features/characters/domain/character_encumbrance_rules.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const rules = CharacterEncumbranceRules();

  test('coin-weight toggle changes total load and tier', () {
    final withoutCoins = rules.evaluate(
      strengthScore: 10,
      carriedItemWeight: 50,
      totalCoinCount: 500,
      includeCoinWeight: false,
    );
    expect(withoutCoins.coinWeight, 0);
    expect(withoutCoins.totalWeight, 50);
    expect(withoutCoins.tier, 'normal');

    final withCoins = rules.evaluate(
      strengthScore: 10,
      carriedItemWeight: 50,
      totalCoinCount: 500,
      includeCoinWeight: true,
    );
    expect(withCoins.coinWeight, 10);
    expect(withCoins.totalWeight, 60);
    expect(withCoins.tier, 'encumbered');
  });

  test('heavily encumbered and over-capacity tiers apply in order', () {
    final heavily = rules.evaluate(
      strengthScore: 10,
      carriedItemWeight: 101,
      totalCoinCount: 0,
      includeCoinWeight: false,
    );
    expect(heavily.tier, 'heavily_encumbered');

    final overCapacity = rules.evaluate(
      strengthScore: 10,
      carriedItemWeight: 151,
      totalCoinCount: 0,
      includeCoinWeight: false,
    );
    expect(overCapacity.tier, 'over_capacity');
  });
}
