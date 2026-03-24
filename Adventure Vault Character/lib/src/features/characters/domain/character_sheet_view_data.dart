import 'package:flutter/foundation.dart';

@immutable
class CharacterSheetViewData {
  const CharacterSheetViewData({
    required this.id,
    required this.identity,
    required this.combat,
    required this.abilities,
    required this.featuresNotes,
    required this.equipment,
  });

  final String id;
  final IdentityPanelViewData identity;
  final CombatPanelViewData combat;
  final AbilitiesPanelViewData abilities;
  final FeaturesNotesPanelViewData featuresNotes;
  final EquipmentPanelViewData equipment;
}

@immutable
class IdentityPanelViewData {
  const IdentityPanelViewData({
    required this.name,
    required this.raceName,
    required this.className,
    required this.level,
    required this.experience,
    required this.proficiencyBonus,
    required this.levelProgressPercent,
  });

  final String name;
  final String raceName;
  final String className;
  final int level;
  final int experience;
  final int proficiencyBonus;
  final int levelProgressPercent;
}

@immutable
class CombatPanelViewData {
  const CombatPanelViewData({
    required this.currentHitPoints,
    required this.maximumHitPoints,
    required this.temporaryHitPoints,
    required this.savingThrows,
  });

  final int currentHitPoints;
  final int maximumHitPoints;
  final int temporaryHitPoints;
  final List<SavingThrowRowViewData> savingThrows;
}

@immutable
class AbilitiesPanelViewData {
  const AbilitiesPanelViewData({
    required this.abilityScoreMethodLabel,
    required this.abilityRows,
  });

  final String abilityScoreMethodLabel;
  final List<AbilityScoreRowViewData> abilityRows;
}

@immutable
class FeaturesNotesPanelViewData {
  const FeaturesNotesPanelViewData({
    required this.backgroundName,
    required this.backgroundSummary,
    required this.backgroundBonuses,
    required this.backgroundSocialPerks,
    required this.proficientSkills,
    required this.otherProficiencies,
    required this.alignment,
    required this.appearanceDetails,
    required this.narrativeDetails,
  });

  final String backgroundName;
  final String backgroundSummary;
  final List<String> backgroundBonuses;
  final List<String> backgroundSocialPerks;
  final List<String> proficientSkills;
  final List<String> otherProficiencies;
  final String alignment;
  final String appearanceDetails;
  final String narrativeDetails;
}

@immutable
class EquipmentPanelViewData {
  const EquipmentPanelViewData({
    required this.equipmentSummary,
    required this.selectedEquipmentLabel,
    required this.currencySummary,
    required this.startingMoneySummary,
    required this.selectedEquipmentItems,
  });

  final EquipmentSummaryViewData equipmentSummary;
  final String selectedEquipmentLabel;
  final String currencySummary;
  final String startingMoneySummary;
  final List<String> selectedEquipmentItems;
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
class SavingThrowRowViewData {
  const SavingThrowRowViewData({
    required this.label,
    required this.bonus,
    required this.isProficient,
  });

  final String label;
  final int bonus;
  final bool isProficient;
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
