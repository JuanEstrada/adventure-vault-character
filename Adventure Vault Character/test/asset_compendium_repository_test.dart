import 'dart:convert';

import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:adventure_vault_character/src/features/compendium/data/asset_compendium_repository.dart';
import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('loads catalog from FightClub SRD 5.5e assets', () async {
    final database = AppDatabase.executor(NativeDatabase.memory());
    addTearDown(database.close);

    final repository = AssetCompendiumRepository(
      database: database,
      bundle: _FakeAssetBundle({
        'local-assets/FightClub5eXML-master/Sources/System_Reference_Document_DND_5.5e/default_backgrounds_5.5e.xml':
            _backgroundsFixture,
        'local-assets/FightClub5eXML-master/Sources/System_Reference_Document_DND_5.5e/default_races_5.5e.xml':
            _racesFixture,
        'local-assets/FightClub5eXML-master/Sources/System_Reference_Document_DND_5.5e/default_classes_5.5e.xml':
            _classesFixture,
        'local-assets/FightClub5eXML-master/Sources/System_Reference_Document_DND_5.5e/default_spells_5.5e.xml':
            _spellsFixture,
        'local-assets/FightClub5eXML-master/Sources/System_Reference_Document_DND_5.5e/default_feats_5.5e.xml':
            _featsFixture,
        'local-assets/FightClub5eXML-master/Sources/System_Reference_Document_DND_5.5e/default_bestiary_5.5e.xml':
            _monstersFixture,
        'local-assets/FightClub5eXML-master/Sources/DND_5e/WizardsOfTheCoast/01_Core/01_Players_Handbook/backgrounds-phb.xml':
            _phbNarrativeFixture,
        'local-assets/FightClub5eXML-master/Sources/DND_5e/WizardsOfTheCoast/03_Campaign_Settings/Sword_Coast_Adventurers_Guide/backgrounds-scag.xml':
            _scagNarrativeFixture,
        'local-assets/FightClub5eXML-master/Sources/DND_5e/WizardsOfTheCoast/03_Campaign_Settings/Planescape_Adventures_in_the_Multiverse/backgrounds-pam.xml':
            _pamNarrativeFixture,
        'local-assets/FightClub5eXML-master/Sources/DND_5e/WizardsOfTheCoast/03_Campaign_Settings/Guildmasters_Guide_to_Ravnica/backgrounds-ggr.xml':
            _ggrNarrativeFixture,
        'local-assets/FightClub5eXML-master/Sources/DND_5e/WizardsOfTheCoast/03_Campaign_Settings/Eberron_Rising_From_the_Last_War/backgrounds-erlw.xml':
            _erlwNarrativeFixture,
        'assets/compendium/catalog.json': jsonEncode(<String, dynamic>{}),
      }),
    );

    final catalog = await repository.loadCatalog();

    expect(catalog.races, containsAll(<String>['Human', 'Elf', 'Dragonborn']));
    expect(
      catalog.classes,
      containsAll(<String>['Fighter', 'Wizard', 'Rogue']),
    );
    expect(catalog.backgrounds.map((item) => item.name), contains('Acolyte'));
    expect(catalog.generatedAbilityScoreSet, <int>[15, 14, 13, 12, 10, 8]);
    expect(catalog.manualAbilityScoreOptions, containsAll(<int>[8, 15]));
    expect(
      catalog.narrativeGroupsForField('alignment').single.options,
      hasLength(9),
    );
    expect(
      catalog.narrativeGroupsForBackground('acolyte', 'ideals').single.options,
      hasLength(2),
    );
    expect(
      catalog.narrativeGroupsForField('faction').map((item) => item.title),
      containsAll(<String>[
        'Factions of the Sword Coast',
        'Factions of Sigil',
        'Guilds of Ravnica',
        'Dragonmarked Houses',
      ]),
    );
    expect(catalog.characterAdvancement.first.level, 1);
    expect(catalog.standardArrayByClass.first.classId, 'barbarian');
    expect(catalog.spells.map((item) => item.level), containsAll(<int>[0, 1]));
    expect(
      catalog.feats.map((item) => item.name),
      containsAll(<String>['Ability Score Improvement', 'Origin: Alert']),
    );
    expect(
      catalog.monsters.map((item) => item.name),
      containsAll(<String>['Giant Fly', 'Owlbear']),
    );
    expect(
      catalog.equipmentLoadoutsForClass('Fighter').map((item) => item.id),
      containsAll(<String>['fighter-a', 'fighter-b']),
    );
    expect(catalog.sourcePolicy.activeSourceType, 'fightclub_xml');
    expect(
      catalog.sourcePolicyForSection('backgrounds')?.primarySources,
      contains(
        'local-assets/FightClub5eXML-master/Sources/System_Reference_Document_DND_5.5e/default_backgrounds_5.5e.xml',
      ),
    );
    expect(
      catalog.sourcePolicyForSection('narrative_options')?.primarySources,
      contains(
        'local-assets/FightClub5eXML-master/Sources/DND_5e/WizardsOfTheCoast/01_Core/01_Players_Handbook/backgrounds-phb.xml',
      ),
    );
    expect(
      catalog.sourcePolicyForSection('narrative_options')?.supplementalSources,
      containsAll(<String>[
        'local-assets/FightClub5eXML-master/Sources/DND_5e/WizardsOfTheCoast/03_Campaign_Settings/Sword_Coast_Adventurers_Guide/backgrounds-scag.xml',
        'local-assets/FightClub5eXML-master/Sources/DND_5e/WizardsOfTheCoast/03_Campaign_Settings/Planescape_Adventures_in_the_Multiverse/backgrounds-pam.xml',
        'local-assets/FightClub5eXML-master/Sources/DND_5e/WizardsOfTheCoast/03_Campaign_Settings/Guildmasters_Guide_to_Ravnica/backgrounds-ggr.xml',
        'local-assets/FightClub5eXML-master/Sources/DND_5e/WizardsOfTheCoast/03_Campaign_Settings/Eberron_Rising_From_the_Last_War/backgrounds-erlw.xml',
      ]),
    );
    expect(catalog.packStates, hasLength(2));
    expect(catalog.packStateById('bundled-base-compendium')?.isFixed, isTrue);
    expect(
      catalog.packStateById('legacy-narrative-supplements')?.isActive,
      isTrue,
    );

    final advancementRows = await database
        .select(database.characterAdvancementDefinitions)
        .get();
    final standardArrayRows = await database
        .select(database.classStandardArrayRecommendations)
        .get();
    final narrativeGroupRows = await database
        .select(database.narrativeOptionGroups)
        .get();
    final narrativeOptionRows = await database
        .select(database.narrativeOptions)
        .get();
    expect(advancementRows, hasLength(20));
    expect(
      advancementRows.firstWhere((row) => row.level == 1).proficiencyBonus,
      2,
    );
    expect(standardArrayRows, isNotEmpty);
    expect(
      standardArrayRows
          .firstWhere((row) => row.classId == 'wizard')
          .intelligence,
      15,
    );
    expect(narrativeGroupRows, isNotEmpty);
    expect(narrativeOptionRows, isNotEmpty);
    expect(
      narrativeGroupRows
          .firstWhere((row) => row.id == 'narrative-sword-coast-factions')
          .packId,
      'legacy-narrative-supplements',
    );

    final updatedCatalog = await repository.setPackActive(
      'legacy-narrative-supplements',
      false,
    );
    expect(
      updatedCatalog.packStateById('legacy-narrative-supplements')?.isActive,
      isFalse,
    );
    expect(updatedCatalog.narrativeGroupsForField('faction'), isEmpty);
    expect(
      updatedCatalog
          .sourcePolicyForSection('narrative_options')
          ?.supplementalSources,
      isEmpty,
    );
    expect(
      updatedCatalog
          .sourcePolicyForSection('narrative_options')
          ?.supplementalPackId,
      'legacy-narrative-supplements',
    );

    final persistedPackRows = await database
        .select(database.compendiumPackStates)
        .get();
    expect(
      persistedPackRows
          .firstWhere((row) => row.id == 'legacy-narrative-supplements')
          .isActive,
      isFalse,
    );
  });

  test(
    'imports XML pack content, exposes it in the catalog, and removes it when inactive',
    () async {
      final database = AppDatabase.executor(NativeDatabase.memory());
      addTearDown(database.close);

      final bundle = _FakeAssetBundle({
        'local-assets/FightClub5eXML-master/Sources/System_Reference_Document_DND_5.5e/default_backgrounds_5.5e.xml':
            _backgroundsFixture,
        'local-assets/FightClub5eXML-master/Sources/System_Reference_Document_DND_5.5e/default_races_5.5e.xml':
            _racesFixture,
        'local-assets/FightClub5eXML-master/Sources/System_Reference_Document_DND_5.5e/default_classes_5.5e.xml':
            _classesFixture,
        'local-assets/FightClub5eXML-master/Sources/System_Reference_Document_DND_5.5e/default_spells_5.5e.xml':
            _spellsFixture,
        'local-assets/FightClub5eXML-master/Sources/System_Reference_Document_DND_5.5e/default_feats_5.5e.xml':
            _featsFixture,
        'local-assets/FightClub5eXML-master/Sources/System_Reference_Document_DND_5.5e/default_bestiary_5.5e.xml':
            _monstersFixture,
        'local-assets/FightClub5eXML-master/Sources/DND_5e/WizardsOfTheCoast/01_Core/01_Players_Handbook/backgrounds-phb.xml':
            _phbNarrativeFixture,
        'local-assets/FightClub5eXML-master/Sources/DND_5e/WizardsOfTheCoast/03_Campaign_Settings/Sword_Coast_Adventurers_Guide/backgrounds-scag.xml':
            _scagNarrativeFixture,
        'local-assets/FightClub5eXML-master/Sources/DND_5e/WizardsOfTheCoast/03_Campaign_Settings/Planescape_Adventures_in_the_Multiverse/backgrounds-pam.xml':
            _pamNarrativeFixture,
        'local-assets/FightClub5eXML-master/Sources/DND_5e/WizardsOfTheCoast/03_Campaign_Settings/Guildmasters_Guide_to_Ravnica/backgrounds-ggr.xml':
            _ggrNarrativeFixture,
        'local-assets/FightClub5eXML-master/Sources/DND_5e/WizardsOfTheCoast/03_Campaign_Settings/Eberron_Rising_From_the_Last_War/backgrounds-erlw.xml':
            _erlwNarrativeFixture,
        'assets/compendium/catalog.json': jsonEncode(<String, dynamic>{}),
      });
      final repository = AssetCompendiumRepository(
        database: database,
        bundle: bundle,
      );

      final initialCatalog = await repository.loadCatalog();
      expect(
        initialCatalog.backgrounds.map((background) => background.name),
        isNot(contains('Imported Acolyte Expansion')),
      );

      final importedCatalog = await repository.importXmlPack(_importFixture);

      expect(
        importedCatalog.packStates.map((packState) => packState.id),
        contains('imported-imported-acolyte-expansion'),
      );
      expect(
        importedCatalog
            .packStateById('imported-imported-acolyte-expansion')
            ?.kind,
        'imported_xml',
      );
      expect(
        importedCatalog.backgrounds.map((background) => background.name),
        contains('Imported Acolyte Expansion'),
      );
      expect(
        importedCatalog.spells.map((spell) => spell.name),
        contains('Imported Arc Bolt'),
      );
      expect(
        importedCatalog.feats.map((feat) => feat.name),
        contains('Imported Adept'),
      );
      expect(
        importedCatalog.monsters.map((monster) => monster.name),
        contains('Imported Watcher'),
      );
      expect(
        importedCatalog.spells
            .firstWhere((spell) => spell.name == 'Imported Arc Bolt')
            .packId,
        'imported-imported-acolyte-expansion',
      );
      expect(
        importedCatalog
            .narrativeGroupsForBackground(
              'imported_acolyte_expansion',
              'ideals',
            )
            .single
            .options
            .map((option) => option.text),
        contains('Tradition. Preserve the old ways.'),
      );
      expect(
        importedCatalog.sourcePolicyForSection('backgrounds')?.notes,
        contains('Imported XML packs active: Imported Acolyte Expansion (1).'),
      );
      expect(
        importedCatalog.sourcePolicyForSection('narrative_options')?.notes,
        contains('Imported XML packs active: Imported Acolyte Expansion (1).'),
      );

      final reloadedRepository = AssetCompendiumRepository(
        database: database,
        bundle: bundle,
      );
      final reloadedCatalog = await reloadedRepository.loadCatalog();

      expect(
        reloadedCatalog.packStates.map((packState) => packState.id),
        contains('imported-imported-acolyte-expansion'),
      );
      expect(
        reloadedCatalog
            .packStateById('imported-imported-acolyte-expansion')
            ?.isActive,
        isTrue,
      );
      expect(
        reloadedCatalog.backgrounds.map((background) => background.name),
        contains('Imported Acolyte Expansion'),
      );
      expect(
        reloadedCatalog
            .narrativeGroupsForBackground(
              'imported_acolyte_expansion',
              'ideals',
            )
            .single
            .options
            .map((option) => option.text),
        contains('Tradition. Preserve the old ways.'),
      );

      final inactiveCatalog = await reloadedRepository.setPackActive(
        'imported-imported-acolyte-expansion',
        false,
      );
      expect(
        inactiveCatalog.backgrounds.map((background) => background.name),
        isNot(contains('Imported Acolyte Expansion')),
      );
      expect(
        inactiveCatalog.spells.map((spell) => spell.name),
        isNot(contains('Imported Arc Bolt')),
      );
      expect(
        inactiveCatalog.feats.map((feat) => feat.name),
        isNot(contains('Imported Adept')),
      );
      expect(
        inactiveCatalog.monsters.map((monster) => monster.name),
        isNot(contains('Imported Watcher')),
      );
      expect(
        inactiveCatalog.sourcePolicyForSection('backgrounds')?.notes,
        isNot(contains('Imported XML packs active:')),
      );
      expect(
        inactiveCatalog
            .narrativeGroupsForField('ideals')
            .map((group) => group.id),
        isNot(
          contains(
            'imported-imported-imported-acolyte-expansion-imported_acolyte_expansion-ideals',
          ),
        ),
      );
      expect(
        inactiveCatalog.sourcePolicyForSection('narrative_options')?.notes,
        isNot(contains('Imported XML packs active:')),
      );
    },
  );

  test(
    'falls back to bundled json catalog when core XML assets fail',
    () async {
      final repository = AssetCompendiumRepository(
        bundle: _FakeAssetBundle({
          'assets/compendium/catalog.json': jsonEncode(<String, dynamic>{
            'races': <String>['Human'],
            'classes': <String>['Fighter'],
            'backgrounds': <Map<String, dynamic>>[
              <String, dynamic>{
                'id': 'acolyte',
                'name': 'Acolyte',
                'summary': 'Fallback summary',
                'bonuses': <String>['Fallback bonus'],
                'socialPerks': <String>['Fallback perk'],
              },
            ],
            'generatedAbilityScoreSet': <int>[15, 14, 13, 12, 10, 8],
            'manualAbilityScoreOptions': <int>[8, 9, 10, 11, 12, 13, 14, 15],
            'equipmentSummariesByClass': <String, dynamic>{
              'Fighter': <String, dynamic>{
                'statusLabel': 'Fallback',
                'description': 'Fallback description',
                'highlightItems': <String>['Fallback item'],
              },
            },
            'equipmentLoadoutsByClass': <String, dynamic>{
              'Fighter': <Map<String, dynamic>>[
                <String, dynamic>{
                  'id': 'fighter-fallback',
                  'label': 'Fallback loadout',
                  'startingMoneySummary': 'Fallback money',
                  'selectedItems': <String>['Fallback item'],
                },
              ],
            },
          }),
        }),
      );

      final catalog = await repository.loadCatalog();

      expect(catalog.races, <String>['Human']);
      expect(catalog.classes, <String>['Fighter']);
      expect(catalog.sourcePolicy.activeSourceType, 'fallback_json');
      expect(
        catalog.sourcePolicyForSection('catalog')?.primarySources,
        <String>['assets/compendium/catalog.json'],
      );
      expect(catalog.packStates, hasLength(1));
      expect(catalog.packStates.single.isFixed, isTrue);
    },
  );
}

class _FakeAssetBundle extends CachingAssetBundle {
  _FakeAssetBundle(this._assets);

  final Map<String, String> _assets;

  @override
  Future<ByteData> load(String key) async {
    final value = _assets[key];
    if (value == null) {
      throw StateError('Missing asset: $key');
    }

    final bytes = Uint8List.fromList(utf8.encode(value));
    return ByteData.view(bytes.buffer);
  }
}

const _backgroundsFixture = '''
<compendium version="5">
  <background>
    <name>Acolyte [5.5e]</name>
    <proficiency>Insight, Religion</proficiency>
    <trait>
      <name>Description</name>
      <text>Temple-shaped background. Source: System Reference Document v5.2.1</text>
    </trait>
    <trait>
      <name>Ability Scores: Intelligence, Wisdom, Charisma</name>
      <text>Increase one by 2 and another by 1.</text>
    </trait>
    <trait>
      <name>Feat: Magic Initiate (Cleric)</name>
      <text>Gain spell access.</text>
    </trait>
    <trait>
      <name>Tool Proficiency: Calligrapher's Supplies</name>
      <text>Tool training.</text>
    </trait>
    <trait>
      <name>Starting Equipment</name>
      <text>Choose A or B: (A) Book, Holy Symbol, 8 GP; or (B) 50 GP</text>
    </trait>
  </background>
</compendium>
''';

const _racesFixture = '''
<compendium version="5">
  <race><name>Dragonborn [5.5e]</name></race>
  <race><name>Elf [5.5e]</name></race>
  <race><name>Human [5.5e]</name></race>
</compendium>
''';

const _classesFixture = '''
<compendium version="5">
  <class>
    <name>Fighter [5.5e]</name>
    <hd>10</hd>
    <proficiency>Strength, Constitution, Acrobatics, Athletics, Insight</proficiency>
    <armor>Light Armor, Medium Armor, Heavy Armor, Shields</armor>
    <weapons>Simple Weapons, Martial Weapons</weapons>
    <autolevel level="1">
      <feature optional="YES">
        <name>Becoming A Fighter As A Level 1 Character</name>
        <text>Primary Ability: Strength or Dexterity. Starting Equipment: Choose A or B: (A) Chain Mail, Greatsword, 4 GP; or (B) 155 GP Source: System Reference Document v5.2.1</text>
      </feature>
      <feature>
        <name>Level 1: Fighting Style</name>
        <text>Choose a style.</text>
      </feature>
      <feature>
        <name>Level 1: Second Wind</name>
        <text>Recover hit points.</text>
      </feature>
    </autolevel>
  </class>
  <class>
    <name>Rogue [5.5e]</name>
    <hd>8</hd>
    <proficiency>Dexterity, Intelligence, Acrobatics, Stealth, Perception</proficiency>
    <armor>Light Armor</armor>
    <weapons>Simple Weapons</weapons>
    <autolevel level="1">
      <feature optional="YES">
        <name>Becoming A Rogue As A Level 1 Character</name>
        <text>Primary Ability: Dexterity. Starting Equipment: Choose A or B: (A) Leather Armor, Dagger, 8 GP; or (B) 100 GP Source: System Reference Document v5.2.1</text>
      </feature>
      <feature>
        <name>Level 1: Sneak Attack</name>
        <text>Extra damage.</text>
      </feature>
    </autolevel>
  </class>
  <class>
    <name>Wizard [5.5e]</name>
    <hd>6</hd>
    <proficiency>Intelligence, Wisdom, Arcana, History, Investigation</proficiency>
    <armor>None</armor>
    <weapons>Simple Weapons</weapons>
    <autolevel level="1">
      <feature optional="YES">
        <name>Becoming A Wizard As A Level 1 Character</name>
        <text>Primary Ability: Intelligence. Starting Equipment: Choose A or B: (A) Spellbook, Robe, 5 GP; or (B) 55 GP Source: System Reference Document v5.2.1</text>
      </feature>
      <feature>
        <name>Level 1: Spellcasting</name>
        <text>Cast spells.</text>
      </feature>
    </autolevel>
  </class>
</compendium>
''';

const _spellsFixture = '''
<compendium version="5">
  <spell>
    <name>Light [5.5e]</name>
    <level>0</level>
    <school>EV</school>
    <time>Action</time>
    <range>Touch</range>
    <components>V, M</components>
    <duration>1 hour</duration>
    <classes>Bard [5.5e], Wizard [5.5e]</classes>
    <text>Light source. Source: System Reference Document v5.2.1</text>
  </spell>
  <spell>
    <name>Magic Missile [5.5e]</name>
    <level>1</level>
    <school>EV</school>
    <time>Action</time>
    <range>120 feet</range>
    <components>V, S</components>
    <duration>Instantaneous</duration>
    <classes>Sorcerer [5.5e], Wizard [5.5e]</classes>
    <text>Magical darts. Source: System Reference Document v5.2.1</text>
  </spell>
</compendium>
''';

const _featsFixture = '''
<compendium version="5">
  <feat>
    <name>Ability Score Improvement [5.5e]</name>
    <prerequisite>Level 4+</prerequisite>
    <text>Increase abilities. Source: System Reference Document v5.2.1</text>
  </feat>
  <feat>
    <name>Grappler (Strength) [5.5e]</name>
    <prerequisite>Level 4+</prerequisite>
    <text>Wrestling benefits. Source: System Reference Document v5.2.1</text>
    <modifier category="ability score">strength +1</modifier>
  </feat>
  <feat>
    <name>Origin: Alert [5.5e]</name>
    <text>Initiative benefits. Source: System Reference Document v5.2.1</text>
  </feat>
</compendium>
''';

const _monstersFixture = '''
<compendium version="5">
  <monster>
    <name>Giant Fly [5.5e]</name>
    <size>L</size>
    <type>beast</type>
    <alignment>unaligned</alignment>
    <ac>11</ac>
    <hp>19 (3d10+3)</hp>
    <speed>30 ft., Fly 60 ft.</speed>
    <senses>darkvision 60 ft.</senses>
    <languages/>
    <cr>0</cr>
    <description>Source: System Reference Document v5.2.1</description>
    <trait>
      <name>Flyby</name>
      <text>No opportunity attacks.</text>
    </trait>
    <action>
      <name>Bite</name>
      <text>Melee attack.</text>
    </action>
  </monster>
  <monster>
    <name>Owlbear [5.5e]</name>
    <size>L</size>
    <type>monstrosity</type>
    <alignment>unaligned</alignment>
    <ac>13</ac>
    <hp>59 (7d10+21)</hp>
    <speed>40 ft.</speed>
    <senses>darkvision 60 ft.</senses>
    <languages/>
    <cr>3</cr>
    <description>Source: System Reference Document v5.2.1</description>
    <trait>
      <name>Keen Sight and Smell</name>
      <text>Advantage on Perception checks.</text>
    </trait>
    <action>
      <name>Beak</name>
      <text>Melee attack.</text>
    </action>
  </monster>
  <monster>
    <name>Adult Red Dragon [5.5e]</name>
    <size>H</size>
    <type>dragon</type>
    <alignment>chaotic evil</alignment>
    <ac>19</ac>
    <hp>256 (19d12+133)</hp>
    <speed>40 ft., fly 80 ft.</speed>
    <senses>blindsight 60 ft.</senses>
    <languages>Common, Draconic</languages>
    <cr>17</cr>
    <description>Source: System Reference Document v5.2.1</description>
    <trait>
      <name>Legendary Resistance</name>
      <text>Can choose to succeed.</text>
    </trait>
    <action>
      <name>Fire Breath</name>
      <text>Area damage.</text>
    </action>
  </monster>
</compendium>
''';

const _phbNarrativeFixture = '''
<compendium version="5">
  <background>
    <name>Acolyte</name>
    <trait>
      <name>Description</name>
      <text>Source: Player's Handbook (2014)</text>
    </trait>
    <trait>
      <name>Suggested Characteristics</name>
      <text>d8 | Personality Trait
1 | I quote sacred texts.
2 | I seek peace.

d6 | Ideal
1 | Tradition. Preserve the rites. (Lawful)
2 | Charity. Help the poor. (Good)

d6 | Bond
1 | I defend a sacred relic.
2 | I owe everything to my mentor.

d6 | Flaw
1 | I judge others harshly.
2 | I trust the hierarchy too much.</text>
      <roll description="Personality Trait">1d8</roll>
      <roll description="Ideal">1d6</roll>
      <roll description="Bond">1d6</roll>
      <roll description="Flaw">1d6</roll>
    </trait>
  </background>
</compendium>
''';

const _scagNarrativeFixture = '''
<compendium version="5">
  <background>
    <name>Faction Agent</name>
    <trait>
      <name>Factions of the Sword Coast</name>
      <text>The Harpers. Agents of freedom and subtle action.
The Order of the Gauntlet. Holy warriors who crush evil.
The Emerald Enclave. Protectors of the natural order.
The Lords' Alliance. Representatives of cities and rulers.
The Zhentarim. Operatives of the Black Network.</text>
    </trait>
  </background>
</compendium>
''';

const _pamNarrativeFixture = '''
<compendium version="5">
  <background>
    <name>Planar Philosopher</name>
    <trait>
      <name>Factions of Sigil</name>
      <text>• Athar: Deities are frauds.
• Bleak Cabal: Each being must find their own meaning.</text>
    </trait>
  </background>
</compendium>
''';

const _ggrNarrativeFixture = '''
<compendium version="5">
  <background><name>Azorius Functionary</name></background>
  <background><name>Boros Legionnaire</name></background>
</compendium>
''';

const _erlwNarrativeFixture = '''
<compendium version="5">
  <background>
    <name>House Agent</name>
    <trait>
      <name>Description</name>
      <text>House Tool Proficiencies:
Your House | Proficiencies
Cannith | Alchemist's supplies and tinker's tools
Deneith | One gaming set and vehicles (land)</text>
    </trait>
  </background>
</compendium>
''';

const _importFixture = '''
<compendium version="5" auto_indent="NO">
  <background>
    <name>Imported Acolyte Expansion</name>
    <source>Imported Test Source</source>
    <trait>
      <name>Description</name>
      <text>Imported background text.</text>
    </trait>
    <trait>
      <name>Suggested Characteristics</name>
      <text>d6 | Ideal
1 | Tradition. Preserve the old ways.</text>
    </trait>
  </background>
  <spell>
    <name>Imported Arc Bolt</name>
    <level>1</level>
    <school>Evocation</school>
    <time>1 action</time>
    <range>60 feet</range>
    <components>V, S</components>
    <duration>Instantaneous</duration>
    <classes>Wizard, Sorcerer</classes>
    <text>Imported spell text.</text>
  </spell>
  <feat>
    <name>Imported Adept</name>
    <prerequisite>Level 1+</prerequisite>
    <text>Imported feat text.</text>
  </feat>
  <monster>
    <name>Imported Watcher</name>
    <size>Medium</size>
    <type>Construct</type>
    <alignment>Neutral</alignment>
    <ac>14</ac>
    <hp>22</hp>
    <speed>30 ft.</speed>
    <cr>1</cr>
    <senses>Darkvision 60 ft.</senses>
    <languages>Common</languages>
    <trait><name>Alert</name></trait>
    <action><name>Arc Slam</name></action>
  </monster>
</compendium>
''';
