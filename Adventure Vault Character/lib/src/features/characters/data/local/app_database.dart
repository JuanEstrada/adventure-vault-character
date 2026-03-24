import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class Characters extends Table {
  TextColumn get id => text()();

  TextColumn get name => text()();

  TextColumn get raceName => text().named('race_name')();

  TextColumn get classDefinitionId =>
      text().named('class_definition_id').nullable()();

  TextColumn get backgroundDefinitionRefId =>
      text().named('background_definition_ref_id').nullable()();

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

  IntColumn get proficiencyBonus =>
      integer().named('proficiency_bonus').nullable()();

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

class CharacterAbilityScores extends Table {
  TextColumn get characterId => text().references(Characters, #id)();

  IntColumn get strengthScore => integer().named('strength_score')();

  IntColumn get dexterityScore => integer().named('dexterity_score')();

  IntColumn get constitutionScore => integer().named('constitution_score')();

  IntColumn get intelligenceScore => integer().named('intelligence_score')();

  IntColumn get wisdomScore => integer().named('wisdom_score')();

  IntColumn get charismaScore => integer().named('charisma_score')();

  IntColumn get strengthModifier =>
      integer().named('strength_modifier').nullable()();

  IntColumn get dexterityModifier =>
      integer().named('dexterity_modifier').nullable()();

  IntColumn get constitutionModifier =>
      integer().named('constitution_modifier').nullable()();

  IntColumn get intelligenceModifier =>
      integer().named('intelligence_modifier').nullable()();

  IntColumn get wisdomModifier =>
      integer().named('wisdom_modifier').nullable()();

  IntColumn get charismaModifier =>
      integer().named('charisma_modifier').nullable()();

  @override
  Set<Column<Object>> get primaryKey => {characterId};
}

class SkillDefinitions extends Table {
  TextColumn get id => text()();

  TextColumn get key => text()();

  TextColumn get name => text()();

  TextColumn get governingAbility => text().named('governing_ability')();

  TextColumn get description => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => <Set<Column<Object>>>[
    {key},
  ];
}

class CharacterSkills extends Table {
  TextColumn get characterId => text().references(Characters, #id)();

  TextColumn get skillDefinitionId =>
      text().named('skill_definition_id').references(SkillDefinitions, #id)();

  BoolColumn get isProficient =>
      boolean().named('is_proficient').withDefault(const Constant(false))();

  BoolColumn get hasExpertise =>
      boolean().named('has_expertise').withDefault(const Constant(false))();

  IntColumn get miscBonus =>
      integer().named('misc_bonus').withDefault(const Constant(0))();

  IntColumn get totalBonus => integer().named('total_bonus').nullable()();

  @override
  Set<Column<Object>> get primaryKey => {characterId, skillDefinitionId};
}

class CharacterSavingThrows extends Table {
  TextColumn get characterId => text().references(Characters, #id)();

  TextColumn get abilityKey => text().named('ability_key')();

  BoolColumn get isProficient =>
      boolean().named('is_proficient').withDefault(const Constant(false))();

  IntColumn get miscBonus =>
      integer().named('misc_bonus').withDefault(const Constant(0))();

  IntColumn get totalBonus => integer().named('total_bonus').nullable()();

  @override
  Set<Column<Object>> get primaryKey => {characterId, abilityKey};
}

class EquipmentDefinitions extends Table {
  TextColumn get id => text()();

  TextColumn get key => text()();

  TextColumn get name => text()();

  TextColumn get category => text()();

  TextColumn get subcategory => text().nullable()();

  IntColumn get weight => integer().nullable()();

  IntColumn get costValue => integer().named('cost_value').nullable()();

  TextColumn get costUnit => text().named('cost_unit').nullable()();

  BoolColumn get isContainer =>
      boolean().named('is_container').withDefault(const Constant(false))();

  BoolColumn get isStackable =>
      boolean().named('is_stackable').withDefault(const Constant(true))();

  TextColumn get description => text().nullable()();

  TextColumn get weaponPropertiesJson =>
      text().named('weapon_properties_json').nullable()();

  TextColumn get armorPropertiesJson =>
      text().named('armor_properties_json').nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => <Set<Column<Object>>>[
    {key},
  ];
}

class CharacterInventory extends Table {
  TextColumn get id => text()();

  TextColumn get characterId => text().references(Characters, #id)();

  TextColumn get equipmentDefinitionId => text()
      .named('equipment_definition_id')
      .nullable()
      .references(EquipmentDefinitions, #id)();

  TextColumn get trinketDefinitionId => text()
      .named('trinket_definition_id')
      .nullable()
      .references(TrinketDefinitions, #id)();

  TextColumn get displayNameSnapshot =>
      text().named('display_name_snapshot').nullable()();

  IntColumn get quantity => integer().withDefault(const Constant(1))();

  BoolColumn get isEquipped =>
      boolean().named('is_equipped').withDefault(const Constant(false))();

  BoolColumn get isCarried =>
      boolean().named('is_carried').withDefault(const Constant(true))();

  BoolColumn get isFavorite =>
      boolean().named('is_favorite').withDefault(const Constant(false))();

  IntColumn get chargesCurrent =>
      integer().named('charges_current').nullable()();

  IntColumn get chargesMax => integer().named('charges_max').nullable()();

  TextColumn get containerInventoryItemId =>
      text().named('container_inventory_item_id').nullable()();

  TextColumn get notes => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class CharacterProficiencies extends Table {
  TextColumn get id => text()();

  TextColumn get characterId => text().references(Characters, #id)();

  TextColumn get proficiencyType => text().named('proficiency_type')();

  TextColumn get referenceKey => text().named('reference_key')();

  TextColumn get sourceType => text().named('source_type').nullable()();

  TextColumn get sourceId => text().named('source_id').nullable()();

  BoolColumn get isExpertise =>
      boolean().named('is_expertise').withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => <Set<Column<Object>>>[
    {characterId, proficiencyType, referenceKey},
  ];
}

class CharacterCurrency extends Table {
  TextColumn get characterId => text().references(Characters, #id)();

  IntColumn get copper => integer().withDefault(const Constant(0))();

  IntColumn get silver => integer().withDefault(const Constant(0))();

  IntColumn get electrum => integer().withDefault(const Constant(0))();

  IntColumn get gold => integer().withDefault(const Constant(0))();

  IntColumn get platinum => integer().withDefault(const Constant(0))();

  TextColumn get summarySnapshot =>
      text().named('summary_snapshot').nullable()();

  @override
  Set<Column<Object>> get primaryKey => {characterId};
}

class ClassDefinitions extends Table {
  TextColumn get id => text()();

  TextColumn get key => text()();

  TextColumn get name => text()();

  IntColumn get hitDie => integer().named('hit_die').nullable()();

  BoolColumn get isSpellcaster =>
      boolean().named('is_spellcaster').withDefault(const Constant(false))();

  TextColumn get spellcastingAbility =>
      text().named('spellcasting_ability').nullable()();

  TextColumn get description => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => <Set<Column<Object>>>[
    {key},
  ];
}

class BackgroundDefinitions extends Table {
  TextColumn get id => text()();

  TextColumn get key => text()();

  TextColumn get name => text()();

  TextColumn get summary => text().nullable()();

  TextColumn get featureName => text().named('feature_name').nullable()();

  TextColumn get featureDescription =>
      text().named('feature_description').nullable()();

  TextColumn get grantedSkillKeysJson =>
      text().named('granted_skill_keys_json').nullable()();

  TextColumn get grantedToolKeysJson =>
      text().named('granted_tool_keys_json').nullable()();

  TextColumn get grantedLanguageKeysJson =>
      text().named('granted_language_keys_json').nullable()();

  TextColumn get startingEquipmentJson =>
      text().named('starting_equipment_json').nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => <Set<Column<Object>>>[
    {key},
  ];
}

class SpellDefinitions extends Table {
  TextColumn get id => text()();

  TextColumn get key => text()();

  TextColumn get name => text()();

  IntColumn get level => integer()();

  TextColumn get school => text()();

  TextColumn get castingTime => text().named('casting_time').nullable()();

  TextColumn get rangeText => text().named('range_text').nullable()();

  TextColumn get durationText => text().named('duration_text').nullable()();

  BoolColumn get requiresConcentration => boolean()
      .named('requires_concentration')
      .withDefault(const Constant(false))();

  BoolColumn get isRitual =>
      boolean().named('is_ritual').withDefault(const Constant(false))();

  TextColumn get componentsJson => text().named('components_json').nullable()();

  TextColumn get description => text().nullable()();

  TextColumn get higherLevelsDescription =>
      text().named('higher_levels_description').nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => <Set<Column<Object>>>[
    {key},
  ];
}

class TrinketDefinitions extends Table {
  TextColumn get id => text()();

  TextColumn get key => text()();

  TextColumn get name => text()();

  TextColumn get description => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => <Set<Column<Object>>>[
    {key},
  ];
}

@DriftDatabase(
  tables: <Type>[
    Characters,
    CharacterAbilityScores,
    SkillDefinitions,
    CharacterSkills,
    CharacterSavingThrows,
    EquipmentDefinitions,
    CharacterInventory,
    CharacterProficiencies,
    CharacterCurrency,
    ClassDefinitions,
    BackgroundDefinitions,
    SpellDefinitions,
    TrinketDefinitions,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase()
    : this.executor(
        driftDatabase(
          name: 'adventure_vault_character',
          native: const DriftNativeOptions(shareAcrossIsolates: true),
          web: DriftWebOptions(
            sqlite3Wasm: Uri.parse('sqlite3.wasm'),
            driftWorker: Uri.parse('drift_worker.js'),
          ),
        ),
      );

  AppDatabase.executor(super.executor);

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (OpeningDetails details) async {
      await customStatement('PRAGMA foreign_keys = ON');
      await customStatement('PRAGMA journal_mode = WAL');
    },
    onCreate: (Migrator migrator) async {
      await migrator.createAll();
      await _createIndexes();
    },
    onUpgrade: (Migrator migrator, int from, int to) async {
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
      if (from < 4) {
        await customStatement(
          'ALTER TABLE characters ADD COLUMN class_definition_id TEXT NULL',
        );
        await customStatement(
          'ALTER TABLE characters ADD COLUMN background_definition_ref_id TEXT NULL',
        );
        await customStatement(
          'ALTER TABLE characters ADD COLUMN proficiency_bonus INTEGER NULL',
        );

        await migrator.createTable(skillDefinitions);
        await migrator.createTable(equipmentDefinitions);
        await migrator.createTable(classDefinitions);
        await migrator.createTable(backgroundDefinitions);
        await migrator.createTable(spellDefinitions);
        await migrator.createTable(trinketDefinitions);
        await migrator.createTable(characterAbilityScores);
        await migrator.createTable(characterSkills);
        await migrator.createTable(characterSavingThrows);
        await migrator.createTable(characterInventory);
        await migrator.createTable(characterProficiencies);
        await migrator.createTable(characterCurrency);

        await _backfillNormalizedCharacterData();
      }

      await _createIndexes();
    },
  );

  Future<void> _createIndexes() async {
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_characters_updated_at_name '
      'ON characters (updated_at DESC, name ASC)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_character_skills_character '
      'ON character_skills (character_id)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_character_saving_throws_character '
      'ON character_saving_throws (character_id)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_character_inventory_character '
      'ON character_inventory (character_id)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_character_inventory_container '
      'ON character_inventory (container_inventory_item_id)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_character_proficiencies_character '
      'ON character_proficiencies (character_id)',
    );
  }

  Future<void> _backfillNormalizedCharacterData() async {
    await customStatement('''
      INSERT INTO character_ability_scores (
        character_id,
        strength_score,
        dexterity_score,
        constitution_score,
        intelligence_score,
        wisdom_score,
        charisma_score,
        strength_modifier,
        dexterity_modifier,
        constitution_modifier,
        intelligence_modifier,
        wisdom_modifier,
        charisma_modifier
      )
      SELECT
        id,
        COALESCE(strength, 0),
        COALESCE(dexterity, 0),
        COALESCE(constitution, 0),
        COALESCE(intelligence, 0),
        COALESCE(wisdom, 0),
        COALESCE(charisma, 0),
        CAST(FLOOR((COALESCE(strength, 0) - 10) / 2.0) AS INTEGER),
        CAST(FLOOR((COALESCE(dexterity, 0) - 10) / 2.0) AS INTEGER),
        CAST(FLOOR((COALESCE(constitution, 0) - 10) / 2.0) AS INTEGER),
        CAST(FLOOR((COALESCE(intelligence, 0) - 10) / 2.0) AS INTEGER),
        CAST(FLOOR((COALESCE(wisdom, 0) - 10) / 2.0) AS INTEGER),
        CAST(FLOOR((COALESCE(charisma, 0) - 10) / 2.0) AS INTEGER)
      FROM characters
    ''');

    await customStatement('''
      INSERT INTO character_currency (
        character_id,
        copper,
        silver,
        electrum,
        gold,
        platinum,
        summary_snapshot
      )
      SELECT
        id,
        0,
        0,
        0,
        0,
        0,
        starting_money_summary
      FROM characters
    ''');

    await customStatement('''
      INSERT INTO character_saving_throws (
        character_id,
        ability_key,
        is_proficient,
        misc_bonus,
        total_bonus
      )
      SELECT id, 'STR', 0, 0, NULL FROM characters
      UNION ALL
      SELECT id, 'DEX', 0, 0, NULL FROM characters
      UNION ALL
      SELECT id, 'CON', 0, 0, NULL FROM characters
      UNION ALL
      SELECT id, 'INT', 0, 0, NULL FROM characters
      UNION ALL
      SELECT id, 'WIS', 0, 0, NULL FROM characters
      UNION ALL
      SELECT id, 'CHA', 0, 0, NULL FROM characters
    ''');

    await customStatement('''
      UPDATE characters
      SET background_definition_ref_id = background_id,
          proficiency_bonus = 2 + CAST((level - 1) / 4 AS INTEGER)
    ''');
  }
}
