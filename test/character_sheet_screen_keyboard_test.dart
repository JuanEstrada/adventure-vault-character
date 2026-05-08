import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:adventure_vault_character/src/features/characters/domain/equipment_summary_view_data.dart';
import 'package:adventure_vault_character/src/features/characters/presentation/character_sheet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('character sheet supports keyboard focus traversal', (
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
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);

    final editButton = find.text('Edit');
    expect(editButton, findsOneWidget);

    await tester.tap(editButton);
    await tester.pumpAndSettle();

    final firstFocus = FocusManager.instance.primaryFocus;
    expect(firstFocus != null, isTrue);

    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pumpAndSettle();

    final secondFocus = FocusManager.instance.primaryFocus;
    expect(secondFocus != null, isTrue);
    expect(secondFocus, isNot(same(firstFocus)));

    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pumpAndSettle();

    final thirdFocus = FocusManager.instance.primaryFocus;
    expect(thirdFocus != null, isTrue);
    expect(thirdFocus, isNot(same(secondFocus)));
    expect(tester.takeException(), isNull);
  });
}

CharacterDomainModel _buildCharacter() {
  return const CharacterDomainModel(
    id: 'character-keyboard-focus',
    identity: CharacterIdentityDomainModel(
      name: 'Test Character',
      raceName: 'Human',
      className: 'Fighter',
      progression: CharacterProgressionDomainModel(level: 1, experience: 0),
    ),
    combat: CharacterCombatDomainModel(
      hitPoints: CharacterHitPointsDomainModel(
        current: 10,
        maximum: 10,
        temporary: 0,
      ),
      savingThrows: <CharacterSavingThrowDomainModel>[],
      classResources: <CharacterClassResourceDomainModel>[],
      weaponAttacks: <CharacterWeaponAttackDomainModel>[],
    ),
    abilities: CharacterAbilitiesDomainModel(
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
    featuresNotes: CharacterFeaturesNotesDomainModel(
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
      equipmentSummary: EquipmentSummaryViewData(
        statusLabel: '',
        description: '',
        highlightItems: <String>[],
      ),
      selectedEquipmentLabel: '',
      money: CharacterMoneySummaryDomainModel(
        currencySummary: '',
        startingMoneySummary: '',
      ),
      items: <CharacterEquipmentItemDomainModel>[],
      carrying: CharacterCarryingDomainModel(
        carriedWeight: 0,
        coinWeight: 0,
        totalWeight: 0,
        capacity: 0,
        encumberedThreshold: 0,
        heavilyEncumberedThreshold: 0,
        includeCoinWeight: false,
        tier: '',
        tierLabel: '',
        tierDescription: '',
      ),
    ),
    spellcasting: null,
  );
}
