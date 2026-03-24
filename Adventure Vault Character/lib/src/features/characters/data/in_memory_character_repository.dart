import 'dart:async';

import 'package:adventure_vault_character/src/features/characters/data/character_repository.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_summary.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_summary_mapper.dart';
import 'package:adventure_vault_character/src/features/compendium/data/compendium_repository.dart';

class InMemoryCharacterRepository implements CharacterRepository {
  InMemoryCharacterRepository.empty({
    required CompendiumRepository compendiumRepository,
  }) : _summaries = <CharacterSummary>[],
       _createdInputsById = <String, CreateCharacterInput>{},
       _compendiumRepository = compendiumRepository;

  InMemoryCharacterRepository.seeded(
    List<CharacterSummary> summaries, {
    required CompendiumRepository compendiumRepository,
  }) : _summaries = List<CharacterSummary>.from(summaries),
       _createdInputsById = <String, CreateCharacterInput>{},
       _compendiumRepository = compendiumRepository;

  final List<CharacterSummary> _summaries;
  final Map<String, CreateCharacterInput> _createdInputsById;
  final CompendiumRepository _compendiumRepository;
  final CharacterSummaryMapper _characterSummaryMapper =
      const CharacterSummaryMapper();
  final StreamController<void> _changes = StreamController<void>.broadcast();

  @override
  Future<List<CharacterSummary>> getCharacterSummaries() async {
    return List<CharacterSummary>.unmodifiable(_summaries);
  }

  @override
  Stream<List<CharacterSummary>> watchCharacterSummaries() async* {
    yield await getCharacterSummaries();
    yield* _changes.stream.asyncMap((_) => getCharacterSummaries());
  }

  @override
  Future<CharacterSummary> createCharacter(CreateCharacterInput input) async {
    final id = DateTime.now().microsecondsSinceEpoch.toString();
    final summary = _characterSummaryMapper.fromCreateInput(
      id: id,
      input: input,
    );
    _summaries.insert(0, summary);
    _createdInputsById[id] = input;
    _changes.add(null);
    return summary;
  }

  @override
  Future<CharacterSummary?> getCharacterSummaryById(String id) async {
    for (final summary in _summaries) {
      if (summary.id == id) {
        return summary;
      }
    }
    return null;
  }

  @override
  Future<CharacterDomainModel?> getCharacterSheetById(String id) async {
    final summary = await getCharacterSummaryById(id);
    if (summary == null) {
      return null;
    }
    final createdInput = _createdInputsById[id];

    final catalog = await _compendiumRepository.loadCatalog();
    final background =
        catalog.backgroundById(createdInput?.backgroundId) ??
        catalog.backgrounds.first;
    final equipmentLoadout = catalog
        .equipmentLoadoutsForClass(summary.className)
        .first;

    return CharacterDomainModel(
      id: summary.id,
      identity: CharacterIdentityDomainModel(
        name: summary.name,
        raceName: summary.raceName,
        className: summary.className,
        progression: CharacterProgressionDomainModel(
          level: summary.level,
          experience: createdInput?.experience ?? 0,
        ),
      ),
      combat: CharacterCombatDomainModel(
        hitPoints: CharacterHitPointsDomainModel(
          current: createdInput?.currentHitPoints ?? 10,
          maximum: createdInput?.maximumHitPoints ?? 10,
          temporary: createdInput?.temporaryHitPoints ?? 0,
        ),
        savingThrows: const <CharacterSavingThrowDomainModel>[],
      ),
      abilities: CharacterAbilitiesDomainModel(
        methodKey: createdInput?.abilityScoreMethod,
        entries: <CharacterAbilityScoreDomainModel>[
          _abilityRow('Strength', createdInput?.strength ?? 15),
          _abilityRow('Dexterity', createdInput?.dexterity ?? 14),
          _abilityRow('Constitution', createdInput?.constitution ?? 13),
          _abilityRow('Intelligence', createdInput?.intelligence ?? 12),
          _abilityRow('Wisdom', createdInput?.wisdom ?? 10),
          _abilityRow('Charisma', createdInput?.charisma ?? 8),
        ],
      ),
      featuresNotes: CharacterFeaturesNotesDomainModel(
        background: CharacterBackgroundDomainModel(
          name: createdInput?.backgroundName ?? background.name,
          summary: createdInput?.backgroundSummary ?? background.summary,
          bonuses: background.bonuses
              .map(_mapBackgroundEntry)
              .toList(growable: false),
          socialPerks: background.socialPerks
              .map(_mapBackgroundEntry)
              .toList(growable: false),
        ),
        proficientSkills: const <CharacterSkillDomainModel>[],
        otherProficiencies: const <CharacterProficiencyDomainModel>[],
        alignment: createdInput?.alignment ?? 'Neutral',
        appearanceDetails: createdInput?.appearanceDetails ?? '',
        narrativeDetails: createdInput?.narrativeDetails ?? '',
      ),
      equipment: CharacterEquipmentDomainModel(
        equipmentSummary: catalog.equipmentSummaryForClass(summary.className),
        selectedEquipmentLabel:
            createdInput?.equipmentLoadoutLabel ?? equipmentLoadout.label,
        money: CharacterMoneySummaryDomainModel(
          currencySummary:
              createdInput?.startingMoneySummary ??
              equipmentLoadout.startingMoneySummary,
          startingMoneySummary:
              createdInput?.startingMoneySummary ??
              equipmentLoadout.startingMoneySummary,
        ),
        items:
            (createdInput?.selectedEquipmentItems ??
                    equipmentLoadout.selectedItems)
                .map(
                  (item) => CharacterEquipmentItemDomainModel(
                    name: item,
                    quantity: 1,
                    isEquipped: false,
                  ),
                )
                .toList(growable: false),
      ),
    );
  }

  @override
  Stream<CharacterDomainModel?> watchCharacterSheetById(String id) async* {
    yield await getCharacterSheetById(id);
    yield* _changes.stream.asyncMap((_) => getCharacterSheetById(id));
  }

  CharacterAbilityScoreDomainModel _abilityRow(String label, int score) {
    return CharacterAbilityScoreDomainModel(label: label, score: score);
  }

  CharacterBackgroundEntryDomainModel _mapBackgroundEntry(String raw) {
    final separatorIndex = raw.indexOf(':');
    if (separatorIndex <= 0 || separatorIndex >= raw.length - 1) {
      return CharacterBackgroundEntryDomainModel(
        label: raw.trim(),
        description: '',
      );
    }

    return CharacterBackgroundEntryDomainModel(
      label: raw.substring(0, separatorIndex).trim(),
      description: raw.substring(separatorIndex + 1).trim(),
    );
  }
}
