import 'package:adventure_vault_character/src/features/characters/domain/character_summary.dart';

abstract interface class CharacterRepository {
  Future<List<CharacterSummary>> getCharacterSummaries();
}
