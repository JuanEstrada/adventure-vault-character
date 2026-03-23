import 'package:adventure_vault_character/src/features/characters/domain/character_sheet_view_data.dart';
import 'package:flutter/foundation.dart';

@immutable
class CompendiumCatalog {
  const CompendiumCatalog({
    required this.races,
    required this.classes,
    required this.backgrounds,
    required this.generatedAbilityScoreSet,
    required this.manualAbilityScoreOptions,
    required this.equipmentSummariesByClass,
  });

  final List<String> races;
  final List<String> classes;
  final List<CompendiumBackground> backgrounds;
  final List<int> generatedAbilityScoreSet;
  final List<int> manualAbilityScoreOptions;
  final Map<String, EquipmentSummaryViewData> equipmentSummariesByClass;

  CompendiumBackground? backgroundById(String? id) {
    for (final background in backgrounds) {
      if (background.id == id) {
        return background;
      }
    }
    return null;
  }

  EquipmentSummaryViewData equipmentSummaryForClass(String className) {
    return equipmentSummariesByClass[className] ??
        const EquipmentSummaryViewData(
          statusLabel: 'MVP minimal',
          description:
              'Equipment sigue como panel controlado mientras el flujo de seleccion y persistencia se expande.',
          highlightItems: <String>['Equipment mapping pending'],
        );
  }
}

@immutable
class CompendiumBackground {
  const CompendiumBackground({
    required this.id,
    required this.name,
    required this.summary,
    required this.bonuses,
    required this.socialPerks,
  });

  final String id;
  final String name;
  final String summary;
  final List<String> bonuses;
  final List<String> socialPerks;
}
