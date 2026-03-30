import 'package:adventure_vault_character/src/features/characters/data/drift_character_repository.dart';
import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_finishing_details.dart';
import 'package:adventure_vault_character/src/features/characters/domain/equipment_summary_view_data.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:adventure_vault_character/src/features/compendium/data/in_memory_compendium_repository.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';
import 'package:drift/drift.dart' show Value, Variable;
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
              CharacterSpellSlotUsageInput(spellLevel: 1, slotsExpended: 1),
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
      final spellSelections = await (database.select(
        database.characterSpellSelections,
      )..where((table) => table.characterId.equals(summary.id))).get();
      final spellSlotUsages = await (database.select(
        database.characterSpellSlotUsages,
      )..where((table) => table.characterId.equals(summary.id))).get();
      final finishingDetails = await (database.select(
        database.characterFinishingDetails,
      )..where((table) => table.characterId.equals(summary.id))).getSingle();
      final narrativeSelections = await (database.select(
        database.characterNarrativeSelections,
      )..where((table) => table.characterId.equals(summary.id))).get();
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
      expect(spellSelections, hasLength(2));
      expect(
        spellSelections.map((row) => row.selectionKind),
        containsAll(<String>['spellbook', 'prepared']),
      );
      expect(spellSlotUsages, hasLength(1));
      expect(spellSlotUsages.single.spellLevel, 1);
      expect(spellSlotUsages.single.slotsExpended, 1);
      expect(finishingDetails.alignment, 'Neutral');
      expect(finishingDetails.appearanceDetails, 'Tall and quiet');
      expect(narrativeSelections, hasLength(1));
      expect(narrativeSelections.single.fieldKey, 'alignment');
      expect(narrativeSelections.single.selectionMode, 'manual');
      expect(narrativeSelections.single.valueText, 'Neutral');

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
        sheet.spellcasting!.selectedSpells.map((spell) => spell.name),
        <String>['Magic Missile'],
      );
      expect(sheet.spellcasting!.selectionSummary, '1 / 7');
      expect(sheet.spellcasting!.slotProgression.first.displaySummary, '3 / 4');
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
        compendiumRepository: InMemoryCompendiumRepository(_testCatalog),
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
              CharacterSpellSlotUsageInput(spellLevel: 1, slotsExpended: 1),
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
          spellState: CharacterSpellStateInput(
            selectionMode: CharacterSpellSelectionMode.spellbook,
            selectedSpells: <CharacterSpellSelectionInput>[
              CharacterSpellSelectionInput(
                spellId: 'mage-hand',
                spellName: 'Mage Hand',
                selectionMode: CharacterSpellSelectionMode.spellbook,
              ),
              CharacterSpellSelectionInput(
                spellId: 'mage-hand',
                spellName: 'Mage Hand',
                selectionMode: CharacterSpellSelectionMode.prepared,
              ),
            ],
            slotUsages: <CharacterSpellSlotUsageInput>[
              CharacterSpellSlotUsageInput(spellLevel: 1, slotsExpended: 0),
            ],
          ),
          finishingDetails: CharacterFinishingDetailsInput(
            appearanceDetails: 'Short hair',
            narrativeNotes: 'Updated after review.',
            narrativeSelections: <NarrativeSelection>[
              NarrativeSelection(
                fieldKey: NarrativeFieldKey.alignment,
                mode: NarrativeSelectionMode.manual,
                valueText: 'Lawful Good',
                groupId: 'narrative-alignment-core',
                optionId: 'narrative-alignment-1',
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
      final spellSelections = await (database.select(
        database.characterSpellSelections,
      )..where((table) => table.characterId.equals(created.id))).get();
      final spellSlotUsages = await (database.select(
        database.characterSpellSlotUsages,
      )..where((table) => table.characterId.equals(created.id))).get();
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
      expect(spellSelections, hasLength(2));
      expect(
        spellSelections.map((row) => row.selectionKind),
        containsAll(<String>['spellbook', 'prepared']),
      );
      expect(spellSlotUsages.single.slotsExpended, 0);
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
      expect(
        sheet.spellcasting!.selectedSpells.map((spell) => spell.name),
        <String>['Mage Hand'],
      );
      expect(sheet.spellcasting!.selectionSummary, '1 / 2');
      expect(sheet.featuresNotes.alignment, 'Lawful Good');
      expect(sheet.equipment.money.startingMoneySummary, '20 gp');
      expect(sheet.equipment.visibleItems, <String>[
        'Quarterstaff (equipped)',
        'Torch x2',
      ]);
    },
  );

  test(
    'createCharacter rejects spell selections above the derived class limit',
    () async {
      final database = AppDatabase.executor(NativeDatabase.memory());
      addTearDown(database.close);

      final repository = DriftCharacterRepository(
        database: database,
        compendiumRepository: InMemoryCompendiumRepository(_testCatalog),
      );

      await expectLater(
        () => repository.createCharacter(
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
            level: 1,
            experience: 0,
            equipmentLoadoutId: 'wizard-focus',
            equipmentLoadoutLabel: 'Arcane focus kit',
            startingMoneySummary: '15 gp, 4 sp',
            selectedEquipmentItems: <String>[
              'Quarterstaff',
              'Component pouch',
              'Scholar pack',
            ],
            currentHitPoints: 8,
            maximumHitPoints: 8,
            temporaryHitPoints: 0,
            spellState: CharacterSpellStateInput(
              selectionMode: CharacterSpellSelectionMode.spellbook,
              selectedSpells: <CharacterSpellSelectionInput>[
                CharacterSpellSelectionInput(
                  spellId: 'light',
                  spellName: 'Light',
                  selectionMode: CharacterSpellSelectionMode.prepared,
                ),
                CharacterSpellSelectionInput(
                  spellId: 'mage-hand',
                  spellName: 'Mage Hand',
                  selectionMode: CharacterSpellSelectionMode.prepared,
                ),
                CharacterSpellSelectionInput(
                  spellId: 'magic-missile',
                  spellName: 'Magic Missile',
                  selectionMode: CharacterSpellSelectionMode.prepared,
                ),
                CharacterSpellSelectionInput(
                  spellId: 'shield',
                  spellName: 'Shield',
                  selectionMode: CharacterSpellSelectionMode.prepared,
                ),
              ],
              slotUsages: <CharacterSpellSlotUsageInput>[
                CharacterSpellSlotUsageInput(spellLevel: 1, slotsExpended: 0),
              ],
            ),
            finishingDetails: CharacterFinishingDetailsInput(
              appearanceDetails: '',
              narrativeNotes: '',
              narrativeSelections: <NarrativeSelection>[
                NarrativeSelection.empty(NarrativeFieldKey.alignment),
                NarrativeSelection.empty(NarrativeFieldKey.faction),
                NarrativeSelection.empty(NarrativeFieldKey.personalityTraits),
                NarrativeSelection.empty(NarrativeFieldKey.ideals),
                NarrativeSelection.empty(NarrativeFieldKey.bonds),
                NarrativeSelection.empty(NarrativeFieldKey.flaws),
              ],
            ),
          ),
        ),
        throwsA(
          isA<StateError>().having(
            (error) => error.message,
            'message',
            'Selected spells exceed the current class limit.',
          ),
        ),
      );
    },
  );

  test(
    'createCharacter persists warlock pact-magic spell state and sheet summary',
    () async {
      final database = AppDatabase.executor(NativeDatabase.memory());
      addTearDown(database.close);

      final repository = DriftCharacterRepository(
        database: database,
        compendiumRepository: InMemoryCompendiumRepository(_testCatalog),
      );

      final summary = await repository.createCharacter(
        const CreateCharacterInput(
          name: 'Nim',
          raceName: 'Elf',
          backgroundId: 'acolyte',
          backgroundName: 'Acolyte',
          backgroundSummary: 'Temple acolyte',
          abilityScoreMethod: 'generatedSetAssignment',
          abilityScoreProvenance:
              'method=generatedSetAssignment;Strength=8;Dexterity=12;Constitution=13;Intelligence=14;Wisdom=10;Charisma=15',
          strength: 8,
          dexterity: 12,
          constitution: 13,
          intelligence: 14,
          wisdom: 10,
          charisma: 15,
          className: 'Warlock',
          level: 5,
          experience: 6500,
          equipmentLoadoutId: 'wizard-focus',
          equipmentLoadoutLabel: 'Arcane focus kit',
          startingMoneySummary: '15 gp, 4 sp',
          selectedEquipmentItems: <String>['Quarterstaff'],
          currentHitPoints: 26,
          maximumHitPoints: 26,
          temporaryHitPoints: 0,
          spellState: CharacterSpellStateInput(
            selectionMode: CharacterSpellSelectionMode.known,
            selectedSpells: <CharacterSpellSelectionInput>[
              CharacterSpellSelectionInput(
                spellId: 'light',
                spellName: 'Light',
                selectionMode: CharacterSpellSelectionMode.known,
              ),
            ],
            slotUsages: <CharacterSpellSlotUsageInput>[
              CharacterSpellSlotUsageInput(spellLevel: 3, slotsExpended: 1),
            ],
          ),
          finishingDetails: CharacterFinishingDetailsInput(
            appearanceDetails: '',
            narrativeNotes: '',
            narrativeSelections: <NarrativeSelection>[
              NarrativeSelection.empty(NarrativeFieldKey.alignment),
              NarrativeSelection.empty(NarrativeFieldKey.faction),
              NarrativeSelection.empty(NarrativeFieldKey.personalityTraits),
              NarrativeSelection.empty(NarrativeFieldKey.ideals),
              NarrativeSelection.empty(NarrativeFieldKey.bonds),
              NarrativeSelection.empty(NarrativeFieldKey.flaws),
            ],
          ),
        ),
      );

      final sheet = await repository.getCharacterSheetById(summary.id);

      expect(sheet, isNotNull);
      expect(sheet!.identity.className, 'Warlock');
      expect(sheet.spellcasting, isNotNull);
      expect(sheet.spellcasting!.selectionLabel, 'Known spells');
      expect(sheet.spellcasting!.selectionSummary, '1 / 6');
      expect(sheet.spellcasting!.slotProgression, hasLength(1));
      expect(sheet.spellcasting!.slotProgression.single.spellLevel, 3);
      expect(
        sheet.spellcasting!.slotProgression.single.displaySummary,
        '1 / 2',
      );
    },
  );
  test('rest actions persist recovery state and refresh sheet values', () async {
    final database = AppDatabase.executor(NativeDatabase.memory());
    addTearDown(database.close);

    final repository = DriftCharacterRepository(
      database: database,
      compendiumRepository: InMemoryCompendiumRepository(_testCatalog),
    );

    final summary = await repository.createCharacter(
      const CreateCharacterInput(
        name: 'Nim',
        raceName: 'Elf',
        backgroundId: 'acolyte',
        backgroundName: 'Acolyte',
        backgroundSummary: 'Temple acolyte',
        abilityScoreMethod: 'generatedSetAssignment',
        abilityScoreProvenance:
            'method=generatedSetAssignment;Strength=8;Dexterity=12;Constitution=13;Intelligence=14;Wisdom=10;Charisma=15',
        strength: 8,
        dexterity: 12,
        constitution: 13,
        intelligence: 14,
        wisdom: 10,
        charisma: 15,
        className: 'Warlock',
        level: 5,
        experience: 6500,
        equipmentLoadoutId: 'wizard-focus',
        equipmentLoadoutLabel: 'Arcane focus kit',
        startingMoneySummary: '15 gp, 4 sp',
        selectedEquipmentItems: <String>['Quarterstaff'],
        currentHitPoints: 12,
        maximumHitPoints: 26,
        temporaryHitPoints: 4,
        spellState: CharacterSpellStateInput(
          selectionMode: CharacterSpellSelectionMode.known,
          selectedSpells: <CharacterSpellSelectionInput>[
            CharacterSpellSelectionInput(
              spellId: 'light',
              spellName: 'Light',
              selectionMode: CharacterSpellSelectionMode.known,
            ),
          ],
          slotUsages: <CharacterSpellSlotUsageInput>[
            CharacterSpellSlotUsageInput(spellLevel: 3, slotsExpended: 2),
          ],
        ),
        finishingDetails: CharacterFinishingDetailsInput(
          appearanceDetails: '',
          narrativeNotes: '',
          narrativeSelections: <NarrativeSelection>[
            NarrativeSelection.empty(NarrativeFieldKey.alignment),
            NarrativeSelection.empty(NarrativeFieldKey.faction),
            NarrativeSelection.empty(NarrativeFieldKey.personalityTraits),
            NarrativeSelection.empty(NarrativeFieldKey.ideals),
            NarrativeSelection.empty(NarrativeFieldKey.bonds),
            NarrativeSelection.empty(NarrativeFieldKey.flaws),
          ],
        ),
      ),
    );

    final beforeShortRest = await repository.getCharacterSheetById(summary.id);
    expect(beforeShortRest, isNotNull);

    await repository.applyShortRest(summary.id);

    var sheet = await repository.getCharacterSheetById(summary.id);
    expect(sheet, isNotNull);
    expect(
      sheet!.combat.hitPoints.current,
      beforeShortRest!.combat.hitPoints.current,
    );
    expect(
      sheet.combat.hitPoints.maximum,
      beforeShortRest.combat.hitPoints.maximum,
    );
    expect(
      sheet.combat.hitPoints.temporary,
      beforeShortRest.combat.hitPoints.temporary,
    );
    expect(sheet.spellcasting, isNotNull);
    expect(sheet.spellcasting!.slotProgression.single.displaySummary, '2 / 2');

    await repository.applyLongRest(summary.id);

    sheet = await repository.getCharacterSheetById(summary.id);
    expect(sheet, isNotNull);
    expect(sheet!.combat.hitPoints.current, sheet.combat.hitPoints.maximum);
    expect(
      sheet.combat.hitPoints.maximum,
      beforeShortRest.combat.hitPoints.maximum,
    );
    expect(sheet.combat.hitPoints.temporary, 0);
    expect(sheet.spellcasting, isNotNull);
    expect(sheet.spellcasting!.slotProgression.single.displaySummary, '2 / 2');

    final slotRows = await (database.select(
      database.characterSpellSlotUsages,
    )..where((table) => table.characterId.equals(summary.id))).get();
    expect(slotRows, hasLength(1));
    expect(slotRows.single.spellLevel, 3);
    expect(slotRows.single.slotsExpended, 0);
  });

  test('short rest restores short-rest class resources', () async {
    final database = AppDatabase.executor(NativeDatabase.memory());
    addTearDown(database.close);

    final repository = DriftCharacterRepository(
      database: database,
      compendiumRepository: InMemoryCompendiumRepository(_testCatalog),
    );

    final summary = await repository.createCharacter(
      const CreateCharacterInput(
        name: 'Tarin',
        raceName: 'Elf',
        backgroundId: 'acolyte',
        backgroundName: 'Acolyte',
        backgroundSummary: 'Temple acolyte',
        abilityScoreMethod: 'generatedSetAssignment',
        abilityScoreProvenance:
            'method=generatedSetAssignment;Strength=8;Dexterity=15;Constitution=13;Intelligence=12;Wisdom=14;Charisma=10',
        strength: 8,
        dexterity: 15,
        constitution: 13,
        intelligence: 12,
        wisdom: 14,
        charisma: 10,
        className: 'Monk',
        level: 5,
        experience: 6500,
        equipmentLoadoutId: 'wizard-focus',
        equipmentLoadoutLabel: 'Arcane focus kit',
        startingMoneySummary: '15 gp, 4 sp',
        selectedEquipmentItems: <String>['Quarterstaff'],
        currentHitPoints: 24,
        maximumHitPoints: 24,
        temporaryHitPoints: 0,
        spellState: CharacterSpellStateInput.empty(),
        finishingDetails: CharacterFinishingDetailsInput(
          appearanceDetails: '',
          narrativeNotes: '',
          narrativeSelections: <NarrativeSelection>[
            NarrativeSelection.empty(NarrativeFieldKey.alignment),
            NarrativeSelection.empty(NarrativeFieldKey.faction),
            NarrativeSelection.empty(NarrativeFieldKey.personalityTraits),
            NarrativeSelection.empty(NarrativeFieldKey.ideals),
            NarrativeSelection.empty(NarrativeFieldKey.bonds),
            NarrativeSelection.empty(NarrativeFieldKey.flaws),
          ],
        ),
      ),
    );

    await database
        .into(database.characterClassResources)
        .insert(
          CharacterClassResourcesCompanion.insert(
            characterId: summary.id,
            resourceKey: 'ki-points',
            currentUses: const Value(1),
          ),
        );

    await repository.applyShortRest(summary.id);

    final resourceRows = await (database.select(
      database.characterClassResources,
    )..where((table) => table.characterId.equals(summary.id))).get();
    expect(resourceRows, hasLength(1));
    expect(resourceRows.single.resourceKey, 'ki-points');
    expect(resourceRows.single.currentUses, 5);
    expect(resourceRows.single.lastChangedSource, 'short-rest');

    await repository.setClassResourceUses(summary.id, 'ki-points', 2);

    final updatedSheet = await repository.getCharacterSheetById(summary.id);
    expect(updatedSheet, isNotNull);
    expect(updatedSheet!.combat.classResources, hasLength(1));
    expect(updatedSheet.combat.classResources.single.resourceKey, 'ki-points');
    expect(updatedSheet.combat.classResources.single.currentUses, 2);
    expect(
      updatedSheet.combat.classResources.single.lastChangedSource,
      'manual-adjustment',
    );
  });

  test(
    'encumbrance respects coin-weight setting and inventory updates',
    () async {
      final database = AppDatabase.executor(NativeDatabase.memory());
      addTearDown(database.close);

      final repository = DriftCharacterRepository(
        database: database,
        compendiumRepository: InMemoryCompendiumRepository(_testCatalog),
      );

      final summary = await repository.createCharacter(
        const CreateCharacterInput(
          name: 'Borin',
          raceName: 'Human',
          backgroundId: 'acolyte',
          backgroundName: 'Acolyte',
          backgroundSummary: 'Temple acolyte',
          abilityScoreMethod: 'manualPointAllocation',
          abilityScoreProvenance: 'method=manualPointAllocation',
          strength: 10,
          dexterity: 12,
          constitution: 13,
          intelligence: 10,
          wisdom: 14,
          charisma: 8,
          className: 'Wizard',
          level: 2,
          experience: 300,
          equipmentLoadoutId: 'wizard-focus',
          equipmentLoadoutLabel: 'Arcane focus kit',
          startingMoneySummary: '0 gp',
          selectedEquipmentItems: <String>['Anvil'],
          currentHitPoints: 12,
          maximumHitPoints: 12,
          temporaryHitPoints: 0,
          spellState: CharacterSpellStateInput(
            selectionMode: CharacterSpellSelectionMode.spellbook,
            selectedSpells: <CharacterSpellSelectionInput>[],
            slotUsages: <CharacterSpellSlotUsageInput>[],
          ),
          finishingDetails: CharacterFinishingDetailsInput(
            appearanceDetails: '',
            narrativeNotes: '',
            narrativeSelections: <NarrativeSelection>[
              NarrativeSelection.empty(NarrativeFieldKey.alignment),
              NarrativeSelection.empty(NarrativeFieldKey.faction),
              NarrativeSelection.empty(NarrativeFieldKey.personalityTraits),
              NarrativeSelection.empty(NarrativeFieldKey.ideals),
              NarrativeSelection.empty(NarrativeFieldKey.bonds),
              NarrativeSelection.empty(NarrativeFieldKey.flaws),
            ],
          ),
        ),
      );

      await (database.update(database.equipmentDefinitions)
            ..where((table) => table.id.equals('equipment-anvil')))
          .write(const EquipmentDefinitionsCompanion(weight: Value(50)));
      await (database.update(
        database.characterCurrency,
      )..where((table) => table.characterId.equals(summary.id))).write(
        const CharacterCurrencyCompanion(
          copper: Value(0),
          silver: Value(0),
          electrum: Value(0),
          gold: Value(500),
          platinum: Value(0),
        ),
      );

      var sheet = await repository.getCharacterSheetById(summary.id);
      expect(sheet, isNotNull);
      expect(sheet!.equipment.carrying.includeCoinWeight, isFalse);
      expect(sheet.equipment.carrying.totalWeight, 50);
      expect(sheet.equipment.carrying.tier, 'normal');

      await database
          .into(database.systemPreferences)
          .insert(
            SystemPreferencesCompanion.insert(
              id: const Value(1),
              includeCoinWeightInEncumbrance: const Value(true),
            ),
          );

      sheet = await repository.getCharacterSheetById(summary.id);
      expect(sheet, isNotNull);
      expect(sheet!.equipment.carrying.includeCoinWeight, isTrue);
      expect(sheet.equipment.carrying.coinWeight, 10);
      expect(sheet.equipment.carrying.totalWeight, 60);
      expect(sheet.equipment.carrying.tier, 'encumbered');

      final inventoryItemId = sheet.equipment.items.single.id;
      await repository.setInventoryItemQuantity(summary.id, inventoryItemId, 2);

      sheet = await repository.getCharacterSheetById(summary.id);
      expect(sheet, isNotNull);
      expect(sheet!.equipment.items.single.quantity, 2);
      expect(sheet.equipment.carrying.totalWeight, 110);
      expect(sheet.equipment.carrying.tier, 'heavily_encumbered');

      await repository.setInventoryItemCarried(
        summary.id,
        inventoryItemId,
        false,
      );

      sheet = await repository.getCharacterSheetById(summary.id);
      expect(sheet, isNotNull);
      expect(sheet!.equipment.items.single.isCarried, isFalse);
      expect(sheet.equipment.carrying.totalWeight, 10);
      expect(sheet.equipment.carrying.tier, 'normal');
    },
  );

  test('inventory supports container assignment and charge tracking', () async {
    final database = AppDatabase.executor(NativeDatabase.memory());
    addTearDown(database.close);

    final repository = DriftCharacterRepository(
      database: database,
      compendiumRepository: InMemoryCompendiumRepository(_testCatalog),
    );

    final summary = await repository.createCharacter(
      const CreateCharacterInput(
        name: 'Lia',
        raceName: 'Human',
        backgroundId: 'acolyte',
        backgroundName: 'Acolyte',
        backgroundSummary: 'Temple acolyte',
        abilityScoreMethod: 'manualPointAllocation',
        abilityScoreProvenance: 'method=manualPointAllocation',
        strength: 10,
        dexterity: 12,
        constitution: 13,
        intelligence: 10,
        wisdom: 14,
        charisma: 8,
        className: 'Wizard',
        level: 2,
        experience: 300,
        equipmentLoadoutId: 'wizard-focus',
        equipmentLoadoutLabel: 'Arcane focus kit',
        startingMoneySummary: '0 gp',
        selectedEquipmentItems: <String>['Backpack', 'Torch'],
        currentHitPoints: 12,
        maximumHitPoints: 12,
        temporaryHitPoints: 0,
        spellState: CharacterSpellStateInput(
          selectionMode: CharacterSpellSelectionMode.spellbook,
          selectedSpells: <CharacterSpellSelectionInput>[],
          slotUsages: <CharacterSpellSlotUsageInput>[],
        ),
        finishingDetails: CharacterFinishingDetailsInput(
          appearanceDetails: '',
          narrativeNotes: '',
          narrativeSelections: <NarrativeSelection>[
            NarrativeSelection.empty(NarrativeFieldKey.alignment),
            NarrativeSelection.empty(NarrativeFieldKey.faction),
            NarrativeSelection.empty(NarrativeFieldKey.personalityTraits),
            NarrativeSelection.empty(NarrativeFieldKey.ideals),
            NarrativeSelection.empty(NarrativeFieldKey.bonds),
            NarrativeSelection.empty(NarrativeFieldKey.flaws),
          ],
        ),
      ),
    );

    var sheet = await repository.getCharacterSheetById(summary.id);
    expect(sheet, isNotNull);
    final backpack = sheet!.equipment.items.firstWhere(
      (item) => item.name == 'Backpack',
    );
    final torch = sheet.equipment.items.firstWhere(
      (item) => item.name == 'Torch',
    );
    expect(backpack.isContainer, isTrue);
    expect(torch.isContainer, isFalse);

    await repository.setInventoryItemCharges(
      summary.id,
      torch.id,
      chargesCurrent: 3,
      chargesMax: 5,
    );
    await repository.setInventoryItemContainer(
      summary.id,
      torch.id,
      backpack.id,
    );

    sheet = await repository.getCharacterSheetById(summary.id);
    expect(sheet, isNotNull);
    final updatedTorch = sheet!.equipment.items.firstWhere(
      (item) => item.name == 'Torch',
    );
    expect(updatedTorch.chargesCurrent, 3);
    expect(updatedTorch.chargesMax, 5);
    expect(updatedTorch.containerInventoryItemId, backpack.id);
    expect(updatedTorch.containerDisplayName, 'Backpack');
  });
}

const _testCatalog = CompendiumCatalog(
  races: <String>['Elf'],
  classes: <String>['Wizard', 'Warlock'],
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
  spells: <CompendiumSpell>[
    CompendiumSpell(
      id: 'light',
      name: 'Light',
      level: 0,
      school: 'Evocation',
      castingTime: '1 action',
      range: 'Touch',
      components: 'V, M',
      duration: '1 hour',
      classes: <String>['Wizard', 'Warlock'],
      description: <String>['An object shines with bright light.'],
      source: 'SRD',
    ),
    CompendiumSpell(
      id: 'mage-hand',
      name: 'Mage Hand',
      level: 0,
      school: 'Conjuration',
      castingTime: '1 action',
      range: '30 feet',
      components: 'V, S',
      duration: '1 minute',
      classes: <String>['Wizard'],
      description: <String>['A spectral hand appears.'],
      source: 'SRD',
    ),
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
    CompendiumSpell(
      id: 'shield',
      name: 'Shield',
      level: 1,
      school: 'Abjuration',
      castingTime: '1 reaction',
      range: 'Self',
      components: 'V, S',
      duration: '1 round',
      classes: <String>['Wizard'],
      description: <String>['An invisible barrier of magical force appears.'],
      source: 'SRD',
    ),
  ],
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
