import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:adventure_vault_character/src/features/settings/data/system_settings_repository.dart';
import 'package:drift/drift.dart';

class DriftSystemSettingsRepository implements SystemSettingsRepository {
  DriftSystemSettingsRepository({required AppDatabase database})
    : _database = database;

  final AppDatabase _database;

  @override
  Future<bool> getIncludeCoinWeightInEncumbrance() async {
    final row = await (_database.select(
      _database.systemPreferences,
    )..where((table) => table.id.equals(_singletonId))).getSingleOrNull();
    return row?.includeCoinWeightInEncumbrance ?? false;
  }

  @override
  Future<void> setIncludeCoinWeightInEncumbrance(bool value) async {
    final now = DateTime.now();
    await _database
        .into(_database.systemPreferences)
        .insertOnConflictUpdate(
          SystemPreferencesCompanion.insert(
            id: const Value(_singletonId),
            includeCoinWeightInEncumbrance: Value(value),
            updatedAt: Value(now),
          ),
        );
  }

  static const int _singletonId = 1;
}
