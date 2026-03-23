import 'package:adventure_vault_character/src/features/characters/data/character_repository.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_summary.dart';

class InMemoryCharacterRepository implements CharacterRepository {
  InMemoryCharacterRepository.empty() : _summaries = <CharacterSummary>[];

  InMemoryCharacterRepository.seeded(List<CharacterSummary> summaries)
      : _summaries = List<CharacterSummary>.from(summaries);

  final List<CharacterSummary> _summaries;

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
}
