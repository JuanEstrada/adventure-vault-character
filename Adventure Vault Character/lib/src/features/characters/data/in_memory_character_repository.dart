import 'dart:async';

import 'package:adventure_vault_character/src/features/characters/data/character_repository.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_sheet_view_data.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_summary.dart';
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
    final summary = CharacterSummary(
      id: id,
      name: input.name,
      raceName: input.raceName,
      className: input.className,
      level: input.level,
      portraitAssetPath: input.portraitAssetPath,
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
  Future<CharacterSheetViewData?> getCharacterSheetById(String id) async {
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

    return CharacterSheetViewData(
      id: summary.id,
      name: summary.name,
      raceName: summary.raceName,
      className: summary.className,
      level: summary.level,
      experience: createdInput?.experience ?? 0,
      proficiencyBonus: 2,
      levelProgressPercent: 0,
      currentHitPoints: createdInput?.currentHitPoints ?? 10,
      maximumHitPoints: createdInput?.maximumHitPoints ?? 10,
      temporaryHitPoints: createdInput?.temporaryHitPoints ?? 0,
      backgroundName: createdInput?.backgroundName ?? background.name,
      backgroundSummary: createdInput?.backgroundSummary ?? background.summary,
      backgroundBonuses: background.bonuses,
      backgroundSocialPerks: background.socialPerks,
      abilityScoreMethodLabel: _abilityMethodLabel(
        createdInput?.abilityScoreMethod,
      ),
      abilityRows: <AbilityScoreRowViewData>[
        _abilityRow('Strength', createdInput?.strength ?? 15),
        _abilityRow('Dexterity', createdInput?.dexterity ?? 14),
        _abilityRow('Constitution', createdInput?.constitution ?? 13),
        _abilityRow('Intelligence', createdInput?.intelligence ?? 12),
        _abilityRow('Wisdom', createdInput?.wisdom ?? 10),
        _abilityRow('Charisma', createdInput?.charisma ?? 8),
      ],
      equipmentSummary: catalog.equipmentSummaryForClass(summary.className),
      selectedEquipmentLabel:
          createdInput?.equipmentLoadoutLabel ?? equipmentLoadout.label,
      currencySummary:
          createdInput?.startingMoneySummary ??
          equipmentLoadout.startingMoneySummary,
      startingMoneySummary:
          createdInput?.startingMoneySummary ??
          equipmentLoadout.startingMoneySummary,
      selectedEquipmentItems:
          createdInput?.selectedEquipmentItems ??
          equipmentLoadout.selectedItems,
      savingThrows: const <SavingThrowRowViewData>[],
      proficientSkills: const <String>[],
      otherProficiencies: const <String>[],
      alignment: createdInput?.alignment ?? 'Neutral',
      appearanceDetails: createdInput?.appearanceDetails ?? '',
      narrativeDetails: createdInput?.narrativeDetails ?? '',
    );
  }

  @override
  Stream<CharacterSheetViewData?> watchCharacterSheetById(String id) async* {
    yield await getCharacterSheetById(id);
    yield* _changes.stream.asyncMap((_) => getCharacterSheetById(id));
  }

  AbilityScoreRowViewData _abilityRow(String label, int score) {
    return AbilityScoreRowViewData(
      label: label,
      score: score,
      modifier: ((score - 10) / 2).floor(),
    );
  }

  String _abilityMethodLabel(String? method) {
    return switch (method) {
      'generatedSetAssignment' => 'Generated set assignment',
      'manualPointAllocation' => 'Manual point allocation',
      _ => 'Generated set assignment',
    };
  }
}
