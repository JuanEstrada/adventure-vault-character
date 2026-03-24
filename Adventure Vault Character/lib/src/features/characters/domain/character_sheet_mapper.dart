import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_sheet_view_data.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';

class CharacterSheetMapper {
  const CharacterSheetMapper();

  CharacterSheetViewData map(
    Character row,
    CompendiumCatalog catalog, {
    BackgroundDefinition? backgroundDefinition,
    CharacterAbilityScore? abilityScores,
    CharacterCurrencyData? currency,
    List<CharacterInventoryData> inventory = const <CharacterInventoryData>[],
    List<CharacterSavingThrow> savingThrows = const <CharacterSavingThrow>[],
    List<CharacterSkill> skills = const <CharacterSkill>[],
    List<SkillDefinition> skillDefinitions = const <SkillDefinition>[],
    List<CharacterProficiency> proficiencies = const <CharacterProficiency>[],
  }) {
    final background = catalog.backgroundById(row.backgroundId);
    final fallbackLoadout = catalog
        .equipmentLoadoutsForClass(row.className)
        .first;
    final persistedEquipmentItems = _mapInventoryItems(inventory);
    final selectedEquipmentItems = persistedEquipmentItems.isNotEmpty
        ? persistedEquipmentItems
        : fallbackLoadout.selectedItems;
    final startingMoneySummary =
        _currencySummary(currency) ?? fallbackLoadout.startingMoneySummary;
    final skillDefinitionsById = <String, SkillDefinition>{
      for (final definition in skillDefinitions) definition.id: definition,
    };
    final resolvedBackgroundName =
        backgroundDefinition?.name ??
        background?.name ??
        row.backgroundName ??
        'Sin background';
    final resolvedBackgroundSummary =
        backgroundDefinition?.summary ??
        background?.summary ??
        row.backgroundSummary ??
        'Sin resumen disponible.';
    final resolvedAbilityScores =
        abilityScores ?? _abilityScoresFromSnapshot(row);

    return CharacterSheetViewData(
      id: row.id,
      identity: IdentityPanelViewData(
        name: row.name,
        raceName: row.raceName,
        className: row.className,
        level: row.level,
        experience: row.experience ?? 0,
        proficiencyBonus:
            row.proficiencyBonus ?? _calculateProficiencyBonus(row.level),
        levelProgressPercent: _calculateLevelProgressPercent(
          row.level,
          row.experience ?? 0,
        ),
      ),
      combat: CombatPanelViewData(
        currentHitPoints: row.currentHitPoints ?? 0,
        maximumHitPoints: row.maximumHitPoints ?? 0,
        temporaryHitPoints: row.temporaryHitPoints ?? 0,
        savingThrows: savingThrows
            .map(
              (row) => SavingThrowRowViewData(
                label: row.abilityKey,
                bonus: row.totalBonus ?? row.miscBonus,
                isProficient: row.isProficient,
              ),
            )
            .toList(growable: false),
      ),
      abilities: AbilitiesPanelViewData(
        abilityScoreMethodLabel: _abilityMethodLabel(row.abilityScoreMethod),
        abilityRows: <AbilityScoreRowViewData>[
          _abilityRow('Strength', resolvedAbilityScores.strengthScore),
          _abilityRow('Dexterity', resolvedAbilityScores.dexterityScore),
          _abilityRow('Constitution', resolvedAbilityScores.constitutionScore),
          _abilityRow('Intelligence', resolvedAbilityScores.intelligenceScore),
          _abilityRow('Wisdom', resolvedAbilityScores.wisdomScore),
          _abilityRow('Charisma', resolvedAbilityScores.charismaScore),
        ],
      ),
      featuresNotes: FeaturesNotesPanelViewData(
        backgroundName: resolvedBackgroundName,
        backgroundSummary: resolvedBackgroundSummary,
        backgroundBonuses:
            background?.bonuses ?? const <String>['Sin bonos cargados'],
        backgroundSocialPerks:
            background?.socialPerks ??
            const <String>['Sin perks sociales cargados'],
        proficientSkills: skills
            .where((row) => row.isProficient || row.hasExpertise)
            .map((row) => skillDefinitionsById[row.skillDefinitionId]?.name)
            .whereType<String>()
            .toList(growable: false),
        otherProficiencies: proficiencies
            .map(
              (row) =>
                  '${_titleCase(row.proficiencyType)}: ${_humanizeKey(row.referenceKey)}',
            )
            .toSet()
            .toList(growable: false),
        alignment: row.alignment ?? 'Unaligned',
        appearanceDetails: row.appearanceDetails ?? '',
        narrativeDetails: row.narrativeDetails ?? '',
      ),
      equipment: EquipmentPanelViewData(
        equipmentSummary: catalog.equipmentSummaryForClass(row.className),
        selectedEquipmentLabel:
            row.equipmentLoadoutLabel ?? fallbackLoadout.label,
        currencySummary: startingMoneySummary,
        startingMoneySummary: startingMoneySummary,
        selectedEquipmentItems: selectedEquipmentItems,
      ),
    );
  }

  AbilityScoreRowViewData _abilityRow(String label, int? score) {
    final safeScore = score ?? 0;
    return AbilityScoreRowViewData(
      label: label,
      score: safeScore,
      modifier: ((safeScore - 10) / 2).floor(),
    );
  }

  int _calculateProficiencyBonus(int level) {
    return 2 + ((level - 1) ~/ 4);
  }

  int _calculateLevelProgressPercent(int level, int experience) {
    const thresholds = <int, int>{
      1: 0,
      2: 300,
      3: 900,
      4: 2700,
      5: 6500,
      6: 14000,
    };

    final currentFloor = thresholds[level] ?? 0;
    final nextFloor = thresholds[level + 1];
    if (nextFloor == null || nextFloor <= currentFloor) {
      return 100;
    }

    final progress = ((experience - currentFloor) / (nextFloor - currentFloor))
        .clamp(0, 1);
    return (progress * 100).round();
  }

  String _abilityMethodLabel(String? method) {
    return switch (method) {
      'generatedSetAssignment' => 'Generated set assignment',
      'manualPointAllocation' => 'Manual point allocation',
      _ => 'Unknown method',
    };
  }

  List<String> _mapInventoryItems(List<CharacterInventoryData> inventory) {
    return inventory
        .map((item) {
          final base =
              item.displayNameSnapshot ??
              item.equipmentDefinitionId ??
              item.trinketDefinitionId ??
              'Unknown item';
          final quantity = item.quantity > 1 ? ' x${item.quantity}' : '';
          final equipped = item.isEquipped ? ' (equipped)' : '';
          return '$base$quantity$equipped';
        })
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

  String _titleCase(String raw) {
    if (raw.isEmpty) {
      return raw;
    }
    return raw[0].toUpperCase() + raw.substring(1);
  }

  String _humanizeKey(String raw) {
    return raw
        .split('-')
        .map((chunk) => chunk.isEmpty ? chunk : _titleCase(chunk))
        .join(' ');
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
