import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:adventure_vault_character/src/features/settings/data/drift_system_settings_repository.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('defaults include coin weight preference to false', () async {
    final database = AppDatabase.executor(NativeDatabase.memory());
    addTearDown(database.close);
    final repository = DriftSystemSettingsRepository(database: database);

    final includeCoinWeight = await repository
        .getIncludeCoinWeightInEncumbrance();

    expect(includeCoinWeight, isFalse);
  });

  test('persists include coin weight preference updates', () async {
    final database = AppDatabase.executor(NativeDatabase.memory());
    addTearDown(database.close);
    final repository = DriftSystemSettingsRepository(database: database);

    await repository.setIncludeCoinWeightInEncumbrance(true);

    expect(await repository.getIncludeCoinWeightInEncumbrance(), isTrue);

    await repository.setIncludeCoinWeightInEncumbrance(false);

    expect(await repository.getIncludeCoinWeightInEncumbrance(), isFalse);
  });
}
