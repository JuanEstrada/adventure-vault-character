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

  TextColumn get className => text().named('class_name')();

  IntColumn get level => integer()();

  IntColumn get experience => integer().nullable()();

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

class CharacterAbilityScoreProvenances extends Table {
  TextColumn get characterId => text().references(Characters, #id)();

  TextColumn get methodKey => text().named('method_key').nullable()();

  IntColumn get strengthAssignedScore =>
      integer().named('strength_assigned_score').nullable()();

  IntColumn get dexterityAssignedScore =>
      integer().named('dexterity_assigned_score').nullable()();

  IntColumn get constitutionAssignedScore =>
      integer().named('constitution_assigned_score').nullable()();

  IntColumn get intelligenceAssignedScore =>
      integer().named('intelligence_assigned_score').nullable()();

  IntColumn get wisdomAssignedScore =>
      integer().named('wisdom_assigned_score').nullable()();

  IntColumn get charismaAssignedScore =>
      integer().named('charisma_assigned_score').nullable()();

  @override
  Set<Column<Object>> get primaryKey => {characterId};
}

class CharacterHitPoints extends Table {
  TextColumn get characterId => text().references(Characters, #id)();

  IntColumn get current => integer().named('current_hit_points')();

  IntColumn get maximum => integer().named('maximum_hit_points')();

  IntColumn get temporary => integer().named('temporary_hit_points')();

  @override
  Set<Column<Object>> get primaryKey => {characterId};
}

class CharacterFinishingDetails extends Table {
  TextColumn get characterId => text().references(Characters, #id)();

  TextColumn get portraitAssetPath =>
      text().named('portrait_asset_path').nullable()();

  TextColumn get alignment => text().nullable()();

  TextColumn get appearanceDetails =>
      text().named('appearance_details').nullable()();

  TextColumn get narrativeDetails =>
      text().named('narrative_details').nullable()();

  @override
  Set<Column<Object>> get primaryKey => {characterId};
}

class CharacterNarrativeSelections extends Table {
  TextColumn get characterId => text().references(Characters, #id)();

  TextColumn get fieldKey => text().named('field_key')();

  TextColumn get selectionMode => text().named('selection_mode')();

  TextColumn get groupId => text().named('group_id').nullable()();

  TextColumn get optionId => text().named('option_id').nullable()();

  TextColumn get valueText => text().named('value_text').nullable()();

  IntColumn get rollValue => integer().named('roll_value').nullable()();

  @override
  Set<Column<Object>> get primaryKey => {characterId, fieldKey};
}

class CharacterEquipmentLoadouts extends Table {
  TextColumn get characterId => text().references(Characters, #id)();

  TextColumn get loadoutId => text().named('loadout_id').nullable()();

  TextColumn get loadoutLabel => text().named('loadout_label').nullable()();

  @override
  Set<Column<Object>> get primaryKey => {characterId};
}

class CharacterSpellSelections extends Table {
  TextColumn get characterId => text().references(Characters, #id)();

  TextColumn get spellDefinitionId => text().named('spell_definition_id')();

  TextColumn get selectionKind => text().named('selection_kind')();

  IntColumn get selectedAtOrder =>
      integer().named('selected_at_order').withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {
    characterId,
    spellDefinitionId,
    selectionKind,
  };
}

class CharacterSpellSlotUsages extends Table {
  TextColumn get characterId => text().references(Characters, #id)();

  IntColumn get spellLevel => integer().named('spell_level')();

  TextColumn get expendedSlotIndices =>
      text().named('expended_slot_indices').withDefault(const Constant('[]'))();

  @override
  Set<Column<Object>> get primaryKey => {characterId, spellLevel};
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

class CharacterClassResources extends Table {
  TextColumn get characterId => text().references(Characters, #id)();

  TextColumn get resourceKey => text().named('resource_key')();

  IntColumn get currentUses =>
      integer().named('current_uses').withDefault(const Constant(0))();

  TextColumn get lastChangedSource =>
      text().named('last_changed_source').withDefault(const Constant('seed'))();

  DateTimeColumn get lastChangedAt =>
      dateTime().named('last_changed_at').withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {characterId, resourceKey};
}

class CharacterDeathSaves extends Table {
  TextColumn get characterId => text().references(Characters, #id)();

  IntColumn get successCount =>
      integer().named('success_count').withDefault(const Constant(0))();

  IntColumn get failureCount =>
      integer().named('failure_count').withDefault(const Constant(0))();

  DateTimeColumn get updatedAt =>
      dateTime().named('updated_at').withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {characterId};
}

class SystemPreferences extends Table {
  IntColumn get id => integer()();

  BoolColumn get includeCoinWeightInEncumbrance => boolean()
      .named('include_coin_weight_in_encumbrance')
      .withDefault(const Constant(false))();

  DateTimeColumn get updatedAt =>
      dateTime().named('updated_at').withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {id};
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

class CharacterAdvancementDefinitions extends Table {
  IntColumn get level => integer()();

  IntColumn get experience => integer()();

  IntColumn get proficiencyBonus => integer().named('proficiency_bonus')();

  @override
  Set<Column<Object>> get primaryKey => {level};
}

class ClassStandardArrayRecommendations extends Table {
  TextColumn get classId => text().named('class_id')();

  TextColumn get className => text().named('class_name')();

  IntColumn get strength => integer()();

  IntColumn get dexterity => integer()();

  IntColumn get constitution => integer()();

  IntColumn get intelligence => integer()();

  IntColumn get wisdom => integer()();

  IntColumn get charisma => integer()();

  @override
  Set<Column<Object>> get primaryKey => {classId};

  @override
  List<Set<Column<Object>>> get uniqueKeys => <Set<Column<Object>>>[
    {className},
  ];
}

class NarrativeOptionGroups extends Table {
  TextColumn get id => text()();

  TextColumn get fieldKey => text().named('field_key')();

  TextColumn get sourceType => text().named('source_type')();

  TextColumn get packId => text().named('pack_id').nullable()();

  TextColumn get sourceId => text().named('source_id').nullable()();

  TextColumn get sourceName => text().named('source_name').nullable()();

  TextColumn get backgroundId => text().named('background_id').nullable()();

  TextColumn get backgroundName => text().named('background_name').nullable()();

  TextColumn get title => text()();

  TextColumn get diceFormula => text().named('dice_formula').nullable()();

  IntColumn get optionCount =>
      integer().named('option_count').withDefault(const Constant(0))();

  TextColumn get sourceBook => text().named('source_book').nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class NarrativeOptions extends Table {
  TextColumn get id => text()();

  TextColumn get groupId =>
      text().named('group_id').references(NarrativeOptionGroups, #id)();

  IntColumn get optionIndex => integer().named('option_index')();

  IntColumn get rollMin => integer().named('roll_min').nullable()();

  IntColumn get rollMax => integer().named('roll_max').nullable()();

  TextColumn get label => text().nullable()();

  TextColumn get content => text().named('content')();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => <Set<Column<Object>>>[
    {groupId, optionIndex},
  ];
}

class CompendiumPackStates extends Table {
  TextColumn get id => text()();

  TextColumn get title => text()();

  TextColumn get description => text()();

  TextColumn get kind => text()();

  BoolColumn get isFixed =>
      boolean().named('is_fixed').withDefault(const Constant(false))();

  BoolColumn get isActive =>
      boolean().named('is_active').withDefault(const Constant(true))();

  DateTimeColumn get updatedAt => dateTime().named('updated_at')();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class ImportedCompendiumPacks extends Table {
  TextColumn get id => text()();

  TextColumn get rawXml => text().named('raw_xml')();

  DateTimeColumn get importedAt => dateTime().named('imported_at')();

  @override
  Set<Column<Object>> get primaryKey => {id};
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
    CharacterAbilityScoreProvenances,
    CharacterHitPoints,
    CharacterFinishingDetails,
    CharacterNarrativeSelections,
    CharacterEquipmentLoadouts,
    CharacterSpellSelections,
    CharacterSpellSlotUsages,
    SkillDefinitions,
    CharacterSkills,
    CharacterSavingThrows,
    EquipmentDefinitions,
    CharacterInventory,
    CharacterProficiencies,
    CharacterCurrency,
    CharacterClassResources,
    CharacterDeathSaves,
    SystemPreferences,
    ClassDefinitions,
    CharacterAdvancementDefinitions,
    ClassStandardArrayRecommendations,
    NarrativeOptionGroups,
    NarrativeOptions,
    CompendiumPackStates,
    ImportedCompendiumPacks,
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
  int get schemaVersion => 20;

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
      if (from < 5) {
        await _migrateCharactersToV5();
      }
      if (from < 6) {
        await migrator.createTable(characterAbilityScoreProvenances);
        await _backfillAbilityScoreProvenanceData();
        await _migrateCharactersToV6();
      }
      if (from < 7) {
        await migrator.createTable(characterHitPoints);
        await migrator.createTable(characterFinishingDetails);
        await _backfillCharacterHitPointsData();
        await _backfillCharacterFinishingDetailsData();
        await _migrateCharactersToV7();
      }
      if (from < 8) {
        await migrator.createTable(characterEquipmentLoadouts);
        await _backfillCharacterEquipmentLoadoutData();
        await _migrateCharactersToV8();
      }
      if (from < 9) {
        await migrator.createTable(characterAdvancementDefinitions);
        await migrator.createTable(classStandardArrayRecommendations);
      }
      if (from < 10) {
        await migrator.createTable(narrativeOptionGroups);
        await migrator.createTable(narrativeOptions);
      }
      if (from < 11) {
        await migrator.createTable(characterNarrativeSelections);
        await _backfillCharacterNarrativeSelectionsData();
      }
      if (from < 12) {
        await migrator.createTable(compendiumPackStates);
      }
      if (from >= 10 && from < 13) {
        await customStatement(
          'ALTER TABLE narrative_option_groups ADD COLUMN pack_id TEXT NULL',
        );
      }
      if (from < 14) {
        await migrator.createTable(importedCompendiumPacks);
      }
      if (from < 15) {
        await migrator.createTable(characterSpellSelections);
        await migrator.createTable(characterSpellSlotUsages);
      }
      if (from >= 15 && from < 16) {
        await customStatement(
          'CREATE TABLE character_spell_selections_v16 ('
          'character_id TEXT NOT NULL REFERENCES characters(id), '
          'spell_definition_id TEXT NOT NULL, '
          'selection_kind TEXT NOT NULL, '
          'selected_at_order INTEGER NOT NULL DEFAULT 0, '
          'PRIMARY KEY(character_id, spell_definition_id, selection_kind)'
          ')',
        );
        await customStatement(
          'INSERT INTO character_spell_selections_v16 '
          '(character_id, spell_definition_id, selection_kind, selected_at_order) '
          'SELECT character_id, spell_definition_id, selection_kind, selected_at_order '
          'FROM character_spell_selections',
        );
        await customStatement('DROP TABLE character_spell_selections');
        await customStatement(
          'ALTER TABLE character_spell_selections_v16 '
          'RENAME TO character_spell_selections',
        );
      }
      if (from < 17) {
        await migrator.createTable(characterClassResources);
      }
      if (from >= 17 && from < 18) {
        await customStatement(
          "ALTER TABLE character_class_resources ADD COLUMN last_changed_source TEXT NOT NULL DEFAULT 'seed'",
        );
        await customStatement(
          "ALTER TABLE character_class_resources ADD COLUMN last_changed_at INTEGER NOT NULL DEFAULT (strftime('%s','now'))",
        );
      }
      if (from < 19) {
        await migrator.createTable(systemPreferences);
      }
      if (from < 20) {
        await migrator.createTable(characterDeathSaves);
        await customStatement('''
          INSERT INTO character_death_saves (character_id, success_count, failure_count)
          SELECT id, 0, 0
          FROM characters
          WHERE id NOT IN (SELECT character_id FROM character_death_saves)
        ''');
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
      'CREATE INDEX IF NOT EXISTS idx_character_ability_score_provenances_character '
      'ON character_ability_score_provenances (character_id)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_character_hit_points_character '
      'ON character_hit_points (character_id)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_character_finishing_details_character '
      'ON character_finishing_details (character_id)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_character_narrative_selections_character '
      'ON character_narrative_selections (character_id)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_character_narrative_selections_mode '
      'ON character_narrative_selections (selection_mode)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_character_equipment_loadouts_character '
      'ON character_equipment_loadouts (character_id)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_character_spell_selections_character '
      'ON character_spell_selections (character_id, selected_at_order)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_character_spell_slot_usages_character '
      'ON character_spell_slot_usages (character_id)',
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
      'CREATE INDEX IF NOT EXISTS idx_character_class_resources_character '
      'ON character_class_resources (character_id)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_character_death_saves_character '
      'ON character_death_saves (character_id)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_character_proficiencies_character '
      'ON character_proficiencies (character_id)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_character_advancement_definitions_experience '
      'ON character_advancement_definitions (experience)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_class_standard_array_recommendations_name '
      'ON class_standard_array_recommendations (class_name)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_narrative_option_groups_field '
      'ON narrative_option_groups (field_key)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_narrative_option_groups_background '
      'ON narrative_option_groups (background_id)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_narrative_options_group '
      'ON narrative_options (group_id, option_index)',
    );
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_compendium_pack_states_active '
      'ON compendium_pack_states (is_active)',
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

  Future<void> _migrateCharactersToV5() async {
    await customStatement('PRAGMA foreign_keys = OFF');

    await customStatement('''
      CREATE TABLE characters_v5 (
        id TEXT NOT NULL PRIMARY KEY,
        name TEXT NOT NULL,
        race_name TEXT NOT NULL,
        class_definition_id TEXT NULL,
        background_definition_ref_id TEXT NULL,
        ability_score_method TEXT NULL,
        ability_score_provenance TEXT NULL,
        class_name TEXT NOT NULL,
        level INTEGER NOT NULL,
        experience INTEGER NULL,
        equipment_loadout_id TEXT NULL,
        equipment_loadout_label TEXT NULL,
        current_hit_points INTEGER NULL,
        maximum_hit_points INTEGER NULL,
        temporary_hit_points INTEGER NULL,
        portrait_asset_path TEXT NULL,
        alignment TEXT NULL,
        appearance_details TEXT NULL,
        narrative_details TEXT NULL,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL
      )
    ''');

    await customStatement('''
      INSERT INTO characters_v5 (
        id,
        name,
        race_name,
        class_definition_id,
        background_definition_ref_id,
        ability_score_method,
        ability_score_provenance,
        class_name,
        level,
        experience,
        equipment_loadout_id,
        equipment_loadout_label,
        current_hit_points,
        maximum_hit_points,
        temporary_hit_points,
        portrait_asset_path,
        alignment,
        appearance_details,
        narrative_details,
        created_at,
        updated_at
      )
      SELECT
        id,
        name,
        race_name,
        class_definition_id,
        COALESCE(background_definition_ref_id, background_id),
        ability_score_method,
        ability_score_provenance,
        class_name,
        level,
        experience,
        equipment_loadout_id,
        equipment_loadout_label,
        current_hit_points,
        maximum_hit_points,
        temporary_hit_points,
        portrait_asset_path,
        alignment,
        appearance_details,
        narrative_details,
        created_at,
        updated_at
      FROM characters
    ''');

    await customStatement('DROP TABLE characters');
    await customStatement('ALTER TABLE characters_v5 RENAME TO characters');
    await customStatement('PRAGMA foreign_keys = ON');
  }

  Future<void> _backfillAbilityScoreProvenanceData() async {
    final legacyRows = await customSelect('''
      SELECT
        id,
        ability_score_method,
        ability_score_provenance
      FROM characters
    ''').get();

    for (final row in legacyRows) {
      final characterId = row.read<String>('id');
      final fallbackMethodKey = row.read<String?>('ability_score_method');
      final rawValue = row.read<String?>('ability_score_provenance');
      final parsed = _parseAbilityScoreProvenance(
        characterId: characterId,
        rawValue: rawValue,
        fallbackMethodKey: fallbackMethodKey,
      );
      await into(
        characterAbilityScoreProvenances,
      ).insertOnConflictUpdate(parsed);
    }
  }

  Future<void> _backfillCharacterHitPointsData() async {
    await customStatement('''
      INSERT INTO character_hit_points (
        character_id,
        current_hit_points,
        maximum_hit_points,
        temporary_hit_points
      )
      SELECT
        id,
        COALESCE(current_hit_points, 0),
        COALESCE(maximum_hit_points, 0),
        COALESCE(temporary_hit_points, 0)
      FROM characters
    ''');
  }

  Future<void> _backfillCharacterFinishingDetailsData() async {
    await customStatement('''
      INSERT INTO character_finishing_details (
        character_id,
        portrait_asset_path,
        alignment,
        appearance_details,
        narrative_details
      )
      SELECT
        id,
        portrait_asset_path,
        alignment,
        appearance_details,
        narrative_details
      FROM characters
    ''');
  }

  Future<void> _backfillCharacterEquipmentLoadoutData() async {
    await customStatement('''
      INSERT INTO character_equipment_loadouts (
        character_id,
        loadout_id,
        loadout_label
      )
      SELECT
        id,
        equipment_loadout_id,
        equipment_loadout_label
      FROM characters
    ''');
  }

  Future<void> _backfillCharacterNarrativeSelectionsData() async {
    final legacyRows = await customSelect('''
      SELECT
        character_id,
        alignment
      FROM character_finishing_details
    ''').get();

    for (final row in legacyRows) {
      final characterId = row.read<String>('character_id');
      final alignment = row.read<String?>('alignment')?.trim();
      if (alignment == null || alignment.isEmpty) {
        continue;
      }

      await into(characterNarrativeSelections).insertOnConflictUpdate(
        CharacterNarrativeSelectionsCompanion.insert(
          characterId: characterId,
          fieldKey: 'alignment',
          selectionMode: 'manual',
          groupId: const Value('narrative-alignment-core'),
          optionId: Value(_alignmentOptionId(alignment)),
          valueText: Value(alignment),
          rollValue: const Value(null),
        ),
      );
    }
  }

  String _alignmentOptionId(String alignment) {
    final normalized = alignment.trim().toLowerCase();
    const idsByValue = <String, String>{
      'lawful good': 'narrative-alignment-1',
      'neutral good': 'narrative-alignment-2',
      'chaotic good': 'narrative-alignment-3',
      'lawful neutral': 'narrative-alignment-4',
      'neutral': 'narrative-alignment-5',
      'chaotic neutral': 'narrative-alignment-6',
      'lawful evil': 'narrative-alignment-7',
      'neutral evil': 'narrative-alignment-8',
      'chaotic evil': 'narrative-alignment-9',
    };
    final fallback = normalized
        .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
        .replaceAll(RegExp(r'^-|-$'), '');
    return idsByValue[normalized] ?? 'legacy-alignment-$fallback';
  }

  Future<void> _migrateCharactersToV6() async {
    await customStatement('PRAGMA foreign_keys = OFF');

    await customStatement('''
      CREATE TABLE characters_v6 (
        id TEXT NOT NULL PRIMARY KEY,
        name TEXT NOT NULL,
        race_name TEXT NOT NULL,
        class_definition_id TEXT NULL,
        background_definition_ref_id TEXT NULL,
        class_name TEXT NOT NULL,
        level INTEGER NOT NULL,
        experience INTEGER NULL,
        equipment_loadout_id TEXT NULL,
        equipment_loadout_label TEXT NULL,
        current_hit_points INTEGER NULL,
        maximum_hit_points INTEGER NULL,
        temporary_hit_points INTEGER NULL,
        portrait_asset_path TEXT NULL,
        alignment TEXT NULL,
        appearance_details TEXT NULL,
        narrative_details TEXT NULL,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL
      )
    ''');

    await customStatement('''
      INSERT INTO characters_v6 (
        id,
        name,
        race_name,
        class_definition_id,
        background_definition_ref_id,
        class_name,
        level,
        experience,
        equipment_loadout_id,
        equipment_loadout_label,
        current_hit_points,
        maximum_hit_points,
        temporary_hit_points,
        portrait_asset_path,
        alignment,
        appearance_details,
        narrative_details,
        created_at,
        updated_at
      )
      SELECT
        id,
        name,
        race_name,
        class_definition_id,
        background_definition_ref_id,
        class_name,
        level,
        experience,
        equipment_loadout_id,
        equipment_loadout_label,
        current_hit_points,
        maximum_hit_points,
        temporary_hit_points,
        portrait_asset_path,
        alignment,
        appearance_details,
        narrative_details,
        created_at,
        updated_at
      FROM characters
    ''');

    await customStatement('DROP TABLE characters');
    await customStatement('ALTER TABLE characters_v6 RENAME TO characters');
    await customStatement('PRAGMA foreign_keys = ON');
  }

  Future<void> _migrateCharactersToV7() async {
    await customStatement('PRAGMA foreign_keys = OFF');

    await customStatement('''
      CREATE TABLE characters_v7 (
        id TEXT NOT NULL PRIMARY KEY,
        name TEXT NOT NULL,
        race_name TEXT NOT NULL,
        class_definition_id TEXT NULL,
        background_definition_ref_id TEXT NULL,
        class_name TEXT NOT NULL,
        level INTEGER NOT NULL,
        experience INTEGER NULL,
        equipment_loadout_id TEXT NULL,
        equipment_loadout_label TEXT NULL,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL
      )
    ''');

    await customStatement('''
      INSERT INTO characters_v7 (
        id,
        name,
        race_name,
        class_definition_id,
        background_definition_ref_id,
        class_name,
        level,
        experience,
        equipment_loadout_id,
        equipment_loadout_label,
        created_at,
        updated_at
      )
      SELECT
        id,
        name,
        race_name,
        class_definition_id,
        background_definition_ref_id,
        class_name,
        level,
        experience,
        equipment_loadout_id,
        equipment_loadout_label,
        created_at,
        updated_at
      FROM characters
    ''');

    await customStatement('DROP TABLE characters');
    await customStatement('ALTER TABLE characters_v7 RENAME TO characters');
    await customStatement('PRAGMA foreign_keys = ON');
  }

  Future<void> _migrateCharactersToV8() async {
    await customStatement('PRAGMA foreign_keys = OFF');

    await customStatement('''
      CREATE TABLE characters_v8 (
        id TEXT NOT NULL PRIMARY KEY,
        name TEXT NOT NULL,
        race_name TEXT NOT NULL,
        class_definition_id TEXT NULL,
        background_definition_ref_id TEXT NULL,
        class_name TEXT NOT NULL,
        level INTEGER NOT NULL,
        experience INTEGER NULL,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL
      )
    ''');

    await customStatement('''
      INSERT INTO characters_v8 (
        id,
        name,
        race_name,
        class_definition_id,
        background_definition_ref_id,
        class_name,
        level,
        experience,
        created_at,
        updated_at
      )
      SELECT
        id,
        name,
        race_name,
        class_definition_id,
        background_definition_ref_id,
        class_name,
        level,
        experience,
        created_at,
        updated_at
      FROM characters
    ''');

    await customStatement('DROP TABLE characters');
    await customStatement('ALTER TABLE characters_v8 RENAME TO characters');
    await customStatement('PRAGMA foreign_keys = ON');
  }

  CharacterAbilityScoreProvenancesCompanion _parseAbilityScoreProvenance({
    required String characterId,
    required String? rawValue,
    required String? fallbackMethodKey,
  }) {
    String? methodKey = fallbackMethodKey;
    final assignedScoresByAbility = <String, int>{};

    if (rawValue != null && rawValue.isNotEmpty) {
      for (final token in rawValue.split(';')) {
        final separatorIndex = token.indexOf('=');
        if (separatorIndex <= 0 || separatorIndex >= token.length - 1) {
          continue;
        }

        final key = token.substring(0, separatorIndex).trim();
        final value = token.substring(separatorIndex + 1).trim();
        if (key == 'method') {
          methodKey = value;
          continue;
        }

        final parsedScore = int.tryParse(value);
        if (parsedScore != null) {
          assignedScoresByAbility[key] = parsedScore;
        }
      }
    }

    return CharacterAbilityScoreProvenancesCompanion.insert(
      characterId: characterId,
      methodKey: Value(methodKey),
      strengthAssignedScore: Value(assignedScoresByAbility['Strength']),
      dexterityAssignedScore: Value(assignedScoresByAbility['Dexterity']),
      constitutionAssignedScore: Value(assignedScoresByAbility['Constitution']),
      intelligenceAssignedScore: Value(assignedScoresByAbility['Intelligence']),
      wisdomAssignedScore: Value(assignedScoresByAbility['Wisdom']),
      charismaAssignedScore: Value(assignedScoresByAbility['Charisma']),
    );
  }
}
