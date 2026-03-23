import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_sheet_view_data.dart';

class CharacterSheetMapper {
  const CharacterSheetMapper();

  CharacterSheetViewData map(Character row) {
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
      backgroundName: row.backgroundName ?? 'Sin background',
      backgroundSummary: row.backgroundSummary ?? 'Sin resumen disponible.',
      backgroundBonuses: _backgroundBonusesFor(row.backgroundId),
      backgroundSocialPerks: _backgroundSocialPerksFor(row.backgroundId),
      abilityScoreMethodLabel: _abilityMethodLabel(row.abilityScoreMethod),
      abilityRows: <AbilityScoreRowViewData>[
        _abilityRow('Strength', row.strength),
        _abilityRow('Dexterity', row.dexterity),
        _abilityRow('Constitution', row.constitution),
        _abilityRow('Intelligence', row.intelligence),
        _abilityRow('Wisdom', row.wisdom),
        _abilityRow('Charisma', row.charisma),
      ],
      equipmentSummary: _equipmentSummaryFor(row.className),
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

  List<String> _backgroundBonusesFor(String? backgroundId) {
    return switch (backgroundId) {
      'scholar' => const <String>[
          'Lore recall',
          'Research discipline',
        ],
      'soldier' => const <String>[
          'Chain of command',
          'Martial routine',
        ],
      'wanderer' => const <String>[
          'Pathfinding',
          'Travel resilience',
        ],
      _ => const <String>['Sin bonos cargados'],
    };
  }

  List<String> _backgroundSocialPerksFor(String? backgroundId) {
    return switch (backgroundId) {
      'scholar' => const <String>[
          'Academic contacts',
          'Library access',
        ],
      'soldier' => const <String>[
          'Barracks familiarity',
          'Veteran rapport',
        ],
      'wanderer' => const <String>[
          'Road gossip',
          'Campfire trust',
        ],
      _ => const <String>['Sin perks sociales cargados'],
    };
  }

  EquipmentSummaryViewData _equipmentSummaryFor(String className) {
    return switch (className) {
      'Fighter' => const EquipmentSummaryViewData(
          statusLabel: 'MVP minimal',
          description:
              'La hoja ya reserva un espacio para el loadout del personaje, con foco futuro en armas, armadura y gear.',
          highlightItems: <String>[
            'Weapon loadout pending',
            'Armor summary pending',
            'Gear list pending',
          ],
        ),
      'Wizard' => const EquipmentSummaryViewData(
          statusLabel: 'MVP minimal',
          description:
              'El detalle de implementos arcanos y gear inicial sigue pendiente de mapeo completo en la hoja.',
          highlightItems: <String>[
            'Arcane focus pending',
            'Gear list pending',
          ],
        ),
      _ => const EquipmentSummaryViewData(
          statusLabel: 'MVP minimal',
          description:
              'Equipment sigue como panel controlado mientras el flujo de seleccion y persistencia se expande.',
          highlightItems: <String>[
            'Equipment mapping pending',
          ],
        ),
    };
  }
}
