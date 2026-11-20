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
  testWidgets('CharacterSheetScreen rename-container action wires to the real '
      'mutation path', (WidgetTester tester) async {
    final compendiumRepository = InMemoryCompendiumRepository(_buildCatalog());
    final characterRepository = InMemoryCharacterRepository.empty(
      compendiumRepository: compendiumRepository,
    );
    final createdCharacter = await characterRepository.createCharacter(
      _createCharacterInput(
        name: 'Rename Container Character',
        items: <String>['Backpack', 'Torch'],
      ),
    );
    final appController = AppController(
      characterRepository: characterRepository,
      compendiumRepository: compendiumRepository,
      systemSettingsRepository: InMemorySystemSettingsRepository(),
    );

    addTearDown(appController.dispose);
    await appController.initialize();
    await appController.openCharacter(createdCharacter.id);

    final sheetBefore = appController.state.selectedCharacterSheet!;
    final torch = sheetBefore.equipment.items.singleWhere(
      (item) => item.name == 'Torch',
    );
    final containerId = await appController.createContainer(
      createdCharacter.id,
      'Spell Pouch',
    );
    await appController.setSelectedCharacterInventoryItemContainer(
      torch.id,
      containerId,
    );
    await tester.pumpWidget(
      MaterialApp(
        home: AnimatedBuilder(
          animation: appController,
          builder: (context, _) {
            final selectedCharacter =
                appController.state.selectedCharacterSheet!;
            return CharacterSheetScreen(
              character: selectedCharacter,
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
              onSetInventoryItemEquipped:
                  (inventoryItemId, isEquipped) async {},
              onSetInventoryItemCarried: (inventoryItemId, isCarried) async {},
              onSetInventoryItemQuantity: (inventoryItemId, quantity) async {},
              onSpendInventoryItemQuantity:
                  (inventoryItemId, {int amount = 1}) async {},
              onSetInventoryItemCharges:
                  (inventoryItemId, {chargesCurrent, chargesMax}) async {},
              onSetInventoryItemContainer:
                  (inventoryItemId, containerInventoryItemId) async {},
              onDeleteContainer: appController.deleteContainer,
              onCreateContainer: appController.createContainer,
              onRenameContainer: appController.renameContainer,
            );
          },
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    final manageButton = tester.widget<OutlinedButton>(
      find.widgetWithText(OutlinedButton, 'Manage containers'),
    );
    expect(manageButton.onPressed, isNotNull);
    manageButton.onPressed!.call();
    await tester.pumpAndSettle();

    expect(find.text('Manage Containers'), findsOneWidget);
    expect(find.text('Spell Pouch'), findsWidgets);

    await tester.tap(find.byKey(Key('SelectContainer-$containerId')));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('New container name')),
      '  Gem Pouch  ',
    );
    await tester.tap(find.byKey(const Key('Rename container')));
    await tester.pumpAndSettle();

    // A successful rename dismisses the dialog and refreshes the sheet
    // through the controller mutation path.
    expect(find.text('Manage Containers'), findsNothing);
    final renamedSheet = appController.state.selectedCharacterSheet!;
    final renamedContainer = renamedSheet.equipment.items.singleWhere(
      (item) => item.id == containerId,
    );
    expect(renamedContainer.name, 'Gem Pouch');
    expect(renamedContainer.isContainer, isTrue);
    final relocatedTorch = renamedSheet.equipment.items.singleWhere(
      (item) => item.id == torch.id,
    );
    expect(relocatedTorch.containerInventoryItemId, containerId);
    expect(relocatedTorch.containerDisplayName, 'Gem Pouch');
    expect(
      renamedSheet.equipment.items
          .singleWhere((item) => item.name == 'Backpack')
          .name,
      'Backpack',
    );
    expect(appController.state.errorMessage, isNull);

    // The renamed label survives a reload/reopen of the character.
    await appController.openCharacter(createdCharacter.id);
    await tester.pumpAndSettle();
    final reopenedSheet = appController.state.selectedCharacterSheet!;
    expect(
      reopenedSheet.equipment.items
          .singleWhere((item) => item.id == containerId)
          .name,
      'Gem Pouch',
    );
    expect(
      reopenedSheet.equipment.items
          .singleWhere((item) => item.id == torch.id)
          .containerDisplayName,
      'Gem Pouch',
    );

    final persistedSheet = await characterRepository.getCharacterSheetById(
      createdCharacter.id,
    );
    expect(persistedSheet, isNotNull);
    expect(
      persistedSheet!.equipment.items
          .singleWhere((item) => item.id == containerId)
          .name,
      'Gem Pouch',
    );
  });
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
