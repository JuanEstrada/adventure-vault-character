import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_sheet_view_data.dart';

class CharacterSheetMapper {
  const CharacterSheetMapper();

  CharacterSheetViewData map(CharacterDomainModel character) {
    final progression = character.identity.progression;
    final hitPoints = character.combat.hitPoints;
    final background = character.featuresNotes.background;
    final money = character.equipment.money;

    return CharacterSheetViewData(
      id: character.id,
      identity: IdentityPanelViewData(
        name: character.identity.name,
        raceName: character.identity.raceName,
        className: character.identity.className,
        level: progression.level,
        experience: progression.experience,
        proficiencyBonus: progression.proficiencyBonus,
        levelProgressPercent: progression.levelProgressPercent,
      ),
      combat: CombatPanelViewData(
        currentHitPoints: hitPoints.current,
        maximumHitPoints: hitPoints.maximum,
        temporaryHitPoints: hitPoints.temporary,
        savingThrows: character.combat.savingThrows
            .map(
              (item) => SavingThrowRowViewData(
                label: item.displayLabel,
                bonus: item.bonus,
                isProficient: item.isProficient,
              ),
            )
            .toList(growable: false),
      ),
      abilities: AbilitiesPanelViewData(
        abilityScoreMethodLabel: character.abilities.methodLabel,
        abilityRows: character.abilities.entries
            .map(
              (item) => AbilityScoreRowViewData(
                label: item.label,
                score: item.score,
                modifier: item.modifier,
              ),
            )
            .toList(growable: false),
      ),
      featuresNotes: FeaturesNotesPanelViewData(
        backgroundName: background.name,
        backgroundSummary: background.summary,
        backgroundBonuses: background.bonusDescriptions,
        backgroundSocialPerks: background.socialPerkDescriptions,
        proficientSkills: character.featuresNotes.proficientSkillLabels,
        otherProficiencies: character.featuresNotes.otherProficiencyLabels,
        alignment: character.featuresNotes.alignment,
        appearanceDetails: character.featuresNotes.appearanceDetails,
        narrativeDetails: character.featuresNotes.narrativeDetails,
      ),
      equipment: EquipmentPanelViewData(
        equipmentSummary: character.equipment.equipmentSummary,
        selectedEquipmentLabel: character.equipment.selectedEquipmentLabel,
        currencySummary: money.currencySummary,
        startingMoneySummary: money.startingMoneySummary,
        selectedEquipmentItems: character.equipment.visibleItems,
      ),
    );
  }
}
