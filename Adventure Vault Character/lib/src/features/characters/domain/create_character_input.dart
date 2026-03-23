import 'package:flutter/foundation.dart';

@immutable
class CreateCharacterInput {
  const CreateCharacterInput({
    required this.name,
    required this.raceName,
    required this.backgroundId,
    required this.backgroundName,
    required this.backgroundSummary,
    required this.abilityScoreMethod,
    required this.abilityScoreProvenance,
    required this.strength,
    required this.dexterity,
    required this.constitution,
    required this.intelligence,
    required this.wisdom,
    required this.charisma,
    required this.className,
    required this.level,
    required this.experience,
    required this.equipmentLoadoutId,
    required this.equipmentLoadoutLabel,
    required this.startingMoneySummary,
    required this.selectedEquipmentItems,
    required this.currentHitPoints,
    required this.maximumHitPoints,
    required this.temporaryHitPoints,
    required this.alignment,
    required this.appearanceDetails,
    required this.narrativeDetails,
    this.portraitAssetPath,
  });

  final String name;
  final String raceName;
  final String backgroundId;
  final String backgroundName;
  final String backgroundSummary;
  final String abilityScoreMethod;
  final String abilityScoreProvenance;
  final int strength;
  final int dexterity;
  final int constitution;
  final int intelligence;
  final int wisdom;
  final int charisma;
  final String className;
  final int level;
  final int experience;
  final String equipmentLoadoutId;
  final String equipmentLoadoutLabel;
  final String startingMoneySummary;
  final List<String> selectedEquipmentItems;
  final int currentHitPoints;
  final int maximumHitPoints;
  final int temporaryHitPoints;
  final String alignment;
  final String appearanceDetails;
  final String narrativeDetails;
  final String? portraitAssetPath;
}
