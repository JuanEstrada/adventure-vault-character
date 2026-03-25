import 'package:flutter/foundation.dart';

@immutable
final class CharacterRules {
  const CharacterRules._();

  static const Map<int, int> _experienceThresholds = <int, int>{
    1: 0,
    2: 300,
    3: 900,
    4: 2700,
    5: 6500,
    6: 14000,
  };

  static int abilityModifier(int score) => ((score - 10) / 2).floor();

  static int proficiencyBonusForLevel(int level) => 2 + ((level - 1) ~/ 4);

  static int levelProgressPercent({
    required int level,
    required int experience,
  }) {
    final currentFloor = _experienceThresholds[level] ?? 0;
    final nextFloor = _experienceThresholds[level + 1];
    if (nextFloor == null || nextFloor <= currentFloor) {
      return 100;
    }

    final progress = ((experience - currentFloor) / (nextFloor - currentFloor))
        .clamp(0, 1);
    return (progress * 100).round();
  }

  static int experienceFloorForLevel(int level) {
    return _experienceThresholds[level] ?? 0;
  }

  static int startingHitPoints({
    required int hitDie,
    required int constitutionScore,
    required int level,
  }) {
    final constitutionModifier = abilityModifier(constitutionScore);
    final firstLevelHitPoints = hitDie + constitutionModifier;
    if (level <= 1) {
      return firstLevelHitPoints.clamp(1, 999);
    }

    final averagePerLevel = ((hitDie / 2).floor() + 1) + constitutionModifier;
    final total =
        firstLevelHitPoints + ((level - 1) * averagePerLevel.clamp(1, 999));
    return total.clamp(1, 999);
  }
}
