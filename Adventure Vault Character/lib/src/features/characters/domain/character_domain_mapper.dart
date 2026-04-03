import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_encumbrance_rules.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_finishing_details.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_class_resource_rules.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_combat_rules.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_record.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_rules.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_spell_rules.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';

class CharacterDomainMapper {
  const CharacterDomainMapper({
    CharacterSpellRules characterSpellRules = const CharacterSpellRules(),
    CharacterClassResourceRules characterClassResourceRules =
        const CharacterClassResourceRules(),
    CharacterEncumbranceRules characterEncumbranceRules =
        const CharacterEncumbranceRules(),
    CharacterCombatRules characterCombatRules = const CharacterCombatRules(),
  }) : _characterSpellRules = characterSpellRules,
       _characterClassResourceRules = characterClassResourceRules,
       _characterEncumbranceRules = characterEncumbranceRules,
       _characterCombatRules = characterCombatRules;

  final CharacterSpellRules _characterSpellRules;
  final CharacterClassResourceRules _characterClassResourceRules;
  final CharacterEncumbranceRules _characterEncumbranceRules;
  final CharacterCombatRules _characterCombatRules;

  CharacterDomainModel map(
    CharacterRecord record, {
    required bool includeCoinWeightInEncumbrance,
  }) {
    final row = record.row;
    final catalog = record.catalog;
    final background = row.backgroundDefinitionRefId == null
        ? null
        : catalog.backgroundById(row.backgroundDefinitionRefId);
    final persistedLoadout = record.equipmentLoadout;
    final fallbackLoadout = catalog
        .equipmentLoadoutsForClass(row.className)
        .first;
    final equipmentDefinitionsById = <String, EquipmentDefinition>{
      for (final definition in record.inventoryEquipmentDefinitions)
        definition.id: definition,
    };
    final inventoryDisplayNameById = <String, String>{
      for (final item in record.inventory)
        item.id: _resolveInventoryItemName(
          item,
          equipmentDefinitionsById: equipmentDefinitionsById,
        ),
    };
    final persistedEquipmentItems = record.inventory
        .map(
          (item) => _mapEquipmentItem(
            item,
            equipmentDefinitionsById: equipmentDefinitionsById,
            inventoryDisplayNameById: inventoryDisplayNameById,
          ),
        )
        .toList(growable: false);
    final equipmentItems = persistedEquipmentItems.isNotEmpty
        ? persistedEquipmentItems
        : fallbackLoadout.selectedItems
              .map(
                (item) => CharacterEquipmentItemDomainModel(
                  id: 'fallback-${item.hashCode}',
                  name: item,
                  quantity: 1,
                  isEquipped: false,
                  isCarried: true,
                  isFavorite: false,
                  weightPerUnit: null,
                  isContainer: false,
                  chargesCurrent: null,
                  chargesMax: null,
                  containerInventoryItemId: null,
                  containerDisplayName: null,
                ),
              )
              .toList(growable: false);
    final startingMoneySummary =
        _currencySummary(record.currency) ??
        fallbackLoadout.startingMoneySummary;
    final skillDefinitionsById = <String, SkillDefinition>{
      for (final definition in record.skillDefinitions)
        definition.id: definition,
    };
    final resolvedAbilityScores =
        record.abilityScores ?? _emptyAbilityScores(row.id);
    final resolvedHitPoints = record.hitPoints;
    final finishingDetails = record.finishingDetails;
    final narrativeSelections = _mapNarrativeSelections(record);
    final progression = CharacterProgressionDomainModel(
      level: row.level,
      experience: row.experience ?? 0,
    );
    final abilityModifierByKey = <String, int>{
      'str': CharacterRules.abilityModifier(
        resolvedAbilityScores.strengthScore,
      ),
      'dex': CharacterRules.abilityModifier(
        resolvedAbilityScores.dexterityScore,
      ),
      'con': CharacterRules.abilityModifier(
        resolvedAbilityScores.constitutionScore,
      ),
      'int': CharacterRules.abilityModifier(
        resolvedAbilityScores.intelligenceScore,
      ),
      'wis': CharacterRules.abilityModifier(resolvedAbilityScores.wisdomScore),
      'cha': CharacterRules.abilityModifier(
        resolvedAbilityScores.charismaScore,
      ),
    };
    final mappedSkills =
        record.skills
            .map(
              (item) => _mapSkill(
                item,
                skillDefinitionsById: skillDefinitionsById,
                proficiencyBonus: progression.proficiencyBonus,
                abilityModifierByKey: abilityModifierByKey,
              ),
            )
            .toList(growable: false)
          ..sort((left, right) => left.name.compareTo(right.name));
    final equipmentItemsById = <String, CharacterEquipmentItemDomainModel>{
      for (final item in equipmentItems) item.id: item,
    };
    final encumbranceResult = _characterEncumbranceRules.evaluate(
      strengthScore: resolvedAbilityScores.strengthScore,
      carriedItemWeight: equipmentItems
          .where(
            (item) =>
                _isEffectivelyCarried(item, itemsById: equipmentItemsById),
          )
          .map((item) => item.totalWeight)
          .fold(0, (total, weight) => total + weight),
      totalCoinCount: _totalCoinCount(record.currency),
      includeCoinWeight: includeCoinWeightInEncumbrance,
    );
    final dexterityModifier = CharacterRules.abilityModifier(
      resolvedAbilityScores.dexterityScore,
    );
    final armorClassResult = _characterCombatRules.deriveArmorClass(
      dexterityModifier: dexterityModifier,
      equippedItems: record.inventory
          .map(
            (item) => CharacterArmorProfile(
              name: _resolveInventoryItemName(
                item,
                equipmentDefinitionsById: equipmentDefinitionsById,
              ),
              isEquipped: item.isEquipped,
              category: item.equipmentDefinitionId == null
                  ? null
                  : equipmentDefinitionsById[item.equipmentDefinitionId!]
                        ?.category,
              armorPropertiesJson: item.equipmentDefinitionId == null
                  ? null
                  : equipmentDefinitionsById[item.equipmentDefinitionId!]
                        ?.armorPropertiesJson,
            ),
          )
          .toList(growable: false),
    );
    final weaponAttackResults = _characterCombatRules.deriveWeaponAttacks(
      strengthModifier: CharacterRules.abilityModifier(
        resolvedAbilityScores.strengthScore,
      ),
      dexterityModifier: dexterityModifier,
      proficiencyBonus: progression.proficiencyBonus,
      weaponProficiencyKeys: record.proficiencies
          .where(
            (item) => item.proficiencyType.trim().toLowerCase() == 'weapon',
          )
          .map((item) => item.referenceKey)
          .toSet(),
      equippedItems: record.inventory
          .map(
            (item) => CharacterWeaponProfile(
              name: _resolveInventoryItemName(
                item,
                equipmentDefinitionsById: equipmentDefinitionsById,
              ),
              isEquipped: item.isEquipped,
              category: item.equipmentDefinitionId == null
                  ? null
                  : equipmentDefinitionsById[item.equipmentDefinitionId!]
                        ?.category,
              subcategory: item.equipmentDefinitionId == null
                  ? null
                  : equipmentDefinitionsById[item.equipmentDefinitionId!]
                        ?.subcategory,
              weaponPropertiesJson: item.equipmentDefinitionId == null
                  ? null
                  : equipmentDefinitionsById[item.equipmentDefinitionId!]
                        ?.weaponPropertiesJson,
            ),
          )
          .toList(growable: false),
    );
    final deathSaves = record.deathSaves;

    return CharacterDomainModel(
      id: row.id,
      identity: CharacterIdentityDomainModel(
        name: row.name,
        raceName: row.raceName,
        className: row.className,
        progression: progression,
      ),
      combat: CharacterCombatDomainModel(
        hitPoints: CharacterHitPointsDomainModel(
          current: resolvedHitPoints?.current ?? 0,
          maximum: resolvedHitPoints?.maximum ?? 0,
          temporary: resolvedHitPoints?.temporary ?? 0,
        ),
        armorClass: armorClassResult.armorClass,
        initiativeModifier: _characterCombatRules.deriveInitiativeModifier(
          dexterityModifier: dexterityModifier,
        ),
        deathSaves: CharacterDeathSaveStateDomainModel(
          successCount: deathSaves?.successCount ?? 0,
          failureCount: deathSaves?.failureCount ?? 0,
        ),
        weaponAttacks: weaponAttackResults
            .map(
              (item) => CharacterWeaponAttackDomainModel(
                name: item.name,
                attackAbilityKey: item.attackAbilityKey,
                attackBonus: item.attackBonus,
                damageModifier: item.damageModifier,
                isProficient: item.isProficient,
                damageDice: item.damageDice,
                damageType: item.damageType,
              ),
            )
            .toList(growable: false),
        hasArmorConfigurationConflict: armorClassResult.hasArmorConflict,
        savingThrows: record.savingThrows
            .map(
              (item) => CharacterSavingThrowDomainModel(
                abilityKey: item.abilityKey,
                bonus: item.totalBonus ?? item.miscBonus,
                isProficient: item.isProficient,
              ),
            )
            .toList(growable: false),
        classResources: _mapClassResources(record),
      ),
      abilities: CharacterAbilitiesDomainModel(
        methodKey: record.abilityScoreProvenance?.methodKey,
        entries: <CharacterAbilityScoreDomainModel>[
          CharacterAbilityScoreDomainModel(
            label: 'Strength',
            score: resolvedAbilityScores.strengthScore,
          ),
          CharacterAbilityScoreDomainModel(
            label: 'Dexterity',
            score: resolvedAbilityScores.dexterityScore,
          ),
          CharacterAbilityScoreDomainModel(
            label: 'Constitution',
            score: resolvedAbilityScores.constitutionScore,
          ),
          CharacterAbilityScoreDomainModel(
            label: 'Intelligence',
            score: resolvedAbilityScores.intelligenceScore,
          ),
          CharacterAbilityScoreDomainModel(
            label: 'Wisdom',
            score: resolvedAbilityScores.wisdomScore,
          ),
          CharacterAbilityScoreDomainModel(
            label: 'Charisma',
            score: resolvedAbilityScores.charismaScore,
          ),
        ],
      ),
      spellcasting: _mapSpellcasting(
        resolvedAbilityScores: resolvedAbilityScores,
        progression: progression,
        record: record,
      ),
      featuresNotes: CharacterFeaturesNotesDomainModel(
        background: CharacterBackgroundDomainModel(
          name:
              record.backgroundDefinition?.name ??
              background?.name ??
              'No background',
          summary:
              record.backgroundDefinition?.summary ??
              background?.summary ??
              'No summary available.',
          bonuses: (background?.bonuses ?? const <String>['No bonuses loaded'])
              .map(_mapBackgroundEntry)
              .toList(growable: false),
          socialPerks:
              (background?.socialPerks ??
                      const <String>['No social perks loaded'])
                  .map(_mapBackgroundEntry)
                  .toList(growable: false),
        ),
        proficientSkills: mappedSkills
            .where((item) => item.isProficient || item.hasExpertise)
            .toList(growable: false),
        skills: mappedSkills,
        otherProficiencies: record.proficiencies
            .map(
              (item) => CharacterProficiencyDomainModel(
                proficiencyType: item.proficiencyType,
                referenceKey: item.referenceKey,
              ),
            )
            .toList(growable: false),
        finishingDetails: CharacterFinishingDetailsDomainModel(
          portraitAssetPath: finishingDetails?.portraitAssetPath,
          appearanceDetails: finishingDetails?.appearanceDetails ?? '',
          narrativeNotes: finishingDetails?.narrativeDetails ?? '',
          narrativeSelections: narrativeSelections,
        ),
      ),
      equipment: CharacterEquipmentDomainModel(
        equipmentSummary: catalog.equipmentSummaryForClass(row.className),
        selectedEquipmentLabel:
            persistedLoadout?.loadoutLabel ?? fallbackLoadout.label,
        money: CharacterMoneySummaryDomainModel(
          currencySummary: startingMoneySummary,
          startingMoneySummary: startingMoneySummary,
        ),
        items: equipmentItems,
        carrying: CharacterCarryingDomainModel(
          carriedWeight: encumbranceResult.carriedWeight,
          coinWeight: encumbranceResult.coinWeight,
          totalWeight: encumbranceResult.totalWeight,
          capacity: encumbranceResult.capacity,
          encumberedThreshold: encumbranceResult.encumberedThreshold,
          heavilyEncumberedThreshold:
              encumbranceResult.heavilyEncumberedThreshold,
          includeCoinWeight: includeCoinWeightInEncumbrance,
          tier: encumbranceResult.tier,
          tierLabel: encumbranceResult.tierLabel,
          tierDescription: encumbranceResult.tierDescription,
        ),
      ),
    );
  }

  CharacterSkillDomainModel _mapSkill(
    CharacterSkill item, {
    required Map<String, SkillDefinition> skillDefinitionsById,
    required int proficiencyBonus,
    required Map<String, int> abilityModifierByKey,
  }) {
    final definition = skillDefinitionsById[item.skillDefinitionId];
    final abilityKey = _normalizeAbilityKey(definition?.governingAbility);
    final proficiencyMultiplier = item.hasExpertise
        ? 2
        : item.isProficient
        ? 1
        : 0;
    final derivedBonus =
        (abilityModifierByKey[abilityKey] ?? 0) +
        (proficiencyMultiplier * proficiencyBonus) +
        item.miscBonus;

    return CharacterSkillDomainModel(
      name: definition?.name ?? item.skillDefinitionId,
      isProficient: item.isProficient,
      hasExpertise: item.hasExpertise,
      abilityKey: abilityKey,
      bonus: item.totalBonus ?? derivedBonus,
    );
  }

  String _normalizeAbilityKey(String? raw) {
    final normalized = raw?.trim().toLowerCase() ?? '';
    if (normalized.isEmpty) {
      return 'unknown';
    }

    if (normalized.length <= 3) {
      return normalized;
    }

    return switch (normalized) {
      'strength' => 'str',
      'dexterity' => 'dex',
      'constitution' => 'con',
      'intelligence' => 'int',
      'wisdom' => 'wis',
      'charisma' => 'cha',
      _ => normalized.substring(0, 3),
    };
  }

  CharacterSpellcastingDomainModel? _mapSpellcasting({
    required CharacterAbilityScore resolvedAbilityScores,
    required CharacterProgressionDomainModel progression,
    required CharacterRecord record,
  }) {
    final classDefinition = record.classDefinition;
    final abilityKey = classDefinition?.spellcastingAbility
        ?.trim()
        .toUpperCase();
    if (classDefinition == null ||
        !classDefinition.isSpellcaster ||
        abilityKey == null ||
        abilityKey.isEmpty) {
      return null;
    }

    final availableSpells =
        record.catalog.spells
            .where(
              (spell) =>
                  _spellMatchesClass(spell.classes, record.row.className),
            )
            .map(
              (spell) => CharacterSpellReferenceDomainModel(
                id: spell.id,
                name: spell.name,
                level: spell.level,
                school: spell.school,
                castingTime: spell.castingTime,
                range: spell.range,
                duration: spell.duration,
                source: spell.source,
              ),
            )
            .toList(growable: false)
          ..sort((left, right) {
            final byLevel = left.level.compareTo(right.level);
            if (byLevel != 0) {
              return byLevel;
            }
            return left.name.compareTo(right.name);
          });
    final availableSpellsById = <String, CharacterSpellReferenceDomainModel>{
      for (final spell in availableSpells) spell.id: spell,
    };
    final expectedMode = _characterSpellRules.selectionModeForClass(
      record.row.className,
    );
    final spellbookSpells = record.spellSelections
        .where((row) => row.selectionKind == 'spellbook')
        .map((row) => availableSpellsById[row.spellDefinitionId])
        .whereType<CharacterSpellReferenceDomainModel>()
        .toList(growable: false);
    final selectedSpells = record.spellSelections
        .where(
          (row) => expectedMode == CharacterSpellSelectionMode.spellbook
              ? row.selectionKind == 'prepared'
              : row.selectionKind == _modeStorageKey(expectedMode),
        )
        .map((row) => availableSpellsById[row.spellDefinitionId])
        .whereType<CharacterSpellReferenceDomainModel>()
        .toList(growable: false);
    final effectiveAvailableSpells =
        expectedMode == CharacterSpellSelectionMode.spellbook &&
            spellbookSpells.isNotEmpty
        ? spellbookSpells
        : availableSpells;
    final slotProgression = _characterSpellRules.slotProgressionFor(
      className: record.row.className,
      level: record.row.level,
    );
    final slotUsageByLevel = <int, int>{
      for (final usage in record.spellSlotUsages)
        usage.spellLevel: usage.slotsExpended,
    };
    final abilityScore = _abilityScoreForKey(
      abilityKey: abilityKey,
      scores: resolvedAbilityScores,
    );

    return CharacterSpellcastingDomainModel(
      abilityKey: abilityKey,
      abilityLabel: _spellcastingAbilityLabel(abilityKey),
      abilityScore: abilityScore,
      proficiencyBonus: progression.proficiencyBonus,
      availableSpells: effectiveAvailableSpells,
      selectionMode: expectedMode,
      selectedSpells: selectedSpells,
      selectionLimit: _characterSpellRules.selectionLimitFor(
        className: record.row.className,
        level: record.row.level,
        abilityModifier: _characterSpellAbilityModifier(abilityScore),
      ),
      slotProgression: slotProgression
          .map(
            (slot) => CharacterSpellSlotDomainModel(
              spellLevel: slot.spellLevel,
              slotsExpended: (slotUsageByLevel[slot.spellLevel] ?? 0).clamp(
                0,
                slot.slotsMax,
              ),
              slotsMax: slot.slotsMax,
            ),
          )
          .toList(growable: false),
    );
  }

  CharacterBackgroundEntryDomainModel _mapBackgroundEntry(String raw) {
    final separatorIndex = raw.indexOf(':');
    if (separatorIndex <= 0 || separatorIndex >= raw.length - 1) {
      return CharacterBackgroundEntryDomainModel(
        label: raw.trim(),
        description: '',
      );
    }

    return CharacterBackgroundEntryDomainModel(
      label: raw.substring(0, separatorIndex).trim(),
      description: raw.substring(separatorIndex + 1).trim(),
    );
  }

  CharacterEquipmentItemDomainModel _mapEquipmentItem(
    CharacterInventoryData item, {
    required Map<String, EquipmentDefinition> equipmentDefinitionsById,
    required Map<String, String> inventoryDisplayNameById,
  }) {
    final equipmentDefinition = item.equipmentDefinitionId == null
        ? null
        : equipmentDefinitionsById[item.equipmentDefinitionId!];
    return CharacterEquipmentItemDomainModel(
      id: item.id,
      name: _resolveInventoryItemName(
        item,
        equipmentDefinitionsById: equipmentDefinitionsById,
      ),
      quantity: item.quantity.clamp(0, 9999).toInt(),
      isEquipped: item.isEquipped,
      isCarried: item.isCarried,
      isFavorite: item.isFavorite,
      weightPerUnit: equipmentDefinition?.weight,
      isContainer: equipmentDefinition?.isContainer ?? false,
      chargesCurrent: item.chargesCurrent,
      chargesMax: item.chargesMax,
      containerInventoryItemId: item.containerInventoryItemId,
      containerDisplayName: item.containerInventoryItemId == null
          ? null
          : inventoryDisplayNameById[item.containerInventoryItemId],
    );
  }

  String _resolveInventoryItemName(
    CharacterInventoryData item, {
    required Map<String, EquipmentDefinition> equipmentDefinitionsById,
  }) {
    final equipmentDefinition = item.equipmentDefinitionId == null
        ? null
        : equipmentDefinitionsById[item.equipmentDefinitionId!];
    return item.displayNameSnapshot ??
        equipmentDefinition?.name ??
        item.equipmentDefinitionId ??
        item.trinketDefinitionId ??
        'Unknown item';
  }

  bool _isEffectivelyCarried(
    CharacterEquipmentItemDomainModel item, {
    required Map<String, CharacterEquipmentItemDomainModel> itemsById,
  }) {
    if (!item.isCarried) {
      return false;
    }

    final visitedIds = <String>{item.id};
    String? containerId = item.containerInventoryItemId;
    while (containerId != null) {
      final container = itemsById[containerId];
      if (container == null) {
        return true;
      }
      if (!container.isCarried) {
        return false;
      }
      if (!visitedIds.add(container.id)) {
        return false;
      }
      containerId = container.containerInventoryItemId;
    }
    return true;
  }

  List<CharacterClassResourceDomainModel> _mapClassResources(
    CharacterRecord record,
  ) {
    final definitions = _characterClassResourceRules.resourcesFor(
      className: record.row.className,
      level: record.row.level,
    );
    if (definitions.isEmpty) {
      return const <CharacterClassResourceDomainModel>[];
    }

    final persistedByKey = <String, int>{
      for (final row in record.classResources) row.resourceKey: row.currentUses,
    };
    final persistedSourceByKey = <String, String>{
      for (final row in record.classResources)
        row.resourceKey: row.lastChangedSource,
    };
    final persistedChangedAtByKey = <String, DateTime>{
      for (final row in record.classResources)
        row.resourceKey: row.lastChangedAt,
    };
    return definitions
        .map(
          (definition) => CharacterClassResourceDomainModel(
            resourceKey: definition.resourceKey,
            label: definition.label,
            currentUses:
                (persistedByKey[definition.resourceKey] ??
                        definition.maximumUses)
                    .clamp(0, definition.maximumUses)
                    .toInt(),
            maximumUses: definition.maximumUses,
            recoversOnShortRest: definition.recoversOnShortRest,
            lastChangedSource:
                persistedSourceByKey[definition.resourceKey] ?? 'seed',
            lastChangedAt:
                persistedChangedAtByKey[definition.resourceKey] ??
                record.row.updatedAt,
          ),
        )
        .toList(growable: false);
  }

  String? _currencySummary(CharacterCurrencyData? currency) {
    if (currency == null) {
      return null;
    }

    final units = <String>[
      if (currency.platinum > 0) '${currency.platinum} pp',
      if (currency.gold > 0) '${currency.gold} gp',
      if (currency.electrum > 0) '${currency.electrum} ep',
      if (currency.silver > 0) '${currency.silver} sp',
      if (currency.copper > 0) '${currency.copper} cp',
    ];

    if (units.isNotEmpty) {
      return units.join(', ');
    }

    return currency.summarySnapshot;
  }

  int _totalCoinCount(CharacterCurrencyData? currency) {
    if (currency == null) {
      return 0;
    }

    return currency.copper +
        currency.silver +
        currency.electrum +
        currency.gold +
        currency.platinum;
  }

  int _abilityScoreForKey({
    required String abilityKey,
    required CharacterAbilityScore scores,
  }) {
    return switch (abilityKey) {
      'STR' => scores.strengthScore,
      'DEX' => scores.dexterityScore,
      'CON' => scores.constitutionScore,
      'INT' => scores.intelligenceScore,
      'WIS' => scores.wisdomScore,
      'CHA' => scores.charismaScore,
      _ => 0,
    };
  }

  int _characterSpellAbilityModifier(int abilityScore) {
    return CharacterRules.abilityModifier(abilityScore);
  }

  String _spellcastingAbilityLabel(String abilityKey) {
    return switch (abilityKey) {
      'STR' => 'Strength',
      'DEX' => 'Dexterity',
      'CON' => 'Constitution',
      'INT' => 'Intelligence',
      'WIS' => 'Wisdom',
      'CHA' => 'Charisma',
      _ => abilityKey,
    };
  }

  String _modeStorageKey(CharacterSpellSelectionMode? mode) {
    return switch (mode) {
      CharacterSpellSelectionMode.prepared => 'prepared',
      CharacterSpellSelectionMode.known => 'known',
      CharacterSpellSelectionMode.spellbook => 'spellbook',
      _ => '',
    };
  }

  bool _spellMatchesClass(List<String> spellClasses, String className) {
    final normalizedClassName = _normalizeClassName(className);
    for (final spellClass in spellClasses) {
      if (_normalizeClassName(spellClass) == normalizedClassName) {
        return true;
      }
    }
    return false;
  }

  String _normalizeClassName(String raw) {
    return raw.trim().toLowerCase();
  }

  CharacterAbilityScore _emptyAbilityScores(String characterId) {
    return CharacterAbilityScore(
      characterId: characterId,
      strengthScore: 0,
      dexterityScore: 0,
      constitutionScore: 0,
      intelligenceScore: 0,
      wisdomScore: 0,
      charismaScore: 0,
      strengthModifier: null,
      dexterityModifier: null,
      constitutionModifier: null,
      intelligenceModifier: null,
      wisdomModifier: null,
      charismaModifier: null,
    );
  }

  List<CharacterNarrativeSelectionDomainModel> _mapNarrativeSelections(
    CharacterRecord record,
  ) {
    final selectionsByField =
        <NarrativeFieldKey, CharacterNarrativeSelectionDomainModel>{};

    for (final row in record.narrativeSelections) {
      final fieldKey = NarrativeFieldKeyX.fromStorageKey(row.fieldKey);
      final mode = NarrativeSelectionModeX.fromStorageKey(row.selectionMode);
      if (fieldKey == null || mode == null) {
        continue;
      }
      selectionsByField[fieldKey] = CharacterNarrativeSelectionDomainModel(
        fieldKey: fieldKey,
        mode: mode,
        valueText: row.valueText,
      );
    }

    final legacyAlignment = record.finishingDetails?.alignment?.trim();
    if (legacyAlignment != null &&
        legacyAlignment.isNotEmpty &&
        !selectionsByField.containsKey(NarrativeFieldKey.alignment)) {
      selectionsByField[NarrativeFieldKey.alignment] =
          CharacterNarrativeSelectionDomainModel(
            fieldKey: NarrativeFieldKey.alignment,
            mode: NarrativeSelectionMode.manual,
            valueText: legacyAlignment,
          );
    }

    return NarrativeFieldKey.values
        .map(
          (fieldKey) =>
              selectionsByField[fieldKey] ??
              CharacterNarrativeSelectionDomainModel(
                fieldKey: fieldKey,
                mode: NarrativeSelectionMode.empty,
                valueText: null,
              ),
        )
        .toList(growable: false);
  }
}
