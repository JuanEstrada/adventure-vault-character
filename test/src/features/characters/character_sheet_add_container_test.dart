import 'package:adventure_vault_character/src/app/app_controller.dart';
import 'package:adventure_vault_character/src/features/characters/data/in_memory_character_repository.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_finishing_details.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:adventure_vault_character/src/features/characters/domain/equipment_summary_view_data.dart';
import 'package:adventure_vault_character/src/features/characters/presentation/character_sheet_screen.dart';
import 'package:adventure_vault_character/src/features/compendium/data/in_memory_compendium_repository.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';
import 'package:adventure_vault_character/src/features/settings/data/in_memory_system_settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'CharacterSheetScreen add-container action wires to real mutation path',
    (WidgetTester tester) async {
      final compendiumRepository = InMemoryCompendiumRepository(
        _buildCatalog(),
      );
      final characterRepository = InMemoryCharacterRepository.empty(
        compendiumRepository: compendiumRepository,
      );
      final createdCharacter = await characterRepository.createCharacter(
        _createCharacterInput(name: 'Test Character', items: <String>['Torch']),
      );
      final appController = AppController(
        characterRepository: characterRepository,
        compendiumRepository: compendiumRepository,
        systemSettingsRepository: InMemorySystemSettingsRepository(),
      );

      addTearDown(appController.dispose);
      await appController.initialize();
      await appController.openCharacter(createdCharacter.id);

      await tester.pumpWidget(
        MaterialApp(
          home: CharacterSheetScreen(
            character: appController.state.selectedCharacterSheet!,
            isApplyingRest: false,
            errorMessage: null,
            onBack: () {},
            onEdit: () {},
            onApplyShortRest: () async {},
            onApplyLongRest: () async {},
            onSpendSpellSlot:
                ({required int spellLevel, required int slotIndex}) async {},
            onRestoreSpellSlot:
                ({required int spellLevel, required int slotIndex}) async {},
            onSetClassResourceUses: (resourceKey, currentUses) async {},
            onRecordDeathSaveSuccess: () async {},
            onRecordDeathSaveFailure: () async {},
            onResetDeathSaves: () async {},
            onSetInventoryItemEquipped: (inventoryItemId, isEquipped) async {},
            onSetInventoryItemCarried: (inventoryItemId, isCarried) async {},
            onSetInventoryItemQuantity: (inventoryItemId, quantity) async {},
            onSpendInventoryItemQuantity:
                (inventoryItemId, {int amount = 1}) async {},
            onSetInventoryItemCharges:
                (inventoryItemId, {chargesCurrent, chargesMax}) async {},
            onSetInventoryItemContainer:
                (inventoryItemId, containerInventoryItemId) async {},
            onCreateContainer: appController.createContainer,
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      final button = tester.widget<OutlinedButton>(
        find.widgetWithText(OutlinedButton, 'Manage containers'),
      );
      expect(button.onPressed, isNotNull);

      button.onPressed!.call();
      await tester.pumpAndSettle();

      expect(find.text('Manage Containers'), findsOneWidget);
      expect(find.text('Add new container:'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'New Spell Pouch');
      await tester.pumpAndSettle();
      await tester.tap(find.text('Add'));
      await tester.pumpAndSettle();

      final containers = appController
          .state
          .selectedCharacterSheet!
          .equipment
          .items
          .where((item) => item.isContainer)
          .toList(growable: false);

      expect(containers, hasLength(1));
      expect(containers.single.name, 'New Spell Pouch');
      expect(containers.single.id, contains('container-'));
    },
  );
}

CreateCharacterInput _createCharacterInput({
  required String name,
  required List<String> items,
  CharacterSpellStateInput spellState = const CharacterSpellStateInput(
    selectionMode: CharacterSpellSelectionMode.spellbook,
    selectedSpells: <CharacterSpellSelectionInput>[],
    slotUsages: <CharacterSpellSlotUsageInput>[],
  ),
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
    className: 'Fighter',
    level: 2,
    experience: 300,
    equipmentLoadoutId: 'fighter-kit',
    equipmentLoadoutLabel: 'Starter kit',
    startingMoneySummary: '0 gp',
    selectedEquipmentItems: items,
    currentHitPoints: 12,
    maximumHitPoints: 12,
    temporaryHitPoints: 0,
    spellState: spellState,
    finishingDetails: CharacterFinishingDetailsInput.empty(),
  );
}

CompendiumCatalog _buildCatalog() {
  return CompendiumCatalog(
    races: const <String>['Human'],
    classes: const <String>['Fighter'],
    backgrounds: const <CompendiumBackground>[
      CompendiumBackground(
        id: 'acolyte',
        name: 'Acolyte',
        summary: 'Temple acolyte',
        bonuses: <String>['Skills: Insight, Religion'],
        socialPerks: <String>['Shelter of the Faithful'],
      ),
    ],
    narrativeOptionGroups: const <CompendiumNarrativeOptionGroup>[],
    generatedAbilityScoreSet: const <int>[15, 14, 13, 12, 10, 8],
    manualAbilityScoreOptions: const <int>[8, 9, 10, 11, 12, 13, 14, 15],
    characterAdvancement: const <CharacterAdvancementEntry>[
      CharacterAdvancementEntry(
        level: 1,
        experience: 0,
        proficiencyBonus: '+2',
      ),
      CharacterAdvancementEntry(
        level: 2,
        experience: 300,
        proficiencyBonus: '+2',
      ),
    ],
    standardArrayByClass: const <StandardArrayByClassEntry>[
      StandardArrayByClassEntry(
        classId: 'fighter',
        className: 'Fighter',
        strength: 15,
        dexterity: 13,
        constitution: 14,
        intelligence: 8,
        wisdom: 10,
        charisma: 12,
      ),
    ],
    spells: const <CompendiumSpell>[],
    feats: const <CompendiumFeat>[],
    monsters: const <CompendiumMonster>[],
    equipmentSummariesByClass: const <String, EquipmentSummaryViewData>{
      'Fighter': EquipmentSummaryViewData(
        statusLabel: 'MVP minimal',
        description: 'Equipment summary',
        highlightItems: <String>['Torch'],
      ),
    },
    equipmentLoadoutsByClass: const <String, List<CompendiumEquipmentLoadout>>{
      'Fighter': <CompendiumEquipmentLoadout>[
        CompendiumEquipmentLoadout(
          id: 'fighter-kit',
          label: 'Starter kit',
          startingMoneySummary: '0 gp',
          selectedItems: <String>['Torch'],
        ),
      ],
    },
  );
}
