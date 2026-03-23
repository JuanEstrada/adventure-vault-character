import 'package:adventure_vault_character/src/features/characters/data/character_repository.dart';
import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_sheet_mapper.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_sheet_view_data.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_summary.dart';
import 'package:drift/drift.dart';

class DriftCharacterRepository implements CharacterRepository {
  DriftCharacterRepository({
    required AppDatabase database,
    CharacterSheetMapper characterSheetMapper = const CharacterSheetMapper(),
  })  : _database = database,
        _characterSheetMapper = characterSheetMapper;

  final AppDatabase _database;
  final CharacterSheetMapper _characterSheetMapper;

  @override
  Future<List<CharacterSummary>> getCharacterSummaries() async {
    final rows = await (_database.select(
      _database.characters,
    )..orderBy([
        (table) => OrderingTerm.desc(table.updatedAt),
        (table) => OrderingTerm.asc(table.name),
      ])).get();

    return rows
        .map(
          (row) => CharacterSummary(
            id: row.id,
            name: row.name,
            raceName: row.raceName,
            className: row.className,
            level: row.level,
            portraitAssetPath: row.portraitAssetPath,
          ),
        )
        .toList(growable: false);
  }

  @override
  Future<CharacterSummary> createCharacter(CreateCharacterInput input) async {
    final now = DateTime.now();
    final id = now.microsecondsSinceEpoch.toString();

    await _database.into(_database.characters).insert(
          CharactersCompanion.insert(
            id: id,
            name: input.name,
            raceName: input.raceName,
            backgroundId: Value(input.backgroundId),
            backgroundName: Value(input.backgroundName),
            backgroundSummary: Value(input.backgroundSummary),
            abilityScoreMethod: Value(input.abilityScoreMethod),
            abilityScoreProvenance: Value(input.abilityScoreProvenance),
            strength: Value(input.strength),
            dexterity: Value(input.dexterity),
            constitution: Value(input.constitution),
            intelligence: Value(input.intelligence),
            wisdom: Value(input.wisdom),
            charisma: Value(input.charisma),
            className: input.className,
            level: input.level,
            experience: Value(input.experience),
            currentHitPoints: Value(input.currentHitPoints),
            maximumHitPoints: Value(input.maximumHitPoints),
            temporaryHitPoints: Value(input.temporaryHitPoints),
            portraitAssetPath: Value(input.portraitAssetPath),
            createdAt: now,
            updatedAt: now,
          ),
        );

    return CharacterSummary(
      id: id,
      name: input.name,
      raceName: input.raceName,
      className: input.className,
      level: input.level,
      portraitAssetPath: input.portraitAssetPath,
    );
  }

  @override
  Future<CharacterSummary?> getCharacterSummaryById(String id) async {
    final row = await (_database.select(
      _database.characters,
    )..where((table) => table.id.equals(id))).getSingleOrNull();

    if (row == null) {
      return null;
    }

    return CharacterSummary(
      id: row.id,
      name: row.name,
      raceName: row.raceName,
      className: row.className,
      level: row.level,
      portraitAssetPath: row.portraitAssetPath,
    );
  }

  @override
  Future<CharacterSheetViewData?> getCharacterSheetById(String id) async {
    final row = await (_database.select(
      _database.characters,
    )..where((table) => table.id.equals(id))).getSingleOrNull();

    if (row == null) {
      return null;
    }

    return _characterSheetMapper.map(row);
  }
}
