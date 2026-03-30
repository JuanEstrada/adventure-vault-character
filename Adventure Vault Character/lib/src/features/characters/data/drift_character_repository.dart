import 'package:adventure_vault_character/src/features/characters/application/character_sheet_service.dart';
import 'package:adventure_vault_character/src/features/characters/application/create_character_service.dart';
import 'package:adventure_vault_character/src/features/characters/application/editable_character_service.dart';
import 'package:adventure_vault_character/src/features/characters/application/character_recovery_service.dart';
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
import 'package:drift/drift.dart';
import 'dart:async';

class DriftCharacterRepository implements CharacterRepository {
  DriftCharacterRepository({
    required AppDatabase database,
    required CompendiumRepository compendiumRepository,
    CharacterSummaryMapper characterSummaryMapper =
        const CharacterSummaryMapper(),
  }) : _readDao = CharacterReadDao(database),
       _database = database,
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
       ),
       _characterRecoveryService = CharacterRecoveryService(
         database: database,
         readDao: CharacterReadDao(database),
         writeDao: CharacterWriteDao(database),
       );

  final CharacterReadDao _readDao;
  final AppDatabase _database;
  final CharacterSummaryMapper _characterSummaryMapper;
  final CreateCharacterService _createCharacterService;
  final CharacterSheetService _characterSheetService;
  final EditableCharacterService _editableCharacterService;
  final CharacterRecoveryService _characterRecoveryService;

  @override
  Future<List<CharacterSummary>> getCharacterSummaries() async {
    final rows = await _readDao.getCharacterRows();
    return _mapSummaries(rows);
  }

  @override
  Stream<List<CharacterSummary>> watchCharacterSummaries() {
    return Stream<List<CharacterSummary>>.multi((controller) {
      Future<void> emitCurrent() async {
        controller.add(await getCharacterSummaries());
      }

      final subscriptions = <StreamSubscription<Object?>>[
        _readDao.watchCharacterRows().listen((_) => emitCurrent()),
        _database
            .tableUpdates(
              TableUpdateQuery.onTable(_database.characterFinishingDetails),
            )
            .listen((_) => emitCurrent()),
      ];

      unawaited(emitCurrent());

      controller.onCancel = () async {
        for (final subscription in subscriptions) {
          await subscription.cancel();
        }
      };
    });
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

    final finishingDetails = await _readDao.getFinishingDetailsByCharacterId(
      id,
    );
    return _characterSummaryMapper.fromCharacterRow(
      row,
      finishingDetails: finishingDetails,
    );
  }

  @override
  Future<void> applyShortRest(String id) {
    return _characterRecoveryService.applyShortRest(id);
  }

  @override
  Future<void> applyLongRest(String id) {
    return _characterRecoveryService.applyLongRest(id);
  }

  @override
  Future<void> setClassResourceUses(
    String id,
    String resourceKey,
    int currentUses,
  ) {
    return _characterRecoveryService.setClassResourceUses(
      id,
      resourceKey,
      currentUses,
    );
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

  Future<List<CharacterSummary>> _mapSummaries(List<Character> rows) async {
    final summaries = <CharacterSummary>[];
    for (final row in rows) {
      final finishingDetails = await _readDao.getFinishingDetailsByCharacterId(
        row.id,
      );
      summaries.add(
        _characterSummaryMapper.fromCharacterRow(
          row,
          finishingDetails: finishingDetails,
        ),
      );
    }
    return summaries;
  }
}
