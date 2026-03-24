import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';
import 'package:flutter/foundation.dart';

@immutable
class CharacterRecord {
  const CharacterRecord({
    required this.row,
    required this.catalog,
    required this.backgroundDefinition,
    required this.abilityScores,
    required this.currency,
    required this.inventory,
    required this.savingThrows,
    required this.skills,
    required this.skillDefinitions,
    required this.proficiencies,
  });

  final Character row;
  final CompendiumCatalog catalog;
  final BackgroundDefinition? backgroundDefinition;
  final CharacterAbilityScore? abilityScores;
  final CharacterCurrencyData? currency;
  final List<CharacterInventoryData> inventory;
  final List<CharacterSavingThrow> savingThrows;
  final List<CharacterSkill> skills;
  final List<SkillDefinition> skillDefinitions;
  final List<CharacterProficiency> proficiencies;
}
