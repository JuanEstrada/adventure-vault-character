import 'package:adventure_vault_character/src/features/characters/domain/equipment_summary_view_data.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_finishing_details.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_rules.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:flutter/foundation.dart';

@immutable
class CharacterDomainModel {
  const CharacterDomainModel({
    required this.id,
    required this.identity,
    required this.combat,
    required this.abilities,
    required this.featuresNotes,
    required this.equipment,
    this.spellcasting,
  });

  final String id;
  final CharacterIdentityDomainModel identity;
  final CharacterCombatDomainModel combat;
  final CharacterAbilitiesDomainModel abilities;
  final CharacterFeaturesNotesDomainModel featuresNotes;
  final CharacterEquipmentDomainModel equipment;
  final CharacterSpellcastingDomainModel? spellcasting;
}

@immutable
class CharacterIdentityDomainModel {
  const CharacterIdentityDomainModel({
    required this.name,
    required this.raceName,
    required this.className,
    required this.progression,
  });

  final String name;
  final String raceName;
  final String className;
  final CharacterProgressionDomainModel progression;
}

@immutable
class CharacterProgressionDomainModel {
  const CharacterProgressionDomainModel({
    required this.level,
    required this.experience,
  });

  final int level;
  final int experience;

  int get proficiencyBonus => CharacterRules.proficiencyBonusForLevel(level);

  int get levelProgressPercent =>
      CharacterRules.levelProgressPercent(level: level, experience: experience);
}

@immutable
class CharacterCombatDomainModel {
  const CharacterCombatDomainModel({
    required this.hitPoints,
    required this.savingThrows,
  });

  final CharacterHitPointsDomainModel hitPoints;
  final List<CharacterSavingThrowDomainModel> savingThrows;
}

@immutable
class CharacterHitPointsDomainModel {
  const CharacterHitPointsDomainModel({
    required this.current,
    required this.maximum,
    required this.temporary,
  });

  final int current;
  final int maximum;
  final int temporary;
}

@immutable
class CharacterSavingThrowDomainModel {
  const CharacterSavingThrowDomainModel({
    required this.abilityKey,
    required this.bonus,
    required this.isProficient,
  });

  final String abilityKey;
  final int bonus;
  final bool isProficient;

  String get displayLabel => _titleCase(abilityKey);
  String get displayBonus => bonus >= 0 ? '+$bonus' : '$bonus';

  static String _titleCase(String raw) {
    if (raw.isEmpty) {
      return raw;
    }

    return raw[0].toUpperCase() + raw.substring(1);
  }
}

@immutable
class CharacterAbilitiesDomainModel {
  const CharacterAbilitiesDomainModel({
    required this.methodKey,
    required this.entries,
  });

  final String? methodKey;
  final List<CharacterAbilityScoreDomainModel> entries;

  String get methodLabel {
    return switch (methodKey) {
      'generatedSetAssignment' => 'Generated set assignment',
      'manualPointAllocation' => 'Manual point allocation',
      _ => 'Unknown method',
    };
  }
}

@immutable
class CharacterAbilityScoreDomainModel {
  const CharacterAbilityScoreDomainModel({
    required this.label,
    required this.score,
  });

  final String label;
  final int score;

  int get modifier => CharacterRules.abilityModifier(score);
}

@immutable
class CharacterSpellcastingDomainModel {
  const CharacterSpellcastingDomainModel({
    required this.abilityKey,
    required this.abilityLabel,
    required this.abilityScore,
    required this.proficiencyBonus,
    required this.availableSpells,
    required this.selectionMode,
    required this.selectedSpells,
    required this.slotProgression,
    this.selectionLimit = 0,
  });

  final String abilityKey;
  final String abilityLabel;
  final int abilityScore;
  final int proficiencyBonus;
  final List<CharacterSpellReferenceDomainModel> availableSpells;
  final CharacterSpellSelectionMode? selectionMode;
  final List<CharacterSpellReferenceDomainModel> selectedSpells;
  final List<CharacterSpellSlotDomainModel> slotProgression;
  final int selectionLimit;

  int get abilityModifier => CharacterRules.abilityModifier(abilityScore);

  int get spellSaveDc => 8 + proficiencyBonus + abilityModifier;

  int get spellAttackBonus => proficiencyBonus + abilityModifier;

  String get displayAbilityModifier =>
      abilityModifier >= 0 ? '+$abilityModifier' : '$abilityModifier';

  String get displaySpellAttackBonus =>
      spellAttackBonus >= 0 ? '+$spellAttackBonus' : '$spellAttackBonus';

  String get selectionLabel {
    return switch (selectionMode) {
      CharacterSpellSelectionMode.prepared => 'Prepared spells',
      CharacterSpellSelectionMode.known => 'Known spells',
      CharacterSpellSelectionMode.spellbook => 'Spellbook spells',
      _ => 'Selected spells',
    };
  }

  String get selectionSummary => '${selectedSpells.length} / $selectionLimit';

  List<CharacterSpellLevelDomainModel> get spellsByLevel {
    return _groupSpellsByLevel(availableSpells);
  }

  List<CharacterSpellLevelDomainModel> get selectedSpellsByLevel {
    return _groupSpellsByLevel(selectedSpells);
  }

  List<CharacterSpellLevelDomainModel> _groupSpellsByLevel(
    List<CharacterSpellReferenceDomainModel> spells,
  ) {
    final byLevel = <int, List<CharacterSpellReferenceDomainModel>>{};
    for (final spell in spells) {
      byLevel
          .putIfAbsent(
            spell.level,
            () => <CharacterSpellReferenceDomainModel>[],
          )
          .add(spell);
    }

    final levels = byLevel.keys.toList()..sort();
    return levels
        .map(
          (level) => CharacterSpellLevelDomainModel(
            level: level,
            spells: List<CharacterSpellReferenceDomainModel>.unmodifiable(
              byLevel[level]!,
            ),
          ),
        )
        .toList(growable: false);
  }
}

@immutable
class CharacterSpellLevelDomainModel {
  const CharacterSpellLevelDomainModel({
    required this.level,
    required this.spells,
  });

  final int level;
  final List<CharacterSpellReferenceDomainModel> spells;

  String get label => level == 0 ? 'Cantrips' : 'Level $level';
}

@immutable
class CharacterSpellReferenceDomainModel {
  const CharacterSpellReferenceDomainModel({
    required this.id,
    required this.name,
    required this.level,
    required this.school,
    required this.castingTime,
    required this.range,
    required this.duration,
    required this.source,
  });

  final String id;
  final String name;
  final int level;
  final String school;
  final String castingTime;
  final String range;
  final String duration;
  final String source;
}

@immutable
class CharacterSpellSlotDomainModel {
  const CharacterSpellSlotDomainModel({
    required this.spellLevel,
    required this.slotsExpended,
    required this.slotsMax,
  });

  final int spellLevel;
  final int slotsExpended;
  final int slotsMax;

  int get slotsRemaining => slotsMax - slotsExpended;

  String get label => 'Level $spellLevel';

  String get displaySummary => '$slotsRemaining / $slotsMax';
}

@immutable
class CharacterFeaturesNotesDomainModel {
  const CharacterFeaturesNotesDomainModel({
    required this.background,
    required this.proficientSkills,
    required this.otherProficiencies,
    required this.finishingDetails,
  });

  final CharacterBackgroundDomainModel background;
  final List<CharacterSkillDomainModel> proficientSkills;
  final List<CharacterProficiencyDomainModel> otherProficiencies;
  final CharacterFinishingDetailsDomainModel finishingDetails;

  List<String> get proficientSkillLabels =>
      proficientSkills.map((item) => item.displayLabel).toList(growable: false);

  List<String> get otherProficiencyLabels => otherProficiencies
      .map((item) => item.displayLabel)
      .toSet()
      .toList(growable: false);

  String get alignment =>
      finishingDetails.valueFor(NarrativeFieldKey.alignment) ?? 'Unaligned';

  String get appearanceDetails => finishingDetails.appearanceDetails;

  String get narrativeDetails => finishingDetails.narrativeNotes;
}

@immutable
class CharacterFinishingDetailsDomainModel {
  const CharacterFinishingDetailsDomainModel({
    required this.appearanceDetails,
    required this.narrativeNotes,
    required this.narrativeSelections,
    this.portraitAssetPath,
  });

  final String appearanceDetails;
  final String narrativeNotes;
  final List<CharacterNarrativeSelectionDomainModel> narrativeSelections;
  final String? portraitAssetPath;

  String? valueFor(NarrativeFieldKey fieldKey) {
    for (final selection in narrativeSelections) {
      if (selection.fieldKey == fieldKey && selection.hasValue) {
        return selection.valueText;
      }
    }
    return null;
  }

  List<CharacterNarrativeSelectionDomainModel> get visibleSelections =>
      narrativeSelections
          .where((selection) => selection.hasValue)
          .toList(growable: false);
}

@immutable
class CharacterNarrativeSelectionDomainModel {
  const CharacterNarrativeSelectionDomainModel({
    required this.fieldKey,
    required this.mode,
    required this.valueText,
  });

  final NarrativeFieldKey fieldKey;
  final NarrativeSelectionMode mode;
  final String? valueText;

  bool get hasValue => valueText != null && valueText!.trim().isNotEmpty;
}

@immutable
class CharacterBackgroundDomainModel {
  const CharacterBackgroundDomainModel({
    required this.name,
    required this.summary,
    required this.bonuses,
    required this.socialPerks,
  });

  final String name;
  final String summary;
  final List<CharacterBackgroundEntryDomainModel> bonuses;
  final List<CharacterBackgroundEntryDomainModel> socialPerks;

  List<String> get bonusDescriptions =>
      bonuses.map((item) => item.displayText).toList(growable: false);

  List<String> get socialPerkDescriptions =>
      socialPerks.map((item) => item.displayText).toList(growable: false);
}

@immutable
class CharacterBackgroundEntryDomainModel {
  const CharacterBackgroundEntryDomainModel({
    required this.label,
    required this.description,
  });

  final String label;
  final String description;

  String get displayText =>
      description.isEmpty ? label : '$label: $description';
}

@immutable
class CharacterSkillDomainModel {
  const CharacterSkillDomainModel({
    required this.name,
    required this.isProficient,
    required this.hasExpertise,
  });

  final String name;
  final bool isProficient;
  final bool hasExpertise;

  String get displayLabel => hasExpertise ? '$name (expertise)' : name;
}

@immutable
class CharacterProficiencyDomainModel {
  const CharacterProficiencyDomainModel({
    required this.proficiencyType,
    required this.referenceKey,
  });

  final String proficiencyType;
  final String referenceKey;

  String get displayLabel =>
      '${_titleCase(proficiencyType)}: ${_humanizeKey(referenceKey)}';

  static String _titleCase(String raw) {
    if (raw.isEmpty) {
      return raw;
    }

    return raw[0].toUpperCase() + raw.substring(1);
  }

  static String _humanizeKey(String raw) {
    return raw
        .split('-')
        .map((chunk) => chunk.isEmpty ? chunk : _titleCase(chunk))
        .join(' ');
  }
}

@immutable
class CharacterEquipmentDomainModel {
  const CharacterEquipmentDomainModel({
    required this.equipmentSummary,
    required this.selectedEquipmentLabel,
    required this.money,
    required this.items,
  });

  final EquipmentSummaryViewData equipmentSummary;
  final String selectedEquipmentLabel;
  final CharacterMoneySummaryDomainModel money;
  final List<CharacterEquipmentItemDomainModel> items;

  List<String> get visibleItems =>
      items.map((item) => item.displayLabel).toList(growable: false);
}

@immutable
class CharacterMoneySummaryDomainModel {
  const CharacterMoneySummaryDomainModel({
    required this.currencySummary,
    required this.startingMoneySummary,
  });

  final String currencySummary;
  final String startingMoneySummary;
}

@immutable
class CharacterEquipmentItemDomainModel {
  const CharacterEquipmentItemDomainModel({
    required this.name,
    required this.quantity,
    required this.isEquipped,
  });

  final String name;
  final int quantity;
  final bool isEquipped;

  String get displayLabel {
    final quantityLabel = quantity > 1 ? ' x$quantity' : '';
    final equippedLabel = isEquipped ? ' (equipped)' : '';
    return '$name$quantityLabel$equippedLabel';
  }
}
