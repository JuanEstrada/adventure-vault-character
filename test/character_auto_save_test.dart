import 'package:adventure_vault_character/src/features/characters/application/auto_save_service.dart';
import 'package:adventure_vault_character/src/features/characters/application/character_change_tracker.dart';
import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'character change tracker flushes last_saved_at for tracked characters',
    () async {
      final database = AppDatabase.executor(NativeDatabase.memory());
      addTearDown(database.close);

      await database
          .into(database.characters)
          .insert(
            CharactersCompanion.insert(
              id: 'hero-1',
              name: 'Lyra',
              raceName: 'Elf',
              className: 'Wizard',
              level: 3,
              createdAt: DateTime(2026, 1, 1),
              updatedAt: DateTime(2026, 1, 1),
            ),
          );

      final tracker = CharacterChangeTracker(database: database);
      tracker.recordChange('hero-1');

      expect(tracker.hasPendingChanges('hero-1'), isTrue);

      final flushed = await tracker.flushChanges('hero-1');
      expect(flushed, isTrue);
      expect(tracker.hasPendingChanges('hero-1'), isFalse);

      final row = await (database.select(
        database.characters,
      )..where((table) => table.id.equals('hero-1'))).getSingle();
      expect(row.lastSavedAt != null, isTrue);
    },
  );

  test(
    'auto save service flushes all pending changes through the tracker',
    () async {
      final database = AppDatabase.executor(NativeDatabase.memory());
      addTearDown(database.close);

      await database
          .into(database.characters)
          .insert(
            CharactersCompanion.insert(
              id: 'hero-2',
              name: 'Mira',
              raceName: 'Human',
              className: 'Fighter',
              level: 2,
              createdAt: DateTime(2026, 1, 1),
              updatedAt: DateTime(2026, 1, 1),
            ),
          );

      final tracker = CharacterChangeTracker(database: database);
      final autoSaveService = AutoSaveService(changeTracker: tracker);
      addTearDown(autoSaveService.dispose);

      autoSaveService.recordChange('hero-2');

      final flushedCount = await autoSaveService.flushPendingChanges();
      expect(flushedCount, 1);
      expect(tracker.hasPendingChanges('hero-2'), isFalse);

      final row = await (database.select(
        database.characters,
      )..where((table) => table.id.equals('hero-2'))).getSingle();
      expect(row.lastSavedAt != null, isTrue);
    },
  );
}
