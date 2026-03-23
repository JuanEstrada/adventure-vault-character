import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class Characters extends Table {
  TextColumn get id => text()();

  TextColumn get name => text()();

  TextColumn get raceName => text().named('race_name')();

  TextColumn get backgroundId => text().named('background_id').nullable()();

  TextColumn get backgroundName => text().named('background_name').nullable()();

  TextColumn get backgroundSummary =>
      text().named('background_summary').nullable()();

  TextColumn get abilityScoreMethod =>
      text().named('ability_score_method').nullable()();

  TextColumn get abilityScoreProvenance =>
      text().named('ability_score_provenance').nullable()();

  IntColumn get strength => integer().nullable()();

  IntColumn get dexterity => integer().nullable()();

  IntColumn get constitution => integer().nullable()();

  IntColumn get intelligence => integer().nullable()();

  IntColumn get wisdom => integer().nullable()();

  IntColumn get charisma => integer().nullable()();

  TextColumn get className => text().named('class_name')();

  IntColumn get level => integer()();

  IntColumn get experience => integer().nullable()();

  TextColumn get equipmentLoadoutId =>
      text().named('equipment_loadout_id').nullable()();

  TextColumn get equipmentLoadoutLabel =>
      text().named('equipment_loadout_label').nullable()();

  TextColumn get startingMoneySummary =>
      text().named('starting_money_summary').nullable()();

  TextColumn get selectedEquipmentItems =>
      text().named('selected_equipment_items').nullable()();

  IntColumn get currentHitPoints =>
      integer().named('current_hit_points').nullable()();

  IntColumn get maximumHitPoints =>
      integer().named('maximum_hit_points').nullable()();

  IntColumn get temporaryHitPoints =>
      integer().named('temporary_hit_points').nullable()();

  TextColumn get portraitAssetPath =>
      text().named('portrait_asset_path').nullable()();

  TextColumn get alignment => text().nullable()();

  TextColumn get appearanceDetails =>
      text().named('appearance_details').nullable()();

  TextColumn get narrativeDetails =>
      text().named('narrative_details').nullable()();

  DateTimeColumn get createdAt => dateTime().named('created_at')();

  DateTimeColumn get updatedAt => dateTime().named('updated_at')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(tables: [Characters])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
    : super(
        driftDatabase(
          name: 'adventure_vault_character',
          web: DriftWebOptions(
            sqlite3Wasm: Uri.parse('sqlite3.wasm'),
            driftWorker: Uri.parse('drift_worker.js'),
          ),
        ),
      );

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await customStatement(
          'ALTER TABLE characters ADD COLUMN background_id TEXT NULL',
        );
        await customStatement(
          'ALTER TABLE characters ADD COLUMN background_name TEXT NULL',
        );
        await customStatement(
          'ALTER TABLE characters ADD COLUMN background_summary TEXT NULL',
        );
        await customStatement(
          'ALTER TABLE characters ADD COLUMN ability_score_method TEXT NULL',
        );
        await customStatement(
          'ALTER TABLE characters ADD COLUMN ability_score_provenance TEXT NULL',
        );
        await customStatement(
          'ALTER TABLE characters ADD COLUMN strength INTEGER NULL',
        );
        await customStatement(
          'ALTER TABLE characters ADD COLUMN dexterity INTEGER NULL',
        );
        await customStatement(
          'ALTER TABLE characters ADD COLUMN constitution INTEGER NULL',
        );
        await customStatement(
          'ALTER TABLE characters ADD COLUMN intelligence INTEGER NULL',
        );
        await customStatement(
          'ALTER TABLE characters ADD COLUMN wisdom INTEGER NULL',
        );
        await customStatement(
          'ALTER TABLE characters ADD COLUMN charisma INTEGER NULL',
        );
        await customStatement(
          'ALTER TABLE characters ADD COLUMN experience INTEGER NULL',
        );
        await customStatement(
          'ALTER TABLE characters ADD COLUMN current_hit_points INTEGER NULL',
        );
        await customStatement(
          'ALTER TABLE characters ADD COLUMN maximum_hit_points INTEGER NULL',
        );
        await customStatement(
          'ALTER TABLE characters ADD COLUMN temporary_hit_points INTEGER NULL',
        );
      }
      if (from < 3) {
        await customStatement(
          'ALTER TABLE characters ADD COLUMN equipment_loadout_id TEXT NULL',
        );
        await customStatement(
          'ALTER TABLE characters ADD COLUMN equipment_loadout_label TEXT NULL',
        );
        await customStatement(
          'ALTER TABLE characters ADD COLUMN starting_money_summary TEXT NULL',
        );
        await customStatement(
          'ALTER TABLE characters ADD COLUMN selected_equipment_items TEXT NULL',
        );
        await customStatement(
          'ALTER TABLE characters ADD COLUMN alignment TEXT NULL',
        );
        await customStatement(
          'ALTER TABLE characters ADD COLUMN appearance_details TEXT NULL',
        );
        await customStatement(
          'ALTER TABLE characters ADD COLUMN narrative_details TEXT NULL',
        );
      }
    },
  );
}
