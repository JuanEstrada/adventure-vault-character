import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_record.dart';

class CharacterDomainMapper {
  const CharacterDomainMapper();

  CharacterDomainModel map(CharacterRecord record) {
    final row = record.row;
    final catalog = record.catalog;
    final background = row.backgroundDefinitionRefId == null
        ? null
        : catalog.backgroundById(row.backgroundDefinitionRefId);
    final fallbackLoadout = catalog
        .equipmentLoadoutsForClass(row.className)
        .first;
    final persistedEquipmentItems = record.inventory
        .map(_mapEquipmentItem)
        .toList(growable: false);
    final equipmentItems = persistedEquipmentItems.isNotEmpty
        ? persistedEquipmentItems
        : fallbackLoadout.selectedItems
              .map(
                (item) => CharacterEquipmentItemDomainModel(
                  name: item,
                  quantity: 1,
                  isEquipped: false,
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

    return CharacterDomainModel(
      id: row.id,
      identity: CharacterIdentityDomainModel(
        name: row.name,
        raceName: row.raceName,
        className: row.className,
        progression: CharacterProgressionDomainModel(
          level: row.level,
          experience: row.experience ?? 0,
        ),
      ),
      combat: CharacterCombatDomainModel(
        hitPoints: CharacterHitPointsDomainModel(
          current: resolvedHitPoints?.current ?? 0,
          maximum: resolvedHitPoints?.maximum ?? 0,
          temporary: resolvedHitPoints?.temporary ?? 0,
        ),
        savingThrows: record.savingThrows
            .map(
              (item) => CharacterSavingThrowDomainModel(
                abilityKey: item.abilityKey,
                bonus: item.totalBonus ?? item.miscBonus,
                isProficient: item.isProficient,
              ),
            )
            .toList(growable: false),
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
      featuresNotes: CharacterFeaturesNotesDomainModel(
        background: CharacterBackgroundDomainModel(
          name:
              record.backgroundDefinition?.name ??
              background?.name ??
              'Sin background',
          summary:
              record.backgroundDefinition?.summary ??
              background?.summary ??
              'Sin resumen disponible.',
          bonuses: (background?.bonuses ?? const <String>['Sin bonos cargados'])
              .map(_mapBackgroundEntry)
              .toList(growable: false),
          socialPerks:
              (background?.socialPerks ??
                      const <String>['Sin perks sociales cargados'])
                  .map(_mapBackgroundEntry)
                  .toList(growable: false),
        ),
        proficientSkills: record.skills
            .where((item) => item.isProficient || item.hasExpertise)
            .map(
              (item) => CharacterSkillDomainModel(
                name:
                    skillDefinitionsById[item.skillDefinitionId]?.name ??
                    item.skillDefinitionId,
                isProficient: item.isProficient,
                hasExpertise: item.hasExpertise,
              ),
            )
            .toList(growable: false),
        otherProficiencies: record.proficiencies
            .map(
              (item) => CharacterProficiencyDomainModel(
                proficiencyType: item.proficiencyType,
                referenceKey: item.referenceKey,
              ),
            )
            .toList(growable: false),
        alignment: finishingDetails?.alignment ?? 'Unaligned',
        appearanceDetails: finishingDetails?.appearanceDetails ?? '',
        narrativeDetails: finishingDetails?.narrativeDetails ?? '',
      ),
      equipment: CharacterEquipmentDomainModel(
        equipmentSummary: catalog.equipmentSummaryForClass(row.className),
        selectedEquipmentLabel:
            row.equipmentLoadoutLabel ?? fallbackLoadout.label,
        money: CharacterMoneySummaryDomainModel(
          currencySummary: startingMoneySummary,
          startingMoneySummary: startingMoneySummary,
        ),
        items: equipmentItems,
      ),
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
    CharacterInventoryData item,
  ) {
    return CharacterEquipmentItemDomainModel(
      name:
          item.displayNameSnapshot ??
          item.equipmentDefinitionId ??
          item.trinketDefinitionId ??
          'Unknown item',
      quantity: item.quantity,
      isEquipped: item.isEquipped,
    );
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
}
