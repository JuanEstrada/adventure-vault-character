import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:drift/drift.dart';

class CharacterChangeTracker {
  CharacterChangeTracker({required AppDatabase database})
    : _database = database;

  final AppDatabase _database;
  final Set<String> _pendingCharacterIds = <String>{};

  bool recordChange(String characterId) {
    return _pendingCharacterIds.add(characterId);
  }

  bool hasPendingChanges(String characterId) {
    return _pendingCharacterIds.contains(characterId);
  }

  Iterable<String> get pendingCharacterIds => _pendingCharacterIds;

  Future<bool> flushChanges(String characterId) async {
    if (!_pendingCharacterIds.remove(characterId)) {
      return false;
    }

    final now = DateTime.now();
    await (_database.update(
      _database.characters,
    )..where((table) => table.id.equals(characterId))).write(
      CharactersCompanion(lastSavedAt: Value(now.millisecondsSinceEpoch)),
    );
    return true;
  }

  Future<int> flushAllChanges() async {
    final pending = _pendingCharacterIds.toList(growable: false);
    var flushed = 0;
    for (final characterId in pending) {
      if (await flushChanges(characterId)) {
        flushed += 1;
      }
    }
    return flushed;
  }

  void clear(String characterId) {
    _pendingCharacterIds.remove(characterId);
  }

  void clearAll() {
    _pendingCharacterIds.clear();
  }
}
