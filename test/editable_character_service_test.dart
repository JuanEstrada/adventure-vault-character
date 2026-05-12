import 'package:adventure_vault_character/src/features/characters/data/drift_character_repository.dart';
import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_finishing_details.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:adventure_vault_character/src/features/characters/domain/editable_character_mapper.dart';
import 'package:adventure_vault_character/src/features/characters/domain/equipment_summary_view_data.dart';
import 'package:adventure_vault_character/src/features/compendium/data/in_memory_compendium_repository.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'editable character preserves normalized values and ability provenance',
    () async {
      final database = AppDatabase.executor(NativeDatabase.memory());
      addTearDown(database.close);

      final repository = DriftCharacterRepository(
        database: database,
        compendiumRepository: InMemoryCompendiumRepository(_testCatalog),
      );

      final summary = await repository.createCharacter(
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
            '2 Torch',
            'Scholar pack',
          ],
          currentHitPoints: 28,
          maximumHitPoints: 28,
          temporaryHitPoints: 0,
          spellState: CharacterSpellStateInput(
            selectionMode: CharacterSpellSelectionMode.spellbook,
            selectedSpells: <CharacterSpellSelectionInput>[
              CharacterSpellSelectionInput(
                spellId: 'magic-missile',
                spellName: 'Magic Missile',
                selectionMode: CharacterSpellSelectionMode.spellbook,
              ),
              CharacterSpellSelectionInput(
                spellId: 'magic-missile',
                spellName: 'Magic Missile',
                selectionMode: CharacterSpellSelectionMode.prepared,
              ),
            ],
            slotUsages: <CharacterSpellSlotUsageInput>[
              CharacterSpellSlotUsageInput(
                spellLevel: 1,
                expendedSlotIndices: ["1"],
              ),
            ],
          ),
          finishingDetails: CharacterFinishingDetailsInput(
            appearanceDetails: 'Tall and quiet',
            narrativeNotes: 'Keeps careful notes.',
            narrativeSelections: <NarrativeSelection>[
              NarrativeSelection(
                fieldKey: NarrativeFieldKey.alignment,
                mode: NarrativeSelectionMode.manual,
                valueText: 'Neutral',
                groupId: 'narrative-alignment-core',
                optionId: 'narrative-alignment-5',
              ),
              NarrativeSelection.empty(NarrativeFieldKey.faction),
              NarrativeSelection.empty(NarrativeFieldKey.personalityTraits),
              NarrativeSelection.empty(NarrativeFieldKey.ideals),
              NarrativeSelection.empty(NarrativeFieldKey.bonds),
              NarrativeSelection.empty(NarrativeFieldKey.flaws),
            ],
          ),
        ),
      );

      final editable = await repository.getEditableCharacterById(summary.id);

      expect(editable, isNotNull);
      expect(editable!.identity.className, 'Wizard');
      expect(editable.background.id, 'acolyte');
      expect(editable.abilities.methodKey, 'generatedSetAssignment');
      expect(editable.abilities.provenance.methodKey, 'generatedSetAssignment');
      expect(
        editable.abilities.provenance.assignedScoresByAbility['Strength'],
        8,
      );
      expect(editable.progression.proficiencyBonus, 3);
      expect(editable.hitPoints.maximum, 27);
      expect(editable.equipment.loadoutId, 'wizard-focus');
      expect(
        editable.spellState.selectionMode,
        CharacterSpellSelectionMode.spellbook,
      );
      expect(editable.spellState.selectedSpells, hasLength(2));
      expect(
        editable.spellState.selectedSpells.map((row) => row.selectionMode),
        containsAll(<CharacterSpellSelectionMode>[
          CharacterSpellSelectionMode.spellbook,
          CharacterSpellSelectionMode.prepared,
        ]),
      );
      expect(
        editable.spellState.slotUsages.single.expendedSlotIndices,
        <String>['0'],
      );
      expect(editable.equipment.items[1].name, 'Torch');
      expect(editable.equipment.items[1].quantity, 2);
      expect(
        editable.finishingDetails.valueFor(NarrativeFieldKey.alignment),
        'Neutral',
      );
    },
  );

  test(
    'editable character mapper round-trips aggregate into create input contract',
    () async {
      final database = AppDatabase.executor(NativeDatabase.memory());
      addTearDown(database.close);

      final repository = DriftCharacterRepository(
        database: database,
        compendiumRepository: InMemoryCompendiumRepository(_testCatalog),
      );

      final summary = await repository.createCharacter(
        const CreateCharacterInput(
          name: 'Aelar',
          raceName: 'Human',
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
          className: 'Fighter',
          level: 1,
          experience: 0,
          equipmentLoadoutId: 'fighter-chain-mail',
          equipmentLoadoutLabel: 'Chain mail starter kit',
          startingMoneySummary: 'Class kit with default martial gear',
          selectedEquipmentItems: <String>['Chain mail', 'Shield', 'Longsword'],
          currentHitPoints: 12,
          maximumHitPoints: 12,
          temporaryHitPoints: 0,
          spellState: CharacterSpellStateInput.empty(),
          finishingDetails: CharacterFinishingDetailsInput(
            appearanceDetails: 'Short hair',
            narrativeNotes: 'Ready for patrol.',
            narrativeSelections: <NarrativeSelection>[
              NarrativeSelection(
                fieldKey: NarrativeFieldKey.alignment,
                mode: NarrativeSelectionMode.manual,
                valueText: 'Neutral',
                groupId: 'narrative-alignment-core',
                optionId: 'narrative-alignment-5',
              ),
              NarrativeSelection.empty(NarrativeFieldKey.faction),
              NarrativeSelection.empty(NarrativeFieldKey.personalityTraits),
              NarrativeSelection.empty(NarrativeFieldKey.ideals),
              NarrativeSelection.empty(NarrativeFieldKey.bonds),
              NarrativeSelection.empty(NarrativeFieldKey.flaws),
            ],
          ),
        ),
      );

      final editable = await repository.getEditableCharacterById(summary.id);
      const mapper = EditableCharacterMapper();
      final remapped = mapper.toCreateCharacterInput(editable!);

      expect(remapped.name, 'Aelar');
      expect(remapped.backgroundId, 'acolyte');
      expect(remapped.abilityScoreMethod, 'manualPointAllocation');
      expect(remapped.strength, 15);
      expect(remapped.equipmentLoadoutId, 'fighter-chain-mail');
      expect(remapped.spellState.selectionMode, isNull);
      expect(remapped.selectedEquipmentItems, <String>[
        'Chain mail',
        'Shield',
        'Longsword',
      ]);
    },
  );
}

const _testCatalog = CompendiumCatalog(
  races: <String>['Human', 'Elf'],
  classes: <String>['Fighter', 'Wizard'],
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
      classId: 'fighter',
      className: 'Fighter',
      strength: 15,
      dexterity: 14,
      constitution: 13,
      intelligence: 8,
      wisdom: 10,
      charisma: 12,
    ),
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
  spells: <CompendiumSpell>[
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
      description: <String>['Three darts of magical force.'],
      source: 'SRD',
    ),
  ],
  feats: <CompendiumFeat>[],
  monsters: <CompendiumMonster>[],
  equipmentSummariesByClass: <String, EquipmentSummaryViewData>{
    'Fighter': EquipmentSummaryViewData(
      statusLabel: 'MVP minimal',
      description: 'Equipment summary',
      highlightItems: <String>['Longsword'],
    ),
    'Wizard': EquipmentSummaryViewData(
      statusLabel: 'MVP minimal',
      description: 'Equipment summary',
      highlightItems: <String>['Quarterstaff'],
    ),
  },
  equipmentLoadoutsByClass: <String, List<CompendiumEquipmentLoadout>>{
    'Fighter': <CompendiumEquipmentLoadout>[
      CompendiumEquipmentLoadout(
        id: 'fighter-chain-mail',
        label: 'Chain mail starter kit',
        startingMoneySummary: 'Class kit with default martial gear',
        selectedItems: <String>['Chain mail', 'Shield', 'Longsword'],
      ),
    ],
    'Wizard': <CompendiumEquipmentLoadout>[
      CompendiumEquipmentLoadout(
        id: 'wizard-focus',
        label: 'Arcane focus kit',
        startingMoneySummary: '15 gp, 4 sp',
        selectedItems: <String>['Quarterstaff', 'Torch', 'Scholar pack'],
      ),
    ],
  },
);
