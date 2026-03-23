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
    </abilityGeneration>
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
