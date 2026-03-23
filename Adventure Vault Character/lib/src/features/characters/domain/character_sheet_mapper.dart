import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_sheet_view_data.dart';
import 'package:adventure_vault_character/src/features/compendium/data/sample_compendium.dart';

class CharacterSheetMapper {
  const CharacterSheetMapper();

  CharacterSheetViewData map(Character row) {
    final background = findSampleBackgroundById(row.backgroundId);

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
          row.backgroundSummary ?? background?.summary ?? 'Sin resumen disponible.',
      backgroundBonuses: background?.bonuses ?? const <String>['Sin bonos cargados'],
      backgroundSocialPerks:
          background?.socialPerks ?? const <String>['Sin perks sociales cargados'],
      abilityScoreMethodLabel: _abilityMethodLabel(row.abilityScoreMethod),
      abilityRows: <AbilityScoreRowViewData>[
        _abilityRow('Strength', row.strength),
        _abilityRow('Dexterity', row.dexterity),
        _abilityRow('Constitution', row.constitution),
        _abilityRow('Intelligence', row.intelligence),
        _abilityRow('Wisdom', row.wisdom),
        _abilityRow('Charisma', row.charisma),
      ],
      equipmentSummary: equipmentSummaryForClass(row.className),
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
}
