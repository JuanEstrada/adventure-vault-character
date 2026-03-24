import 'dart:convert';

import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_sheet_view_data.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';

class CharacterSheetMapper {
  const CharacterSheetMapper();

  CharacterSheetViewData map(
    Character row,
    CompendiumCatalog catalog, {
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
    final persistedEquipmentItems = inventory.isNotEmpty
        ? _mapInventoryItems(inventory)
        : _decodeEquipmentItems(row.selectedEquipmentItems);
    final selectedEquipmentItems = persistedEquipmentItems.isNotEmpty
        ? persistedEquipmentItems
        : fallbackLoadout.selectedItems;
    final startingMoneySummary =
        _currencySummary(currency) ??
        row.startingMoneySummary ??
        fallbackLoadout.startingMoneySummary;
    final skillDefinitionsById = <String, SkillDefinition>{
      for (final definition in skillDefinitions) definition.id: definition,
    };

    return CharacterSheetViewData(
      id: row.id,
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
      currentHitPoints: row.currentHitPoints ?? 0,
      maximumHitPoints: row.maximumHitPoints ?? 0,
      temporaryHitPoints: row.temporaryHitPoints ?? 0,
      backgroundName:
          row.backgroundName ?? background?.name ?? 'Sin background',
      backgroundSummary:
          row.backgroundSummary ??
          background?.summary ??
          'Sin resumen disponible.',
      backgroundBonuses:
          background?.bonuses ?? const <String>['Sin bonos cargados'],
      backgroundSocialPerks:
          background?.socialPerks ??
          const <String>['Sin perks sociales cargados'],
      abilityScoreMethodLabel: _abilityMethodLabel(row.abilityScoreMethod),
      abilityRows: <AbilityScoreRowViewData>[
        _abilityRow('Strength', abilityScores?.strengthScore ?? row.strength),
        _abilityRow(
          'Dexterity',
          abilityScores?.dexterityScore ?? row.dexterity,
        ),
        _abilityRow(
          'Constitution',
          abilityScores?.constitutionScore ?? row.constitution,
        ),
        _abilityRow(
          'Intelligence',
          abilityScores?.intelligenceScore ?? row.intelligence,
        ),
        _abilityRow('Wisdom', abilityScores?.wisdomScore ?? row.wisdom),
        _abilityRow('Charisma', abilityScores?.charismaScore ?? row.charisma),
      ],
      equipmentSummary: catalog.equipmentSummaryForClass(row.className),
      selectedEquipmentLabel:
          row.equipmentLoadoutLabel ?? fallbackLoadout.label,
      currencySummary: startingMoneySummary,
      startingMoneySummary: startingMoneySummary,
      selectedEquipmentItems: selectedEquipmentItems,
      savingThrows: savingThrows
          .map(
            (row) => SavingThrowRowViewData(
              label: row.abilityKey,
              bonus: row.totalBonus ?? row.miscBonus,
              isProficient: row.isProficient,
            ),
          )
          .toList(growable: false),
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

  List<String> _decodeEquipmentItems(String? raw) {
    if (raw == null || raw.isEmpty) {
      return const <String>[];
    }

    final decoded = jsonDecode(raw);
    if (decoded is! List<dynamic>) {
      return const <String>[];
    }

    return decoded.cast<String>();
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
}
