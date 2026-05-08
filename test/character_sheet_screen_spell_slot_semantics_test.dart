import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:adventure_vault_character/src/features/characters/domain/equipment_summary_view_data.dart';
import 'package:adventure_vault_character/src/features/characters/presentation/character_sheet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('spell slot controls have semantics labels', (
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

    final semanticsHandle = tester.ensureSemantics();
    try {
      expect(find.bySemanticsLabel('Spend slot 1'), findsOneWidget);
      expect(find.bySemanticsLabel('Restore slot 1'), findsOneWidget);
      expect(find.bySemanticsLabel('Spend slot 2'), findsOneWidget);
      expect(
        find.bySemanticsLabel('Mage Hand (conjuration, 1 action)'),
        findsOneWidget,
      );
      expect(find.bySemanticsLabel('Decrease quantity'), findsWidgets);
      expect(find.bySemanticsLabel('Increase quantity'), findsWidgets);
      expect(find.bySemanticsLabel('Spend 1'), findsOneWidget);
      expect(find.bySemanticsLabel('Toggle equipped'), findsWidgets);
      expect(find.bySemanticsLabel('Toggle carried'), findsWidgets);
      expect(find.bySemanticsLabel('Clear charges'), findsOneWidget);
      expect(find.bySemanticsLabel('Track charges'), findsWidgets);
      expect(find.bySemanticsLabel('Decrease charges'), findsOneWidget);
      expect(find.bySemanticsLabel('Increase charges'), findsOneWidget);
      expect(find.bySemanticsLabel('Select container'), findsWidgets);
      expect(find.bySemanticsLabel('Split stack'), findsOneWidget);
      expect(find.bySemanticsLabel('Transfer to container'), findsOneWidget);
      expect(find.bySemanticsLabel('Merge with containers'), findsOneWidget);
    } finally {
      semanticsHandle.dispose();
    }
  });
}

CharacterDomainModel _buildCharacter() {
  return CharacterDomainModel(
    id: 'character-spell-slot-semantics-test',
    identity: const CharacterIdentityDomainModel(
      name: 'Aldric',
      raceName: 'Human',
      className: 'Wizard',
      progression: CharacterProgressionDomainModel(level: 3, experience: 900),
    ),
    combat: CharacterCombatDomainModel(
      hitPoints: const CharacterHitPointsDomainModel(
        current: 10,
        maximum: 10,
        temporary: 0,
      ),
      savingThrows: const <CharacterSavingThrowDomainModel>[],
      classResources: const <CharacterClassResourceDomainModel>[],
      deathSaves: const CharacterDeathSaveStateDomainModel(
        successCount: 0,
        failureCount: 0,
      ),
      weaponAttacks: const <CharacterWeaponAttackDomainModel>[],
      armorClass: 12,
      initiativeModifier: 2,
    ),
    abilities: CharacterAbilitiesDomainModel(
      methodKey: null,
      entries: const <CharacterAbilityScoreDomainModel>[
        CharacterAbilityScoreDomainModel(label: 'Strength', score: 8),
        CharacterAbilityScoreDomainModel(label: 'Dexterity', score: 14),
        CharacterAbilityScoreDomainModel(label: 'Constitution', score: 12),
        CharacterAbilityScoreDomainModel(label: 'Intelligence', score: 16),
        CharacterAbilityScoreDomainModel(label: 'Wisdom', score: 10),
        CharacterAbilityScoreDomainModel(label: 'Charisma', score: 10),
      ],
    ),
    featuresNotes: CharacterFeaturesNotesDomainModel(
      background: CharacterBackgroundDomainModel(
        name: '',
        summary: '',
        bonuses: const <CharacterBackgroundEntryDomainModel>[],
        socialPerks: const <CharacterBackgroundEntryDomainModel>[],
      ),
      proficientSkills: const <CharacterSkillDomainModel>[],
      skills: const <CharacterSkillDomainModel>[],
      otherProficiencies: const <CharacterProficiencyDomainModel>[],
      finishingDetails: CharacterFinishingDetailsDomainModel(
        portraitAssetPath: null,
        appearanceDetails: '',
        narrativeNotes: '',
        narrativeSelections: const <CharacterNarrativeSelectionDomainModel>[],
      ),
    ),
    equipment: CharacterEquipmentDomainModel(
      equipmentSummary: EquipmentSummaryViewData(
        statusLabel: '',
        description: '',
        highlightItems: const <String>[],
      ),
      selectedEquipmentLabel: '',
      money: const CharacterMoneySummaryDomainModel(
        currencySummary: '',
        startingMoneySummary: '',
      ),
      items: <CharacterEquipmentItemDomainModel>[
        CharacterEquipmentItemDomainModel(
          id: 'torch-1',
          name: 'Torch',
          quantity: 2,
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
        CharacterEquipmentItemDomainModel(
          id: 'wand-1',
          name: 'Wand',
          quantity: 1,
          isEquipped: true,
          isCarried: true,
          isFavorite: false,
          weightPerUnit: 1,
          isContainer: false,
          chargesCurrent: 1,
          chargesMax: 3,
          containerInventoryItemId: null,
          containerDisplayName: null,
        ),
        CharacterEquipmentItemDomainModel(
          id: 'backpack-1',
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
      ],
      carrying: const CharacterCarryingDomainModel(
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
    spellcasting: CharacterSpellcastingDomainModel(
      abilityKey: 'int',
      abilityLabel: 'Intelligence',
      abilityScore: 16,
      proficiencyBonus: 2,
      availableSpells: const <CharacterSpellReferenceDomainModel>[
        CharacterSpellReferenceDomainModel(
          id: 'mage-hand',
          name: 'Mage Hand',
          level: 0,
          school: 'conjuration',
          castingTime: '1 action',
          range: '30 feet',
          duration: '1 minute',
          source: 'PHB',
        ),
      ],
      selectionMode: CharacterSpellSelectionMode.known,
      selectedSpells: const <CharacterSpellReferenceDomainModel>[],
      slotProgression: const <CharacterSpellSlotDomainModel>[
        CharacterSpellSlotDomainModel(
          spellLevel: 1,
          slotIndex: 0,
          slotsExpended: 1,
          slotsMax: 2,
        ),
      ],
      selectionLimit: 1,
    ),
  );
}
