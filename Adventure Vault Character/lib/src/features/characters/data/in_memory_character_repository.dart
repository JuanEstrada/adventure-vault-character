import 'package:adventure_vault_character/src/features/characters/data/character_repository.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_summary.dart';

class InMemoryCharacterRepository implements CharacterRepository {
  InMemoryCharacterRepository.empty() : _summaries = const <CharacterSummary>[];

  const InMemoryCharacterRepository.seeded(List<CharacterSummary> summaries)
      : _summaries = summaries;

  final List<CharacterSummary> _summaries;

  @override
  Future<List<CharacterSummary>> getCharacterSummaries() async {
    return List<CharacterSummary>.unmodifiable(_summaries);
  }
}
