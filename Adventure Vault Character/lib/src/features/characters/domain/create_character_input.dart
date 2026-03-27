import 'package:adventure_vault_character/src/features/characters/domain/character_finishing_details.dart';
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
    required this.finishingDetails,
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
  final CharacterFinishingDetailsInput finishingDetails;

  String get alignment =>
      finishingDetails.valueFor(NarrativeFieldKey.alignment) ?? '';

  String get appearanceDetails => finishingDetails.appearanceDetails;

  String get narrativeDetails => finishingDetails.narrativeNotes;

  String? get portraitAssetPath => finishingDetails.portraitAssetPath;
}
