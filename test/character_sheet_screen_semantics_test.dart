import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:adventure_vault_character/src/features/characters/domain/equipment_summary_view_data.dart';
import 'package:adventure_vault_character/src/features/characters/presentation/character_sheet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'character sheet app bar and identity header have semantics labels',
    (WidgetTester tester) async {
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
        expect(find.bySemanticsLabel('Back'), findsOneWidget);
        expect(find.bySemanticsLabel('Edit character'), findsOneWidget);
        expect(find.bySemanticsLabel('Aldric'), findsWidgets);
        expect(
          find.bySemanticsLabel('Aldric, Human Fighter Level 1'),
          findsOneWidget,
        );
        expect(
          find.bySemanticsLabel(
            'Race: Human, Class: Fighter, Level: 1, XP: 1000',
          ),
          findsOneWidget,
        );
      } finally {
        semanticsHandle.dispose();
      }
    },
  );
}

CharacterDomainModel _buildCharacter() {
  return const CharacterDomainModel(
    id: 'character-semantics-test',
    identity: CharacterIdentityDomainModel(
      name: 'Aldric',
      raceName: 'Human',
      className: 'Fighter',
      progression: CharacterProgressionDomainModel(level: 1, experience: 1000),
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
