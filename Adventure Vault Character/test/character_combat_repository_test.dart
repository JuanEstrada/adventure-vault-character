import 'package:adventure_vault_character/src/features/characters/data/drift_character_repository.dart';
import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_finishing_details.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:adventure_vault_character/src/features/characters/domain/equipment_summary_view_data.dart';
import 'package:adventure_vault_character/src/features/compendium/data/in_memory_compendium_repository.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('sheet exposes deterministic armor class and initiative', () async {
    final database = AppDatabase.executor(NativeDatabase.memory());
    addTearDown(database.close);

    final repository = DriftCharacterRepository(
      database: database,
      compendiumRepository: InMemoryCompendiumRepository(_catalog),
    );

    final summary = await repository.createCharacter(
      _createInput(selectedEquipmentItems: <String>['Chain Mail', 'Shield']),
    );
    final sheet = await repository.getCharacterSheetById(summary.id);

    expect(sheet, isNotNull);
    expect(sheet!.combat.armorClass, 18);
    expect(sheet.combat.initiativeModifier, 2);
  });

  test('death saves persist and reset through repository operations', () async {
    final database = AppDatabase.executor(NativeDatabase.memory());
    addTearDown(database.close);

    final repository = DriftCharacterRepository(
      database: database,
      compendiumRepository: InMemoryCompendiumRepository(_catalog),
    );

    final summary = await repository.createCharacter(_createInput());
    await repository.recordDeathSaveSuccess(summary.id);
    await repository.recordDeathSaveSuccess(summary.id);
    await repository.recordDeathSaveFailure(summary.id);

    var sheet = await repository.getCharacterSheetById(summary.id);
    expect(sheet, isNotNull);
    expect(sheet!.combat.deathSaves.successCount, 2);
    expect(sheet.combat.deathSaves.failureCount, 1);

    await repository.applyLongRest(summary.id);
    sheet = await repository.getCharacterSheetById(summary.id);
    expect(sheet, isNotNull);
    expect(sheet!.combat.deathSaves.successCount, 0);
    expect(sheet.combat.deathSaves.failureCount, 0);
  });

  test('sheet exposes equipped weapon attack helpers', () async {
    final database = AppDatabase.executor(NativeDatabase.memory());
    addTearDown(database.close);

    final repository = DriftCharacterRepository(
      database: database,
      compendiumRepository: InMemoryCompendiumRepository(_catalog),
    );

    final summary = await repository.createCharacter(
      _createInput(selectedEquipmentItems: <String>['Quarterstaff']),
    );
    final sheet = await repository.getCharacterSheetById(summary.id);

    expect(sheet, isNotNull);
    expect(sheet!.combat.weaponAttacks, hasLength(1));
    expect(sheet.combat.weaponAttacks.single.name, 'Quarterstaff');
    expect(sheet.combat.weaponAttacks.single.attackAbilityKey, 'str');
    expect(sheet.combat.weaponAttacks.single.attackBonus, 2);
    expect(sheet.combat.weaponAttacks.single.damageModifier, 0);
    expect(sheet.combat.weaponAttacks.single.damageDice, '1d6');
  });

  test(
    'seeded weapon metadata applies deterministic magic weapon bonuses',
    () async {
      final database = AppDatabase.executor(NativeDatabase.memory());
      addTearDown(database.close);

      final repository = DriftCharacterRepository(
        database: database,
        compendiumRepository: InMemoryCompendiumRepository(_catalog),
      );

      final summary = await repository.createCharacter(
        _createInput(selectedEquipmentItems: const <String>['Longsword +1']),
      );
      final sheet = await repository.getCharacterSheetById(summary.id);

      expect(sheet, isNotNull);
      expect(sheet!.combat.weaponAttacks, hasLength(1));
      expect(sheet.combat.weaponAttacks.single.name, 'Longsword +1');
      expect(sheet.combat.weaponAttacks.single.attackAbilityKey, 'str');
      expect(sheet.combat.weaponAttacks.single.attackBonus, 3);
      expect(sheet.combat.weaponAttacks.single.damageModifier, 1);
      expect(sheet.combat.weaponAttacks.single.damageDice, '1d8');
      expect(sheet.combat.weaponAttacks.single.damageType, 'slashing');
    },
  );

  test(
    'seeded armor metadata applies deterministic shield magic bonuses',
    () async {
      final database = AppDatabase.executor(NativeDatabase.memory());
      addTearDown(database.close);

      final repository = DriftCharacterRepository(
        database: database,
        compendiumRepository: InMemoryCompendiumRepository(_catalog),
      );

      final summary = await repository.createCharacter(
        _createInput(
          selectedEquipmentItems: const <String>['Chain Mail', 'Shield +1'],
        ),
      );
      final sheet = await repository.getCharacterSheetById(summary.id);

      expect(sheet, isNotNull);
      expect(sheet!.combat.armorClass, 19);
      expect(sheet.combat.hasArmorConfigurationConflict, isFalse);
    },
  );
}

CreateCharacterInput _createInput({
  List<String> selectedEquipmentItems = const <String>['Quarterstaff'],
}) {
  return CreateCharacterInput(
    name: 'Combat Test',
    raceName: 'Human',
    backgroundId: 'acolyte',
    backgroundName: 'Acolyte',
    backgroundSummary: 'Temple acolyte',
    abilityScoreMethod: 'generatedSetAssignment',
    abilityScoreProvenance: 'method=generatedSetAssignment',
    strength: 10,
    dexterity: 14,
    constitution: 13,
    intelligence: 12,
    wisdom: 10,
    charisma: 8,
    className: 'Fighter',
    level: 1,
    experience: 0,
    equipmentLoadoutId: 'fighter-kit',
    equipmentLoadoutLabel: 'Fighter kit',
    startingMoneySummary: '10 gp',
    selectedEquipmentItems: selectedEquipmentItems,
    currentHitPoints: 12,
    maximumHitPoints: 12,
    temporaryHitPoints: 0,
    spellState: const CharacterSpellStateInput.empty(),
    finishingDetails: CharacterFinishingDetailsInput.empty(),
  );
}

const _catalog = CompendiumCatalog(
  races: <String>['Human'],
  classes: <String>['Fighter'],
  backgrounds: <CompendiumBackground>[
    CompendiumBackground(
      id: 'acolyte',
      name: 'Acolyte',
      summary: 'Temple acolyte',
      bonuses: <String>['Skills: Insight, Religion'],
      socialPerks: <String>['Temple service'],
    ),
  ],
  narrativeOptionGroups: <CompendiumNarrativeOptionGroup>[],
  generatedAbilityScoreSet: <int>[15, 14, 13, 12, 10, 8],
  manualAbilityScoreOptions: <int>[8, 9, 10, 11, 12, 13, 14, 15],
  characterAdvancement: <CharacterAdvancementEntry>[],
  standardArrayByClass: <StandardArrayByClassEntry>[],
  spells: <CompendiumSpell>[],
  feats: <CompendiumFeat>[],
  monsters: <CompendiumMonster>[],
  equipmentSummariesByClass: <String, EquipmentSummaryViewData>{
    'Fighter': EquipmentSummaryViewData(
      statusLabel: 'Ready',
      description: 'Starter loadout',
      highlightItems: <String>['Chain Mail', 'Shield'],
    ),
  },
  equipmentLoadoutsByClass: <String, List<CompendiumEquipmentLoadout>>{
    'Fighter': <CompendiumEquipmentLoadout>[
      CompendiumEquipmentLoadout(
        id: 'fighter-kit',
        label: 'Fighter kit',
        startingMoneySummary: '10 gp',
        selectedItems: <String>['Chain Mail', 'Shield'],
      ),
    ],
  },
);
