import 'dart:convert';
import 'dart:typed_data';

import 'package:adventure_vault_character/src/features/compendium/data/asset_compendium_repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('loads catalog from XML base dataset when available', () async {
    final repository = AssetCompendiumRepository(
      bundle: _FakeAssetBundle({
        'local-assets/srd_5_2_1_app_base.xml': _xmlFixture,
        'local-assets/Official Only 2024.xml': _officialFixture,
        'local-assets/Core Rulebooks.xml': _monsterFixture,
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
    expect(catalog.standardArrayByClass.first.classId, 'fighter');
    expect(catalog.spells.map((item) => item.level), containsAll(<int>[0, 1]));
    expect(catalog.feats.map((item) => item.name), contains('Actor [2024]'));
    expect(
      catalog.monsters.map((item) => item.name),
      containsAll(<String>['Goblin', 'Owlbear']),
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

const _xmlFixture = '''
<?xml version="1.0" encoding="UTF-8"?>
<adventure-vault-srd-base>
  <characterCreation>
    <abilityGeneration>
      <standardArray>
        <score>15</score>
        <score>14</score>
        <score>13</score>
        <score>12</score>
        <score>10</score>
        <score>8</score>
      </standardArray>
      <pointBuy budget="27">
        <score value="8" cost="0" />
        <score value="9" cost="1" />
        <score value="10" cost="2" />
        <score value="11" cost="3" />
        <score value="12" cost="4" />
        <score value="13" cost="5" />
        <score value="14" cost="7" />
        <score value="15" cost="9" />
      </pointBuy>
      <standardArrayByClass>
        <classRef id="fighter" strength="15" dexterity="14" constitution="13" intelligence="8" wisdom="10" charisma="12" />
      </standardArrayByClass>
    </abilityGeneration>
    <levelProgression>
      <level value="1" xp="0" proficiencyBonus="+2" />
      <level value="2" xp="300" proficiencyBonus="+2" />
    </levelProgression>
  </characterCreation>
  <backgrounds>
    <background id="acolyte">
      <name>Acolyte</name>
      <abilityOptions>
        <ability>Intelligence</ability>
        <ability>Wisdom</ability>
        <ability>Charisma</ability>
      </abilityOptions>
      <originFeat>Magic Initiate (Cleric)</originFeat>
      <skillProficiencies>
        <skill>Insight</skill>
        <skill>Religion</skill>
      </skillProficiencies>
      <toolProficiency>Calligrapher&apos;s Supplies</toolProficiency>
      <equipment>
        <option id="A">Book, Holy Symbol, 8 GP</option>
        <option id="B">50 GP</option>
      </equipment>
      <summary>Temple-shaped background.</summary>
    </background>
  </backgrounds>
  <speciesList>
    <species id="dragonborn"><name>Dragonborn</name></species>
    <species id="elf"><name>Elf</name></species>
    <species id="human"><name>Human</name></species>
  </speciesList>
  <classes>
    <class id="fighter">
      <name>Fighter</name>
      <primaryAbility>Strength or Dexterity</primaryAbility>
      <hitDie>d10</hitDie>
      <weaponProficiencies>Simple and Martial weapons</weaponProficiencies>
      <armorTraining>Light armor, Medium armor, Heavy armor, Shields</armorTraining>
      <startingEquipment>
        <option id="A">Chain Mail, Greatsword, 4 GP</option>
        <option id="B">155 GP</option>
      </startingEquipment>
      <level1Features>
        <feature>Fighting Style</feature>
        <feature>Second Wind</feature>
      </level1Features>
    </class>
    <class id="rogue">
      <name>Rogue</name>
      <primaryAbility>Dexterity</primaryAbility>
      <hitDie>d8</hitDie>
      <weaponProficiencies>Simple weapons</weaponProficiencies>
      <armorTraining>Light armor</armorTraining>
      <startingEquipment>
        <option id="A">Leather Armor, Dagger, 8 GP</option>
      </startingEquipment>
      <level1Features>
        <feature>Sneak Attack</feature>
      </level1Features>
    </class>
    <class id="wizard">
      <name>Wizard</name>
      <primaryAbility>Intelligence</primaryAbility>
      <hitDie>d6</hitDie>
      <weaponProficiencies>Simple weapons</weaponProficiencies>
      <armorTraining>None</armorTraining>
      <startingEquipment>
        <option id="A">Spellbook, Robe, 5 GP</option>
      </startingEquipment>
      <level1Features>
        <feature>Spellcasting</feature>
      </level1Features>
    </class>
  </classes>
</adventure-vault-srd-base>
''';

const _officialFixture = '''
<compendium version="5">
  <feat>
    <name>Actor [2024]</name>
    <prerequisite>Level 4+, Cha 13+</prerequisite>
    <text>You gain the following benefits.</text>
    <text>Ability Score Increase. Increase your Charisma score by 1.</text>
    <text>Source: Player's Handbook 2024 p. 202</text>
    <modifier category="ability score">Charisma +1</modifier>
  </feat>
  <feat>
    <name>Alert [2024]</name>
    <prerequisite>Level 4+</prerequisite>
    <text>You gain a bonus to Initiative rolls.</text>
    <text>Source: Player's Handbook 2024 p. 202</text>
  </feat>
  <feat>
    <name>Shield Master [2024]</name>
    <prerequisite>Level 4+, Shield Training</prerequisite>
    <text>You gain shield-focused combat benefits.</text>
    <text>Source: Player's Handbook 2024 p. 207</text>
    <modifier category="ability score">Strength +1</modifier>
  </feat>
  <spell>
    <name>Light [2024]</name>
    <level>0</level>
    <school>E</school>
    <time>Action</time>
    <range>Touch</range>
    <components>V, M</components>
    <duration>1 hour</duration>
    <classes>Bard [2024], Cleric [2024], Wizard [2024]</classes>
    <text>You touch one object that is no larger than 10 feet in any dimension.</text>
    <text>Source: Player's Handbook 2024 p. 290</text>
  </spell>
  <spell>
    <name>Magic Missile [2024]</name>
    <level>1</level>
    <school>EV</school>
    <time>Action</time>
    <range>120 feet</range>
    <components>V, S</components>
    <duration>Instantaneous</duration>
    <classes>Sorcerer [2024], Wizard [2024]</classes>
    <text>You create three glowing darts of magical force.</text>
    <text>Source: Player's Handbook 2024 p. 295</text>
  </spell>
</compendium>
''';

const _monsterFixture = '''
<compendium version="5">
  <monster>
    <name>Goblin</name>
    <size>S</size>
    <type>humanoid (goblinoid)</type>
    <alignment>neutral evil</alignment>
    <ac>15 (leather armor, shield)</ac>
    <hp>7 (2d6)</hp>
    <speed>30 ft.</speed>
    <senses>darkvision 60 ft.</senses>
    <languages>Common, Goblin</languages>
    <cr>1/4</cr>
    <trait>
      <name>Source</name>
      <text>Monster Manual p. 166</text>
    </trait>
    <trait>
      <name>Nimble Escape</name>
      <text>The goblin can take the Disengage or Hide action as a bonus action.</text>
    </trait>
    <action>
      <name>Scimitar</name>
      <text>Melee Weapon Attack.</text>
    </action>
  </monster>
  <monster>
    <name>Owlbear</name>
    <size>L</size>
    <type>monstrosity</type>
    <alignment>unaligned</alignment>
    <ac>13 (natural armor)</ac>
    <hp>59 (7d10+21)</hp>
    <speed>40 ft.</speed>
    <senses>darkvision 60 ft.</senses>
    <languages/>
    <cr>3</cr>
    <trait>
      <name>Source</name>
      <text>Monster Manual p. 249</text>
    </trait>
    <trait>
      <name>Keen Sight and Smell</name>
      <text>The owlbear has advantage on Wisdom (Perception) checks.</text>
    </trait>
    <action>
      <name>Beak</name>
      <text>Melee Weapon Attack.</text>
    </action>
  </monster>
</compendium>
''';
