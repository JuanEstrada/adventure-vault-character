import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:adventure_vault_character/src/features/characters/domain/equipment_summary_view_data.dart';
import 'package:adventure_vault_character/src/features/characters/presentation/character_sheet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Restore passes the slotIndex of a higher-level spell slot', (
    WidgetTester tester,
  ) async {
    int? restoredSpellLevel;
    int? restoredSlotIndex;

    final character = CharacterDomainModel(
      id: 'character-spell-slot-restore',
      identity: CharacterIdentityDomainModel(
        name: 'Meris',
        raceName: 'Elf',
        className: 'Wizard',
        progression: CharacterProgressionDomainModel(level: 9, experience: 0),
      ),
      combat: CharacterCombatDomainModel(
        hitPoints: CharacterHitPointsDomainModel(
          current: 28,
          maximum: 28,
          temporary: 0,
        ),
        savingThrows: <CharacterSavingThrowDomainModel>[],
        classResources: <CharacterClassResourceDomainModel>[],
      ),
      abilities: CharacterAbilitiesDomainModel(
        methodKey: null,
        entries: <CharacterAbilityScoreDomainModel>[
          CharacterAbilityScoreDomainModel(label: 'Strength', score: 10),
          CharacterAbilityScoreDomainModel(label: 'Dexterity', score: 10),
          CharacterAbilityScoreDomainModel(label: 'Constitution', score: 10),
          CharacterAbilityScoreDomainModel(label: 'Intelligence', score: 18),
          CharacterAbilityScoreDomainModel(label: 'Wisdom', score: 12),
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
      spellcasting: CharacterSpellcastingDomainModel(
        abilityKey: 'INT',
        abilityLabel: 'Intelligence',
        abilityScore: 18,
        proficiencyBonus: 4,
        selectionMode: CharacterSpellSelectionMode.spellbook,
        selectedSpells: <CharacterSpellReferenceDomainModel>[],
        slotProgression: <CharacterSpellSlotDomainModel>[
          const CharacterSpellSlotDomainModel(
            spellLevel: 1,
            slotIndex: 0,
            slotsExpended: 0,
            slotsMax: 4,
          ),
          const CharacterSpellSlotDomainModel(
            spellLevel: 5,
            slotIndex: 4,
            slotsExpended: 1,
            slotsMax: 2,
          ),
        ],
        availableSpells: <CharacterSpellReferenceDomainModel>[],
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: CharacterSheetScreen(
          character: character,
          isApplyingRest: false,
          errorMessage: null,
          onBack: () {},
          onEdit: () {},
          onApplyShortRest: () async {},
          onApplyLongRest: () async {},
          onSpendSpellSlot:
              ({required int spellLevel, required int slotIndex}) async {},
          onRestoreSpellSlot:
              ({required int spellLevel, required int slotIndex}) async {
                restoredSpellLevel = spellLevel;
                restoredSlotIndex = slotIndex;
              },
          onSetClassResourceUses: (resourceKey, currentUses) async {},
          onRecordDeathSaveSuccess: () async {},
          onRecordDeathSaveFailure: () async {},
          onResetDeathSaves: () async {},
          onSetInventoryItemEquipped: (itemId, isEquipped) async {},
          onSetInventoryItemCarried: (itemId, isCarried) async {},
          onSetInventoryItemQuantity: (itemId, quantity) async {},
          onSpendInventoryItemQuantity: (itemId, {int amount = 1}) async {},
          onSetInventoryItemCharges:
              (itemId, {chargesCurrent, chargesMax}) async {},
          onSetInventoryItemContainer:
              (itemId, containerInventoryItemId) async {},
        ),
      ),
    );

    await tester.pumpAndSettle();
    await tester.dragUntilVisible(
      find.text('Restore'),
      find.descendant(
        of: find.byType(ListView),
        matching: find.byType(Scrollable),
      ),
      const Offset(0, -300),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Restore'));
    await tester.pumpAndSettle();

    expect(restoredSpellLevel, 5);
    expect(restoredSlotIndex, 4);
  });
}
