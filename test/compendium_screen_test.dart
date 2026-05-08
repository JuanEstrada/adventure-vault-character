import 'package:adventure_vault_character/src/features/characters/domain/equipment_summary_view_data.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';
import 'package:adventure_vault_character/src/features/compendium/presentation/compendium_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'CompendiumScreen filters entries through the quick search panel',
    (tester) async {
      final catalog = _buildCatalog();

      await tester.pumpWidget(
        MaterialApp(
          home: CompendiumScreen(
            catalog: catalog,
            onBack: () {},
            onOpenCompendiumPacks: () {},
            onOpenCompendiumImport: () {},
          ),
        ),
      );
      await tester.scrollUntilVisible(
        find.text('Quick search'),
        200,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();

      expect(find.text('Quick search'), findsOneWidget);
      expect(find.text('8 matching entries'), findsOneWidget);
      expect(find.text('Magic Missile'), findsOneWidget);
      expect(find.text('Goblin'), findsOneWidget);

      await _selectDropdownItem(
        tester,
        const Key('compendium-category-filter'),
        'spell',
      );
      await tester.pumpAndSettle();

      expect(find.text('2 matching entries'), findsOneWidget);
      expect(find.text('Magic Missile'), findsOneWidget);
      expect(find.text('Fire Bolt'), findsOneWidget);
      expect(find.text('Goblin'), findsNothing);

      await _selectDropdownItem(
        tester,
        const Key('compendium-source-filter'),
        'PHB',
      );
      await tester.pumpAndSettle();

      expect(find.text('1 matching entries'), findsOneWidget);
      expect(find.text('Magic Missile'), findsOneWidget);
      expect(find.text('Fire Bolt'), findsNothing);

      await _selectDropdownItem(
        tester,
        const Key('compendium-pack-filter'),
        'core',
      );
      await tester.pumpAndSettle();

      expect(find.text('1 matching entries'), findsOneWidget);
      expect(find.text('Magic Missile'), findsOneWidget);
      expect(find.text('Fire Bolt'), findsNothing);
    },
  );
}

Future<void> _selectDropdownItem(
  WidgetTester tester,
  Key key,
  String itemText,
) async {
  await tester.tap(find.byKey(key));
  await tester.pumpAndSettle();
  await tester.tap(find.text(itemText).last);
  await tester.pumpAndSettle();
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
