import 'package:adventure_vault_character/src/features/characters/application/finishing_details_service.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_finishing_details.dart';
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
    FinishingDetailsService finishingDetailsService =
        const FinishingDetailsService(),
    EditableCharacterMapper editableCharacterMapper =
        const EditableCharacterMapper(),
  }) : _editableCharacterMapper = editableCharacterMapper,
       _finishingDetailsService = finishingDetailsService,
       _editableCharacter = editableCharacter,
       _draft = editableCharacterMapper.toCreateCharacterInput(
         editableCharacter,
       );

  final String characterId;
  final CompendiumCatalog catalog;
  final EditableCharacterMapper _editableCharacterMapper;
  final FinishingDetailsService _finishingDetailsService;

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

  List<NarrativeFieldAvailability> narrativeAvailability() {
    return _finishingDetailsService.availabilityForBackground(
      catalog: catalog,
      backgroundId: _draft.backgroundId,
    );
  }

  List<CompendiumNarrativeOptionGroup> groupsForField(
    NarrativeFieldKey fieldKey,
  ) {
    return _finishingDetailsService.availableGroups(
      catalog: catalog,
      fieldKey: fieldKey,
      backgroundId: _draft.backgroundId,
    );
  }
}
