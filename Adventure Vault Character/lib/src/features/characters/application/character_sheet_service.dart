import 'dart:async';

import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:adventure_vault_character/src/features/characters/data/local/character_read_dao.dart';
import 'package:adventure_vault_character/src/features/characters/application/character_record_loader.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_domain_mapper.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:adventure_vault_character/src/features/compendium/data/compendium_repository.dart';
import 'package:drift/drift.dart';

class CharacterSheetService {
  CharacterSheetService({
    required AppDatabase database,
    required CharacterReadDao readDao,
    required CompendiumRepository compendiumRepository,
    CharacterDomainMapper characterDomainMapper = const CharacterDomainMapper(),
  }) : _database = database,
       _readDao = readDao,
       _recordLoader = CharacterRecordLoader(
         readDao: readDao,
         compendiumRepository: compendiumRepository,
       ),
       _characterDomainMapper = characterDomainMapper;

  final AppDatabase _database;
  final CharacterReadDao _readDao;
  final CharacterRecordLoader _recordLoader;
  final CharacterDomainMapper _characterDomainMapper;

  Future<CharacterDomainModel?> getCharacterSheetById(String id) async {
    return _loadCharacterSheet(id);
  }

  Stream<CharacterDomainModel?> watchCharacterSheetById(String id) {
    return Stream<CharacterDomainModel?>.multi((controller) {
      Future<void> emitCurrent() async {
        controller.add(await _loadCharacterSheet(id));
      }

      final subscriptions = <StreamSubscription<Object?>>[
        _readDao.watchCharacterRowById(id).listen((_) => emitCurrent()),
        _database
            .tableUpdates(
              TableUpdateQuery.onTable(_database.characterAbilityScores),
            )
            .listen((_) => emitCurrent()),
        _database
            .tableUpdates(
              TableUpdateQuery.onTable(_database.characterHitPoints),
            )
            .listen((_) => emitCurrent()),
        _database
            .tableUpdates(
              TableUpdateQuery.onTable(_database.characterFinishingDetails),
            )
            .listen((_) => emitCurrent()),
        _database
            .tableUpdates(
              TableUpdateQuery.onTable(_database.characterEquipmentLoadouts),
            )
            .listen((_) => emitCurrent()),
        _database
            .tableUpdates(TableUpdateQuery.onTable(_database.characterCurrency))
            .listen((_) => emitCurrent()),
        _database
            .tableUpdates(
              TableUpdateQuery.onTable(_database.characterInventory),
            )
            .listen((_) => emitCurrent()),
        _database
            .tableUpdates(
              TableUpdateQuery.onTable(_database.characterSavingThrows),
            )
            .listen((_) => emitCurrent()),
        _database
            .tableUpdates(TableUpdateQuery.onTable(_database.characterSkills))
            .listen((_) => emitCurrent()),
        _database
            .tableUpdates(
              TableUpdateQuery.onTable(_database.characterProficiencies),
            )
            .listen((_) => emitCurrent()),
        _database
            .tableUpdates(
              TableUpdateQuery.onTable(_database.characterSpellSlotUsages),
            )
            .listen((_) => emitCurrent()),
        _database
            .tableUpdates(
              TableUpdateQuery.onTable(_database.characterClassResources),
            )
            .listen((_) => emitCurrent()),
        _database
            .tableUpdates(TableUpdateQuery.onTable(_database.systemPreferences))
            .listen((_) => emitCurrent()),
        _database
            .tableUpdates(TableUpdateQuery.onTable(_database.skillDefinitions))
            .listen((_) => emitCurrent()),
        _database
            .tableUpdates(
              TableUpdateQuery.onTable(_database.backgroundDefinitions),
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

  Future<CharacterDomainModel?> _loadCharacterSheet(String id) async {
    final record = await _recordLoader.loadById(id);
    if (record == null) {
      return null;
    }

    return _characterDomainMapper.map(
      record,
      includeCoinWeightInEncumbrance: await _includeCoinWeightInEncumbrance(),
    );
  }

  Future<bool> _includeCoinWeightInEncumbrance() async {
    final preference = await (_database.select(
      _database.systemPreferences,
    )..where((table) => table.id.equals(1))).getSingleOrNull();
    return preference?.includeCoinWeightInEncumbrance ?? false;
  }
}
