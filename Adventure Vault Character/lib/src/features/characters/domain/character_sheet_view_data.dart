import 'package:flutter/foundation.dart';

@immutable
class CharacterSheetViewData {
  const CharacterSheetViewData({
    required this.id,
    required this.name,
    required this.raceName,
    required this.className,
    required this.level,
    required this.experience,
    required this.proficiencyBonus,
    required this.levelProgressPercent,
    required this.currentHitPoints,
    required this.maximumHitPoints,
    required this.temporaryHitPoints,
    required this.backgroundName,
    required this.backgroundSummary,
    required this.backgroundBonuses,
    required this.backgroundSocialPerks,
    required this.abilityScoreMethodLabel,
    required this.abilityRows,
    required this.equipmentSummary,
    required this.selectedEquipmentLabel,
    required this.startingMoneySummary,
    required this.selectedEquipmentItems,
    required this.alignment,
    required this.appearanceDetails,
    required this.narrativeDetails,
  });

  final String id;
  final String name;
  final String raceName;
  final String className;
  final int level;
  final int experience;
  final int proficiencyBonus;
  final int levelProgressPercent;
  final int currentHitPoints;
  final int maximumHitPoints;
  final int temporaryHitPoints;
  final String backgroundName;
  final String backgroundSummary;
  final List<String> backgroundBonuses;
  final List<String> backgroundSocialPerks;
  final String abilityScoreMethodLabel;
  final List<AbilityScoreRowViewData> abilityRows;
  final EquipmentSummaryViewData equipmentSummary;
  final String selectedEquipmentLabel;
  final String startingMoneySummary;
  final List<String> selectedEquipmentItems;
  final String alignment;
  final String appearanceDetails;
  final String narrativeDetails;
}

@immutable
class AbilityScoreRowViewData {
  const AbilityScoreRowViewData({
    required this.label,
    required this.score,
    required this.modifier,
  });

  final String label;
  final int score;
  final int modifier;
}

@immutable
class EquipmentSummaryViewData {
  const EquipmentSummaryViewData({
    required this.statusLabel,
    required this.description,
    required this.highlightItems,
  });

  final String statusLabel;
  final String description;
  final List<String> highlightItems;
}
