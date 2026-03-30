import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_summary.dart';
import 'package:adventure_vault_character/src/features/characters/domain/editable_character.dart';

abstract interface class CharacterRepository {
  Future<List<CharacterSummary>> getCharacterSummaries();

  Stream<List<CharacterSummary>> watchCharacterSummaries();

  Future<CharacterSummary> createCharacter(CreateCharacterInput input);

  Future<CharacterSummary> updateCharacter(
    String id,
    CreateCharacterInput input,
  );

  Future<CharacterSummary?> getCharacterSummaryById(String id);

  Future<void> applyShortRest(String id);

  Future<void> applyLongRest(String id);

  Future<void> setClassResourceUses(
    String id,
    String resourceKey,
    int currentUses,
  );

  Future<CharacterDomainModel?> getCharacterSheetById(String id);

  Stream<CharacterDomainModel?> watchCharacterSheetById(String id);

  Future<EditableCharacter?> getEditableCharacterById(String id);
}
