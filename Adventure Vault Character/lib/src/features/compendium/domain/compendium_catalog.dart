import 'package:adventure_vault_character/src/features/characters/domain/equipment_summary_view_data.dart';
import 'package:flutter/foundation.dart';

@immutable
class CompendiumCatalog {
  const CompendiumCatalog({
    required this.races,
    required this.classes,
    required this.backgrounds,
    required this.generatedAbilityScoreSet,
    required this.manualAbilityScoreOptions,
    required this.characterAdvancement,
    required this.standardArrayByClass,
    required this.spells,
    required this.feats,
    required this.monsters,
    required this.equipmentSummariesByClass,
    required this.equipmentLoadoutsByClass,
  });

  final List<String> races;
  final List<String> classes;
  final List<CompendiumBackground> backgrounds;
  final List<int> generatedAbilityScoreSet;
  final List<int> manualAbilityScoreOptions;
  final List<CharacterAdvancementEntry> characterAdvancement;
  final List<StandardArrayByClassEntry> standardArrayByClass;
  final List<CompendiumSpell> spells;
  final List<CompendiumFeat> feats;
  final List<CompendiumMonster> monsters;
  final Map<String, EquipmentSummaryViewData> equipmentSummariesByClass;
  final Map<String, List<CompendiumEquipmentLoadout>> equipmentLoadoutsByClass;

  CompendiumBackground? backgroundById(String? id) {
    for (final background in backgrounds) {
      if (background.id == id) {
        return background;
      }
    }
    return null;
  }

  EquipmentSummaryViewData equipmentSummaryForClass(String className) {
    return equipmentSummariesByClass[className] ??
        const EquipmentSummaryViewData(
          statusLabel: 'MVP minimal',
          description:
              'Equipment sigue como panel controlado mientras el flujo de seleccion y persistencia se expande.',
          highlightItems: <String>['Equipment mapping pending'],
        );
  }

  List<CompendiumEquipmentLoadout> equipmentLoadoutsForClass(String className) {
    final loadouts = equipmentLoadoutsByClass[className];
    if (loadouts != null && loadouts.isNotEmpty) {
      return List<CompendiumEquipmentLoadout>.unmodifiable(loadouts);
    }

    final fallbackSummary = equipmentSummaryForClass(className);
    return <CompendiumEquipmentLoadout>[
      CompendiumEquipmentLoadout(
        id: 'fallback-loadout',
        label: 'Starter loadout',
        startingMoneySummary: 'Class kit baseline',
        selectedItems: fallbackSummary.highlightItems,
      ),
    ];
  }
}

@immutable
class CharacterAdvancementEntry {
  const CharacterAdvancementEntry({
    required this.level,
    required this.experience,
    required this.proficiencyBonus,
  });

  final int level;
  final int experience;
  final String proficiencyBonus;
}

@immutable
class StandardArrayByClassEntry {
  const StandardArrayByClassEntry({
    required this.classId,
    required this.className,
    required this.strength,
    required this.dexterity,
    required this.constitution,
    required this.intelligence,
    required this.wisdom,
    required this.charisma,
  });

  final String classId;
  final String className;
  final int strength;
  final int dexterity;
  final int constitution;
  final int intelligence;
  final int wisdom;
  final int charisma;
}

@immutable
class CompendiumBackground {
  const CompendiumBackground({
    required this.id,
    required this.name,
    required this.summary,
    required this.bonuses,
    required this.socialPerks,
  });

  final String id;
  final String name;
  final String summary;
  final List<String> bonuses;
  final List<String> socialPerks;
}

@immutable
class CompendiumEquipmentLoadout {
  const CompendiumEquipmentLoadout({
    required this.id,
    required this.label,
    required this.startingMoneySummary,
    required this.selectedItems,
  });

  final String id;
  final String label;
  final String startingMoneySummary;
  final List<String> selectedItems;
}

@immutable
class CompendiumSpell {
  const CompendiumSpell({
    required this.name,
    required this.level,
    required this.school,
    required this.castingTime,
    required this.range,
    required this.components,
    required this.duration,
    required this.classes,
    required this.description,
    required this.source,
  });

  final String name;
  final int level;
  final String school;
  final String castingTime;
  final String range;
  final String components;
  final String duration;
  final List<String> classes;
  final List<String> description;
  final String source;
}

@immutable
class CompendiumFeat {
  const CompendiumFeat({
    required this.name,
    required this.prerequisite,
    required this.description,
    required this.modifiers,
    required this.source,
  });

  final String name;
  final String prerequisite;
  final List<String> description;
  final List<String> modifiers;
  final String source;
}

@immutable
class CompendiumMonster {
  const CompendiumMonster({
    required this.name,
    required this.size,
    required this.type,
    required this.alignment,
    required this.armorClass,
    required this.hitPoints,
    required this.speed,
    required this.challengeRating,
    required this.senses,
    required this.languages,
    required this.traits,
    required this.actions,
    required this.source,
  });

  final String name;
  final String size;
  final String type;
  final String alignment;
  final String armorClass;
  final String hitPoints;
  final String speed;
  final String challengeRating;
  final String senses;
  final String languages;
  final List<String> traits;
  final List<String> actions;
  final String source;
}
