import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_finishing_details.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:adventure_vault_character/src/features/characters/domain/equipment_summary_view_data.dart';
import 'package:adventure_vault_character/src/features/characters/presentation/character_sheet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('character sheet stays usable with partial missing data', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: CharacterSheetScreen(
          character: const CharacterDomainModel(
            id: 'character-partial',
            identity: CharacterIdentityDomainModel(
              name: '',
              raceName: '',
              className: '',
              progression: CharacterProgressionDomainModel(
                level: 1,
                experience: 0,
              ),
            ),
            combat: CharacterCombatDomainModel(
              hitPoints: CharacterHitPointsDomainModel(
                current: 0,
                maximum: 0,
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
                CharacterAbilityScoreDomainModel(
                  label: 'Constitution',
                  score: 10,
                ),
                CharacterAbilityScoreDomainModel(
                  label: 'Intelligence',
                  score: 10,
                ),
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
              otherProficiencies: <CharacterProficiencyDomainModel>[],
              finishingDetails: CharacterFinishingDetailsDomainModel(
                portraitAssetPath: null,
                appearanceDetails: '',
                narrativeNotes: '',
                narrativeSelections: const <CharacterNarrativeSelectionDomainModel>[
                  CharacterNarrativeSelectionDomainModel(
                    fieldKey: NarrativeFieldKey.alignment,
                    mode: NarrativeSelectionMode.empty,
                    valueText: null,
                  ),
                  CharacterNarrativeSelectionDomainModel(
                    fieldKey: NarrativeFieldKey.faction,
                    mode: NarrativeSelectionMode.empty,
                    valueText: null,
                  ),
                  CharacterNarrativeSelectionDomainModel(
                    fieldKey: NarrativeFieldKey.personalityTraits,
                    mode: NarrativeSelectionMode.empty,
                    valueText: null,
                  ),
                  CharacterNarrativeSelectionDomainModel(
                    fieldKey: NarrativeFieldKey.ideals,
                    mode: NarrativeSelectionMode.empty,
                    valueText: null,
                  ),
                  CharacterNarrativeSelectionDomainModel(
                    fieldKey: NarrativeFieldKey.bonds,
                    mode: NarrativeSelectionMode.empty,
                    valueText: null,
                  ),
                  CharacterNarrativeSelectionDomainModel(
                    fieldKey: NarrativeFieldKey.flaws,
                    mode: NarrativeSelectionMode.empty,
                    valueText: null,
                  ),
                ],
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
          ),
          isApplyingRest: false,
          errorMessage: null,
          onBack: () {},
          onEdit: () {},
          onApplyShortRest: () async {},
          onApplyLongRest: () async {},
          onSpendSpellSlot: ({required int spellLevel, required int slotIndex}) async {},
          onRestoreSpellSlot: ({required int spellLevel, required int slotIndex}) async {},
          onSetClassResourceUses: (resourceKey, currentUses) async {},
          onRecordDeathSaveSuccess: () async {},
          onRecordDeathSaveFailure: () async {},
          onResetDeathSaves: () async {},
          onSetInventoryItemEquipped: (inventoryItemId, isEquipped) async {},
          onSetInventoryItemCarried: (inventoryItemId, isCarried) async {},
          onSetInventoryItemQuantity: (inventoryItemId, quantity) async {},
          onSpendInventoryItemQuantity: (inventoryItemId, {int amount = 1}) async {},
          onSetInventoryItemCharges: (
            inventoryItemId, {
            chargesCurrent,
            chargesMax,
          }) async {},
          onSetInventoryItemContainer: (
            inventoryItemId,
            containerInventoryItemId,
          ) async {},
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('Unnamed character'), findsWidgets);
    expect(find.textContaining('Unknown race'), findsWidgets);
    expect(find.textContaining('Unknown class'), findsWidgets);
    expect(find.text('Background unavailable'), findsOneWidget);
    expect(find.text('No background bonuses recorded.'), findsOneWidget);
    expect(find.text('No social perks recorded.'), findsOneWidget);
    expect(find.text('No finishing details recorded.'), findsOneWidget);
    expect(find.text('Not recorded'), findsNWidgets(2));
    expect(find.text('Equipment loadout unavailable'), findsOneWidget);
    expect(find.text('No equipment summary available.'), findsOneWidget);
  });
}
