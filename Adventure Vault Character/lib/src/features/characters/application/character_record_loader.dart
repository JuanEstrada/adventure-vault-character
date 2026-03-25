import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:adventure_vault_character/src/features/characters/data/local/character_read_dao.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_record.dart';
import 'package:adventure_vault_character/src/features/compendium/data/compendium_repository.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';

class CharacterRecordLoader {
  CharacterRecordLoader({
    required CharacterReadDao readDao,
    required CompendiumRepository compendiumRepository,
  }) : _readDao = readDao,
       _compendiumRepository = compendiumRepository;

  final CharacterReadDao _readDao;
  final CompendiumRepository _compendiumRepository;
  Future<CompendiumCatalog>? _catalogFuture;

  Future<CharacterRecord?> loadById(String id) async {
    final row = await _readDao.getCharacterRowById(id);
    if (row == null) {
      return null;
    }

    final catalog = await _loadCatalog();
    final backgroundDefinition = await _loadBackgroundDefinition(row);
    final abilityScores = await _readDao.getAbilityScoresByCharacterId(id);
    final abilityScoreProvenance = await _readDao
        .getAbilityScoreProvenanceByCharacterId(id);
    final currency = await _readDao.getCurrencyByCharacterId(id);
    final inventory = await _readDao.getInventoryByCharacterId(id);
    final savingThrows = await _readDao.getSavingThrowsByCharacterId(id);
    final skills = await _readDao.getSkillsByCharacterId(id);
    final skillDefinitions = await _readDao.getSkillDefinitions();
    final proficiencies = await _readDao.getProficienciesByCharacterId(id);

    return CharacterRecord(
      row: row,
      catalog: catalog,
      backgroundDefinition: backgroundDefinition,
      abilityScores: abilityScores,
      abilityScoreProvenance: abilityScoreProvenance,
      currency: currency,
      inventory: inventory,
      savingThrows: savingThrows,
      skills: skills,
      skillDefinitions: skillDefinitions,
      proficiencies: proficiencies,
    );
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
      if (row.backgroundDefinitionRefId case final refId?)
        'background-${_slugify(refId)}',
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
