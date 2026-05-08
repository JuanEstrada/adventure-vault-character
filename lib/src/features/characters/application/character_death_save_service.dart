import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:adventure_vault_character/src/features/characters/data/local/character_read_dao.dart';
import 'package:adventure_vault_character/src/features/characters/data/local/character_write_dao.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_combat_rules.dart';
import 'package:drift/drift.dart';

class CharacterDeathSaveService {
  CharacterDeathSaveService({
    required AppDatabase database,
    required CharacterReadDao readDao,
    required CharacterWriteDao writeDao,
    CharacterCombatRules characterCombatRules = const CharacterCombatRules(),
    void Function(String characterId)? onCharacterChanged,
  }) : _database = database,
       _readDao = readDao,
       _writeDao = writeDao,
       _characterCombatRules = characterCombatRules,
       _onCharacterChanged = onCharacterChanged;

  final AppDatabase _database;
  final CharacterReadDao _readDao;
  final CharacterWriteDao _writeDao;
  final CharacterCombatRules _characterCombatRules;
  final void Function(String characterId)? _onCharacterChanged;

  Future<void> recordSuccess(String id) {
    return _updateDeathSaves(id, registerSuccess: true);
  }

  Future<void> recordFailure(String id) {
    return _updateDeathSaves(id, registerSuccess: false);
  }

  Future<void> reset(String id) async {
    final row = await _readDao.getCharacterRowById(id);
    if (row == null) {
      throw StateError('Character not found.');
    }
    final resetResult = _characterCombatRules.resetDeathSaves();

    await _database.transaction(() async {
      final now = DateTime.now();
      await _writeDao.updateCharacter(
        id,
        CharactersCompanion(updatedAt: Value(now)),
      );
      await _writeDao.replaceDeathSaves(
        CharacterDeathSavesCompanion.insert(
          characterId: id,
          successCount: Value(resetResult.successCount),
          failureCount: Value(resetResult.failureCount),
          updatedAt: Value(now),
        ),
      );
    });

    _onCharacterChanged?.call(id);
  }

  Future<void> _updateDeathSaves(
    String id, {
    required bool registerSuccess,
  }) async {
    final row = await _readDao.getCharacterRowById(id);
    if (row == null) {
      throw StateError('Character not found.');
    }
    final persisted = await _readDao.getDeathSavesByCharacterId(id);
    final successCount = persisted?.successCount ?? 0;
    final failureCount = persisted?.failureCount ?? 0;
    final next = registerSuccess
        ? _characterCombatRules.registerSuccess(
            successCount: successCount,
            failureCount: failureCount,
          )
        : _characterCombatRules.registerFailure(
            successCount: successCount,
            failureCount: failureCount,
          );

    await _database.transaction(() async {
      final now = DateTime.now();
      await _writeDao.updateCharacter(
        id,
        CharactersCompanion(updatedAt: Value(now)),
      );
      await _writeDao.replaceDeathSaves(
        CharacterDeathSavesCompanion.insert(
          characterId: id,
          successCount: Value(next.successCount),
          failureCount: Value(next.failureCount),
          updatedAt: Value(now),
        ),
      );
    });

    _onCharacterChanged?.call(id);
  }
}
