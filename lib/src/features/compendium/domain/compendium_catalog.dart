import 'package:adventure_vault_character/src/features/characters/domain/equipment_summary_view_data.dart';
import 'package:flutter/foundation.dart';

@immutable
class CompendiumCatalog {
  const CompendiumCatalog({
    required this.races,
    required this.classes,
    required this.backgrounds,
    required this.narrativeOptionGroups,
    required this.generatedAbilityScoreSet,
    required this.manualAbilityScoreOptions,
    required this.characterAdvancement,
    required this.standardArrayByClass,
    required this.spells,
    required this.feats,
    required this.monsters,
    required this.equipmentSummariesByClass,
    required this.equipmentLoadoutsByClass,
    this.packStates = const <CompendiumPackStateModel>[],
    this.sourcePolicy = const CompendiumSourcePolicy(
      activeSourceType: 'unknown',
      activeSourceLabel: 'Unknown compendium source',
      fallbackSourceLabel: 'assets/compendium/catalog.json',
      sections: <CompendiumSectionSourcePolicy>[],
    ),
  });

  final List<String> races;
  final List<String> classes;
  final List<CompendiumBackground> backgrounds;
  final List<CompendiumNarrativeOptionGroup> narrativeOptionGroups;
  final List<int> generatedAbilityScoreSet;
  final List<int> manualAbilityScoreOptions;
  final List<CharacterAdvancementEntry> characterAdvancement;
  final List<StandardArrayByClassEntry> standardArrayByClass;
  final List<CompendiumSpell> spells;
  final List<CompendiumFeat> feats;
  final List<CompendiumMonster> monsters;
  final Map<String, EquipmentSummaryViewData> equipmentSummariesByClass;
  final Map<String, List<CompendiumEquipmentLoadout>> equipmentLoadoutsByClass;
  final List<CompendiumPackStateModel> packStates;
  final CompendiumSourcePolicy sourcePolicy;

  CompendiumCatalog copyWith({
    List<String>? races,
    List<String>? classes,
    List<CompendiumBackground>? backgrounds,
    List<CompendiumNarrativeOptionGroup>? narrativeOptionGroups,
    List<int>? generatedAbilityScoreSet,
    List<int>? manualAbilityScoreOptions,
    List<CharacterAdvancementEntry>? characterAdvancement,
    List<StandardArrayByClassEntry>? standardArrayByClass,
    List<CompendiumSpell>? spells,
    List<CompendiumFeat>? feats,
    List<CompendiumMonster>? monsters,
    Map<String, EquipmentSummaryViewData>? equipmentSummariesByClass,
    Map<String, List<CompendiumEquipmentLoadout>>? equipmentLoadoutsByClass,
    List<CompendiumPackStateModel>? packStates,
    CompendiumSourcePolicy? sourcePolicy,
  }) {
    return CompendiumCatalog(
      races: races ?? this.races,
      classes: classes ?? this.classes,
      backgrounds: backgrounds ?? this.backgrounds,
      narrativeOptionGroups:
          narrativeOptionGroups ?? this.narrativeOptionGroups,
      generatedAbilityScoreSet:
          generatedAbilityScoreSet ?? this.generatedAbilityScoreSet,
      manualAbilityScoreOptions:
          manualAbilityScoreOptions ?? this.manualAbilityScoreOptions,
      characterAdvancement: characterAdvancement ?? this.characterAdvancement,
      standardArrayByClass: standardArrayByClass ?? this.standardArrayByClass,
      spells: spells ?? this.spells,
      feats: feats ?? this.feats,
      monsters: monsters ?? this.monsters,
      equipmentSummariesByClass:
          equipmentSummariesByClass ?? this.equipmentSummariesByClass,
      equipmentLoadoutsByClass:
          equipmentLoadoutsByClass ?? this.equipmentLoadoutsByClass,
      packStates: packStates ?? this.packStates,
      sourcePolicy: sourcePolicy ?? this.sourcePolicy,
    );
  }

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
              'Equipment remains a controlled panel while selection and persistence flows expand.',
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

  List<CompendiumNarrativeOptionGroup> narrativeGroupsForField(
    String fieldKey,
  ) {
    return narrativeOptionGroups
        .where((group) => group.fieldKey == fieldKey)
        .toList(growable: false);
  }

  List<CompendiumNarrativeOptionGroup> narrativeGroupsForBackground(
    String backgroundId,
    String fieldKey,
  ) {
    return narrativeOptionGroups
        .where(
          (group) =>
              group.fieldKey == fieldKey && group.backgroundId == backgroundId,
        )
        .toList(growable: false);
  }

  CompendiumSectionSourcePolicy? sourcePolicyForSection(String sectionKey) {
    return sourcePolicy.sectionFor(sectionKey);
  }

  CompendiumPackStateModel? packStateById(String packId) {
    for (final packState in packStates) {
      if (packState.id == packId) {
        return packState;
      }
    }
    return null;
  }

  bool isPackActive(String packId, {bool defaultValue = true}) {
    final packState = packStateById(packId);
    return packState?.isActive ?? defaultValue;
  }

  List<CompendiumPackStateModel> get optionalPackStates {
    return List<CompendiumPackStateModel>.unmodifiable(
      packStates.where((packState) => !packState.isFixed),
    );
  }

  bool get hasOptionalPacks => optionalPackStates.isNotEmpty;

  int get activeOptionalPackCount =>
      optionalPackStates.where((packState) => packState.isActive).length;

  Set<String> get inactiveOptionalPackIds {
    return packStates
        .where((packState) => !packState.isFixed && !packState.isActive)
        .map((packState) => packState.id)
        .toSet();
  }

  String packDisplayLabel(String packId) {
    final packTitle = packStateById(packId)?.title;
    if (packTitle != null && packTitle.isNotEmpty) {
      return packTitle;
    }
    return packId.replaceAll('-', ' ');
  }

  CompendiumSectionSourcePolicy sectionWithPackActivity(
    CompendiumSectionSourcePolicy section,
  ) {
    final supplementalPackId = section.supplementalPackId;
    if (supplementalPackId == null ||
        !inactiveOptionalPackIds.contains(supplementalPackId)) {
      return section;
    }
    final inactiveNote =
        '${packDisplayLabel(supplementalPackId)} is currently inactive.';
    return CompendiumSectionSourcePolicy(
      sectionKey: section.sectionKey,
      sectionLabel: section.sectionLabel,
      sourceType: section.sourceType,
      primarySources: section.primarySources,
      supplementalSources: const <String>[],
      supplementalPackId: supplementalPackId,
      notes: section.notes == null
          ? inactiveNote
          : '${section.notes} $inactiveNote',
    );
  }

  CompendiumCatalog applyPackStateEffects() {
    final inactivePackIds = inactiveOptionalPackIds;
    if (inactivePackIds.isEmpty) {
      return this;
    }

    final filteredNarrativeGroups = narrativeOptionGroups
        .where(
          (group) =>
              group.packId == null || !inactivePackIds.contains(group.packId),
        )
        .toList(growable: false);
    final filteredBackgrounds = backgrounds
        .where(
          (background) =>
              background.packId == null ||
              !inactivePackIds.contains(background.packId),
        )
        .toList(growable: false);
    final filteredSpells = spells
        .where(
          (spell) =>
              spell.packId == null || !inactivePackIds.contains(spell.packId),
        )
        .toList(growable: false);
    final filteredFeats = feats
        .where(
          (feat) =>
              feat.packId == null || !inactivePackIds.contains(feat.packId),
        )
        .toList(growable: false);
    final filteredMonsters = monsters
        .where(
          (monster) =>
              monster.packId == null ||
              !inactivePackIds.contains(monster.packId),
        )
        .toList(growable: false);

    final filteredSections = sourcePolicy.sections
        .map(sectionWithPackActivity)
        .toList(growable: false);

    return copyWith(
      backgrounds: filteredBackgrounds,
      narrativeOptionGroups: filteredNarrativeGroups,
      spells: filteredSpells,
      feats: filteredFeats,
      monsters: filteredMonsters,
      sourcePolicy: CompendiumSourcePolicy(
        activeSourceType: sourcePolicy.activeSourceType,
        activeSourceLabel: sourcePolicy.activeSourceLabel,
        fallbackSourceLabel: sourcePolicy.fallbackSourceLabel,
        sections: filteredSections,
      ),
    );
  }
}

@immutable
class CompendiumPackStateModel {
  const CompendiumPackStateModel({
    required this.id,
    required this.title,
    required this.description,
    required this.kind,
    required this.isFixed,
    required this.isActive,
  });

  final String id;
  final String title;
  final String description;
  final String kind;
  final bool isFixed;
  final bool isActive;

  CompendiumPackStateModel copyWith({
    String? id,
    String? title,
    String? description,
    String? kind,
    bool? isFixed,
    bool? isActive,
  }) {
    return CompendiumPackStateModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      kind: kind ?? this.kind,
      isFixed: isFixed ?? this.isFixed,
      isActive: isActive ?? this.isActive,
    );
  }
}

@immutable
class CompendiumSourcePolicy {
  const CompendiumSourcePolicy({
    required this.activeSourceType,
    required this.activeSourceLabel,
    required this.fallbackSourceLabel,
    required this.sections,
  });

  final String activeSourceType;
  final String activeSourceLabel;
  final String fallbackSourceLabel;
  final List<CompendiumSectionSourcePolicy> sections;

  CompendiumSectionSourcePolicy? sectionFor(String sectionKey) {
    for (final section in sections) {
      if (section.sectionKey == sectionKey) {
        return section;
      }
    }
    return null;
  }
}

@immutable
class CompendiumSectionSourcePolicy {
  const CompendiumSectionSourcePolicy({
    required this.sectionKey,
    required this.sectionLabel,
    required this.sourceType,
    required this.primarySources,
    this.supplementalSources = const <String>[],
    this.supplementalPackId,
    this.notes,
  });

  final String sectionKey;
  final String sectionLabel;
  final String sourceType;
  final List<String> primarySources;
  final List<String> supplementalSources;
  final String? supplementalPackId;
  final String? notes;
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
    this.packId,
  });

  final String id;
  final String name;
  final String summary;
  final List<String> bonuses;
  final List<String> socialPerks;
  final String? packId;
}

@immutable
class CompendiumNarrativeOptionGroup {
  const CompendiumNarrativeOptionGroup({
    required this.id,
    required this.fieldKey,
    required this.sourceType,
    required this.title,
    required this.options,
    this.packId,
    this.sourceId,
    this.sourceName,
    this.backgroundId,
    this.backgroundName,
    this.diceFormula,
    this.sourceBook,
  });

  final String id;
  final String fieldKey;
  final String sourceType;
  final String? packId;
  final String? sourceId;
  final String? sourceName;
  final String? backgroundId;
  final String? backgroundName;
  final String title;
  final String? diceFormula;
  final String? sourceBook;
  final List<CompendiumNarrativeOption> options;
}

@immutable
class CompendiumNarrativeOption {
  const CompendiumNarrativeOption({
    required this.id,
    required this.optionIndex,
    required this.text,
    this.rollMin,
    this.rollMax,
    this.label,
  });

  final String id;
  final int optionIndex;
  final int? rollMin;
  final int? rollMax;
  final String? label;
  final String text;
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
    required this.id,
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
    this.packId,
  });

  final String id;
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
  final String? packId;
}

@immutable
class CompendiumFeat {
  const CompendiumFeat({
    required this.name,
    required this.prerequisite,
    required this.description,
    required this.modifiers,
    required this.source,
    this.packId,
  });

  final String name;
  final String prerequisite;
  final List<String> description;
  final List<String> modifiers;
  final String source;
  final String? packId;
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
    this.packId,
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
  final String? packId;
}
