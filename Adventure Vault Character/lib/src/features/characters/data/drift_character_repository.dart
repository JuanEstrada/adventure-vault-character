import 'package:adventure_vault_character/src/features/characters/application/character_sheet_service.dart';
import 'package:adventure_vault_character/src/features/characters/application/create_character_service.dart';
import 'package:adventure_vault_character/src/features/characters/application/editable_character_service.dart';
import 'package:adventure_vault_character/src/features/characters/application/character_record_loader.dart';
import 'package:adventure_vault_character/src/features/characters/data/character_repository.dart';
import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:adventure_vault_character/src/features/characters/data/local/character_read_dao.dart';
import 'package:adventure_vault_character/src/features/characters/data/local/character_reference_dao.dart';
import 'package:adventure_vault_character/src/features/characters/data/local/character_write_dao.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_summary.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_summary_mapper.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:adventure_vault_character/src/features/characters/domain/editable_character.dart';
import 'package:adventure_vault_character/src/features/compendium/data/compendium_repository.dart';

class DriftCharacterRepository implements CharacterRepository {
  DriftCharacterRepository({
    required AppDatabase database,
    required CompendiumRepository compendiumRepository,
    CharacterSummaryMapper characterSummaryMapper =
        const CharacterSummaryMapper(),
  }) : _readDao = CharacterReadDao(database),
       _characterSummaryMapper = characterSummaryMapper,
       _createCharacterService = CreateCharacterService(
         database: database,
         referenceDao: CharacterReferenceDao(database),
         writeDao: CharacterWriteDao(database),
         compendiumRepository: compendiumRepository,
         characterSummaryMapper: characterSummaryMapper,
       ),
       _characterSheetService = CharacterSheetService(
         database: database,
         readDao: CharacterReadDao(database),
         compendiumRepository: compendiumRepository,
       ),
       _editableCharacterService = EditableCharacterService(
         recordLoader: CharacterRecordLoader(
           readDao: CharacterReadDao(database),
           compendiumRepository: compendiumRepository,
         ),
       );

  final CharacterReadDao _readDao;
  final CharacterSummaryMapper _characterSummaryMapper;
  final CreateCharacterService _createCharacterService;
  final CharacterSheetService _characterSheetService;
  final EditableCharacterService _editableCharacterService;

  @override
  Future<List<CharacterSummary>> getCharacterSummaries() async {
    return (await _readDao.getCharacterRows())
        .map(_characterSummaryMapper.fromCharacterRow)
        .toList(growable: false);
  }

  @override
  Stream<List<CharacterSummary>> watchCharacterSummaries() {
    return _readDao.watchCharacterRows().map(
      (rows) => rows
          .map(_characterSummaryMapper.fromCharacterRow)
          .toList(growable: false),
    );
  }

  @override
  Future<CharacterSummary> createCharacter(CreateCharacterInput input) {
    return _createCharacterService.createCharacter(input);
  }

  @override
  Future<CharacterSummary> updateCharacter(
    String id,
    CreateCharacterInput input,
  ) {
    return _createCharacterService.updateCharacter(id, input);
  }

  @override
  Future<CharacterSummary?> getCharacterSummaryById(String id) async {
    final row = await _readDao.getCharacterRowById(id);
    if (row == null) {
      return null;
    }

    return _characterSummaryMapper.fromCharacterRow(row);
  }

  @override
  Future<CharacterDomainModel?> getCharacterSheetById(String id) {
    return _characterSheetService.getCharacterSheetById(id);
  }

  @override
  Stream<CharacterDomainModel?> watchCharacterSheetById(String id) {
    return _characterSheetService.watchCharacterSheetById(id);
  }

  @override
  Future<EditableCharacter?> getEditableCharacterById(String id) {
    return _editableCharacterService.getEditableCharacterById(id);
  }
}
