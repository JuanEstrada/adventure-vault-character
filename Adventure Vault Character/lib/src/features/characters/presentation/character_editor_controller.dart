import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:adventure_vault_character/src/features/characters/domain/editable_character.dart';
import 'package:adventure_vault_character/src/features/characters/domain/editable_character_mapper.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';
import 'package:flutter/foundation.dart';

class CharacterEditorController extends ChangeNotifier {
  CharacterEditorController({
    required this.characterId,
    required this.catalog,
    required EditableCharacter editableCharacter,
    EditableCharacterMapper editableCharacterMapper =
        const EditableCharacterMapper(),
  }) : _editableCharacterMapper = editableCharacterMapper,
       _editableCharacter = editableCharacter,
       _draft = editableCharacterMapper.toCreateCharacterInput(
         editableCharacter,
       );

  final String characterId;
  final CompendiumCatalog catalog;
  final EditableCharacterMapper _editableCharacterMapper;

  EditableCharacter _editableCharacter;
  CreateCharacterInput _draft;

  EditableCharacter get editableCharacter => _editableCharacter;
  CreateCharacterInput get draft => _draft;

  void replaceEditableCharacter(EditableCharacter value) {
    _editableCharacter = value;
    _draft = _editableCharacterMapper.toCreateCharacterInput(value);
    notifyListeners();
  }

  void replaceDraft(CreateCharacterInput value) {
    _draft = value;
    notifyListeners();
  }
}
