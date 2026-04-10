import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_finishing_details.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:flutter/foundation.dart';

@immutable
class EditableCharacter {
  const EditableCharacter({
    required this.id,
    required this.identity,
    required this.background,
    required this.abilities,
    required this.progression,
    required this.hitPoints,
    required this.spellState,
    required this.equipment,
    required this.finishingDetails,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final EditableCharacterIdentity identity;
  final EditableCharacterBackground background;
  final EditableCharacterAbilities abilities;
  final CharacterProgressionDomainModel progression;
  final CharacterHitPointsDomainModel hitPoints;
  final EditableCharacterSpellState spellState;
  final EditableCharacterEquipment equipment;
  final EditableCharacterFinishingDetails finishingDetails;
  final DateTime createdAt;
  final DateTime updatedAt;
}

@immutable
class EditableCharacterSpellState {
  const EditableCharacterSpellState({
    required this.selectionMode,
    required this.selectedSpells,
    required this.slotUsages,
  });

  final CharacterSpellSelectionMode? selectionMode;
  final List<CharacterSpellSelectionInput> selectedSpells;
  final List<CharacterSpellSlotUsageInput> slotUsages;
}

@immutable
class EditableCharacterIdentity {
  const EditableCharacterIdentity({
    required this.name,
    required this.raceName,
    required this.className,
    this.portraitAssetPath,
  });

  final String name;
  final String raceName;
  final String className;
  final String? portraitAssetPath;
}

@immutable
class EditableCharacterBackground {
  const EditableCharacterBackground({
    required this.id,
    required this.name,
    required this.summary,
    required this.bonuses,
    required this.socialPerks,
  });

  final String? id;
  final String name;
  final String summary;
  final List<CharacterBackgroundEntryDomainModel> bonuses;
  final List<CharacterBackgroundEntryDomainModel> socialPerks;
}

@immutable
class EditableCharacterAbilities {
  const EditableCharacterAbilities({
    required this.methodKey,
    required this.entries,
    required this.provenance,
  });

  final String? methodKey;
  final List<CharacterAbilityScoreDomainModel> entries;
  final EditableAbilityScoreProvenance provenance;
}

@immutable
class EditableAbilityScoreProvenance {
  const EditableAbilityScoreProvenance({
    required this.rawValue,
    required this.methodKey,
    required this.assignedScoresByAbility,
  });

  final String? rawValue;
  final String? methodKey;
  final Map<String, int> assignedScoresByAbility;
}

@immutable
class EditableCharacterEquipment {
  const EditableCharacterEquipment({
    required this.loadoutId,
    required this.loadoutLabel,
    required this.startingMoneySummary,
    required this.currencySummary,
    required this.items,
  });

  final String? loadoutId;
  final String loadoutLabel;
  final String startingMoneySummary;
  final String currencySummary;
  final List<EditableCharacterEquipmentItem> items;
}

@immutable
class EditableCharacterEquipmentItem {
  const EditableCharacterEquipmentItem({
    required this.name,
    required this.quantity,
    required this.isEquipped,
  });

  final String name;
  final int quantity;
  final bool isEquipped;
}

@immutable
class EditableCharacterFinishingDetails {
  const EditableCharacterFinishingDetails({
    required this.appearanceDetails,
    required this.narrativeNotes,
    required this.narrativeSelections,
    this.portraitAssetPath,
  });

  final String appearanceDetails;
  final String narrativeNotes;
  final List<NarrativeSelection> narrativeSelections;
  final String? portraitAssetPath;

  String? valueFor(NarrativeFieldKey fieldKey) {
    for (final selection in narrativeSelections) {
      if (selection.fieldKey == fieldKey) {
        return selection.valueText;
      }
    }
    return null;
  }
}
