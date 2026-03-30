class CharacterEncumbranceResult {
  const CharacterEncumbranceResult({
    required this.carriedWeight,
    required this.coinWeight,
    required this.totalWeight,
    required this.capacity,
    required this.encumberedThreshold,
    required this.heavilyEncumberedThreshold,
    required this.tier,
    required this.tierLabel,
    required this.tierDescription,
  });

  final int carriedWeight;
  final int coinWeight;
  final int totalWeight;
  final int capacity;
  final int encumberedThreshold;
  final int heavilyEncumberedThreshold;
  final String tier;
  final String tierLabel;
  final String tierDescription;
}

class CharacterEncumbranceRules {
  const CharacterEncumbranceRules();

  CharacterEncumbranceResult evaluate({
    required int strengthScore,
    required int carriedItemWeight,
    required int totalCoinCount,
    required bool includeCoinWeight,
  }) {
    final strength = strengthScore.clamp(1, 30);
    final carried = carriedItemWeight.clamp(0, 99999);
    final coins = totalCoinCount.clamp(0, 999999);
    final coinWeight = includeCoinWeight ? (coins / 50).ceil() : 0;
    final totalWeight = carried + coinWeight;
    final encumberedThreshold = strength * 5;
    final heavilyEncumberedThreshold = strength * 10;
    final capacity = strength * 15;

    if (totalWeight > capacity) {
      return CharacterEncumbranceResult(
        carriedWeight: carried,
        coinWeight: coinWeight,
        totalWeight: totalWeight,
        capacity: capacity,
        encumberedThreshold: encumberedThreshold,
        heavilyEncumberedThreshold: heavilyEncumberedThreshold,
        tier: 'over_capacity',
        tierLabel: 'Over Capacity',
        tierDescription: 'Move speed 0 until carried weight is reduced.',
      );
    }

    if (totalWeight > heavilyEncumberedThreshold) {
      return CharacterEncumbranceResult(
        carriedWeight: carried,
        coinWeight: coinWeight,
        totalWeight: totalWeight,
        capacity: capacity,
        encumberedThreshold: encumberedThreshold,
        heavilyEncumberedThreshold: heavilyEncumberedThreshold,
        tier: 'heavily_encumbered',
        tierLabel: 'Heavily Encumbered',
        tierDescription:
            'Speed -20 ft; disadvantage on STR, DEX, and CON checks.',
      );
    }

    if (totalWeight > encumberedThreshold) {
      return CharacterEncumbranceResult(
        carriedWeight: carried,
        coinWeight: coinWeight,
        totalWeight: totalWeight,
        capacity: capacity,
        encumberedThreshold: encumberedThreshold,
        heavilyEncumberedThreshold: heavilyEncumberedThreshold,
        tier: 'encumbered',
        tierLabel: 'Encumbered',
        tierDescription: 'Speed -10 ft.',
      );
    }

    return CharacterEncumbranceResult(
      carriedWeight: carried,
      coinWeight: coinWeight,
      totalWeight: totalWeight,
      capacity: capacity,
      encumberedThreshold: encumberedThreshold,
      heavilyEncumberedThreshold: heavilyEncumberedThreshold,
      tier: 'normal',
      tierLabel: 'Normal',
      tierDescription: 'No encumbrance penalties.',
    );
  }
}
