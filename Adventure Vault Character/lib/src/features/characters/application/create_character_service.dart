import 'dart:convert';

import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:adventure_vault_character/src/features/characters/data/local/character_reference_dao.dart';
import 'package:adventure_vault_character/src/features/characters/data/local/character_write_dao.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_rules.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_summary.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_summary_mapper.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:adventure_vault_character/src/features/compendium/data/compendium_repository.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';
import 'package:drift/drift.dart';

class CreateCharacterService {
  CreateCharacterService({
    required AppDatabase database,
    required CharacterReferenceDao referenceDao,
    required CharacterWriteDao writeDao,
    required CompendiumRepository compendiumRepository,
    CharacterSummaryMapper characterSummaryMapper =
        const CharacterSummaryMapper(),
  }) : _database = database,
       _referenceDao = referenceDao,
       _writeDao = writeDao,
       _compendiumRepository = compendiumRepository,
       _characterSummaryMapper = characterSummaryMapper;

  final AppDatabase _database;
  final CharacterReferenceDao _referenceDao;
  final CharacterWriteDao _writeDao;
  final CompendiumRepository _compendiumRepository;
  final CharacterSummaryMapper _characterSummaryMapper;
  Future<CompendiumCatalog>? _catalogFuture;

  Future<CharacterSummary> createCharacter(CreateCharacterInput input) async {
    final now = DateTime.now();
    final id = now.microsecondsSinceEpoch.toString();
    return _persistCharacter(
      id: id,
      input: input,
      createdAt: now,
      updatedAt: now,
      existingRow: null,
      existingHitPoints: null,
    );
  }

  Future<CharacterSummary> updateCharacter(
    String id,
    CreateCharacterInput input,
  ) async {
    final existingRow = await (_database.select(
      _database.characters,
    )..where((table) => table.id.equals(id))).getSingleOrNull();
    if (existingRow == null) {
      throw StateError('Character not found.');
    }
    final existingHitPoints = await _readExistingHitPoints(id);

    return _persistCharacter(
      id: id,
      input: input,
      createdAt: existingRow.createdAt,
      updatedAt: DateTime.now(),
      existingRow: existingRow,
      existingHitPoints: existingHitPoints,
    );
  }

  Future<CharacterSummary> _persistCharacter({
    required String id,
    required CreateCharacterInput input,
    required DateTime createdAt,
    required DateTime updatedAt,
    required Character? existingRow,
    required CharacterHitPoint? existingHitPoints,
  }) async {
    final catalog = await _loadCatalog();
    final background = catalog.backgroundById(input.backgroundId);
    final classSeed = _classSeedFor(input.className);
    final proficiencyBonus = CharacterRules.proficiencyBonusForLevel(
      input.level,
    );
    final currency = _parseCurrencySummary(input.startingMoneySummary);
    final recomputedHitPoints = CharacterRules.startingHitPoints(
      hitDie: classSeed.hitDie ?? 10,
      constitutionScore: input.constitution,
      level: input.level,
    );
    final resolvedHitPoints = _resolveHitPoints(
      existingHitPoints: existingHitPoints,
      recomputedMaximum: recomputedHitPoints,
    );
    final inventoryItems = input.selectedEquipmentItems
        .map(_parseInventoryItemSpec)
        .toList(growable: false);

    if (input.equipmentLoadoutId == 'fallback-loadout' ||
        inventoryItems.any((item) => _isPlaceholderEquipmentItem(item.name))) {
      throw StateError('Unsupported equipment loadout selected.');
    }

    await _database.transaction(() async {
      await _ensureCoreSkillDefinitions();
      await _ensureClassDefinition(classSeed);
      await _ensureBackgroundDefinition(catalog, input, input.backgroundId);
      await _ensureEquipmentDefinitions(inventoryItems);

      final characterCompanion = CharactersCompanion(
        id: Value(id),
        name: Value(input.name),
        raceName: Value(input.raceName),
        classDefinitionId: Value(classSeed.id),
        backgroundDefinitionRefId: Value(input.backgroundId),
        className: Value(input.className),
        level: Value(input.level),
        experience: Value(input.experience),
        createdAt: Value(createdAt),
        updatedAt: Value(updatedAt),
      );

      if (existingRow == null) {
        await _writeDao.insertCharacter(characterCompanion);
      } else {
        await _writeDao.updateCharacter(id, characterCompanion);
      }

      await _writeAbilityScores(
        id,
        input,
        replaceExisting: existingRow != null,
      );
      await _writeAbilityScoreProvenance(
        id,
        input,
        replaceExisting: existingRow != null,
      );
      await _writeHitPoints(
        id,
        resolvedHitPoints,
        replaceExisting: existingRow != null,
      );
      await _writeFinishingDetails(
        id,
        input,
        replaceExisting: existingRow != null,
      );
      await _writeEquipmentLoadout(
        id,
        input,
        replaceExisting: existingRow != null,
      );
      await _writeDao.deleteSkillsByCharacterId(id);
      await _writeDao.insertSkills(
        _buildCharacterSkillRows(characterId: id, background: background),
      );
      await _writeDao.deleteSavingThrowsByCharacterId(id);
      await _writeDao.insertSavingThrows(
        _buildCharacterSavingThrowRows(
          characterId: id,
          savingThrowKeys: classSeed.savingThrowAbilities,
          abilityScores: _AbilityScores(
            strength: input.strength,
            dexterity: input.dexterity,
            constitution: input.constitution,
            intelligence: input.intelligence,
            wisdom: input.wisdom,
            charisma: input.charisma,
          ),
          proficiencyBonus: proficiencyBonus,
        ),
      );
      await _writeDao.deleteProficienciesByCharacterId(id);
      await _writeDao.insertProficiencies(
        _buildCharacterProficiencyRows(
          characterId: id,
          classSeed: classSeed,
          background: background,
        ),
      );
      final currencyCompanion = CharacterCurrencyCompanion(
        characterId: Value(id),
        copper: Value(currency.copper),
        silver: Value(currency.silver),
        electrum: Value(currency.electrum),
        gold: Value(currency.gold),
        platinum: Value(currency.platinum),
        summarySnapshot: Value(input.startingMoneySummary),
      );
      if (existingRow == null) {
        await _writeDao.insertCurrency(
          CharacterCurrencyCompanion.insert(
            characterId: id,
            copper: Value(currency.copper),
            silver: Value(currency.silver),
            electrum: Value(currency.electrum),
            gold: Value(currency.gold),
            platinum: Value(currency.platinum),
            summarySnapshot: Value(input.startingMoneySummary),
          ),
        );
      } else {
        await _writeDao.replaceCurrency(currencyCompanion);
      }
      await _writeDao.deleteInventoryByCharacterId(id);
      await _writeDao.insertInventory(
        _buildInventoryRows(characterId: id, items: inventoryItems),
      );
    });

    return _characterSummaryMapper.fromCreateInput(id: id, input: input);
  }

  Future<void> _writeAbilityScores(
    String id,
    CreateCharacterInput input, {
    required bool replaceExisting,
  }) async {
    if (replaceExisting) {
      await _writeDao.replaceAbilityScores(
        CharacterAbilityScoresCompanion(
          characterId: Value(id),
          strengthScore: Value(input.strength),
          dexterityScore: Value(input.dexterity),
          constitutionScore: Value(input.constitution),
          intelligenceScore: Value(input.intelligence),
          wisdomScore: Value(input.wisdom),
          charismaScore: Value(input.charisma),
          strengthModifier: Value(
            CharacterRules.abilityModifier(input.strength),
          ),
          dexterityModifier: Value(
            CharacterRules.abilityModifier(input.dexterity),
          ),
          constitutionModifier: Value(
            CharacterRules.abilityModifier(input.constitution),
          ),
          intelligenceModifier: Value(
            CharacterRules.abilityModifier(input.intelligence),
          ),
          wisdomModifier: Value(CharacterRules.abilityModifier(input.wisdom)),
          charismaModifier: Value(
            CharacterRules.abilityModifier(input.charisma),
          ),
        ),
      );
      return;
    }

    await _writeDao.insertAbilityScores(
      CharacterAbilityScoresCompanion.insert(
        characterId: id,
        strengthScore: input.strength,
        dexterityScore: input.dexterity,
        constitutionScore: input.constitution,
        intelligenceScore: input.intelligence,
        wisdomScore: input.wisdom,
        charismaScore: input.charisma,
        strengthModifier: Value(CharacterRules.abilityModifier(input.strength)),
        dexterityModifier: Value(
          CharacterRules.abilityModifier(input.dexterity),
        ),
        constitutionModifier: Value(
          CharacterRules.abilityModifier(input.constitution),
        ),
        intelligenceModifier: Value(
          CharacterRules.abilityModifier(input.intelligence),
        ),
        wisdomModifier: Value(CharacterRules.abilityModifier(input.wisdom)),
        charismaModifier: Value(CharacterRules.abilityModifier(input.charisma)),
      ),
    );
  }

  Future<void> _writeAbilityScoreProvenance(
    String id,
    CreateCharacterInput input, {
    required bool replaceExisting,
  }) async {
    final provenance = _parseAbilityScoreProvenance(
      input.abilityScoreProvenance,
      fallbackMethodKey: input.abilityScoreMethod,
    );
    final companion = CharacterAbilityScoreProvenancesCompanion(
      characterId: Value(id),
      methodKey: Value(provenance.methodKey),
      strengthAssignedScore: Value(
        provenance.assignedScoresByAbility['Strength'],
      ),
      dexterityAssignedScore: Value(
        provenance.assignedScoresByAbility['Dexterity'],
      ),
      constitutionAssignedScore: Value(
        provenance.assignedScoresByAbility['Constitution'],
      ),
      intelligenceAssignedScore: Value(
        provenance.assignedScoresByAbility['Intelligence'],
      ),
      wisdomAssignedScore: Value(provenance.assignedScoresByAbility['Wisdom']),
      charismaAssignedScore: Value(
        provenance.assignedScoresByAbility['Charisma'],
      ),
    );
    if (replaceExisting) {
      await _writeDao.replaceAbilityScoreProvenance(companion);
      return;
    }

    await _writeDao.insertAbilityScoreProvenance(companion);
  }

  Future<void> _writeHitPoints(
    String id,
    _ResolvedHitPoints hitPoints, {
    required bool replaceExisting,
  }) async {
    final companion = CharacterHitPointsCompanion(
      characterId: Value(id),
      current: Value(hitPoints.current),
      maximum: Value(hitPoints.maximum),
      temporary: Value(hitPoints.temporary),
    );
    if (replaceExisting) {
      await _writeDao.replaceHitPoints(companion);
      return;
    }

    await _writeDao.insertHitPoints(
      CharacterHitPointsCompanion.insert(
        characterId: id,
        current: hitPoints.current,
        maximum: hitPoints.maximum,
        temporary: hitPoints.temporary,
      ),
    );
  }

  Future<void> _writeFinishingDetails(
    String id,
    CreateCharacterInput input, {
    required bool replaceExisting,
  }) async {
    final companion = CharacterFinishingDetailsCompanion(
      characterId: Value(id),
      portraitAssetPath: Value(input.portraitAssetPath),
      alignment: Value(input.alignment),
      appearanceDetails: Value(input.appearanceDetails),
      narrativeDetails: Value(input.narrativeDetails),
    );
    if (replaceExisting) {
      await _writeDao.replaceFinishingDetails(companion);
      return;
    }

    await _writeDao.insertFinishingDetails(
      CharacterFinishingDetailsCompanion.insert(
        characterId: id,
        portraitAssetPath: Value(input.portraitAssetPath),
        alignment: Value(input.alignment),
        appearanceDetails: Value(input.appearanceDetails),
        narrativeDetails: Value(input.narrativeDetails),
      ),
    );
  }

  Future<void> _writeEquipmentLoadout(
    String id,
    CreateCharacterInput input, {
    required bool replaceExisting,
  }) async {
    final companion = CharacterEquipmentLoadoutsCompanion(
      characterId: Value(id),
      loadoutId: Value(input.equipmentLoadoutId),
      loadoutLabel: Value(input.equipmentLoadoutLabel),
    );
    if (replaceExisting) {
      await _writeDao.replaceEquipmentLoadout(companion);
      return;
    }

    await _writeDao.insertEquipmentLoadout(
      CharacterEquipmentLoadoutsCompanion.insert(
        characterId: id,
        loadoutId: Value(input.equipmentLoadoutId),
        loadoutLabel: Value(input.equipmentLoadoutLabel),
      ),
    );
  }

  Future<CompendiumCatalog> _loadCatalog() {
    return _catalogFuture ??= _compendiumRepository.loadCatalog();
  }

  Future<void> _ensureCoreSkillDefinitions() async {
    await _referenceDao.upsertSkillDefinitions(
      _skillDefinitions
          .map(
            (definition) => SkillDefinitionsCompanion.insert(
              id: definition.id,
              key: definition.key,
              name: definition.name,
              governingAbility: definition.governingAbility,
              description: const Value(null),
            ),
          )
          .toList(growable: false),
    );
  }

  Future<void> _ensureClassDefinition(_ClassSeed classSeed) async {
    await _referenceDao.upsertClassDefinition(
      ClassDefinitionsCompanion.insert(
        id: classSeed.id,
        key: classSeed.key,
        name: classSeed.name,
        hitDie: Value(classSeed.hitDie),
        isSpellcaster: Value(classSeed.isSpellcaster),
        spellcastingAbility: Value(classSeed.spellcastingAbility),
        description: const Value(null),
      ),
    );
  }

  Future<void> _ensureBackgroundDefinition(
    CompendiumCatalog catalog,
    CreateCharacterInput input,
    String backgroundDefinitionId,
  ) async {
    final background = catalog.backgroundById(input.backgroundId);
    await _referenceDao.upsertBackgroundDefinition(
      BackgroundDefinitionsCompanion.insert(
        id: backgroundDefinitionId,
        key: _slugify(input.backgroundId),
        name: input.backgroundName,
        summary: Value(input.backgroundSummary),
        featureName: Value(background?.socialPerks.firstOrNull),
        featureDescription: Value(background?.socialPerks.join('\n')),
        grantedSkillKeysJson: Value(
          background == null
              ? null
              : jsonEncode(_extractBackgroundSkillKeys(background)),
        ),
        grantedToolKeysJson: const Value(null),
        grantedLanguageKeysJson: Value(
          background == null
              ? null
              : jsonEncode(_extractBackgroundLanguageKeys(background)),
        ),
        startingEquipmentJson: Value(
          background == null ? null : jsonEncode(background.socialPerks),
        ),
      ),
    );
  }

  Future<void> _ensureEquipmentDefinitions(
    List<_InventoryItemSpec> items,
  ) async {
    await _referenceDao.upsertEquipmentDefinitions(
      items
          .map(
            (item) => EquipmentDefinitionsCompanion.insert(
              id: _equipmentDefinitionId(item.name),
              key: _slugify(item.name),
              name: item.name,
              category: _inferEquipmentCategory(item.name),
              subcategory: const Value(null),
              weight: const Value(null),
              costValue: const Value(null),
              costUnit: const Value(null),
              isContainer: Value(_looksLikeContainer(item.name)),
              isStackable: const Value(true),
              description: const Value(null),
              weaponPropertiesJson: const Value(null),
              armorPropertiesJson: const Value(null),
            ),
          )
          .toList(growable: false),
    );
  }

  List<CharacterSkillsCompanion> _buildCharacterSkillRows({
    required String characterId,
    required CompendiumBackground? background,
  }) {
    final proficientSkillKeys = _extractBackgroundSkillKeys(background);
    return _skillDefinitions
        .map(
          (definition) => CharacterSkillsCompanion.insert(
            characterId: characterId,
            skillDefinitionId: definition.id,
            isProficient: Value(proficientSkillKeys.contains(definition.key)),
            hasExpertise: const Value(false),
            miscBonus: const Value(0),
            totalBonus: const Value(null),
          ),
        )
        .toList(growable: false);
  }

  List<CharacterSavingThrowsCompanion> _buildCharacterSavingThrowRows({
    required String characterId,
    required List<String> savingThrowKeys,
    required _AbilityScores abilityScores,
    required int proficiencyBonus,
  }) {
    return _abilityKeys
        .map(
          (abilityKey) => CharacterSavingThrowsCompanion.insert(
            characterId: characterId,
            abilityKey: abilityKey,
            isProficient: Value(savingThrowKeys.contains(abilityKey)),
            miscBonus: const Value(0),
            totalBonus: Value(
              _abilityModifier(abilityScores.scoreFor(abilityKey)) +
                  (savingThrowKeys.contains(abilityKey) ? proficiencyBonus : 0),
            ),
          ),
        )
        .toList(growable: false);
  }

  List<CharacterProficienciesCompanion> _buildCharacterProficiencyRows({
    required String characterId,
    required _ClassSeed classSeed,
    required CompendiumBackground? background,
  }) {
    return <CharacterProficienciesCompanion>[
      ...classSeed.armorProficiencies.map(
        (item) => _buildProficiencyRow(
          characterId: characterId,
          proficiencyType: 'armor',
          referenceKey: item,
          sourceType: 'class',
          sourceId: classSeed.id,
        ),
      ),
      ...classSeed.weaponProficiencies.map(
        (item) => _buildProficiencyRow(
          characterId: characterId,
          proficiencyType: 'weapon',
          referenceKey: item,
          sourceType: 'class',
          sourceId: classSeed.id,
        ),
      ),
      ...classSeed.toolProficiencies.map(
        (item) => _buildProficiencyRow(
          characterId: characterId,
          proficiencyType: 'tool',
          referenceKey: item,
          sourceType: 'class',
          sourceId: classSeed.id,
        ),
      ),
      ..._extractBackgroundLanguageKeys(background).map(
        (item) => _buildProficiencyRow(
          characterId: characterId,
          proficiencyType: 'language',
          referenceKey: item,
          sourceType: 'background',
          sourceId: background?.id,
        ),
      ),
      ..._extractBackgroundSkillKeys(background).map(
        (item) => _buildProficiencyRow(
          characterId: characterId,
          proficiencyType: 'skill',
          referenceKey: item,
          sourceType: 'background',
          sourceId: background?.id,
        ),
      ),
      ..._extractBackgroundNarrativeBonuses(background).map(
        (item) => _buildProficiencyRow(
          characterId: characterId,
          proficiencyType: 'background',
          referenceKey: item,
          sourceType: 'background',
          sourceId: background?.id,
        ),
      ),
    ];
  }

  _ResolvedHitPoints _resolveHitPoints({
    required CharacterHitPoint? existingHitPoints,
    required int recomputedMaximum,
  }) {
    if (existingHitPoints == null) {
      return _ResolvedHitPoints(
        current: recomputedMaximum,
        maximum: recomputedMaximum,
        temporary: 0,
      );
    }

    final previousCurrent = existingHitPoints.current;
    final previousMaximum = existingHitPoints.maximum;
    final previousTemporary = existingHitPoints.temporary;
    final current = previousCurrent >= previousMaximum
        ? recomputedMaximum
        : previousCurrent.clamp(0, recomputedMaximum);

    return _ResolvedHitPoints(
      current: current,
      maximum: recomputedMaximum,
      temporary: previousTemporary,
    );
  }

  Future<CharacterHitPoint?> _readExistingHitPoints(String id) {
    return (_database.select(
      _database.characterHitPoints,
    )..where((table) => table.characterId.equals(id))).getSingleOrNull();
  }

  int _abilityModifier(int score) => CharacterRules.abilityModifier(score);

  CharacterProficienciesCompanion _buildProficiencyRow({
    required String characterId,
    required String proficiencyType,
    required String referenceKey,
    required String sourceType,
    required String? sourceId,
  }) {
    final id =
        '$characterId-$proficiencyType-${_slugify(referenceKey)}-${_slugify(sourceType)}';
    return CharacterProficienciesCompanion.insert(
      id: id,
      characterId: characterId,
      proficiencyType: proficiencyType,
      referenceKey: referenceKey,
      sourceType: Value(sourceType),
      sourceId: Value(sourceId),
      isExpertise: const Value(false),
    );
  }

  List<CharacterInventoryCompanion> _buildInventoryRows({
    required String characterId,
    required List<_InventoryItemSpec> items,
  }) {
    return items
        .asMap()
        .entries
        .map(
          (entry) => CharacterInventoryCompanion.insert(
            id: '$characterId-inventory-${entry.key + 1}',
            characterId: characterId,
            equipmentDefinitionId: Value(
              _equipmentDefinitionId(entry.value.name),
            ),
            trinketDefinitionId: const Value(null),
            displayNameSnapshot: Value(entry.value.name),
            quantity: Value(entry.value.quantity),
            isEquipped: Value(_looksEquipped(entry.value.name)),
            isCarried: const Value(true),
            isFavorite: const Value(false),
            chargesCurrent: const Value(null),
            chargesMax: const Value(null),
            containerInventoryItemId: const Value(null),
            notes: const Value(null),
          ),
        )
        .toList(growable: false);
  }

  String _equipmentDefinitionId(String name) => 'equipment-${_slugify(name)}';

  String _slugify(String raw) {
    return raw
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
        .replaceAll(RegExp(r'^-|-$'), '');
  }

  String _inferEquipmentCategory(String itemName) {
    final lower = itemName.toLowerCase();
    if (lower.contains('pack')) {
      return 'adventuring_gear';
    }
    if (lower.contains('mail') ||
        lower.contains('armor') ||
        lower.contains('shield')) {
      return 'armor';
    }
    if (lower.contains('sword') ||
        lower.contains('dagger') ||
        lower.contains('staff') ||
        lower.contains('bow')) {
      return 'weapon';
    }
    if (lower.contains('pouch') || lower.contains('focus')) {
      return 'focus';
    }
    return 'gear';
  }

  bool _looksLikeContainer(String itemName) {
    final lower = itemName.toLowerCase();
    return lower.contains('pack') ||
        lower.contains('pouch') ||
        lower.contains('bag');
  }

  bool _looksEquipped(String itemName) {
    final lower = itemName.toLowerCase();
    return lower.contains('mail') ||
        lower.contains('armor') ||
        lower.contains('shield') ||
        lower.contains('sword') ||
        lower.contains('dagger') ||
        lower.contains('staff') ||
        lower.contains('bow');
  }

  _InventoryItemSpec _parseInventoryItemSpec(String raw) {
    final trimmed = raw.trim();
    final match = RegExp(r'^(\d+)\s+(.+)$').firstMatch(trimmed);
    if (match == null) {
      return _InventoryItemSpec(name: trimmed, quantity: 1);
    }

    final quantity = int.tryParse(match.group(1) ?? '') ?? 1;
    final name = (match.group(2) ?? trimmed).trim();
    return _InventoryItemSpec(name: name, quantity: quantity);
  }

  bool _isPlaceholderEquipmentItem(String itemName) {
    return itemName.trim().toLowerCase().contains('pending');
  }

  List<String> _extractBackgroundSkillKeys(CompendiumBackground? background) {
    if (background == null) {
      return const <String>[];
    }

    final skillBonus = background.bonuses.firstWhere(
      (bonus) => bonus.toLowerCase().startsWith('skills:'),
      orElse: () => '',
    );
    if (skillBonus.isEmpty) {
      return const <String>[];
    }

    return skillBonus
        .replaceFirst(RegExp(r'^skills:\s*', caseSensitive: false), '')
        .split(',')
        .map((item) => _slugify(item))
        .where((item) => item.isNotEmpty)
        .toList(growable: false);
  }

  List<String> _extractBackgroundLanguageKeys(
    CompendiumBackground? background,
  ) {
    if (background == null) {
      return const <String>[];
    }

    final languageBonus = background.bonuses.firstWhere(
      (bonus) => bonus.toLowerCase().startsWith('languages:'),
      orElse: () => '',
    );
    if (languageBonus.isEmpty) {
      return const <String>[];
    }

    return languageBonus
        .replaceFirst(RegExp(r'^languages:\s*', caseSensitive: false), '')
        .split(',')
        .map((item) => _slugify(item))
        .where((item) => item.isNotEmpty)
        .toList(growable: false);
  }

  List<String> _extractBackgroundNarrativeBonuses(
    CompendiumBackground? background,
  ) {
    if (background == null) {
      return const <String>[];
    }

    return background.bonuses
        .where((bonus) {
          final normalized = bonus.toLowerCase();
          return !normalized.startsWith('skills:') &&
              !normalized.startsWith('languages:') &&
              bonus.trim().isNotEmpty;
        })
        .toList(growable: false);
  }

  _CurrencyBreakdown _parseCurrencySummary(String raw) {
    final normalized = raw.toLowerCase();

    int read(String unit) {
      final match = RegExp('([0-9]+)\\s*$unit\\b').firstMatch(normalized);
      return int.tryParse(match?.group(1) ?? '') ?? 0;
    }

    return _CurrencyBreakdown(
      copper: read('cp'),
      silver: read('sp'),
      electrum: read('ep'),
      gold: read('gp'),
      platinum: read('pp'),
    );
  }

  _ClassSeed _classSeedFor(String className) {
    final key = _slugify(className);
    return _classSeeds[key] ??
        _ClassSeed(
          id: 'class-$key',
          key: key,
          name: className,
          hitDie: null,
          isSpellcaster: false,
          spellcastingAbility: null,
          savingThrowAbilities: const <String>[],
          armorProficiencies: const <String>[],
          weaponProficiencies: const <String>[],
          toolProficiencies: const <String>[],
        );
  }

  _ParsedAbilityScoreProvenance _parseAbilityScoreProvenance(
    String rawValue, {
    required String fallbackMethodKey,
  }) {
    var methodKey = fallbackMethodKey.trim().isEmpty ? null : fallbackMethodKey;
    final assignedScoresByAbility = <String, int>{};

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

    return _ParsedAbilityScoreProvenance(
      methodKey: methodKey,
      assignedScoresByAbility: assignedScoresByAbility,
    );
  }
}

class _AbilityScores {
  const _AbilityScores({
    required this.strength,
    required this.dexterity,
    required this.constitution,
    required this.intelligence,
    required this.wisdom,
    required this.charisma,
  });

  final int strength;
  final int dexterity;
  final int constitution;
  final int intelligence;
  final int wisdom;
  final int charisma;

  int scoreFor(String abilityKey) {
    return switch (abilityKey) {
      'STR' => strength,
      'DEX' => dexterity,
      'CON' => constitution,
      'INT' => intelligence,
      'WIS' => wisdom,
      'CHA' => charisma,
      _ => 0,
    };
  }
}

class _ResolvedHitPoints {
  const _ResolvedHitPoints({
    required this.current,
    required this.maximum,
    required this.temporary,
  });

  final int current;
  final int maximum;
  final int temporary;
}

class _CurrencyBreakdown {
  const _CurrencyBreakdown({
    required this.copper,
    required this.silver,
    required this.electrum,
    required this.gold,
    required this.platinum,
  });

  final int copper;
  final int silver;
  final int electrum;
  final int gold;
  final int platinum;
}

class _InventoryItemSpec {
  const _InventoryItemSpec({required this.name, required this.quantity});

  final String name;
  final int quantity;
}

class _ParsedAbilityScoreProvenance {
  const _ParsedAbilityScoreProvenance({
    required this.methodKey,
    required this.assignedScoresByAbility,
  });

  final String? methodKey;
  final Map<String, int> assignedScoresByAbility;
}

class _SkillDefinitionSeed {
  const _SkillDefinitionSeed({
    required this.id,
    required this.key,
    required this.name,
    required this.governingAbility,
  });

  final String id;
  final String key;
  final String name;
  final String governingAbility;
}

class _ClassSeed {
  const _ClassSeed({
    required this.id,
    required this.key,
    required this.name,
    required this.hitDie,
    required this.isSpellcaster,
    required this.spellcastingAbility,
    required this.savingThrowAbilities,
    required this.armorProficiencies,
    required this.weaponProficiencies,
    required this.toolProficiencies,
  });

  final String id;
  final String key;
  final String name;
  final int? hitDie;
  final bool isSpellcaster;
  final String? spellcastingAbility;
  final List<String> savingThrowAbilities;
  final List<String> armorProficiencies;
  final List<String> weaponProficiencies;
  final List<String> toolProficiencies;
}

const List<String> _abilityKeys = <String>[
  'STR',
  'DEX',
  'CON',
  'INT',
  'WIS',
  'CHA',
];

const List<_SkillDefinitionSeed> _skillDefinitions = <_SkillDefinitionSeed>[
  _SkillDefinitionSeed(
    id: 'skill-acrobatics',
    key: 'acrobatics',
    name: 'Acrobatics',
    governingAbility: 'DEX',
  ),
  _SkillDefinitionSeed(
    id: 'skill-animal-handling',
    key: 'animal-handling',
    name: 'Animal Handling',
    governingAbility: 'WIS',
  ),
  _SkillDefinitionSeed(
    id: 'skill-arcana',
    key: 'arcana',
    name: 'Arcana',
    governingAbility: 'INT',
  ),
  _SkillDefinitionSeed(
    id: 'skill-athletics',
    key: 'athletics',
    name: 'Athletics',
    governingAbility: 'STR',
  ),
  _SkillDefinitionSeed(
    id: 'skill-deception',
    key: 'deception',
    name: 'Deception',
    governingAbility: 'CHA',
  ),
  _SkillDefinitionSeed(
    id: 'skill-history',
    key: 'history',
    name: 'History',
    governingAbility: 'INT',
  ),
  _SkillDefinitionSeed(
    id: 'skill-insight',
    key: 'insight',
    name: 'Insight',
    governingAbility: 'WIS',
  ),
  _SkillDefinitionSeed(
    id: 'skill-intimidation',
    key: 'intimidation',
    name: 'Intimidation',
    governingAbility: 'CHA',
  ),
  _SkillDefinitionSeed(
    id: 'skill-investigation',
    key: 'investigation',
    name: 'Investigation',
    governingAbility: 'INT',
  ),
  _SkillDefinitionSeed(
    id: 'skill-medicine',
    key: 'medicine',
    name: 'Medicine',
    governingAbility: 'WIS',
  ),
  _SkillDefinitionSeed(
    id: 'skill-nature',
    key: 'nature',
    name: 'Nature',
    governingAbility: 'INT',
  ),
  _SkillDefinitionSeed(
    id: 'skill-perception',
    key: 'perception',
    name: 'Perception',
    governingAbility: 'WIS',
  ),
  _SkillDefinitionSeed(
    id: 'skill-performance',
    key: 'performance',
    name: 'Performance',
    governingAbility: 'CHA',
  ),
  _SkillDefinitionSeed(
    id: 'skill-persuasion',
    key: 'persuasion',
    name: 'Persuasion',
    governingAbility: 'CHA',
  ),
  _SkillDefinitionSeed(
    id: 'skill-religion',
    key: 'religion',
    name: 'Religion',
    governingAbility: 'INT',
  ),
  _SkillDefinitionSeed(
    id: 'skill-sleight-of-hand',
    key: 'sleight-of-hand',
    name: 'Sleight of Hand',
    governingAbility: 'DEX',
  ),
  _SkillDefinitionSeed(
    id: 'skill-stealth',
    key: 'stealth',
    name: 'Stealth',
    governingAbility: 'DEX',
  ),
  _SkillDefinitionSeed(
    id: 'skill-survival',
    key: 'survival',
    name: 'Survival',
    governingAbility: 'WIS',
  ),
];

final Map<String, _ClassSeed> _classSeeds = <String, _ClassSeed>{
  'barbarian': const _ClassSeed(
    id: 'class-barbarian',
    key: 'barbarian',
    name: 'Barbarian',
    hitDie: 12,
    isSpellcaster: false,
    spellcastingAbility: null,
    savingThrowAbilities: <String>['STR', 'CON'],
    armorProficiencies: <String>['light-armor', 'medium-armor', 'shields'],
    weaponProficiencies: <String>['simple-weapons', 'martial-weapons'],
    toolProficiencies: <String>[],
  ),
  'bard': const _ClassSeed(
    id: 'class-bard',
    key: 'bard',
    name: 'Bard',
    hitDie: 8,
    isSpellcaster: true,
    spellcastingAbility: 'CHA',
    savingThrowAbilities: <String>['DEX', 'CHA'],
    armorProficiencies: <String>['light-armor'],
    weaponProficiencies: <String>[
      'simple-weapons',
      'hand-crossbows',
      'longswords',
      'rapiers',
      'shortswords',
    ],
    toolProficiencies: <String>['musical-instruments'],
  ),
  'cleric': const _ClassSeed(
    id: 'class-cleric',
    key: 'cleric',
    name: 'Cleric',
    hitDie: 8,
    isSpellcaster: true,
    spellcastingAbility: 'WIS',
    savingThrowAbilities: <String>['WIS', 'CHA'],
    armorProficiencies: <String>['light-armor', 'medium-armor', 'shields'],
    weaponProficiencies: <String>['simple-weapons'],
    toolProficiencies: <String>[],
  ),
  'druid': const _ClassSeed(
    id: 'class-druid',
    key: 'druid',
    name: 'Druid',
    hitDie: 8,
    isSpellcaster: true,
    spellcastingAbility: 'WIS',
    savingThrowAbilities: <String>['INT', 'WIS'],
    armorProficiencies: <String>['light-armor', 'medium-armor', 'shields'],
    weaponProficiencies: <String>[
      'clubs',
      'daggers',
      'darts',
      'javelins',
      'maces',
      'quarterstaffs',
      'scimitars',
      'sickles',
      'slings',
      'spears',
    ],
    toolProficiencies: <String>['herbalism-kit'],
  ),
  'fighter': const _ClassSeed(
    id: 'class-fighter',
    key: 'fighter',
    name: 'Fighter',
    hitDie: 10,
    isSpellcaster: false,
    spellcastingAbility: null,
    savingThrowAbilities: <String>['STR', 'CON'],
    armorProficiencies: <String>[
      'light-armor',
      'medium-armor',
      'heavy-armor',
      'shields',
    ],
    weaponProficiencies: <String>['simple-weapons', 'martial-weapons'],
    toolProficiencies: <String>[],
  ),
  'monk': const _ClassSeed(
    id: 'class-monk',
    key: 'monk',
    name: 'Monk',
    hitDie: 8,
    isSpellcaster: false,
    spellcastingAbility: null,
    savingThrowAbilities: <String>['STR', 'DEX'],
    armorProficiencies: <String>[],
    weaponProficiencies: <String>['simple-weapons', 'shortswords'],
    toolProficiencies: <String>['artisan-tool-or-musical-instrument'],
  ),
  'paladin': const _ClassSeed(
    id: 'class-paladin',
    key: 'paladin',
    name: 'Paladin',
    hitDie: 10,
    isSpellcaster: true,
    spellcastingAbility: 'CHA',
    savingThrowAbilities: <String>['WIS', 'CHA'],
    armorProficiencies: <String>[
      'light-armor',
      'medium-armor',
      'heavy-armor',
      'shields',
    ],
    weaponProficiencies: <String>['simple-weapons', 'martial-weapons'],
    toolProficiencies: <String>[],
  ),
  'ranger': const _ClassSeed(
    id: 'class-ranger',
    key: 'ranger',
    name: 'Ranger',
    hitDie: 10,
    isSpellcaster: true,
    spellcastingAbility: 'WIS',
    savingThrowAbilities: <String>['STR', 'DEX'],
    armorProficiencies: <String>['light-armor', 'medium-armor', 'shields'],
    weaponProficiencies: <String>['simple-weapons', 'martial-weapons'],
    toolProficiencies: <String>[],
  ),
  'rogue': const _ClassSeed(
    id: 'class-rogue',
    key: 'rogue',
    name: 'Rogue',
    hitDie: 8,
    isSpellcaster: false,
    spellcastingAbility: null,
    savingThrowAbilities: <String>['DEX', 'INT'],
    armorProficiencies: <String>['light-armor'],
    weaponProficiencies: <String>[
      'simple-weapons',
      'hand-crossbows',
      'longswords',
      'rapiers',
      'shortswords',
    ],
    toolProficiencies: <String>['thieves-tools'],
  ),
  'sorcerer': const _ClassSeed(
    id: 'class-sorcerer',
    key: 'sorcerer',
    name: 'Sorcerer',
    hitDie: 6,
    isSpellcaster: true,
    spellcastingAbility: 'CHA',
    savingThrowAbilities: <String>['CON', 'CHA'],
    armorProficiencies: <String>[],
    weaponProficiencies: <String>[
      'daggers',
      'darts',
      'slings',
      'quarterstaffs',
      'light-crossbows',
    ],
    toolProficiencies: <String>[],
  ),
  'warlock': const _ClassSeed(
    id: 'class-warlock',
    key: 'warlock',
    name: 'Warlock',
    hitDie: 8,
    isSpellcaster: true,
    spellcastingAbility: 'CHA',
    savingThrowAbilities: <String>['WIS', 'CHA'],
    armorProficiencies: <String>['light-armor'],
    weaponProficiencies: <String>['simple-weapons'],
    toolProficiencies: <String>[],
  ),
  'wizard': const _ClassSeed(
    id: 'class-wizard',
    key: 'wizard',
    name: 'Wizard',
    hitDie: 6,
    isSpellcaster: true,
    spellcastingAbility: 'INT',
    savingThrowAbilities: <String>['INT', 'WIS'],
    armorProficiencies: <String>[],
    weaponProficiencies: <String>[
      'daggers',
      'darts',
      'slings',
      'quarterstaffs',
      'light-crossbows',
    ],
    toolProficiencies: <String>[],
  ),
};
