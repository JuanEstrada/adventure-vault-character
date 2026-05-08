import 'package:adventure_vault_character/src/features/characters/domain/equipment_summary_view_data.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_search_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const service = CompendiumSearchService();
  final catalog = _buildCatalog();

  test('filters entries by source and pack', () {
    final sourceEntries = service.filterBySource(catalog, 'PHB');
    expect(sourceEntries.map((entry) => entry.name), <String>[
      'Alert',
      'Magic Missile',
    ]);

    final packEntries = service.filterByPack(catalog, 'core');
    expect(packEntries.map((entry) => entry.name), <String>[
      'Alert',
      'Magic Missile',
    ]);
  });

  test('filters entries by category and search text', () {
    final spellEntries = service.entriesByCategory(catalog, 'spell');
    expect(spellEntries.map((entry) => entry.name), <String>[
      'Fire Bolt',
      'Magic Missile',
    ]);

    final searchEntries = service.searchByName(catalog, 'bolt');
    expect(searchEntries.map((entry) => entry.name), <String>['Fire Bolt']);
  });
}

CompendiumCatalog _buildCatalog() {
  return CompendiumCatalog(
    races: const <String>['Human'],
    classes: const <String>['Wizard'],
    backgrounds: const <CompendiumBackground>[
      CompendiumBackground(
        id: 'acolyte',
        name: 'Acolyte',
        summary: 'A life of service.',
        bonuses: <String>['Insight', 'Religion'],
        socialPerks: <String>['Shelter of the Faithful'],
      ),
    ],
    narrativeOptionGroups: const <CompendiumNarrativeOptionGroup>[
      CompendiumNarrativeOptionGroup(
        id: 'narrative-1',
        fieldKey: 'bond',
        sourceType: 'base',
        title: 'Bond',
        options: <CompendiumNarrativeOption>[
          CompendiumNarrativeOption(
            id: 'bond-1',
            optionIndex: 0,
            text: 'A treasured keepsake.',
          ),
        ],
      ),
    ],
    generatedAbilityScoreSet: const <int>[15, 14, 13, 12, 10, 8],
    manualAbilityScoreOptions: const <int>[15, 14, 13, 12, 10, 8],
    characterAdvancement: const <CharacterAdvancementEntry>[],
    standardArrayByClass: const <StandardArrayByClassEntry>[],
    spells: const <CompendiumSpell>[
      CompendiumSpell(
        id: 'magic-missile',
        name: 'Magic Missile',
        level: 1,
        school: 'Evocation',
        castingTime: '1 action',
        range: '120 feet',
        components: 'V, S',
        duration: 'Instantaneous',
        classes: <String>['Wizard'],
        description: <String>['Three glowing darts of force.'],
        source: 'PHB',
        packId: 'core',
      ),
      CompendiumSpell(
        id: 'fire-bolt',
        name: 'Fire Bolt',
        level: 0,
        school: 'Evocation',
        castingTime: '1 action',
        range: '120 feet',
        components: 'V, S',
        duration: 'Instantaneous',
        classes: <String>['Wizard', 'Sorcerer'],
        description: <String>['A mote of fire streaks toward a target.'],
        source: 'XGE',
        packId: 'supplement',
      ),
    ],
    feats: const <CompendiumFeat>[
      CompendiumFeat(
        name: 'Alert',
        prerequisite: 'None',
        description: <String>['Always on the lookout.'],
        modifiers: <String>['+5 initiative'],
        source: 'PHB',
        packId: 'core',
      ),
    ],
    monsters: const <CompendiumMonster>[
      CompendiumMonster(
        name: 'Goblin',
        size: 'Small',
        type: 'Humanoid',
        alignment: 'Neutral Evil',
        armorClass: '15 (leather armor, shield)',
        hitPoints: '7 (2d6)',
        speed: '30 ft.',
        challengeRating: '1/4',
        senses: 'darkvision 60 ft.',
        languages: 'Common, Goblin',
        traits: <String>['Nimble Escape'],
        actions: <String>['Scimitar'],
        source: 'MM',
        packId: 'bestiary',
      ),
    ],
    equipmentSummariesByClass: const <String, EquipmentSummaryViewData>{},
    equipmentLoadoutsByClass:
        const <String, List<CompendiumEquipmentLoadout>>{},
  );
}
