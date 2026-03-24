import 'package:adventure_vault_character/src/features/characters/data/drift_character_repository.dart';
import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_sheet_view_data.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:adventure_vault_character/src/features/compendium/data/in_memory_compendium_repository.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'createCharacter keeps redundant snapshots out of characters and reads normalized data for sheet',
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
      final sheet = await repository.getCharacterSheetById(summary.id);

      expect(row.backgroundDefinitionRefId, 'acolyte');
      expect(row.backgroundName, isNull);
      expect(row.backgroundSummary, isNull);
      expect(row.strength, isNull);
      expect(row.dexterity, isNull);
      expect(row.constitution, isNull);
      expect(row.intelligence, isNull);
      expect(row.wisdom, isNull);
      expect(row.charisma, isNull);
      expect(row.startingMoneySummary, isNull);
      expect(row.selectedEquipmentItems, isNull);

      expect(sheet, isNotNull);
      expect(sheet!.featuresNotes.backgroundName, 'Acolyte');
      expect(sheet.featuresNotes.backgroundSummary, 'Temple acolyte');
      expect(sheet.identity.proficiencyBonus, 3);
      expect(
        sheet.abilities.abilityRows
            .firstWhere((row) => row.label == 'Intelligence')
            .score,
        15,
      );
      expect(sheet.equipment.selectedEquipmentLabel, 'Arcane focus kit');
      expect(sheet.equipment.startingMoneySummary, '15 gp, 4 sp');
      expect(
        sheet.equipment.selectedEquipmentItems,
        containsAll(<String>[
          'Quarterstaff (equipped)',
          'Component pouch',
          'Scholar pack',
        ]),
      );
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
