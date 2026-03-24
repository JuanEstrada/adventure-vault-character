import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_record.dart';

class CharacterDomainMapper {
  const CharacterDomainMapper();

  CharacterDomainModel map(CharacterRecord record) {
    final row = record.row;
    final catalog = record.catalog;
    final background = catalog.backgroundById(row.backgroundId);
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
        record.abilityScores ?? _abilityScoresFromSnapshot(row);

    return CharacterDomainModel(
      id: row.id,
      identity: CharacterIdentityDomainModel(
        name: row.name,
        raceName: row.raceName,
        className: row.className,
        progression: CharacterProgressionDomainModel(
          level: row.level,
          experience: row.experience ?? 0,
          proficiencyBonusOverride: row.proficiencyBonus,
        ),
      ),
      combat: CharacterCombatDomainModel(
        hitPoints: CharacterHitPointsDomainModel(
          current: row.currentHitPoints ?? 0,
          maximum: row.maximumHitPoints ?? 0,
          temporary: row.temporaryHitPoints ?? 0,
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
        methodKey: row.abilityScoreMethod,
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
              row.backgroundName ??
              'Sin background',
          summary:
              record.backgroundDefinition?.summary ??
              background?.summary ??
              row.backgroundSummary ??
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
        alignment: row.alignment ?? 'Unaligned',
        appearanceDetails: row.appearanceDetails ?? '',
        narrativeDetails: row.narrativeDetails ?? '',
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

  CharacterAbilityScore _abilityScoresFromSnapshot(Character row) {
    return CharacterAbilityScore(
      characterId: row.id,
      strengthScore: row.strength ?? 0,
      dexterityScore: row.dexterity ?? 0,
      constitutionScore: row.constitution ?? 0,
      intelligenceScore: row.intelligence ?? 0,
      wisdomScore: row.wisdom ?? 0,
      charismaScore: row.charisma ?? 0,
      strengthModifier: row.strength == null ? null : _modifier(row.strength!),
      dexterityModifier: row.dexterity == null
          ? null
          : _modifier(row.dexterity!),
      constitutionModifier: row.constitution == null
          ? null
          : _modifier(row.constitution!),
      intelligenceModifier: row.intelligence == null
          ? null
          : _modifier(row.intelligence!),
      wisdomModifier: row.wisdom == null ? null : _modifier(row.wisdom!),
      charismaModifier: row.charisma == null ? null : _modifier(row.charisma!),
    );
  }

  int _modifier(int score) => ((score - 10) / 2).floor();
}
