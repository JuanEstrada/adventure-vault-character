import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_finishing_details.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:adventure_vault_character/src/features/characters/domain/equipment_summary_view_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'read domain derives gameplay and formatting values outside widgets',
    () {
      const character = CharacterDomainModel(
        id: 'character-1',
        identity: CharacterIdentityDomainModel(
          name: 'Meris',
          raceName: 'Elf',
          className: 'Wizard',
          progression: CharacterProgressionDomainModel(
            level: 5,
            experience: 8000,
          ),
        ),
        combat: CharacterCombatDomainModel(
          hitPoints: CharacterHitPointsDomainModel(
            current: 28,
            maximum: 28,
            temporary: 3,
          ),
          savingThrows: <CharacterSavingThrowDomainModel>[
            CharacterSavingThrowDomainModel(
              abilityKey: 'wisdom',
              bonus: 6,
              isProficient: true,
            ),
          ],
          classResources: <CharacterClassResourceDomainModel>[],
        ),
        abilities: CharacterAbilitiesDomainModel(
          methodKey: 'generatedSetAssignment',
          entries: <CharacterAbilityScoreDomainModel>[
            CharacterAbilityScoreDomainModel(label: 'Strength', score: 8),
            CharacterAbilityScoreDomainModel(label: 'Dexterity', score: 12),
            CharacterAbilityScoreDomainModel(label: 'Constitution', score: 13),
            CharacterAbilityScoreDomainModel(label: 'Intelligence', score: 15),
            CharacterAbilityScoreDomainModel(label: 'Wisdom', score: 14),
            CharacterAbilityScoreDomainModel(label: 'Charisma', score: 10),
          ],
        ),
        featuresNotes: CharacterFeaturesNotesDomainModel(
          background: CharacterBackgroundDomainModel(
            name: 'Acolyte',
            summary: 'Temple acolyte',
            bonuses: <CharacterBackgroundEntryDomainModel>[
              CharacterBackgroundEntryDomainModel(
                label: 'Skills',
                description: 'Insight, Religion',
              ),
            ],
            socialPerks: <CharacterBackgroundEntryDomainModel>[
              CharacterBackgroundEntryDomainModel(
                label: 'Shelter of the Faithful',
                description: '',
              ),
            ],
          ),
          proficientSkills: <CharacterSkillDomainModel>[
            CharacterSkillDomainModel(
              name: 'Arcana',
              isProficient: true,
              hasExpertise: false,
            ),
            CharacterSkillDomainModel(
              name: 'History',
              isProficient: true,
              hasExpertise: true,
            ),
          ],
          otherProficiencies: <CharacterProficiencyDomainModel>[
            CharacterProficiencyDomainModel(
              proficiencyType: 'weapon',
              referenceKey: 'simple-weapons',
            ),
            CharacterProficiencyDomainModel(
              proficiencyType: 'weapon',
              referenceKey: 'simple-weapons',
            ),
          ],
          finishingDetails: CharacterFinishingDetailsDomainModel(
            portraitAssetPath: null,
            appearanceDetails: 'Tall and quiet',
            narrativeNotes: 'Keeps careful notes.',
            narrativeSelections: <CharacterNarrativeSelectionDomainModel>[
              CharacterNarrativeSelectionDomainModel(
                fieldKey: NarrativeFieldKey.alignment,
                mode: NarrativeSelectionMode.manual,
                valueText: 'Neutral',
              ),
            ],
          ),
        ),
        equipment: CharacterEquipmentDomainModel(
          equipmentSummary: EquipmentSummaryViewData(
            statusLabel: 'MVP minimal',
            description: 'Equipment summary',
            highlightItems: <String>['Quarterstaff'],
          ),
          selectedEquipmentLabel: 'Arcane focus kit',
          money: CharacterMoneySummaryDomainModel(
            currencySummary: '15 gp, 4 sp',
            startingMoneySummary: '15 gp, 4 sp',
          ),
          items: <CharacterEquipmentItemDomainModel>[
            CharacterEquipmentItemDomainModel(
              id: 'item-1',
              name: 'Quarterstaff',
              quantity: 1,
              isEquipped: true,
              isCarried: true,
              isFavorite: false,
              weightPerUnit: 4,
            ),
            CharacterEquipmentItemDomainModel(
              id: 'item-2',
              name: 'Torch',
              quantity: 3,
              isEquipped: false,
              isCarried: true,
              isFavorite: false,
              weightPerUnit: 1,
            ),
          ],
          carrying: CharacterCarryingDomainModel(
            carriedWeight: 7,
            coinWeight: 0,
            totalWeight: 7,
            capacity: 150,
            encumberedThreshold: 50,
            heavilyEncumberedThreshold: 100,
            includeCoinWeight: false,
            tier: 'normal',
            tierLabel: 'Normal',
            tierDescription: 'No encumbrance penalties.',
          ),
        ),
        spellcasting: CharacterSpellcastingDomainModel(
          abilityKey: 'INT',
          abilityLabel: 'Intelligence',
          abilityScore: 15,
          proficiencyBonus: 3,
          selectionMode: CharacterSpellSelectionMode.spellbook,
          selectedSpells: <CharacterSpellReferenceDomainModel>[
            CharacterSpellReferenceDomainModel(
              id: 'magic-missile',
              name: 'Magic Missile',
              level: 1,
              school: 'Evocation',
              castingTime: '1 action',
              range: '120 feet',
              duration: 'Instantaneous',
              source: 'SRD',
            ),
          ],
          slotProgression: <CharacterSpellSlotDomainModel>[
            CharacterSpellSlotDomainModel(
              spellLevel: 1,
              slotsExpended: 1,
              slotsMax: 4,
            ),
          ],
          availableSpells: <CharacterSpellReferenceDomainModel>[
            CharacterSpellReferenceDomainModel(
              id: 'mage-hand',
              name: 'Mage Hand',
              level: 0,
              school: 'Conjuration',
              castingTime: '1 action',
              range: '30 feet',
              duration: '1 minute',
              source: 'SRD',
            ),
            CharacterSpellReferenceDomainModel(
              id: 'magic-missile',
              name: 'Magic Missile',
              level: 1,
              school: 'Evocation',
              castingTime: '1 action',
              range: '120 feet',
              duration: 'Instantaneous',
              source: 'SRD',
            ),
          ],
        ),
      );

      expect(character.identity.progression.proficiencyBonus, 3);
      expect(character.identity.progression.levelProgressPercent, 20);
      expect(character.combat.savingThrows.first.displayLabel, 'Wisdom');
      expect(character.combat.savingThrows.first.displayBonus, '+6');
      expect(character.abilities.methodLabel, 'Generated set assignment');
      expect(character.abilities.entries[3].modifier, 2);
      expect(character.featuresNotes.background.name, 'Acolyte');
      expect(character.featuresNotes.background.bonusDescriptions, <String>[
        'Skills: Insight, Religion',
      ]);
      expect(character.featuresNotes.proficientSkillLabels, <String>[
        'Arcana',
        'History (expertise)',
      ]);
      expect(character.featuresNotes.otherProficiencyLabels, <String>[
        'Weapon: Simple Weapons',
      ]);
      expect(character.spellcasting, isNotNull);
      expect(character.spellcasting!.displayAbilityModifier, '+2');
      expect(character.spellcasting!.spellSaveDc, 13);
      expect(character.spellcasting!.displaySpellAttackBonus, '+5');
      expect(character.spellcasting!.selectionLabel, 'Prepared spells');
      expect(
        character.spellcasting!.slotProgression.single.displaySummary,
        '3 / 4',
      );
      expect(
        character.spellcasting!.spellsByLevel.map((item) => item.label),
        <String>['Cantrips', 'Level 1'],
      );
      expect(character.equipment.visibleItems, <String>[
        'Quarterstaff (equipped)',
        'Torch x3',
      ]);
    },
  );
}
