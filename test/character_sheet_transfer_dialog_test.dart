import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:adventure_vault_character/src/features/characters/domain/equipment_summary_view_data.dart';
import 'package:adventure_vault_character/src/features/characters/presentation/character_sheet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('transfer dialog opens with source item and container choices', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: CharacterSheetScreen(
          character: _buildCharacter(),
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
          onTransferToContainer:
              (sourceItemId, targetContainerId, quantity) async {},
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    await tester.dragUntilVisible(
      find.text('Torch'),
      find.byType(ListView),
      const Offset(0, -300),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Transfer to container'));
    await tester.pumpAndSettle();

    expect(find.text('Transfer to Container'), findsOneWidget);
    expect(find.text('Transfer from: Torch (3)'), findsOneWidget);
    expect(find.text('Select container:'), findsOneWidget);
    expect(find.text('Backpack'), findsWidgets);
    expect(find.textContaining('After: 0'), findsOneWidget);
  });

  testWidgets('transfer dialog validates container selection and quantity', (
    WidgetTester tester,
  ) async {
    final transfers =
        <({String sourceItemId, String targetContainerId, int quantity})>[];

    await tester.pumpWidget(
      MaterialApp(
        home: CharacterSheetScreen(
          character: _buildCharacter(),
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
          onTransferToContainer:
              (sourceItemId, targetContainerId, quantity) async {
                transfers.add((
                  sourceItemId: sourceItemId,
                  targetContainerId: targetContainerId,
                  quantity: quantity,
                ));
              },
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    await tester.dragUntilVisible(
      find.text('Torch'),
      find.byType(ListView),
      const Offset(0, -300),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Transfer to container'));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ElevatedButton, 'Transfer'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Please select a container'), findsWidgets);
    expect(transfers, isEmpty);

    await tester.tap(find.widgetWithText(ChoiceChip, 'Backpack'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '2');
    await tester.pumpAndSettle();

    expect(find.bySemanticsLabel('After: 1'), findsOneWidget);

    await tester.tap(find.widgetWithText(ElevatedButton, 'Transfer'));
    await tester.pumpAndSettle();

    expect(transfers, hasLength(1));
    expect(transfers.single.sourceItemId, 'torch');
    expect(transfers.single.targetContainerId, 'backpack');
    expect(transfers.single.quantity, 2);
    expect(find.text('Transfer to Container'), findsNothing);
  });
}

CharacterDomainModel _buildCharacter() {
  return CharacterDomainModel(
    id: 'character-transfer-dialog',
    identity: const CharacterIdentityDomainModel(
      name: 'Aldric',
      raceName: 'Human',
      className: 'Fighter',
      progression: CharacterProgressionDomainModel(level: 1, experience: 1000),
    ),
    combat: const CharacterCombatDomainModel(
      hitPoints: CharacterHitPointsDomainModel(
        current: 10,
        maximum: 10,
        temporary: 0,
      ),
      savingThrows: <CharacterSavingThrowDomainModel>[],
      classResources: <CharacterClassResourceDomainModel>[],
      weaponAttacks: <CharacterWeaponAttackDomainModel>[],
    ),
    abilities: const CharacterAbilitiesDomainModel(
      methodKey: null,
      entries: <CharacterAbilityScoreDomainModel>[
        CharacterAbilityScoreDomainModel(label: 'Strength', score: 10),
        CharacterAbilityScoreDomainModel(label: 'Dexterity', score: 10),
        CharacterAbilityScoreDomainModel(label: 'Constitution', score: 10),
        CharacterAbilityScoreDomainModel(label: 'Intelligence', score: 10),
        CharacterAbilityScoreDomainModel(label: 'Wisdom', score: 10),
        CharacterAbilityScoreDomainModel(label: 'Charisma', score: 10),
      ],
    ),
    featuresNotes: const CharacterFeaturesNotesDomainModel(
      background: CharacterBackgroundDomainModel(
        name: '',
        summary: '',
        bonuses: <CharacterBackgroundEntryDomainModel>[],
        socialPerks: <CharacterBackgroundEntryDomainModel>[],
      ),
      proficientSkills: <CharacterSkillDomainModel>[],
      skills: <CharacterSkillDomainModel>[],
      otherProficiencies: <CharacterProficiencyDomainModel>[],
      finishingDetails: CharacterFinishingDetailsDomainModel(
        portraitAssetPath: null,
        appearanceDetails: '',
        narrativeNotes: '',
        narrativeSelections: <CharacterNarrativeSelectionDomainModel>[],
      ),
    ),
    equipment: CharacterEquipmentDomainModel(
      equipmentSummary: const EquipmentSummaryViewData(
        statusLabel: '',
        description: 'Inventory ready.',
        highlightItems: <String>[],
      ),
      selectedEquipmentLabel: '',
      money: const CharacterMoneySummaryDomainModel(
        currencySummary: '',
        startingMoneySummary: '',
      ),
      items: <CharacterEquipmentItemDomainModel>[
        const CharacterEquipmentItemDomainModel(
          id: 'backpack',
          name: 'Backpack',
          quantity: 1,
          isEquipped: false,
          isCarried: true,
          isFavorite: false,
          weightPerUnit: 5,
          isContainer: true,
          chargesCurrent: null,
          chargesMax: null,
          containerInventoryItemId: null,
          containerDisplayName: null,
        ),
        const CharacterEquipmentItemDomainModel(
          id: 'torch',
          name: 'Torch',
          quantity: 3,
          isEquipped: false,
          isCarried: true,
          isFavorite: false,
          weightPerUnit: 1,
          isContainer: false,
          chargesCurrent: null,
          chargesMax: null,
          containerInventoryItemId: null,
          containerDisplayName: null,
        ),
      ],
      carrying: const CharacterCarryingDomainModel(
        carriedWeight: 8,
        coinWeight: 0,
        totalWeight: 8,
        capacity: 150,
        encumberedThreshold: 50,
        heavilyEncumberedThreshold: 100,
        includeCoinWeight: false,
        tier: 'normal',
        tierLabel: 'Normal',
        tierDescription: 'No encumbrance penalties.',
      ),
    ),
    spellcasting: null,
  );
}
