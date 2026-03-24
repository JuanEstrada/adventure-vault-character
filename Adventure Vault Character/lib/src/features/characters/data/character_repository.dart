import 'package:adventure_vault_character/src/features/characters/domain/character_sheet_view_data.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_summary.dart';

abstract interface class CharacterRepository {
  Future<List<CharacterSummary>> getCharacterSummaries();

  Stream<List<CharacterSummary>> watchCharacterSummaries();

  Future<CharacterSummary> createCharacter(CreateCharacterInput input);

  Future<CharacterSummary?> getCharacterSummaryById(String id);

  Future<CharacterSheetViewData?> getCharacterSheetById(String id);

  Stream<CharacterSheetViewData?> watchCharacterSheetById(String id);
}
