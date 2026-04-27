import 'package:adventure_vault_character/src/features/characters/application/finishing_details_service.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_finishing_details.dart';
import 'package:adventure_vault_character/src/features/characters/domain/deterministic_roller.dart';
import 'package:adventure_vault_character/src/features/characters/domain/equipment_summary_view_data.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('prefers background-specific groups over generic field groups', () {
    const service = FinishingDetailsService();

    final groups = service.availableGroups(
      catalog: _catalog,
      fieldKey: NarrativeFieldKey.ideals,
      backgroundId: 'acolyte',
    );

    expect(groups, hasLength(1));
    expect(groups.single.id, 'ideals-acolyte');
  });

  test(
    'falls back to field-wide groups when background-specific groups are absent',
    () {
      const service = FinishingDetailsService();

      final groups = service.availableGroups(
        catalog: _catalog,
        fieldKey: NarrativeFieldKey.alignment,
        backgroundId: 'acolyte',
      );

      expect(groups, hasLength(1));
      expect(groups.single.id, 'alignment-core');
    },
  );

  test('rolled selection is deterministic for a fixed roller', () {
    const service = FinishingDetailsService(
      deterministicRoller: _FixedRoller(2),
    );
    final group = _catalog.narrativeGroupsForField('alignment').single;

    final selection = service.rolledSelection(
      fieldKey: NarrativeFieldKey.alignment,
      group: group,
      seed: 'test-seed',
    );

    expect(selection.mode, NarrativeSelectionMode.rolled);
    expect(selection.rollValue, 2);
    expect(selection.optionId, 'alignment-2');
    expect(selection.valueText, 'Neutral');
  });
}

class _FixedRoller implements DeterministicRoller {
  const _FixedRoller(this.value);

  final int value;

  @override
  int roll({required String seed, required int sides}) {
    if (value > sides) {
      return sides;
    }
    return value;
  }
}

const _catalog = CompendiumCatalog(
  races: <String>['Human'],
  classes: <String>['Cleric'],
  backgrounds: <CompendiumBackground>[
    CompendiumBackground(
      id: 'acolyte',
      name: 'Acolyte',
      summary: 'Temple acolyte',
      bonuses: <String>[],
      socialPerks: <String>[],
    ),
  ],
  narrativeOptionGroups: <CompendiumNarrativeOptionGroup>[
    CompendiumNarrativeOptionGroup(
      id: 'alignment-core',
      fieldKey: 'alignment',
      sourceType: 'core',
      title: 'Alignment',
      options: <CompendiumNarrativeOption>[
        CompendiumNarrativeOption(
          id: 'alignment-1',
          optionIndex: 1,
          rollMin: 1,
          rollMax: 1,
          text: 'Lawful Good',
        ),
        CompendiumNarrativeOption(
          id: 'alignment-2',
          optionIndex: 2,
          rollMin: 2,
          rollMax: 2,
          text: 'Neutral',
        ),
      ],
    ),
    CompendiumNarrativeOptionGroup(
      id: 'ideals-generic',
      fieldKey: 'ideals',
      sourceType: 'core',
      title: 'Generic ideals',
      options: <CompendiumNarrativeOption>[
        CompendiumNarrativeOption(
          id: 'ideals-generic-1',
          optionIndex: 1,
          text: 'Justice',
        ),
      ],
    ),
    CompendiumNarrativeOptionGroup(
      id: 'ideals-acolyte',
      fieldKey: 'ideals',
      sourceType: 'background',
      backgroundId: 'acolyte',
      backgroundName: 'Acolyte',
      title: 'Acolyte ideals',
      options: <CompendiumNarrativeOption>[
        CompendiumNarrativeOption(
          id: 'ideals-acolyte-1',
          optionIndex: 1,
          text: 'Tradition',
        ),
      ],
    ),
  ],
  generatedAbilityScoreSet: <int>[15, 14, 13, 12, 10, 8],
  manualAbilityScoreOptions: <int>[8, 9, 10, 11, 12, 13, 14, 15],
  characterAdvancement: <CharacterAdvancementEntry>[],
  standardArrayByClass: <StandardArrayByClassEntry>[],
  spells: <CompendiumSpell>[],
  feats: <CompendiumFeat>[],
  monsters: <CompendiumMonster>[],
  equipmentSummariesByClass: <String, EquipmentSummaryViewData>{
    'Cleric': EquipmentSummaryViewData(
      statusLabel: 'MVP minimal',
      description: 'Equipment summary',
      highlightItems: <String>['Mace'],
    ),
  },
  equipmentLoadoutsByClass: <String, List<CompendiumEquipmentLoadout>>{
    'Cleric': <CompendiumEquipmentLoadout>[
      CompendiumEquipmentLoadout(
        id: 'cleric-a',
        label: 'Cleric starter',
        startingMoneySummary: '10 gp',
        selectedItems: <String>['Mace'],
      ),
    ],
  },
);
