import 'package:adventure_vault_character/src/features/characters/data/in_memory_character_repository.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_finishing_details.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_inventory_validation_error.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:adventure_vault_character/src/features/characters/domain/equipment_summary_view_data.dart';
import 'package:adventure_vault_character/src/features/compendium/data/in_memory_compendium_repository.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'spendInventoryItemQuantity rejects non-positive amount without state change',
    () async {
      final repository = InMemoryCharacterRepository.empty(
        compendiumRepository: InMemoryCompendiumRepository(_testCatalog),
      );
      final summary = await repository.createCharacter(
        _createCharacterInput(
          name: 'Invalid quantity',
          items: <String>['3 Torch'],
        ),
      );
      final torchBefore = await _torchFor(repository, summary.id);

      await expectLater(
        repository.spendInventoryItemQuantity(
          summary.id,
          torchBefore.id,
          amount: 0,
        ),
        throwsA(
          isA<CharacterInventoryValidationError>().having(
            (error) => error.code,
            'code',
            'invalid_quantity',
          ),
        ),
      );

      final torchAfter = await _torchFor(repository, summary.id);
      expect(torchAfter.quantity, torchBefore.quantity);
    },
  );

  test(
    'spendInventoryItemQuantity rejects insufficient quantity without state change',
    () async {
      final repository = InMemoryCharacterRepository.empty(
        compendiumRepository: InMemoryCompendiumRepository(_testCatalog),
      );
      final summary = await repository.createCharacter(
        _createCharacterInput(
          name: 'Insufficient quantity',
          items: <String>['Torch'],
        ),
      );
      final torchBefore = await _torchFor(repository, summary.id);

      await expectLater(
        repository.spendInventoryItemQuantity(
          summary.id,
          torchBefore.id,
          amount: 2,
        ),
        throwsA(
          isA<CharacterInventoryValidationError>().having(
            (error) => error.code,
            'code',
            'insufficient_quantity',
          ),
        ),
      );

      final torchAfter = await _torchFor(repository, summary.id);
      expect(torchAfter.quantity, torchBefore.quantity);
    },
  );
}

Future<dynamic> _torchFor(
  InMemoryCharacterRepository repository,
  String characterId,
) async {
  final sheet = await repository.getCharacterSheetById(characterId);
  expect(sheet, isNotNull);
  return sheet!.equipment.items.firstWhere((item) => item.name == 'Torch');
}

CreateCharacterInput _createCharacterInput({
  required String name,
  required List<String> items,
}) {
  return CreateCharacterInput(
    name: name,
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
    selectedEquipmentItems: items,
    currentHitPoints: 12,
    maximumHitPoints: 12,
    temporaryHitPoints: 0,
    spellState: const CharacterSpellStateInput(
      selectionMode: CharacterSpellSelectionMode.spellbook,
      selectedSpells: <CharacterSpellSelectionInput>[],
      slotUsages: <CharacterSpellSlotUsageInput>[],
    ),
    finishingDetails: const CharacterFinishingDetailsInput(
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
  );
}

const _testCatalog = CompendiumCatalog(
  races: <String>['Human'],
  classes: <String>['Wizard'],
  backgrounds: <CompendiumBackground>[
    CompendiumBackground(
      id: 'acolyte',
      name: 'Acolyte',
      summary: 'Temple acolyte',
      bonuses: <String>['Skills: Insight, Religion'],
      socialPerks: <String>['Shelter of the Faithful'],
    ),
  ],
  narrativeOptionGroups: <CompendiumNarrativeOptionGroup>[],
  generatedAbilityScoreSet: <int>[15, 14, 13, 12, 10, 8],
  manualAbilityScoreOptions: <int>[8, 9, 10, 11, 12, 13, 14, 15],
  characterAdvancement: <CharacterAdvancementEntry>[
    CharacterAdvancementEntry(level: 1, experience: 0, proficiencyBonus: '+2'),
    CharacterAdvancementEntry(
      level: 2,
      experience: 300,
      proficiencyBonus: '+2',
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
      highlightItems: <String>['Torch'],
    ),
  },
  equipmentLoadoutsByClass: <String, List<CompendiumEquipmentLoadout>>{
    'Wizard': <CompendiumEquipmentLoadout>[
      CompendiumEquipmentLoadout(
        id: 'wizard-focus',
        label: 'Arcane focus kit',
        startingMoneySummary: '0 gp',
        selectedItems: <String>['Torch'],
      ),
    ],
  },
);
