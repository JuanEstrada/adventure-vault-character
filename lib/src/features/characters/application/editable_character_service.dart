import 'package:adventure_vault_character/src/features/characters/application/character_record_loader.dart';
import 'package:adventure_vault_character/src/features/characters/domain/editable_character.dart';
import 'package:adventure_vault_character/src/features/characters/domain/editable_character_mapper.dart';

class EditableCharacterService {
  const EditableCharacterService({
    required CharacterRecordLoader recordLoader,
    EditableCharacterMapper editableCharacterMapper =
        const EditableCharacterMapper(),
  }) : _recordLoader = recordLoader,
       _editableCharacterMapper = editableCharacterMapper;

  final CharacterRecordLoader _recordLoader;
  final EditableCharacterMapper _editableCharacterMapper;

  Future<EditableCharacter?> getEditableCharacterById(String id) async {
    final record = await _recordLoader.loadById(id);
    if (record == null) {
      return null;
    }

    return _editableCharacterMapper.map(record);
  }
}
