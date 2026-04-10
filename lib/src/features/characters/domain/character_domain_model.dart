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

  int get passivePerception => 10 + _perceptionBonus;

  int get _perceptionBonus {
    for (final skill in featuresNotes.skills) {
      if (skill.name.trim().toLowerCase() == 'perception') {
        return skill.bonus;
      }
    }

    for (final ability in abilities.entries) {
      if (ability.label.trim().toLowerCase() == 'wisdom') {
        return ability.modifier;
      }
    }

    return 0;
  }
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
    required this.classResources,
    this.weaponAttacks = const <CharacterWeaponAttackDomainModel>[],
    this.armorClass = 10,
    this.initiativeModifier = 0,
    this.deathSaves = const CharacterDeathSaveStateDomainModel(),
    this.hasArmorConfigurationConflict = false,
  });

  final CharacterHitPointsDomainModel hitPoints;
  final List<CharacterSavingThrowDomainModel> savingThrows;
  final List<CharacterClassResourceDomainModel> classResources;
  final List<CharacterWeaponAttackDomainModel> weaponAttacks;
  final int armorClass;
  final int initiativeModifier;
  final CharacterDeathSaveStateDomainModel deathSaves;
  final bool hasArmorConfigurationConflict;

  String get displayInitiativeModifier =>
      initiativeModifier >= 0 ? '+$initiativeModifier' : '$initiativeModifier';
}

@immutable
class CharacterWeaponAttackDomainModel {
  const CharacterWeaponAttackDomainModel({
    required this.name,
    required this.attackAbilityKey,
    required this.attackBonus,
    required this.damageModifier,
    required this.isProficient,
    this.damageDice,
    this.damageType,
  });

  final String name;
  final String attackAbilityKey;
  final int attackBonus;
  final int damageModifier;
  final bool isProficient;
  final String? damageDice;
  final String? damageType;

  String get attackAbilityLabel {
    return switch (attackAbilityKey) {
      'str' => 'Strength',
      'dex' => 'Dexterity',
      _ => attackAbilityKey.toUpperCase(),
    };
  }

  String get displayAttackBonus =>
      attackBonus >= 0 ? '+$attackBonus' : '$attackBonus';

  String get displayDamageModifier =>
      damageModifier >= 0 ? '+$damageModifier' : '$damageModifier';

  String get displayDamageExpression {
    final dice = damageDice;
    final typeSuffix = damageType == null ? '' : ' ${damageType!}';
    if (dice == null || dice.isEmpty || dice == '1') {
      return 'Damage $displayDamageModifier$typeSuffix'.trim();
    }
    if (damageModifier == 0) {
      return '$dice$typeSuffix'.trim();
    }
    return '$dice $displayDamageModifier$typeSuffix'.trim();
  }
}

@immutable
class CharacterDeathSaveStateDomainModel {
  const CharacterDeathSaveStateDomainModel({
    this.successCount = 0,
    this.failureCount = 0,
  });

  final int successCount;
  final int failureCount;

  bool get isStable => successCount >= 3;
  bool get isDead => failureCount >= 3;
  bool get canRecordSuccess => !isStable && !isDead;
  bool get canRecordFailure => !isStable && !isDead;
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
class CharacterClassResourceDomainModel {
  const CharacterClassResourceDomainModel({
    required this.resourceKey,
    required this.label,
    required this.currentUses,
    required this.maximumUses,
    required this.recoversOnShortRest,
    required this.lastChangedSource,
    required this.lastChangedAt,
  });

  final String resourceKey;
  final String label;
  final int currentUses;
  final int maximumUses;
  final bool recoversOnShortRest;
  final String lastChangedSource;
  final DateTime lastChangedAt;

  String get recoveryLabel =>
      recoversOnShortRest ? 'Short/Long Rest' : 'Long Rest';

  String get usageSummary => '$currentUses / $maximumUses';

  String get lastChangedSourceLabel {
    return switch (lastChangedSource) {
      'short-rest' => 'Short Rest',
      'long-rest' => 'Long Rest',
      'manual-adjustment' => 'Manual',
      'seed' => 'Initial',
      _ => 'Unknown',
    };
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
      CharacterSpellSelectionMode.spellbook => 'Prepared spells',
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
    this.skills = const <CharacterSkillDomainModel>[],
  });

  final CharacterBackgroundDomainModel background;
  final List<CharacterSkillDomainModel> proficientSkills;
  final List<CharacterProficiencyDomainModel> otherProficiencies;
  final CharacterFinishingDetailsDomainModel finishingDetails;
  final List<CharacterSkillDomainModel> skills;

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
    this.abilityKey = 'unknown',
    this.bonus = 0,
  });

  final String name;
  final bool isProficient;
  final bool hasExpertise;
  final String abilityKey;
  final int bonus;

  String get displayLabel => hasExpertise ? '$name (expertise)' : name;

  String get displayBonus => bonus >= 0 ? '+$bonus' : '$bonus';
}

@immutable
class CharacterProficiencyDomainModel {
  const CharacterProficiencyDomainModel({
    required this.proficiencyType,
    required this.referenceKey,
  });

  final String proficiencyType;
  final String referenceKey;

  String get proficiencyTypeLabel => _titleCase(proficiencyType);

  String get referenceLabel => _humanizeKey(referenceKey);

  String get displayLabel => '$proficiencyTypeLabel: $referenceLabel';

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
    required this.carrying,
  });

  final EquipmentSummaryViewData equipmentSummary;
  final String selectedEquipmentLabel;
  final CharacterMoneySummaryDomainModel money;
  final List<CharacterEquipmentItemDomainModel> items;
  final CharacterCarryingDomainModel carrying;

  List<String> get visibleItems =>
      items.map((item) => item.displayLabel).toList(growable: false);

  CharacterInventoryInvariantReport get inventoryInvariantReport =>
      const CharacterInventoryInvariantEvaluator().evaluate(items);

  CharacterInventoryContainerStateDomainModel? containerStateFor(
    String containerItemId,
  ) {
    CharacterEquipmentItemDomainModel? container;
    for (final item in items) {
      if (item.id == containerItemId) {
        container = item;
        break;
      }
    }
    if (container == null || !container.isContainer) {
      return null;
    }
    final contained = items
        .where((item) => item.containerInventoryItemId == containerItemId)
        .toList(growable: false);
    final containedWeight = contained.fold<int>(
      0,
      (sum, item) => sum + item.totalWeight,
    );
    final containedItemQuantity = contained.fold<int>(
      0,
      (sum, item) => sum + item.safeQuantity,
    );
    return CharacterInventoryContainerStateDomainModel(
      containerItemId: containerItemId,
      containedStackCount: contained.length,
      containedItemQuantity: containedItemQuantity,
      containedWeight: containedWeight,
      capacityWeight: container.containerMaxWeight,
    );
  }
}

@immutable
class CharacterInventoryContainerStateDomainModel {
  const CharacterInventoryContainerStateDomainModel({
    required this.containerItemId,
    required this.containedStackCount,
    required this.containedItemQuantity,
    required this.containedWeight,
    required this.capacityWeight,
  });

  final String containerItemId;
  final int containedStackCount;
  final int containedItemQuantity;
  final int containedWeight;
  final int? capacityWeight;

  String get summaryLabel {
    final capacityLabel = capacityWeight == null
        ? 'unknown capacity'
        : '$containedWeight / $capacityWeight lb';
    return '$containedStackCount stack(s), $containedItemQuantity item(s), $capacityLabel';
  }
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
    required this.id,
    required this.name,
    required this.quantity,
    required this.isEquipped,
    required this.isCarried,
    required this.isFavorite,
    required this.weightPerUnit,
    required this.isContainer,
    required this.chargesCurrent,
    required this.chargesMax,
    required this.containerInventoryItemId,
    required this.containerDisplayName,
  });

  final String id;
  final String name;
  final int quantity;
  final bool isEquipped;
  final bool isCarried;
  final bool isFavorite;
  final int? weightPerUnit;
  final bool isContainer;
  final int? chargesCurrent;
  final int? chargesMax;
  final String? containerInventoryItemId;
  final String? containerDisplayName;

  int get safeQuantity => quantity.clamp(0, 9999).toInt();

  int get totalWeight => (weightPerUnit ?? 0) * safeQuantity;

  int? get containerMaxWeight {
    if (!isContainer) {
      return null;
    }
    final normalized = _normalizedName;
    return switch (normalized) {
      'backpack' => 30,
      'scholar pack' => 25,
      'explorer pack' => 30,
      'priest pack' => 25,
      'burglar pack' => 30,
      'dungeoneer pack' => 30,
      'component pouch' => 5,
      'pouch' => 6,
      _ => null,
    };
  }

  bool get hasCharges => chargesMax != null;

  int get safeChargesCurrent =>
      (chargesCurrent ?? 0).clamp(0, chargesMax ?? 0).toInt();

  bool get hasValidChargeState {
    if (chargesMax == null) {
      return chargesCurrent == null;
    }
    if (chargesMax! < 0 || chargesMax! > 9999) {
      return false;
    }
    if (chargesCurrent == null) {
      return false;
    }
    return chargesCurrent! >= 0 && chargesCurrent! <= chargesMax!;
  }

  bool get isAmmunition {
    final normalized = _normalizedName;
    return normalized.contains('arrow') ||
        normalized.contains('bolt') ||
        normalized.contains('dart') ||
        normalized.contains('bullet') ||
        normalized.contains('sling stone');
  }

  bool get isConsumable {
    final normalized = _normalizedName;
    return normalized.contains('ration') ||
        normalized.contains('potion') ||
        normalized.contains('vial') ||
        normalized.contains('flask') ||
        normalized.contains('oil') ||
        normalized.contains('waterskin') ||
        normalized.contains('torch') ||
        normalized.contains('ammunition');
  }

  String get chargesLabel {
    final max = chargesMax;
    if (max == null) {
      return 'Not tracked';
    }
    return '$safeChargesCurrent / $max';
  }

  String get containerLabel {
    if (isContainer) {
      return 'Container item';
    }
    if (containerDisplayName == null || containerDisplayName!.isEmpty) {
      return 'Not stored in container';
    }
    return 'Stored in $containerDisplayName';
  }

  String get displayLabel {
    final quantityLabel = safeQuantity > 1 ? ' x$safeQuantity' : '';
    final equippedLabel = isEquipped ? ' (equipped)' : '';
    final carriedLabel = isCarried ? '' : ' (stowed)';
    return '$name$quantityLabel$equippedLabel$carriedLabel';
  }

  String get stackStateLabel =>
      safeQuantity > 1 ? 'Stack size: $safeQuantity' : 'Single-item stack';

  String get _normalizedName => name.trim().toLowerCase();
}

@immutable
class CharacterCarryingDomainModel {
  const CharacterCarryingDomainModel({
    required this.carriedWeight,
    required this.coinWeight,
    required this.totalWeight,
    required this.capacity,
    required this.encumberedThreshold,
    required this.heavilyEncumberedThreshold,
    required this.includeCoinWeight,
    required this.tier,
    required this.tierLabel,
    required this.tierDescription,
  });

  final int carriedWeight;
  final int coinWeight;
  final int totalWeight;
  final int capacity;
  final int encumberedThreshold;
  final int heavilyEncumberedThreshold;
  final bool includeCoinWeight;
  final String tier;
  final String tierLabel;
  final String tierDescription;

  String get coinWeightLabel => includeCoinWeight ? 'Included' : 'Excluded';
}

@immutable
class CharacterInventoryPolicyDomainModel {
  const CharacterInventoryPolicyDomainModel({
    required this.maxContainerNestingDepth,
    required this.maxItemQuantity,
    required this.maxChargeCount,
  });

  static const CharacterInventoryPolicyDomainModel phase1Defaults =
      CharacterInventoryPolicyDomainModel(
        maxContainerNestingDepth: 5,
        maxItemQuantity: 9999,
        maxChargeCount: 9999,
      );

  final int maxContainerNestingDepth;
  final int maxItemQuantity;
  final int maxChargeCount;
}

@immutable
class CharacterInventoryInvariantIssue {
  const CharacterInventoryInvariantIssue({
    required this.code,
    required this.itemId,
    required this.message,
  });

  final String code;
  final String itemId;
  final String message;
}

@immutable
class CharacterInventoryInvariantReport {
  const CharacterInventoryInvariantReport({required this.issues});

  final List<CharacterInventoryInvariantIssue> issues;

  bool get isValid => issues.isEmpty;
}

class CharacterInventoryInvariantEvaluator {
  const CharacterInventoryInvariantEvaluator({
    this.policy = CharacterInventoryPolicyDomainModel.phase1Defaults,
  });

  final CharacterInventoryPolicyDomainModel policy;

  CharacterInventoryInvariantReport evaluate(
    List<CharacterEquipmentItemDomainModel> items,
  ) {
    final issues = <CharacterInventoryInvariantIssue>[];
    final byId = <String, CharacterEquipmentItemDomainModel>{
      for (final item in items) item.id: item,
    };

    for (final item in items) {
      if (item.safeQuantity != item.quantity) {
        issues.add(
          CharacterInventoryInvariantIssue(
            code: 'invalid_quantity',
            itemId: item.id,
            message: 'Quantity is outside the allowed range.',
          ),
        );
      }

      if (!item.hasValidChargeState &&
          (item.hasCharges || item.chargesCurrent != null)) {
        issues.add(
          CharacterInventoryInvariantIssue(
            code: 'invalid_charge_state',
            itemId: item.id,
            message:
                'Charge state must be within 0..max and tracked consistently.',
          ),
        );
      }

      final parentId = item.containerInventoryItemId;
      if (parentId == null) {
        continue;
      }
      if (parentId == item.id) {
        issues.add(
          CharacterInventoryInvariantIssue(
            code: 'invalid_structure',
            itemId: item.id,
            message: 'Item cannot reference itself as container.',
          ),
        );
        continue;
      }

      final parent = byId[parentId];
      if (parent == null) {
        issues.add(
          CharacterInventoryInvariantIssue(
            code: 'invalid_target',
            itemId: item.id,
            message: 'Container reference does not exist in current inventory.',
          ),
        );
        continue;
      }
      if (!parent.isContainer) {
        issues.add(
          CharacterInventoryInvariantIssue(
            code: 'invalid_target',
            itemId: item.id,
            message: 'Target container item is not container-capable.',
          ),
        );
      }

      final depth = _containerDepthFor(item, byId);
      if (depth > policy.maxContainerNestingDepth) {
        issues.add(
          CharacterInventoryInvariantIssue(
            code: 'invalid_structure',
            itemId: item.id,
            message: 'Container nesting depth exceeds phase-1 policy.',
          ),
        );
      }
      if (_hasCycle(item, byId)) {
        issues.add(
          CharacterInventoryInvariantIssue(
            code: 'invalid_structure',
            itemId: item.id,
            message: 'Container assignment creates a cycle.',
          ),
        );
      }
    }

    for (final container in items.where((item) => item.isContainer)) {
      final maxWeight = container.containerMaxWeight;
      if (maxWeight == null) {
        continue;
      }
      final contentWeight = _contentWeightFor(container, byId);
      if (contentWeight > maxWeight) {
        issues.add(
          CharacterInventoryInvariantIssue(
            code: 'capacity_exceeded',
            itemId: container.id,
            message: 'Contained weight exceeds container capacity.',
          ),
        );
      }
    }

    return CharacterInventoryInvariantReport(issues: issues);
  }

  int _containerDepthFor(
    CharacterEquipmentItemDomainModel item,
    Map<String, CharacterEquipmentItemDomainModel> byId,
  ) {
    var depth = 0;
    final visited = <String>{item.id};
    String? parentId = item.containerInventoryItemId;
    while (parentId != null) {
      final parent = byId[parentId];
      if (parent == null || !visited.add(parent.id)) {
        break;
      }
      depth += 1;
      parentId = parent.containerInventoryItemId;
    }
    return depth;
  }

  bool _hasCycle(
    CharacterEquipmentItemDomainModel item,
    Map<String, CharacterEquipmentItemDomainModel> byId,
  ) {
    final visited = <String>{item.id};
    String? parentId = item.containerInventoryItemId;
    while (parentId != null) {
      final parent = byId[parentId];
      if (parent == null) {
        return false;
      }
      if (!visited.add(parent.id)) {
        return true;
      }
      parentId = parent.containerInventoryItemId;
    }
    return false;
  }

  int _contentWeightFor(
    CharacterEquipmentItemDomainModel container,
    Map<String, CharacterEquipmentItemDomainModel> byId,
  ) {
    var total = 0;
    for (final item in byId.values) {
      if (item.id == container.id) {
        continue;
      }
      if (_isDescendantOf(item: item, ancestorId: container.id, byId: byId)) {
        total += item.totalWeight;
      }
    }
    return total;
  }

  bool _isDescendantOf({
    required CharacterEquipmentItemDomainModel item,
    required String ancestorId,
    required Map<String, CharacterEquipmentItemDomainModel> byId,
  }) {
    final visited = <String>{item.id};
    String? parentId = item.containerInventoryItemId;
    while (parentId != null) {
      if (parentId == ancestorId) {
        return true;
      }
      final parent = byId[parentId];
      if (parent == null || !visited.add(parent.id)) {
        return false;
      }
      parentId = parent.containerInventoryItemId;
    }
    return false;
  }
}
