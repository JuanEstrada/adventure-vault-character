import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';
import 'package:flutter/foundation.dart';

@immutable
class CharacterRecord {
  const CharacterRecord({
    required this.row,
    required this.catalog,
    required this.classDefinition,
    required this.backgroundDefinition,
    required this.abilityScores,
    required this.abilityScoreProvenance,
    required this.hitPoints,
    required this.finishingDetails,
    required this.narrativeSelections,
    required this.equipmentLoadout,
    required this.spellSelections,
    required this.spellSlotUsages,
    required this.classResources,
    required this.currency,
    required this.inventory,
    required this.inventoryEquipmentDefinitions,
    required this.savingThrows,
    required this.skills,
    required this.skillDefinitions,
    required this.proficiencies,
  });

  final Character row;
  final CompendiumCatalog catalog;
  final ClassDefinition? classDefinition;
  final BackgroundDefinition? backgroundDefinition;
  final CharacterAbilityScore? abilityScores;
  final CharacterAbilityScoreProvenance? abilityScoreProvenance;
  final CharacterHitPoint? hitPoints;
  final CharacterFinishingDetail? finishingDetails;
  final List<CharacterNarrativeSelection> narrativeSelections;
  final CharacterEquipmentLoadout? equipmentLoadout;
  final List<CharacterSpellSelection> spellSelections;
  final List<CharacterSpellSlotUsage> spellSlotUsages;
  final List<CharacterClassResource> classResources;
  final CharacterCurrencyData? currency;
  final List<CharacterInventoryData> inventory;
  final List<EquipmentDefinition> inventoryEquipmentDefinitions;
  final List<CharacterSavingThrow> savingThrows;
  final List<CharacterSkill> skills;
  final List<SkillDefinition> skillDefinitions;
  final List<CharacterProficiency> proficiencies;
}
