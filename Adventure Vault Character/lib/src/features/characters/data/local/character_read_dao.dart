import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:drift/drift.dart';

class CharacterReadDao {
  CharacterReadDao(this._database);

  final AppDatabase _database;

  Future<List<Character>> getCharacterRows() {
    return (_database.select(_database.characters)..orderBy([
          (table) => OrderingTerm.desc(table.updatedAt),
          (table) => OrderingTerm.asc(table.name),
        ]))
        .get();
  }

  Stream<List<Character>> watchCharacterRows() {
    return (_database.select(_database.characters)..orderBy([
          (table) => OrderingTerm.desc(table.updatedAt),
          (table) => OrderingTerm.asc(table.name),
        ]))
        .watch();
  }

  Future<Character?> getCharacterRowById(String id) {
    return (_database.select(
      _database.characters,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
  }

  Stream<Character?> watchCharacterRowById(String id) {
    return (_database.select(
      _database.characters,
    )..where((table) => table.id.equals(id))).watchSingleOrNull();
  }
}
