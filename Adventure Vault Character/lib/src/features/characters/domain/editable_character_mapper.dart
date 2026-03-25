import 'package:adventure_vault_character/src/features/characters/domain/character_domain_mapper.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_record.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:adventure_vault_character/src/features/characters/domain/editable_character.dart';

class EditableCharacterMapper {
  const EditableCharacterMapper({
    CharacterDomainMapper characterDomainMapper = const CharacterDomainMapper(),
  }) : _characterDomainMapper = characterDomainMapper;

  final CharacterDomainMapper _characterDomainMapper;

  EditableCharacter map(CharacterRecord record) {
    final character = _characterDomainMapper.map(record);
    final row = record.row;
    final provenance = _mapAbilityScoreProvenance(record);

    return EditableCharacter(
      id: row.id,
      identity: EditableCharacterIdentity(
        name: character.identity.name,
        raceName: character.identity.raceName,
        className: character.identity.className,
        portraitAssetPath: record.finishingDetails?.portraitAssetPath,
      ),
      background: EditableCharacterBackground(
        id: row.backgroundDefinitionRefId,
        name: character.featuresNotes.background.name,
        summary: character.featuresNotes.background.summary,
        bonuses: character.featuresNotes.background.bonuses,
        socialPerks: character.featuresNotes.background.socialPerks,
      ),
      abilities: EditableCharacterAbilities(
        methodKey: character.abilities.methodKey,
        entries: character.abilities.entries,
        provenance: provenance,
      ),
      progression: character.identity.progression,
      hitPoints: character.combat.hitPoints,
      equipment: EditableCharacterEquipment(
        loadoutId: record.equipmentLoadout?.loadoutId,
        loadoutLabel: character.equipment.selectedEquipmentLabel,
        startingMoneySummary: character.equipment.money.startingMoneySummary,
        currencySummary: character.equipment.money.currencySummary,
        items: character.equipment.items
            .map(
              (item) => EditableCharacterEquipmentItem(
                name: item.name,
                quantity: item.quantity,
                isEquipped: item.isEquipped,
              ),
            )
            .toList(growable: false),
      ),
      finishingDetails: EditableCharacterFinishingDetails(
        alignment: character.featuresNotes.alignment,
        appearanceDetails: character.featuresNotes.appearanceDetails,
        narrativeDetails: character.featuresNotes.narrativeDetails,
      ),
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  CreateCharacterInput toCreateCharacterInput(EditableCharacter character) {
    final abilitiesByLabel = <String, int>{
      for (final entry in character.abilities.entries) entry.label: entry.score,
    };

    return CreateCharacterInput(
      name: character.identity.name,
      raceName: character.identity.raceName,
      backgroundId: character.background.id ?? '',
      backgroundName: character.background.name,
      backgroundSummary: character.background.summary,
      abilityScoreMethod:
          character.abilities.methodKey ??
          character.abilities.provenance.methodKey ??
          '',
      abilityScoreProvenance: character.abilities.provenance.rawValue ?? '',
      strength: abilitiesByLabel['Strength'] ?? 0,
      dexterity: abilitiesByLabel['Dexterity'] ?? 0,
      constitution: abilitiesByLabel['Constitution'] ?? 0,
      intelligence: abilitiesByLabel['Intelligence'] ?? 0,
      wisdom: abilitiesByLabel['Wisdom'] ?? 0,
      charisma: abilitiesByLabel['Charisma'] ?? 0,
      className: character.identity.className,
      level: character.progression.level,
      experience: character.progression.experience,
      equipmentLoadoutId: character.equipment.loadoutId ?? '',
      equipmentLoadoutLabel: character.equipment.loadoutLabel,
      startingMoneySummary: character.equipment.startingMoneySummary,
      selectedEquipmentItems: character.equipment.items
          .map(
            (item) =>
                item.quantity > 1 ? '${item.quantity} ${item.name}' : item.name,
          )
          .toList(growable: false),
      currentHitPoints: character.hitPoints.current,
      maximumHitPoints: character.hitPoints.maximum,
      temporaryHitPoints: character.hitPoints.temporary,
      alignment: character.finishingDetails.alignment,
      appearanceDetails: character.finishingDetails.appearanceDetails,
      narrativeDetails: character.finishingDetails.narrativeDetails,
      portraitAssetPath: character.identity.portraitAssetPath,
    );
  }

  EditableAbilityScoreProvenance _mapAbilityScoreProvenance(
    CharacterRecord record,
  ) {
    final persisted = record.abilityScoreProvenance;
    if (persisted == null) {
      return const EditableAbilityScoreProvenance(
        rawValue: null,
        methodKey: null,
        assignedScoresByAbility: <String, int>{},
      );
    }

    final assignedScoresByAbility = <String, int>{
      if (persisted.strengthAssignedScore case final value?) 'Strength': value,
      if (persisted.dexterityAssignedScore case final value?)
        'Dexterity': value,
      if (persisted.constitutionAssignedScore case final value?)
        'Constitution': value,
      if (persisted.intelligenceAssignedScore case final value?)
        'Intelligence': value,
      if (persisted.wisdomAssignedScore case final value?) 'Wisdom': value,
      if (persisted.charismaAssignedScore case final value?) 'Charisma': value,
    };

    final rawParts = <String>[
      if (persisted.methodKey case final method?) 'method=$method',
      for (final entry in assignedScoresByAbility.entries)
        '${entry.key}=${entry.value}',
    ];

    return EditableAbilityScoreProvenance(
      rawValue: rawParts.isEmpty ? null : rawParts.join(';'),
      methodKey: persisted.methodKey,
      assignedScoresByAbility: assignedScoresByAbility,
    );
  }
}
