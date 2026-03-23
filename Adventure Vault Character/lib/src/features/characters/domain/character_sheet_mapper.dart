import 'dart:convert';

import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_sheet_view_data.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';

class CharacterSheetMapper {
  const CharacterSheetMapper();

  CharacterSheetViewData map(Character row, CompendiumCatalog catalog) {
    final background = catalog.backgroundById(row.backgroundId);
    final fallbackLoadout = catalog
        .equipmentLoadoutsForClass(row.className)
        .first;
    final persistedEquipmentItems = _decodeEquipmentItems(
      row.selectedEquipmentItems,
    );
    final selectedEquipmentItems = persistedEquipmentItems.isNotEmpty
        ? persistedEquipmentItems
        : fallbackLoadout.selectedItems;

    return CharacterSheetViewData(
      id: row.id,
      name: row.name,
      raceName: row.raceName,
      className: row.className,
      level: row.level,
      experience: row.experience ?? 0,
      proficiencyBonus: _calculateProficiencyBonus(row.level),
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
        _abilityRow('Strength', row.strength),
        _abilityRow('Dexterity', row.dexterity),
        _abilityRow('Constitution', row.constitution),
        _abilityRow('Intelligence', row.intelligence),
        _abilityRow('Wisdom', row.wisdom),
        _abilityRow('Charisma', row.charisma),
      ],
      equipmentSummary: catalog.equipmentSummaryForClass(row.className),
      selectedEquipmentLabel:
          row.equipmentLoadoutLabel ?? fallbackLoadout.label,
      startingMoneySummary:
          row.startingMoneySummary ?? fallbackLoadout.startingMoneySummary,
      selectedEquipmentItems: selectedEquipmentItems,
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
}
