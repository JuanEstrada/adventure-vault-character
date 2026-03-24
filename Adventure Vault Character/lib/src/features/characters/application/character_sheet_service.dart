import 'dart:async';

import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:adventure_vault_character/src/features/characters/data/local/character_read_dao.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_domain_mapper.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_record.dart';
import 'package:adventure_vault_character/src/features/compendium/data/compendium_repository.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';
import 'package:drift/drift.dart';

class CharacterSheetService {
  CharacterSheetService({
    required AppDatabase database,
    required CharacterReadDao readDao,
    required CompendiumRepository compendiumRepository,
    CharacterDomainMapper characterDomainMapper = const CharacterDomainMapper(),
  }) : _database = database,
       _readDao = readDao,
       _compendiumRepository = compendiumRepository,
       _characterDomainMapper = characterDomainMapper;

  final AppDatabase _database;
  final CharacterReadDao _readDao;
  final CompendiumRepository _compendiumRepository;
  final CharacterDomainMapper _characterDomainMapper;
  Future<CompendiumCatalog>? _catalogFuture;

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
    final row = await _readDao.getCharacterRowById(id);
    if (row == null) {
      return null;
    }

    final catalog = await _loadCatalog();
    final backgroundDefinition = await _loadBackgroundDefinition(row);
    final abilityScores = await _readDao.getAbilityScoresByCharacterId(id);
    final currency = await _readDao.getCurrencyByCharacterId(id);
    final inventory = await _readDao.getInventoryByCharacterId(id);
    final savingThrows = await _readDao.getSavingThrowsByCharacterId(id);
    final skills = await _readDao.getSkillsByCharacterId(id);
    final skillDefinitions = await _readDao.getSkillDefinitions();
    final proficiencies = await _readDao.getProficienciesByCharacterId(id);
    final record = CharacterRecord(
      row: row,
      catalog: catalog,
      backgroundDefinition: backgroundDefinition,
      abilityScores: abilityScores,
      currency: currency,
      inventory: inventory,
      savingThrows: savingThrows,
      skills: skills,
      skillDefinitions: skillDefinitions,
      proficiencies: proficiencies,
    );
    final character = _characterDomainMapper.map(record);

    return character;
  }

  Future<CompendiumCatalog> _loadCatalog() {
    return _catalogFuture ??= _compendiumRepository.loadCatalog();
  }

  Future<BackgroundDefinition?> _loadBackgroundDefinition(Character row) async {
    for (final id in _backgroundDefinitionLookupIds(row)) {
      final definition = await _readDao.getBackgroundDefinitionById(id);
      if (definition != null) {
        return definition;
      }
    }

    return null;
  }

  List<String> _backgroundDefinitionLookupIds(Character row) {
    final ids = <String>{
      if (row.backgroundDefinitionRefId case final refId?) refId,
      if (row.backgroundId case final backgroundId?) backgroundId,
      if (row.backgroundId case final backgroundId?)
        'background-${_slugify(backgroundId)}',
    };
    return ids.toList(growable: false);
  }

  String _slugify(String raw) {
    return raw
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
        .replaceAll(RegExp(r'^-|-$'), '');
  }
}
