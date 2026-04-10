import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:drift/drift.dart';

class CharacterReferenceDao {
  CharacterReferenceDao(this._database);

  final AppDatabase _database;

  Future<void> upsertSkillDefinitions(
    List<SkillDefinitionsCompanion> companions,
  ) async {
    if (companions.isEmpty) {
      return;
    }

    await _database.batch((Batch batch) {
      batch.insertAll(
        _database.skillDefinitions,
        companions,
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Future<void> upsertClassDefinition(
    ClassDefinitionsCompanion companion,
  ) async {
    await _database
        .into(_database.classDefinitions)
        .insertOnConflictUpdate(companion);
  }

  Future<void> upsertBackgroundDefinition(
    BackgroundDefinitionsCompanion companion,
  ) async {
    await _database
        .into(_database.backgroundDefinitions)
        .insertOnConflictUpdate(companion);
  }

  Future<void> upsertEquipmentDefinitions(
    List<EquipmentDefinitionsCompanion> companions,
  ) async {
    if (companions.isEmpty) {
      return;
    }

    await _database.batch((Batch batch) {
      batch.insertAll(
        _database.equipmentDefinitions,
        companions,
        mode: InsertMode.insertOrReplace,
      );
    });
  }
}
