import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_sheet_mapper.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_sheet_view_data.dart';
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
          alignment: 'Neutral',
          appearanceDetails: 'Tall and quiet',
          narrativeDetails: 'Keeps careful notes.',
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
              name: 'Quarterstaff',
              quantity: 1,
              isEquipped: true,
            ),
            CharacterEquipmentItemDomainModel(
              name: 'Torch',
              quantity: 3,
              isEquipped: false,
            ),
          ],
        ),
      );

      const mapper = CharacterSheetMapper();
      final sheet = mapper.map(character);

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
      expect(character.equipment.visibleItems, <String>[
        'Quarterstaff (equipped)',
        'Torch x3',
      ]);
      expect(sheet.identity.proficiencyBonus, 3);
      expect(sheet.abilities.abilityRows[3].modifier, 2);
      expect(sheet.featuresNotes.backgroundBonuses, <String>[
        'Skills: Insight, Religion',
      ]);
      expect(sheet.featuresNotes.proficientSkills, <String>[
        'Arcana',
        'History (expertise)',
      ]);
      expect(sheet.featuresNotes.otherProficiencies, <String>[
        'Weapon: Simple Weapons',
      ]);
      expect(sheet.equipment.selectedEquipmentItems, <String>[
        'Quarterstaff (equipped)',
        'Torch x3',
      ]);
    },
  );
}
