import 'package:adventure_vault_character/src/features/characters/data/drift_character_repository.dart';
import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:adventure_vault_character/src/features/characters/domain/equipment_summary_view_data.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:adventure_vault_character/src/features/compendium/data/in_memory_compendium_repository.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';
import 'package:drift/drift.dart' show Variable;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'createCharacter persists v8 character rows and normalized loadout data for sheet',
    () async {
      final database = AppDatabase.executor(NativeDatabase.memory());
      addTearDown(database.close);

      final repository = DriftCharacterRepository(
        database: database,
        compendiumRepository: const InMemoryCompendiumRepository(_testCatalog),
      );

      final summary = await repository.createCharacter(
        const CreateCharacterInput(
          name: 'Meris',
          raceName: 'Elf',
          backgroundId: 'acolyte',
          backgroundName: 'Acolyte',
          backgroundSummary: 'Temple acolyte',
          abilityScoreMethod: 'generatedSetAssignment',
          abilityScoreProvenance: 'method=generatedSetAssignment',
          strength: 8,
          dexterity: 12,
          constitution: 13,
          intelligence: 15,
          wisdom: 14,
          charisma: 10,
          className: 'Wizard',
          level: 5,
          experience: 6500,
          equipmentLoadoutId: 'wizard-focus',
          equipmentLoadoutLabel: 'Arcane focus kit',
          startingMoneySummary: '15 gp, 4 sp',
          selectedEquipmentItems: <String>[
            'Quarterstaff',
            'Component pouch',
            'Scholar pack',
          ],
          currentHitPoints: 28,
          maximumHitPoints: 28,
          temporaryHitPoints: 0,
          alignment: 'Neutral',
          appearanceDetails: 'Tall and quiet',
          narrativeDetails: 'Keeps careful notes.',
        ),
      );

      final row = await (database.select(
        database.characters,
      )..where((table) => table.id.equals(summary.id))).getSingle();
      final rawCharacterRow =
          (await database
                  .customSelect(
                    'SELECT * FROM characters WHERE id = ?',
                    variables: <Variable<Object>>[Variable<String>(summary.id)],
                  )
                  .getSingle())
              .data;
      final provenance = await (database.select(
        database.characterAbilityScoreProvenances,
      )..where((table) => table.characterId.equals(summary.id))).getSingle();
      final equipmentLoadout = await (database.select(
        database.characterEquipmentLoadouts,
      )..where((table) => table.characterId.equals(summary.id))).getSingle();
      final hitPoints = await (database.select(
        database.characterHitPoints,
      )..where((table) => table.characterId.equals(summary.id))).getSingle();
      final finishingDetails = await (database.select(
        database.characterFinishingDetails,
      )..where((table) => table.characterId.equals(summary.id))).getSingle();
      final sheet = await repository.getCharacterSheetById(summary.id);

      expect(row.backgroundDefinitionRefId, 'acolyte');
      expect(rawCharacterRow.containsKey('background_name'), isFalse);
      expect(rawCharacterRow.containsKey('ability_score_method'), isFalse);
      expect(rawCharacterRow.containsKey('ability_score_provenance'), isFalse);
      expect(rawCharacterRow.containsKey('strength'), isFalse);
      expect(rawCharacterRow.containsKey('starting_money_summary'), isFalse);
      expect(rawCharacterRow.containsKey('selected_equipment_items'), isFalse);
      expect(rawCharacterRow.containsKey('equipment_loadout_id'), isFalse);
      expect(rawCharacterRow.containsKey('equipment_loadout_label'), isFalse);
      expect(rawCharacterRow.containsKey('current_hit_points'), isFalse);
      expect(rawCharacterRow.containsKey('portrait_asset_path'), isFalse);
      expect(provenance.methodKey, 'generatedSetAssignment');
      expect(equipmentLoadout.loadoutId, 'wizard-focus');
      expect(equipmentLoadout.loadoutLabel, 'Arcane focus kit');
      expect(hitPoints.maximum, 27);
      expect(finishingDetails.alignment, 'Neutral');
      expect(finishingDetails.appearanceDetails, 'Tall and quiet');

      expect(sheet, isNotNull);
      expect(sheet!.featuresNotes.background.name, 'Acolyte');
      expect(sheet.featuresNotes.background.summary, 'Temple acolyte');
      expect(sheet.identity.progression.proficiencyBonus, 3);
      expect(
        sheet.abilities.entries
            .firstWhere((row) => row.label == 'Intelligence')
            .score,
        15,
      );
      expect(sheet.equipment.selectedEquipmentLabel, 'Arcane focus kit');
      expect(sheet.equipment.money.startingMoneySummary, '15 gp, 4 sp');
      expect(
        sheet.equipment.visibleItems,
        containsAll(<String>[
          'Quarterstaff (equipped)',
          'Component pouch',
          'Scholar pack',
        ]),
      );
    },
  );

  test(
    'updateCharacter rewrites normalized rows against the v8 character schema',
    () async {
      final database = AppDatabase.executor(NativeDatabase.memory());
      addTearDown(database.close);

      final repository = DriftCharacterRepository(
        database: database,
        compendiumRepository: const InMemoryCompendiumRepository(_testCatalog),
      );

      final created = await repository.createCharacter(
        const CreateCharacterInput(
          name: 'Meris',
          raceName: 'Elf',
          backgroundId: 'acolyte',
          backgroundName: 'Acolyte',
          backgroundSummary: 'Temple acolyte',
          abilityScoreMethod: 'generatedSetAssignment',
          abilityScoreProvenance:
              'method=generatedSetAssignment;Strength=8;Dexterity=12;Constitution=13;Intelligence=15;Wisdom=14;Charisma=10',
          strength: 8,
          dexterity: 12,
          constitution: 13,
          intelligence: 15,
          wisdom: 14,
          charisma: 10,
          className: 'Wizard',
          level: 5,
          experience: 6500,
          equipmentLoadoutId: 'wizard-focus',
          equipmentLoadoutLabel: 'Arcane focus kit',
          startingMoneySummary: '15 gp, 4 sp',
          selectedEquipmentItems: <String>[
            'Quarterstaff',
            'Component pouch',
            'Scholar pack',
          ],
          currentHitPoints: 28,
          maximumHitPoints: 28,
          temporaryHitPoints: 0,
          alignment: 'Neutral',
          appearanceDetails: 'Tall and quiet',
          narrativeDetails: 'Keeps careful notes.',
        ),
      );

      await repository.updateCharacter(
        created.id,
        const CreateCharacterInput(
          name: 'Aelar',
          raceName: 'Elf',
          backgroundId: 'acolyte',
          backgroundName: 'Acolyte',
          backgroundSummary: 'Temple acolyte',
          abilityScoreMethod: 'manualPointAllocation',
          abilityScoreProvenance:
              'method=manualPointAllocation;Strength=15;Dexterity=14;Constitution=13;Intelligence=12;Wisdom=10;Charisma=8',
          strength: 15,
          dexterity: 14,
          constitution: 13,
          intelligence: 12,
          wisdom: 10,
          charisma: 8,
          className: 'Wizard',
          level: 1,
          experience: 0,
          equipmentLoadoutId: 'wizard-focus',
          equipmentLoadoutLabel: 'Arcane focus kit',
          startingMoneySummary: '20 gp',
          selectedEquipmentItems: <String>['Quarterstaff', '2 Torch'],
          currentHitPoints: 28,
          maximumHitPoints: 28,
          temporaryHitPoints: 0,
          alignment: 'Lawful Good',
          appearanceDetails: 'Short hair',
          narrativeDetails: 'Updated after review.',
        ),
      );

      final row = await (database.select(
        database.characters,
      )..where((table) => table.id.equals(created.id))).getSingle();
      final rawCharacterRow =
          (await database
                  .customSelect(
                    'SELECT * FROM characters WHERE id = ?',
                    variables: <Variable<Object>>[Variable<String>(created.id)],
                  )
                  .getSingle())
              .data;
      final abilityScores = await (database.select(
        database.characterAbilityScores,
      )..where((table) => table.characterId.equals(created.id))).getSingle();
      final provenance = await (database.select(
        database.characterAbilityScoreProvenances,
      )..where((table) => table.characterId.equals(created.id))).getSingle();
      final equipmentLoadout = await (database.select(
        database.characterEquipmentLoadouts,
      )..where((table) => table.characterId.equals(created.id))).getSingle();
      final hitPoints = await (database.select(
        database.characterHitPoints,
      )..where((table) => table.characterId.equals(created.id))).getSingle();
      final finishingDetails = await (database.select(
        database.characterFinishingDetails,
      )..where((table) => table.characterId.equals(created.id))).getSingle();
      final inventory = await (database.select(
        database.characterInventory,
      )..where((table) => table.characterId.equals(created.id))).get();
      final sheet = await repository.getCharacterSheetById(created.id);

      expect(row.name, 'Aelar');
      expect(rawCharacterRow.containsKey('background_name'), isFalse);
      expect(rawCharacterRow.containsKey('ability_score_method'), isFalse);
      expect(rawCharacterRow.containsKey('ability_score_provenance'), isFalse);
      expect(rawCharacterRow.containsKey('strength'), isFalse);
      expect(rawCharacterRow.containsKey('selected_equipment_items'), isFalse);
      expect(rawCharacterRow.containsKey('starting_money_summary'), isFalse);
      expect(rawCharacterRow.containsKey('equipment_loadout_id'), isFalse);
      expect(rawCharacterRow.containsKey('equipment_loadout_label'), isFalse);
      expect(rawCharacterRow.containsKey('current_hit_points'), isFalse);
      expect(rawCharacterRow.containsKey('alignment'), isFalse);

      expect(abilityScores.strengthScore, 15);
      expect(abilityScores.intelligenceScore, 12);
      expect(provenance.methodKey, 'manualPointAllocation');
      expect(provenance.strengthAssignedScore, 15);
      expect(equipmentLoadout.loadoutId, 'wizard-focus');
      expect(equipmentLoadout.loadoutLabel, 'Arcane focus kit');
      expect(hitPoints.maximum, 7);
      expect(hitPoints.current, 7);
      expect(finishingDetails.alignment, 'Lawful Good');
      expect(finishingDetails.appearanceDetails, 'Short hair');
      expect(inventory.map((item) => item.displayNameSnapshot), <String>[
        'Quarterstaff',
        'Torch',
      ]);
      expect(inventory.map((item) => item.quantity), <int>[1, 2]);

      expect(sheet, isNotNull);
      expect(sheet!.identity.name, 'Aelar');
      expect(sheet.identity.progression.level, 1);
      expect(sheet.abilities.methodLabel, 'Manual point allocation');
      expect(sheet.featuresNotes.alignment, 'Lawful Good');
      expect(sheet.equipment.money.startingMoneySummary, '20 gp');
      expect(sheet.equipment.visibleItems, <String>[
        'Quarterstaff (equipped)',
        'Torch x2',
      ]);
    },
  );
}

const _testCatalog = CompendiumCatalog(
  races: <String>['Elf'],
  classes: <String>['Wizard'],
  backgrounds: <CompendiumBackground>[
    CompendiumBackground(
      id: 'acolyte',
      name: 'Acolyte',
      summary: 'Temple acolyte',
      bonuses: <String>[
        'Skills: Insight, Religion',
        'Languages: any two of your choice',
      ],
      socialPerks: <String>['Shelter of the Faithful', 'Temple support'],
    ),
  ],
  narrativeOptionGroups: <CompendiumNarrativeOptionGroup>[],
  generatedAbilityScoreSet: <int>[15, 14, 13, 12, 10, 8],
  manualAbilityScoreOptions: <int>[8, 9, 10, 11, 12, 13, 14, 15],
  characterAdvancement: <CharacterAdvancementEntry>[
    CharacterAdvancementEntry(level: 1, experience: 0, proficiencyBonus: '+2'),
    CharacterAdvancementEntry(
      level: 5,
      experience: 6500,
      proficiencyBonus: '+3',
    ),
  ],
  standardArrayByClass: <StandardArrayByClassEntry>[
    StandardArrayByClassEntry(
      classId: 'wizard',
      className: 'Wizard',
      strength: 8,
      dexterity: 12,
      constitution: 13,
      intelligence: 15,
      wisdom: 14,
      charisma: 10,
    ),
  ],
  spells: <CompendiumSpell>[],
  feats: <CompendiumFeat>[],
  monsters: <CompendiumMonster>[],
  equipmentSummariesByClass: <String, EquipmentSummaryViewData>{
    'Wizard': EquipmentSummaryViewData(
      statusLabel: 'MVP minimal',
      description: 'Equipment summary',
      highlightItems: <String>['Quarterstaff'],
    ),
  },
  equipmentLoadoutsByClass: <String, List<CompendiumEquipmentLoadout>>{
    'Wizard': <CompendiumEquipmentLoadout>[
      CompendiumEquipmentLoadout(
        id: 'wizard-focus',
        label: 'Arcane focus kit',
        startingMoneySummary: '15 gp, 4 sp',
        selectedItems: <String>[
          'Quarterstaff',
          'Component pouch',
          'Scholar pack',
        ],
      ),
    ],
  },
);
