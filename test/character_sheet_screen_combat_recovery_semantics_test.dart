import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:adventure_vault_character/src/features/characters/domain/equipment_summary_view_data.dart';
import 'package:adventure_vault_character/src/features/characters/presentation/character_sheet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('combat and recovery controls have semantics labels', (
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
      expect(find.bySemanticsLabel('Attacks'), findsWidgets);
      expect(find.bySemanticsLabel('Death Saves'), findsWidgets);
      expect(find.bySemanticsLabel('Recovery'), findsWidgets);
      expect(find.bySemanticsLabel('Session recovery'), findsWidgets);
      expect(find.bySemanticsLabel('Class resources'), findsWidgets);
      expect(find.bySemanticsLabel('Saving Throws'), findsWidgets);

      expect(find.bySemanticsLabel('Record death save success'), findsWidgets);
      expect(find.bySemanticsLabel('Record death save failure'), findsWidgets);
      expect(find.bySemanticsLabel('Reset death saves'), findsWidgets);
      expect(find.bySemanticsLabel('Apply short rest'), findsWidgets);
      expect(find.bySemanticsLabel('Apply long rest'), findsWidgets);
      expect(find.bySemanticsLabel('Spend use'), findsWidgets);
      expect(find.bySemanticsLabel('Restore use'), findsWidgets);
    } finally {
      semanticsHandle.dispose();
    }
  });
}

CharacterDomainModel _buildCharacter() {
  return CharacterDomainModel(
    id: 'character-combat-recovery-semantics-test',
    identity: const CharacterIdentityDomainModel(
      name: 'Aldric',
      raceName: 'Human',
      className: 'Fighter',
      progression: CharacterProgressionDomainModel(level: 1, experience: 1000),
    ),
    combat: CharacterCombatDomainModel(
      hitPoints: const CharacterHitPointsDomainModel(
        current: 10,
        maximum: 10,
        temporary: 0,
      ),
      savingThrows: const <CharacterSavingThrowDomainModel>[
        CharacterSavingThrowDomainModel(
          abilityKey: 'strength',
          bonus: 3,
          isProficient: true,
        ),
      ],
      classResources: <CharacterClassResourceDomainModel>[
        CharacterClassResourceDomainModel(
          resourceKey: 'rage',
          label: 'Rage',
          currentUses: 1,
          maximumUses: 2,
          recoversOnShortRest: true,
          lastChangedSource: 'seed',
          lastChangedAt: DateTime.utc(2025, 1, 1, 12),
        ),
      ],
      deathSaves: const CharacterDeathSaveStateDomainModel(
        successCount: 1,
        failureCount: 0,
      ),
      weaponAttacks: const <CharacterWeaponAttackDomainModel>[],
      armorClass: 15,
      initiativeModifier: 2,
    ),
    abilities: CharacterAbilitiesDomainModel(
      methodKey: null,
      entries: const <CharacterAbilityScoreDomainModel>[
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
      equipmentSummary: EquipmentSummaryViewData(
        statusLabel: '',
        description: '',
        highlightItems: <String>[],
      ),
      selectedEquipmentLabel: '',
      money: const CharacterMoneySummaryDomainModel(
        currencySummary: '',
        startingMoneySummary: '',
      ),
      items: <CharacterEquipmentItemDomainModel>[],
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
      abilityKey: 'wis',
      abilityLabel: 'Wisdom',
      abilityScore: 14,
      proficiencyBonus: 2,
      availableSpells: const <CharacterSpellReferenceDomainModel>[
        CharacterSpellReferenceDomainModel(
          id: 'cure-wounds',
          name: 'Cure Wounds',
          level: 1,
          school: 'evocation',
          castingTime: '1 action',
          range: 'Touch',
          duration: 'Instantaneous',
          source: 'PHB',
        ),
      ],
      selectionMode: CharacterSpellSelectionMode.known,
      selectedSpells: const <CharacterSpellReferenceDomainModel>[],
      slotProgression: const <CharacterSpellSlotDomainModel>[
        CharacterSpellSlotDomainModel(
          spellLevel: 1,
          slotIndex: 0,
          slotsExpended: 0,
          slotsMax: 2,
        ),
      ],
      selectionLimit: 1,
    ),
  );
}
