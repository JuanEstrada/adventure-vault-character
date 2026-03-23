import 'package:adventure_vault_character/src/features/characters/data/character_repository.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_sheet_view_data.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_summary.dart';
import 'package:adventure_vault_character/src/features/compendium/data/compendium_repository.dart';

class InMemoryCharacterRepository implements CharacterRepository {
  InMemoryCharacterRepository.empty({
    required CompendiumRepository compendiumRepository,
  }) : _summaries = <CharacterSummary>[],
       _compendiumRepository = compendiumRepository;

  InMemoryCharacterRepository.seeded(
    List<CharacterSummary> summaries, {
    required CompendiumRepository compendiumRepository,
  }) : _summaries = List<CharacterSummary>.from(summaries),
       _compendiumRepository = compendiumRepository;

  final List<CharacterSummary> _summaries;
  final CompendiumRepository _compendiumRepository;

  @override
  Future<List<CharacterSummary>> getCharacterSummaries() async {
    return List<CharacterSummary>.unmodifiable(_summaries);
  }

  @override
  Future<CharacterSummary> createCharacter(CreateCharacterInput input) async {
    final summary = CharacterSummary(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: input.name,
      raceName: input.raceName,
      className: input.className,
      level: input.level,
      portraitAssetPath: input.portraitAssetPath,
    );
    _summaries.insert(0, summary);
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

    final catalog = await _compendiumRepository.loadCatalog();
    final background = catalog.backgrounds.first;
    final equipmentLoadout = catalog
        .equipmentLoadoutsForClass(summary.className)
        .first;

    return CharacterSheetViewData(
      id: summary.id,
      name: summary.name,
      raceName: summary.raceName,
      className: summary.className,
      level: summary.level,
      experience: 0,
      proficiencyBonus: 2,
      levelProgressPercent: 0,
      currentHitPoints: 10,
      maximumHitPoints: 10,
      temporaryHitPoints: 0,
      backgroundName: background.name,
      backgroundSummary: background.summary,
      backgroundBonuses: background.bonuses,
      backgroundSocialPerks: background.socialPerks,
      abilityScoreMethodLabel: 'Generated set assignment',
      abilityRows: const <AbilityScoreRowViewData>[
        AbilityScoreRowViewData(label: 'Strength', score: 15, modifier: 2),
        AbilityScoreRowViewData(label: 'Dexterity', score: 14, modifier: 2),
        AbilityScoreRowViewData(label: 'Constitution', score: 13, modifier: 1),
        AbilityScoreRowViewData(label: 'Intelligence', score: 12, modifier: 1),
        AbilityScoreRowViewData(label: 'Wisdom', score: 10, modifier: 0),
        AbilityScoreRowViewData(label: 'Charisma', score: 8, modifier: -1),
      ],
      equipmentSummary: catalog.equipmentSummaryForClass(summary.className),
      selectedEquipmentLabel: equipmentLoadout.label,
      startingMoneySummary: equipmentLoadout.startingMoneySummary,
      selectedEquipmentItems: equipmentLoadout.selectedItems,
      alignment: 'Neutral',
      appearanceDetails: '',
      narrativeDetails: '',
    );
  }
}
