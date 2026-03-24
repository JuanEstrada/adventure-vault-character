import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_summary.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';

class CharacterSummaryMapper {
  const CharacterSummaryMapper();

  CharacterSummary fromCharacterRow(Character row) {
    return CharacterSummary(
      id: row.id,
      name: row.name,
      raceName: row.raceName,
      className: row.className,
      level: row.level,
      portraitAssetPath: row.portraitAssetPath,
    );
  }

  CharacterSummary fromCreateInput({
    required String id,
    required CreateCharacterInput input,
  }) {
    return CharacterSummary(
      id: id,
      name: input.name,
      raceName: input.raceName,
      className: input.className,
      level: input.level,
      portraitAssetPath: input.portraitAssetPath,
    );
  }
}
