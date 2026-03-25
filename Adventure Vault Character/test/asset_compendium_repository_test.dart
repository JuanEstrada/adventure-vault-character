import 'dart:convert';

import 'package:adventure_vault_character/src/features/compendium/data/asset_compendium_repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('loads catalog from FightClub SRD 5.5e assets', () async {
    final repository = AssetCompendiumRepository(
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
  });
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
