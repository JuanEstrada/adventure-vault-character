import 'dart:convert';

import 'package:adventure_vault_character/src/features/characters/domain/equipment_summary_view_data.dart';
import 'package:adventure_vault_character/src/features/characters/data/local/app_database.dart';
import 'package:adventure_vault_character/src/features/compendium/data/compendium_repository.dart';
import 'package:adventure_vault_character/src/features/compendium/data/imported_compendium_content.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart';

class AssetCompendiumRepository implements CompendiumRepository {
  AssetCompendiumRepository({
    AssetBundle? bundle,
    AppDatabase? database,
    String backgroundsAssetPath =
        'local-assets/FightClub5eXML-master/Sources/System_Reference_Document_DND_5.5e/default_backgrounds_5.5e.xml',
    String racesAssetPath =
        'local-assets/FightClub5eXML-master/Sources/System_Reference_Document_DND_5.5e/default_races_5.5e.xml',
    String classesAssetPath =
        'local-assets/FightClub5eXML-master/Sources/System_Reference_Document_DND_5.5e/default_classes_5.5e.xml',
    String spellsAssetPath =
        'local-assets/FightClub5eXML-master/Sources/System_Reference_Document_DND_5.5e/default_spells_5.5e.xml',
    String featsAssetPath =
        'local-assets/FightClub5eXML-master/Sources/System_Reference_Document_DND_5.5e/default_feats_5.5e.xml',
    String monstersAssetPath =
        'local-assets/FightClub5eXML-master/Sources/System_Reference_Document_DND_5.5e/default_bestiary_5.5e.xml',
    String phbBackgroundsAssetPath =
        'local-assets/FightClub5eXML-master/Sources/DND_5e/WizardsOfTheCoast/01_Core/01_Players_Handbook/backgrounds-phb.xml',
    String scagBackgroundsAssetPath =
        'local-assets/FightClub5eXML-master/Sources/DND_5e/WizardsOfTheCoast/03_Campaign_Settings/Sword_Coast_Adventurers_Guide/backgrounds-scag.xml',
    String pamBackgroundsAssetPath =
        'local-assets/FightClub5eXML-master/Sources/DND_5e/WizardsOfTheCoast/03_Campaign_Settings/Planescape_Adventures_in_the_Multiverse/backgrounds-pam.xml',
    String ggrBackgroundsAssetPath =
        'local-assets/FightClub5eXML-master/Sources/DND_5e/WizardsOfTheCoast/03_Campaign_Settings/Guildmasters_Guide_to_Ravnica/backgrounds-ggr.xml',
    String erlwBackgroundsAssetPath =
        'local-assets/FightClub5eXML-master/Sources/DND_5e/WizardsOfTheCoast/03_Campaign_Settings/Eberron_Rising_From_the_Last_War/backgrounds-erlw.xml',
    String fallbackCatalogAssetPath = 'assets/compendium/catalog.json',
  }) : _bundle = bundle ?? rootBundle,
       _database = database,
       _backgroundsAssetPath = backgroundsAssetPath,
       _racesAssetPath = racesAssetPath,
       _classesAssetPath = classesAssetPath,
       _spellsAssetPath = spellsAssetPath,
       _featsAssetPath = featsAssetPath,
       _monstersAssetPath = monstersAssetPath,
       _phbBackgroundsAssetPath = phbBackgroundsAssetPath,
       _scagBackgroundsAssetPath = scagBackgroundsAssetPath,
       _pamBackgroundsAssetPath = pamBackgroundsAssetPath,
       _ggrBackgroundsAssetPath = ggrBackgroundsAssetPath,
       _erlwBackgroundsAssetPath = erlwBackgroundsAssetPath,
       _fallbackCatalogAssetPath = fallbackCatalogAssetPath;

  final AssetBundle _bundle;
  final AppDatabase? _database;
  final String _backgroundsAssetPath;
  final String _racesAssetPath;
  final String _classesAssetPath;
  final String _spellsAssetPath;
  final String _featsAssetPath;
  final String _monstersAssetPath;
  final String _phbBackgroundsAssetPath;
  final String _scagBackgroundsAssetPath;
  final String _pamBackgroundsAssetPath;
  final String _ggrBackgroundsAssetPath;
  final String _erlwBackgroundsAssetPath;
  final String _fallbackCatalogAssetPath;

  CompendiumCatalog? _cachedCatalog;
  final Map<String, String> _importedPackXmlById = <String, String>{};

  @override
  Future<CompendiumCatalog> loadCatalog() async {
    final cachedCatalog = _cachedCatalog;
    if (cachedCatalog != null) {
      return cachedCatalog;
    }

    var catalog = await _loadBaseCatalog();
    final database = _database;
    if (database != null) {
      catalog = await _mergeImportedCompendiumContent(database, catalog);
    } else {
      catalog = _mergeImportedCompendiumContentFromMemory(catalog);
    }

    final effectiveCatalog = catalog.applyPackStateEffects();
    _cachedCatalog = effectiveCatalog;
    return effectiveCatalog;
  }

  @override
  Future<CompendiumCatalog> setPackActive(String packId, bool isActive) async {
    final catalog = await loadCatalog();
    final database = _database;
    if (database == null) {
      final updatedCatalog = _mergeImportedCompendiumContentFromMemory(
        _updateCatalogPackState(catalog, packId, isActive),
      ).applyPackStateEffects();
      _cachedCatalog = updatedCatalog;
      return updatedCatalog;
    }

    final existingRows = await (database.select(
      database.compendiumPackStates,
    )..where((table) => table.id.equals(packId))).get();
    final existing = existingRows.isEmpty ? null : existingRows.single;
    if (existing == null) {
      return catalog.applyPackStateEffects();
    }

    final nextIsActive = existing.isFixed ? true : isActive;
    await (database.update(
      database.compendiumPackStates,
    )..where((table) => table.id.equals(packId))).write(
      CompendiumPackStatesCompanion(
        isActive: Value(nextIsActive),
        updatedAt: Value(DateTime.now()),
      ),
    );

    var refreshed = await _loadBaseCatalog();
    refreshed = await _mergeImportedCompendiumContent(database, refreshed);
    final effectiveCatalog = refreshed.applyPackStateEffects();
    _cachedCatalog = effectiveCatalog;
    return effectiveCatalog;
  }

  @override
  Future<CompendiumCatalog> importXmlPack(String rawXml) async {
    final catalog = await loadCatalog();
    final importedPackState = _buildImportedPackState(
      rawXml,
      catalog.packStates,
    );
    parseImportedCompendiumContent(
      packId: importedPackState.id,
      packTitle: importedPackState.title,
      rawXml: rawXml,
    );
    final database = _database;

    if (database == null) {
      _importedPackXmlById[importedPackState.id] = rawXml;
      final updatedCatalog = _mergeImportedCompendiumContentFromMemory(
        catalog.copyWith(
          packStates: _mergeImportedPackState(
            catalog.packStates,
            importedPackState,
          ),
        ),
      ).applyPackStateEffects();
      _cachedCatalog = updatedCatalog;
      return updatedCatalog;
    }

    await database
        .into(database.compendiumPackStates)
        .insertOnConflictUpdate(
          CompendiumPackStatesCompanion.insert(
            id: importedPackState.id,
            title: importedPackState.title,
            description: importedPackState.description,
            kind: importedPackState.kind,
            isFixed: Value(importedPackState.isFixed),
            isActive: Value(importedPackState.isActive),
            updatedAt: DateTime.now(),
          ),
        );
    await database
        .into(database.importedCompendiumPacks)
        .insertOnConflictUpdate(
          ImportedCompendiumPacksCompanion.insert(
            id: importedPackState.id,
            rawXml: rawXml,
            importedAt: DateTime.now(),
          ),
        );

    var refreshed = await _loadBaseCatalog();
    refreshed = await _mergeImportedCompendiumContent(database, refreshed);
    final effectiveCatalog = refreshed.applyPackStateEffects();
    _cachedCatalog = effectiveCatalog;
    return effectiveCatalog;
  }

  static const Map<int, List<String>> _spellSeedsByLevel = <int, List<String>>{
    0: <String>['Light [5.5e]'],
    1: <String>['Magic Missile [5.5e]'],
    2: <String>['Misty Step [5.5e]'],
    3: <String>['Fireball [5.5e]'],
    4: <String>['Dimension Door [5.5e]'],
    5: <String>['Cone of Cold [5.5e]'],
    6: <String>['Chain Lightning [5.5e]'],
    7: <String>['Teleport [5.5e]'],
    8: <String>['Dominate Monster [5.5e]'],
    9: <String>['Wish [5.5e]'],
  };

  static const List<String> _featSeeds = <String>[
    'Ability Score Improvement [5.5e]',
    'Grappler (Strength) [5.5e]',
    'Origin: Alert [5.5e]',
  ];

  static const List<String> _monsterSeeds = <String>[
    'Giant Fly [5.5e]',
    'Owlbear [5.5e]',
    'Adult Red Dragon [5.5e]',
  ];

  static const List<int> _generatedAbilityScoreSet = <int>[
    15,
    14,
    13,
    12,
    10,
    8,
  ];
  static const List<int> _manualAbilityScoreOptions = <int>[
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
  ];
  static const List<CharacterAdvancementEntry> _characterAdvancement =
      <CharacterAdvancementEntry>[
        CharacterAdvancementEntry(
          level: 1,
          experience: 0,
          proficiencyBonus: '+2',
        ),
        CharacterAdvancementEntry(
          level: 2,
          experience: 300,
          proficiencyBonus: '+2',
        ),
        CharacterAdvancementEntry(
          level: 3,
          experience: 900,
          proficiencyBonus: '+2',
        ),
        CharacterAdvancementEntry(
          level: 4,
          experience: 2700,
          proficiencyBonus: '+2',
        ),
        CharacterAdvancementEntry(
          level: 5,
          experience: 6500,
          proficiencyBonus: '+3',
        ),
        CharacterAdvancementEntry(
          level: 6,
          experience: 14000,
          proficiencyBonus: '+3',
        ),
        CharacterAdvancementEntry(
          level: 7,
          experience: 23000,
          proficiencyBonus: '+3',
        ),
        CharacterAdvancementEntry(
          level: 8,
          experience: 34000,
          proficiencyBonus: '+3',
        ),
        CharacterAdvancementEntry(
          level: 9,
          experience: 48000,
          proficiencyBonus: '+4',
        ),
        CharacterAdvancementEntry(
          level: 10,
          experience: 64000,
          proficiencyBonus: '+4',
        ),
        CharacterAdvancementEntry(
          level: 11,
          experience: 85000,
          proficiencyBonus: '+4',
        ),
        CharacterAdvancementEntry(
          level: 12,
          experience: 100000,
          proficiencyBonus: '+4',
        ),
        CharacterAdvancementEntry(
          level: 13,
          experience: 120000,
          proficiencyBonus: '+5',
        ),
        CharacterAdvancementEntry(
          level: 14,
          experience: 140000,
          proficiencyBonus: '+5',
        ),
        CharacterAdvancementEntry(
          level: 15,
          experience: 165000,
          proficiencyBonus: '+5',
        ),
        CharacterAdvancementEntry(
          level: 16,
          experience: 195000,
          proficiencyBonus: '+5',
        ),
        CharacterAdvancementEntry(
          level: 17,
          experience: 225000,
          proficiencyBonus: '+6',
        ),
        CharacterAdvancementEntry(
          level: 18,
          experience: 265000,
          proficiencyBonus: '+6',
        ),
        CharacterAdvancementEntry(
          level: 19,
          experience: 305000,
          proficiencyBonus: '+6',
        ),
        CharacterAdvancementEntry(
          level: 20,
          experience: 355000,
          proficiencyBonus: '+6',
        ),
      ];
  static const List<String> _alignmentOptions = <String>[
    'Lawful Good',
    'Neutral Good',
    'Chaotic Good',
    'Lawful Neutral',
    'Neutral',
    'Chaotic Neutral',
    'Lawful Evil',
    'Neutral Evil',
    'Chaotic Evil',
  ];
  static const List<StandardArrayByClassEntry> _standardArrayByClass =
      <StandardArrayByClassEntry>[
        StandardArrayByClassEntry(
          classId: 'barbarian',
          className: 'Barbarian',
          strength: 15,
          dexterity: 13,
          constitution: 14,
          intelligence: 10,
          wisdom: 12,
          charisma: 8,
        ),
        StandardArrayByClassEntry(
          classId: 'bard',
          className: 'Bard',
          strength: 8,
          dexterity: 14,
          constitution: 12,
          intelligence: 13,
          wisdom: 10,
          charisma: 15,
        ),
        StandardArrayByClassEntry(
          classId: 'cleric',
          className: 'Cleric',
          strength: 14,
          dexterity: 8,
          constitution: 13,
          intelligence: 10,
          wisdom: 15,
          charisma: 12,
        ),
        StandardArrayByClassEntry(
          classId: 'druid',
          className: 'Druid',
          strength: 8,
          dexterity: 12,
          constitution: 14,
          intelligence: 13,
          wisdom: 15,
          charisma: 10,
        ),
        StandardArrayByClassEntry(
          classId: 'fighter',
          className: 'Fighter',
          strength: 15,
          dexterity: 14,
          constitution: 13,
          intelligence: 8,
          wisdom: 10,
          charisma: 12,
        ),
        StandardArrayByClassEntry(
          classId: 'monk',
          className: 'Monk',
          strength: 12,
          dexterity: 15,
          constitution: 13,
          intelligence: 10,
          wisdom: 14,
          charisma: 8,
        ),
        StandardArrayByClassEntry(
          classId: 'paladin',
          className: 'Paladin',
          strength: 15,
          dexterity: 10,
          constitution: 13,
          intelligence: 8,
          wisdom: 12,
          charisma: 14,
        ),
        StandardArrayByClassEntry(
          classId: 'ranger',
          className: 'Ranger',
          strength: 12,
          dexterity: 15,
          constitution: 13,
          intelligence: 8,
          wisdom: 14,
          charisma: 10,
        ),
        StandardArrayByClassEntry(
          classId: 'rogue',
          className: 'Rogue',
          strength: 12,
          dexterity: 15,
          constitution: 13,
          intelligence: 14,
          wisdom: 10,
          charisma: 8,
        ),
        StandardArrayByClassEntry(
          classId: 'sorcerer',
          className: 'Sorcerer',
          strength: 10,
          dexterity: 13,
          constitution: 14,
          intelligence: 8,
          wisdom: 12,
          charisma: 15,
        ),
        StandardArrayByClassEntry(
          classId: 'warlock',
          className: 'Warlock',
          strength: 8,
          dexterity: 14,
          constitution: 13,
          intelligence: 12,
          wisdom: 10,
          charisma: 15,
        ),
        StandardArrayByClassEntry(
          classId: 'wizard',
          className: 'Wizard',
          strength: 8,
          dexterity: 12,
          constitution: 13,
          intelligence: 15,
          wisdom: 14,
          charisma: 10,
        ),
      ];

  CompendiumCatalog _parseFightClubCatalog({
    required String backgroundsXml,
    required String racesXml,
    required String classesXml,
    required String spellsXml,
    required String featsXml,
    required String monstersXml,
    required String phbBackgroundsXml,
    required String scagBackgroundsXml,
    required String pamBackgroundsXml,
    required String ggrBackgroundsXml,
    required String erlwBackgroundsXml,
  }) {
    final races = _extractElements(racesXml, 'race')
        .map(
          (race) => _normalizeCatalogName(
            _extractSingleTagText(race.innerXml, 'name') ?? '',
          ),
        )
        .where((name) => name.isNotEmpty)
        .toList(growable: false);
    final classes = <String>[];
    final equipmentSummariesByClass = <String, EquipmentSummaryViewData>{};
    final equipmentLoadoutsByClass =
        <String, List<CompendiumEquipmentLoadout>>{};
    for (final classElement in _extractElements(classesXml, 'class')) {
      final className = _normalizeCatalogName(
        _extractSingleTagText(classElement.innerXml, 'name') ?? '',
      );
      if (className.isEmpty) {
        continue;
      }

      classes.add(className);
      equipmentSummariesByClass[className] = _buildEquipmentSummary(
        classElement.innerXml,
      );
      equipmentLoadoutsByClass[className] = _buildEquipmentLoadouts(
        className: className,
        classId: _slugifyName(className),
        classXml: classElement.innerXml,
      );
    }

    final backgrounds = _extractElements(
      backgroundsXml,
      'background',
    ).map(_parseFightClubBackground).toList(growable: false);
    final narrativeOptionGroups = _parseNarrativeOptionGroups(
      phbBackgroundsXml: phbBackgroundsXml,
      scagBackgroundsXml: scagBackgroundsXml,
      pamBackgroundsXml: pamBackgroundsXml,
      ggrBackgroundsXml: ggrBackgroundsXml,
      erlwBackgroundsXml: erlwBackgroundsXml,
    );
    final sourcePolicy = CompendiumSourcePolicy(
      activeSourceType: 'fightclub_xml',
      activeSourceLabel:
          'FightClub XML asset bundle with SRD 5.5e core data and legacy 5e narrative supplements',
      fallbackSourceLabel: _fallbackCatalogAssetPath,
      sections: <CompendiumSectionSourcePolicy>[
        CompendiumSectionSourcePolicy(
          sectionKey: 'backgrounds',
          sectionLabel: 'Backgrounds',
          sourceType: 'srd_5_5e_xml',
          primarySources: <String>[_backgroundsAssetPath],
        ),
        CompendiumSectionSourcePolicy(
          sectionKey: 'races',
          sectionLabel: 'Races',
          sourceType: 'srd_5_5e_xml',
          primarySources: <String>[_racesAssetPath],
        ),
        CompendiumSectionSourcePolicy(
          sectionKey: 'classes',
          sectionLabel: 'Classes',
          sourceType: 'srd_5_5e_xml',
          primarySources: <String>[_classesAssetPath],
        ),
        CompendiumSectionSourcePolicy(
          sectionKey: 'spells',
          sectionLabel: 'Spells',
          sourceType: 'srd_5_5e_xml',
          primarySources: <String>[_spellsAssetPath],
          notes:
              'The current catalog keeps a small deterministic spell seed from the SRD 5.5e source set.',
        ),
        CompendiumSectionSourcePolicy(
          sectionKey: 'feats',
          sectionLabel: 'Feats',
          sourceType: 'srd_5_5e_xml',
          primarySources: <String>[_featsAssetPath],
          notes:
              'The current catalog keeps a small deterministic feat seed from the SRD 5.5e source set.',
        ),
        CompendiumSectionSourcePolicy(
          sectionKey: 'monsters',
          sectionLabel: 'Monsters',
          sourceType: 'srd_5_5e_xml',
          primarySources: <String>[_monstersAssetPath],
          notes:
              'The current catalog keeps a small deterministic monster seed from the SRD 5.5e source set.',
        ),
        CompendiumSectionSourcePolicy(
          sectionKey: 'narrative_options',
          sectionLabel: 'Narrative options',
          sourceType: 'legacy_5e_xml_supplements',
          primarySources: <String>[_phbBackgroundsAssetPath],
          supplementalSources: <String>[
            _scagBackgroundsAssetPath,
            _pamBackgroundsAssetPath,
            _ggrBackgroundsAssetPath,
            _erlwBackgroundsAssetPath,
          ],
          supplementalPackId: 'legacy-narrative-supplements',
          notes:
              'Narrative tables currently mix the Player\'s Handbook (2014) plus setting books while SRD 5.5e remains the canonical source for structured character-build data.',
        ),
      ],
    );

    return CompendiumCatalog(
      races: races,
      classes: classes,
      backgrounds: backgrounds,
      narrativeOptionGroups: narrativeOptionGroups,
      generatedAbilityScoreSet: _generatedAbilityScoreSet,
      manualAbilityScoreOptions: _manualAbilityScoreOptions,
      characterAdvancement: _characterAdvancement,
      standardArrayByClass: _standardArrayByClass,
      spells: _parseSeededSpells(spellsXml),
      feats: _parseSeededFeats(featsXml),
      monsters: _parseSeededMonsters(monstersXml),
      equipmentSummariesByClass: equipmentSummariesByClass,
      equipmentLoadoutsByClass: equipmentLoadoutsByClass,
      packStates: _buildDefaultPackStates(sourcePolicy),
      sourcePolicy: sourcePolicy,
    );
  }

  CompendiumCatalog _parseJsonCatalog(String raw) {
    final Map<String, dynamic> json = jsonDecode(raw) as Map<String, dynamic>;
    final sourcePolicy = CompendiumSourcePolicy(
      activeSourceType: 'fallback_json',
      activeSourceLabel: 'Fallback bundled JSON catalog',
      fallbackSourceLabel: _fallbackCatalogAssetPath,
      sections: <CompendiumSectionSourcePolicy>[
        CompendiumSectionSourcePolicy(
          sectionKey: 'catalog',
          sectionLabel: 'Catalog',
          sourceType: 'fallback_json',
          primarySources: <String>[_fallbackCatalogAssetPath],
          notes:
              'Fallback mode provides a compact bundled catalog when FightClub XML assets cannot be loaded.',
        ),
      ],
    );

    return CompendiumCatalog(
      races: (json['races'] as List<dynamic>).cast<String>(),
      classes: (json['classes'] as List<dynamic>).cast<String>(),
      backgrounds: (json['backgrounds'] as List<dynamic>)
          .map((background) {
            final map = Map<String, dynamic>.from(background as Map);
            return CompendiumBackground(
              id: map['id'] as String,
              name: map['name'] as String,
              summary: map['summary'] as String,
              bonuses: (map['bonuses'] as List<dynamic>).cast<String>(),
              socialPerks: (map['socialPerks'] as List<dynamic>).cast<String>(),
            );
          })
          .toList(growable: false),
      narrativeOptionGroups: const <CompendiumNarrativeOptionGroup>[],
      generatedAbilityScoreSet:
          (json['generatedAbilityScoreSet'] as List<dynamic>).cast<int>(),
      manualAbilityScoreOptions:
          (json['manualAbilityScoreOptions'] as List<dynamic>).cast<int>(),
      characterAdvancement: const <CharacterAdvancementEntry>[],
      standardArrayByClass: const <StandardArrayByClassEntry>[],
      spells: const <CompendiumSpell>[],
      feats: const <CompendiumFeat>[],
      monsters: const <CompendiumMonster>[],
      equipmentSummariesByClass:
          Map<String, dynamic>.from(
            json['equipmentSummariesByClass'] as Map,
          ).map((key, value) {
            final map = Map<String, dynamic>.from(value as Map);
            return MapEntry(
              key,
              EquipmentSummaryViewData(
                statusLabel: map['statusLabel'] as String,
                description: map['description'] as String,
                highlightItems: (map['highlightItems'] as List<dynamic>)
                    .cast<String>(),
              ),
            );
          }),
      equipmentLoadoutsByClass:
          Map<String, dynamic>.from(
            json['equipmentLoadoutsByClass'] as Map,
          ).map((key, value) {
            final entries = (value as List<dynamic>)
                .map((entry) {
                  final map = Map<String, dynamic>.from(entry as Map);
                  return CompendiumEquipmentLoadout(
                    id: map['id'] as String,
                    label: map['label'] as String,
                    startingMoneySummary: map['startingMoneySummary'] as String,
                    selectedItems: (map['selectedItems'] as List<dynamic>)
                        .cast<String>(),
                  );
                })
                .toList(growable: false);
            return MapEntry(key, entries);
          }),
      packStates: _buildDefaultPackStates(sourcePolicy),
      sourcePolicy: sourcePolicy,
    );
  }

  CompendiumBackground _parseFightClubBackground(
    _XmlElement backgroundElement,
  ) {
    final xml = backgroundElement.innerXml;
    final name = _normalizeCatalogName(
      _extractSingleTagText(xml, 'name') ?? '',
    );
    final proficiency = _splitCsv(
      _extractSingleTagText(xml, 'proficiency') ?? '',
    );
    final traits = _extractElements(xml, 'trait');
    final description = _findTraitText(traits, 'Description');
    final abilityScores = _parseAbilityScoresFromTraitNames(traits);
    final feat = _extractValueFromTraitName(traits, prefix: 'Feat:');
    final tool = _extractValueFromTraitName(
      traits,
      prefix: 'Tool Proficiency:',
    );
    final equipment = _findTraitText(traits, 'Starting Equipment');

    final bonuses = <String>[
      if (abilityScores.isNotEmpty)
        'Ability options: ${abilityScores.join(', ')}',
      if (proficiency.isNotEmpty) 'Skills: ${proficiency.join(', ')}',
      if (tool != null && tool.isNotEmpty) 'Tool: $tool',
    ];
    final socialPerks = <String>[
      if (feat != null && feat.isNotEmpty) 'Origin feat: $feat',
      if (equipment.isNotEmpty) 'Starting equipment: $equipment',
    ];

    return CompendiumBackground(
      id: _slugifyName(name),
      name: name.isEmpty ? 'Unknown background' : name,
      summary: description.isEmpty
          ? 'Background summary unavailable.'
          : description,
      bonuses: bonuses.isEmpty ? const <String>['No bonuses parsed'] : bonuses,
      socialPerks: socialPerks.isEmpty
          ? const <String>['No starter perks parsed']
          : socialPerks,
    );
  }

  List<CompendiumSpell> _parseSeededSpells(String xml) {
    if (xml.isEmpty) {
      return const <CompendiumSpell>[];
    }

    final spells = <CompendiumSpell>[];
    for (final names in _spellSeedsByLevel.values) {
      for (final name in names) {
        final element = _findElementByExactName(xml, 'spell', name);
        if (element == null) {
          continue;
        }

        final spellXml = element.innerXml;
        spells.add(
          CompendiumSpell(
            name: _normalizeCatalogName(
              _extractSingleTagText(spellXml, 'name') ?? name,
            ),
            level: int.parse(_extractSingleTagText(spellXml, 'level') ?? '0'),
            school: _extractSingleTagText(spellXml, 'school') ?? '',
            castingTime: _extractSingleTagText(spellXml, 'time') ?? '',
            range: _extractSingleTagText(spellXml, 'range') ?? '',
            components: _extractSingleTagText(spellXml, 'components') ?? '',
            duration: _extractSingleTagText(spellXml, 'duration') ?? '',
            classes: _splitCsv(
              _extractSingleTagText(spellXml, 'classes') ?? '',
            ).map(_normalizeCatalogName).toList(growable: false),
            description: _extractTextParagraphs(spellXml),
            source: _extractSource(spellXml),
          ),
        );
      }
    }

    return List<CompendiumSpell>.unmodifiable(spells);
  }

  List<CompendiumFeat> _parseSeededFeats(String xml) {
    if (xml.isEmpty) {
      return const <CompendiumFeat>[];
    }

    return _featSeeds
        .map((name) {
          final element = _findElementByExactName(xml, 'feat', name);
          if (element == null) {
            return null;
          }

          final featXml = element.innerXml;
          return CompendiumFeat(
            name: _normalizeCatalogName(
              _extractSingleTagText(featXml, 'name') ?? name,
            ),
            prerequisite: _extractSingleTagText(featXml, 'prerequisite') ?? '',
            description: _extractTextParagraphs(featXml),
            modifiers: _extractModifierTexts(featXml),
            source: _extractSource(featXml),
          );
        })
        .whereType<CompendiumFeat>()
        .toList(growable: false);
  }

  List<CompendiumMonster> _parseSeededMonsters(String xml) {
    if (xml.isEmpty) {
      return const <CompendiumMonster>[];
    }

    return _monsterSeeds
        .map((name) {
          final element = _findElementByExactName(xml, 'monster', name);
          if (element == null) {
            return null;
          }

          final monsterXml = element.innerXml;
          return CompendiumMonster(
            name: _normalizeCatalogName(
              _extractSingleTagText(monsterXml, 'name') ?? name,
            ),
            size: _extractSingleTagText(monsterXml, 'size') ?? '',
            type: _extractSingleTagText(monsterXml, 'type') ?? '',
            alignment: _extractSingleTagText(monsterXml, 'alignment') ?? '',
            armorClass: _extractSingleTagText(monsterXml, 'ac') ?? '',
            hitPoints: _extractSingleTagText(monsterXml, 'hp') ?? '',
            speed: _extractSingleTagText(monsterXml, 'speed') ?? '',
            challengeRating: _extractSingleTagText(monsterXml, 'cr') ?? '',
            senses: _extractSingleTagText(monsterXml, 'senses') ?? '',
            languages: _extractSingleTagText(monsterXml, 'languages') ?? '',
            traits: _extractNamedBlocks(monsterXml, 'trait'),
            actions: _extractNamedBlocks(monsterXml, 'action'),
            source: _extractMonsterSource(monsterXml),
          );
        })
        .whereType<CompendiumMonster>()
        .toList(growable: false);
  }

  EquipmentSummaryViewData _buildEquipmentSummary(String classXml) {
    final hitDie = _extractSingleTagText(classXml, 'hd');
    final proficiency = _splitCsv(
      _extractSingleTagText(classXml, 'proficiency') ?? '',
    );
    final armorTraining = _extractSingleTagText(classXml, 'armor');
    final weapons = _extractSingleTagText(classXml, 'weapons');
    final firstLevelFeatures = _extractElements(classXml, 'autolevel')
        .firstWhere(
          (element) => element.attributes['level'] == '1',
          orElse: () =>
              const _XmlElement(attributes: <String, String>{}, innerXml: ''),
        );
    final features = _extractElements(firstLevelFeatures.innerXml, 'feature')
        .map((feature) => _extractSingleTagText(feature.innerXml, 'name') ?? '')
        .where(
          (name) =>
              name.isNotEmpty &&
              !name.startsWith('Becoming A ') &&
              !name.contains('Multiclass'),
        )
        .map(_normalizeFeatureName)
        .toList(growable: false);
    final primaryAbility = _extractPrimaryAbilityFromClassFeature(
      firstLevelFeatures.innerXml,
    );
    final skillChoices = proficiency.length >= 2
        ? proficiency.sublist(2)
        : const <String>[];

    return EquipmentSummaryViewData(
      statusLabel: 'SRD 5.5e',
      description:
          'Primary ability: ${primaryAbility ?? 'Unknown'}. Hit Die: ${hitDie ?? 'Unknown'}. '
          'Armor: ${armorTraining ?? 'Unknown'}. Weapons: ${weapons ?? 'Unknown'}.',
      highlightItems: features.isEmpty
          ? (skillChoices.isEmpty
                ? const <String>['Level 1 feature data unavailable']
                : skillChoices)
          : features,
    );
  }

  List<CompendiumEquipmentLoadout> _buildEquipmentLoadouts({
    required String className,
    required String classId,
    required String classXml,
  }) {
    final startingEquipmentText = _extractStartingEquipmentText(classXml);
    if (startingEquipmentText.isEmpty) {
      return const <CompendiumEquipmentLoadout>[];
    }
    final options = _parseStartingEquipmentOptions(startingEquipmentText);
    if (options.isEmpty) {
      return const <CompendiumEquipmentLoadout>[];
    }

    return options
        .map((option) {
          final rawText = option;
          final moneyMatch = RegExp(r'(\d+\s*GP)\s*$').firstMatch(rawText);
          final moneySummary = moneyMatch?.group(1) ?? 'No listed GP';
          final itemsText = moneyMatch == null
              ? rawText
              : rawText
                    .substring(0, moneyMatch.start)
                    .trim()
                    .replaceFirst(RegExp(r',$'), '');
          final selectedItems = itemsText.isEmpty
              ? const <String>['Custom purchases pending']
              : itemsText
                    .split(',')
                    .map(_normalizeText)
                    .where((item) => item.isNotEmpty)
                    .toList(growable: false);
          final optionId = String.fromCharCode(
            'A'.codeUnitAt(0) + options.indexOf(option),
          );

          return CompendiumEquipmentLoadout(
            id: '$classId-${optionId.toLowerCase()}',
            label: _buildLoadoutLabel(
              optionId,
              selectedItems,
              moneyMatch != null,
            ),
            startingMoneySummary: moneySummary,
            selectedItems: selectedItems,
          );
        })
        .toList(growable: false);
  }

  String _buildLoadoutLabel(
    String optionId,
    List<String> selectedItems,
    bool hasMoneySummary,
  ) {
    if (selectedItems.length == 1 &&
        selectedItems.first == 'Custom purchases pending' &&
        hasMoneySummary) {
      return 'Option $optionId: shopping budget';
    }

    final anchorItem = selectedItems.isEmpty
        ? 'starter kit'
        : selectedItems.first.toLowerCase();
    return 'Option $optionId: $anchorItem';
  }

  Future<String?> _tryLoadString(String path) async {
    try {
      return await _bundle.loadString(path);
    } catch (_) {
      return null;
    }
  }

  String? _extractSingleTagText(String xml, String tagName) {
    final match = RegExp(
      '<$tagName\\b[^>]*>([\\s\\S]*?)</$tagName>',
      caseSensitive: false,
    ).firstMatch(xml);
    if (match == null) {
      return null;
    }

    return _normalizeText(match.group(1) ?? '');
  }

  List<String> _extractAllTagTexts(String xml, String tagName) {
    if (xml.isEmpty) {
      return const <String>[];
    }

    return RegExp(
          '<$tagName\\b[^>]*>([\\s\\S]*?)</$tagName>',
          caseSensitive: false,
        )
        .allMatches(xml)
        .map((match) {
          return _normalizeText(match.group(1) ?? '');
        })
        .where((text) => text.isNotEmpty)
        .toList(growable: false);
  }

  List<_XmlElement> _extractElements(String xml, String tagName) {
    if (xml.isEmpty) {
      return const <_XmlElement>[];
    }

    return RegExp(
          '<$tagName\\b([^>]*)>([\\s\\S]*?)</$tagName>',
          caseSensitive: false,
        )
        .allMatches(xml)
        .map((match) {
          final attributes = <String, String>{};
          final rawAttributes = match.group(1) ?? '';
          for (final attributeMatch in RegExp(
            r'(\w+)="([^"]*)"',
          ).allMatches(rawAttributes)) {
            attributes[attributeMatch.group(1)!] = _normalizeText(
              attributeMatch.group(2) ?? '',
            );
          }

          return _XmlElement(
            attributes: attributes,
            innerXml: match.group(2) ?? '',
          );
        })
        .toList(growable: false);
  }

  _XmlElement? _findElementByExactName(
    String xml,
    String tagName,
    String expectedName,
  ) {
    for (final element in _extractElements(xml, tagName)) {
      final name = _extractSingleTagText(element.innerXml, 'name');
      if (_normalizeCatalogName(name ?? '') ==
          _normalizeCatalogName(expectedName)) {
        return element;
      }
    }
    return null;
  }

  List<String> _extractTextParagraphs(String xml) {
    return _extractAllTagTexts(
      xml,
      'text',
    ).where((text) => !text.startsWith('Source:')).toList(growable: false);
  }

  List<String> _extractModifierTexts(String xml) {
    return RegExp(
          '<modifier\\b[^>]*>([\\s\\S]*?)</modifier>',
          caseSensitive: false,
        )
        .allMatches(xml)
        .map((match) {
          return _normalizeText(match.group(1) ?? '');
        })
        .where((text) => text.isNotEmpty)
        .toList(growable: false);
  }

  List<String> _extractNamedBlocks(String xml, String tagName) {
    return _extractElements(xml, tagName)
        .map((element) {
          final blockName =
              _extractSingleTagText(element.innerXml, 'name') ?? '';
          final blockText = _extractTextParagraphs(element.innerXml).join(' ');
          if (blockName.isEmpty) {
            return blockText;
          }
          if (blockText.isEmpty) {
            return blockName;
          }
          return '$blockName: $blockText';
        })
        .where((text) => text.isNotEmpty)
        .toList(growable: false);
  }

  String _extractSource(String xml) {
    final sourceLine = _extractAllTagTexts(
      xml,
      'text',
    ).firstWhere((text) => text.startsWith('Source:'), orElse: () => '');
    return sourceLine;
  }

  String _extractMonsterSource(String xml) {
    final description = _extractSingleTagText(xml, 'description');
    if (description != null && description.startsWith('Source:')) {
      return description;
    }
    for (final trait in _extractElements(xml, 'trait')) {
      final name = _extractSingleTagText(trait.innerXml, 'name');
      if (name == 'Source') {
        return _extractTextParagraphs(trait.innerXml).join(' ');
      }
    }
    return '';
  }

  String _extractSourceLine(String text) {
    for (final line in _normalizeMultilineText(text).split('\n')) {
      final normalized = _normalizeText(line);
      if (normalized.startsWith('Source:')) {
        return normalized;
      }
    }
    return '';
  }

  List<String> _splitCsv(String text) {
    if (text.isEmpty) {
      return const <String>[];
    }

    return text
        .split(',')
        .map(_normalizeText)
        .where((item) => item.isNotEmpty)
        .toList(growable: false);
  }

  String _normalizeText(String text) {
    return text
        .replaceAll('&apos;', "'")
        .replaceAll('&quot;', '"')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  String _normalizeCatalogName(String text) {
    return _normalizeText(
      text.replaceAll(
        RegExp(r'\s*\[(?:2024|5\.5e)\]\s*$', caseSensitive: false),
        '',
      ),
    );
  }

  String _slugifyName(String text) {
    return _normalizeCatalogName(text)
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
        .replaceAll(RegExp(r'^_+|_+$'), '');
  }

  String _findTraitText(List<_XmlElement> traits, String expectedName) {
    for (final trait in traits) {
      final name = _extractSingleTagText(trait.innerXml, 'name');
      if (_normalizeText(name ?? '') == expectedName) {
        return _extractTextParagraphs(trait.innerXml).join(' ');
      }
    }
    return '';
  }

  String? _extractValueFromTraitName(
    List<_XmlElement> traits, {
    required String prefix,
  }) {
    for (final trait in traits) {
      final name = _extractSingleTagText(trait.innerXml, 'name');
      if (name != null && name.startsWith(prefix)) {
        return _normalizeText(name.substring(prefix.length));
      }
    }
    return null;
  }

  List<String> _parseAbilityScoresFromTraitNames(List<_XmlElement> traits) {
    for (final trait in traits) {
      final name = _extractSingleTagText(trait.innerXml, 'name');
      if (name != null && name.startsWith('Ability Scores:')) {
        return _splitCsv(name.substring('Ability Scores:'.length));
      }
    }
    return const <String>[];
  }

  String? _extractPrimaryAbilityFromClassFeature(String firstLevelXml) {
    final feature = _extractElements(firstLevelXml, 'feature').firstWhere(
      (element) {
        final name = _extractSingleTagText(element.innerXml, 'name') ?? '';
        return name.contains('Level 1 Character');
      },
      orElse: () =>
          const _XmlElement(attributes: <String, String>{}, innerXml: ''),
    );
    final text = _extractTextParagraphs(feature.innerXml).join(' ');
    final match = RegExp(
      r'Primary Ability:\s*([^\.]+)',
      caseSensitive: false,
    ).firstMatch(text);
    return match == null ? null : _normalizeText(match.group(1) ?? '');
  }

  String _extractStartingEquipmentText(String classXml) {
    for (final autolevel in _extractElements(classXml, 'autolevel')) {
      if (autolevel.attributes['level'] != '1') {
        continue;
      }
      for (final feature in _extractElements(autolevel.innerXml, 'feature')) {
        final name = _extractSingleTagText(feature.innerXml, 'name') ?? '';
        if (!name.contains('Level 1 Character')) {
          continue;
        }
        final text = _extractTextParagraphs(feature.innerXml).join(' ');
        final match = RegExp(
          r'Starting Equipment:\s*(.+?)\s*Source:',
          caseSensitive: false,
        ).firstMatch(text);
        if (match != null) {
          return _normalizeText(match.group(1) ?? '');
        }
      }
    }
    return '';
  }

  List<String> _parseStartingEquipmentOptions(String text) {
    final normalized = text.replaceFirst(
      RegExp(r'^Choose\s+[A-Z]\s+or\s+[A-Z]:\s*', caseSensitive: false),
      '',
    );
    final matches = RegExp(
      r'\(([A-Z])\)\s*(.+?)(?=\s*;\s*or\s*\([A-Z]\)|$)',
      caseSensitive: false,
    ).allMatches(normalized);
    if (matches.isEmpty) {
      return <String>[normalized];
    }

    return matches
        .map((match) => _normalizeText(match.group(2) ?? ''))
        .where((entry) => entry.isNotEmpty)
        .toList(growable: false);
  }

  String _normalizeFeatureName(String text) {
    return _normalizeText(
      text.replaceFirst(RegExp(r'^Level\s+\d+:\s*', caseSensitive: false), ''),
    );
  }

  List<CompendiumNarrativeOptionGroup> _parseNarrativeOptionGroups({
    required String phbBackgroundsXml,
    required String scagBackgroundsXml,
    required String pamBackgroundsXml,
    required String ggrBackgroundsXml,
    required String erlwBackgroundsXml,
  }) {
    return <CompendiumNarrativeOptionGroup>[
      _buildAlignmentNarrativeGroup(),
      ..._parsePhbBackgroundNarrativeGroups(phbBackgroundsXml),
      ..._parseScagFactionGroups(scagBackgroundsXml),
      ..._parsePamFactionGroups(pamBackgroundsXml),
      ..._parseGgrFactionGroups(ggrBackgroundsXml),
      ..._parseErlwFactionGroups(erlwBackgroundsXml),
    ];
  }

  CompendiumNarrativeOptionGroup _buildAlignmentNarrativeGroup() {
    return CompendiumNarrativeOptionGroup(
      id: 'narrative-alignment-core',
      fieldKey: 'alignment',
      sourceType: 'core_rules',
      sourceId: 'alignment_reference',
      sourceName: 'Alignment Reference',
      title: 'Official Alignments',
      sourceBook: 'SRD reference',
      options: _alignmentOptions
          .asMap()
          .entries
          .map(
            (entry) => CompendiumNarrativeOption(
              id: 'narrative-alignment-${entry.key + 1}',
              optionIndex: entry.key + 1,
              text: entry.value,
              label: entry.value,
            ),
          )
          .toList(growable: false),
    );
  }

  List<CompendiumNarrativeOptionGroup> _parsePhbBackgroundNarrativeGroups(
    String xml,
  ) {
    if (xml.isEmpty) {
      return const <CompendiumNarrativeOptionGroup>[];
    }

    final groups = <CompendiumNarrativeOptionGroup>[];
    for (final background in _extractElements(xml, 'background')) {
      final backgroundName = _extractSingleTagText(background.innerXml, 'name');
      if (backgroundName == null || backgroundName.isEmpty) {
        continue;
      }
      final backgroundId = _slugifyName(backgroundName);
      final sourceBook = _extractSourceLine(
        _findTraitTextByName(background.innerXml, 'Description'),
      );
      final suggestedTrait = _findTraitElement(
        background.innerXml,
        'Suggested Characteristics',
      );
      if (suggestedTrait == null) {
        continue;
      }
      final suggestedText = _extractRawTagText(suggestedTrait.innerXml, 'text');
      if (suggestedText == null || suggestedText.isEmpty) {
        continue;
      }
      final rolls = <String, String>{};
      for (final item in _extractElements(suggestedTrait.innerXml, 'roll')) {
        final description = item.attributes['description'] ?? '';
        if (description.isEmpty) {
          continue;
        }
        rolls[description] = _normalizeText(item.innerXml);
      }

      for (final field in _narrativeTableFields) {
        final section = _parseNarrativeTableSection(
          suggestedText,
          tableLabel: field.tableLabel,
        );
        if (section == null || section.options.isEmpty) {
          continue;
        }

        groups.add(
          CompendiumNarrativeOptionGroup(
            id: 'narrative-$backgroundId-${field.fieldKey}',
            fieldKey: field.fieldKey,
            sourceType: 'background',
            sourceId: backgroundId,
            sourceName: backgroundName,
            backgroundId: backgroundId,
            backgroundName: backgroundName,
            title: '${field.groupTitle} for $backgroundName',
            diceFormula: rolls[field.tableLabel],
            sourceBook: sourceBook.isEmpty
                ? "Player's Handbook (2014)"
                : sourceBook,
            options: section.options
                .map(
                  (option) => CompendiumNarrativeOption(
                    id: 'narrative-$backgroundId-${field.fieldKey}-${option.optionIndex}',
                    optionIndex: option.optionIndex,
                    rollMin: option.rollMin,
                    rollMax: option.rollMax,
                    label: option.label,
                    text: option.text,
                  ),
                )
                .toList(growable: false),
          ),
        );
      }
    }

    return List<CompendiumNarrativeOptionGroup>.unmodifiable(groups);
  }

  List<CompendiumNarrativeOptionGroup> _parseScagFactionGroups(String xml) {
    if (xml.isEmpty) {
      return const <CompendiumNarrativeOptionGroup>[];
    }

    final factionAgent = _findElementByExactName(
      xml,
      'background',
      'Faction Agent',
    );
    if (factionAgent == null) {
      return const <CompendiumNarrativeOptionGroup>[];
    }

    final factionsTrait = _findTraitElement(
      factionAgent.innerXml,
      'Factions of the Sword Coast',
    );
    final text = factionsTrait == null
        ? null
        : _extractRawTagText(factionsTrait.innerXml, 'text');
    if (text == null || text.isEmpty) {
      return const <CompendiumNarrativeOptionGroup>[];
    }

    final options = <CompendiumNarrativeOption>[];
    var index = 1;
    for (final line in _normalizeMultilineText(text).split('\n')) {
      final trimmed = _normalizeText(line);
      if (!trimmed.startsWith('The ') || !trimmed.contains('. ')) {
        continue;
      }
      final separatorIndex = trimmed.indexOf('. ');
      final label = trimmed.substring(0, separatorIndex).trim();
      final description = trimmed.substring(separatorIndex + 2).trim();
      if (label.isEmpty || description.isEmpty) {
        continue;
      }
      options.add(
        CompendiumNarrativeOption(
          id: 'narrative-sword-coast-faction-$index',
          optionIndex: index,
          label: label,
          text: description,
        ),
      );
      index += 1;
    }

    if (options.isEmpty) {
      return const <CompendiumNarrativeOptionGroup>[];
    }

    return <CompendiumNarrativeOptionGroup>[
      CompendiumNarrativeOptionGroup(
        id: 'narrative-sword-coast-factions',
        fieldKey: 'faction',
        sourceType: 'setting',
        packId: 'legacy-narrative-supplements',
        sourceId: 'sword_coast',
        sourceName: 'Sword Coast Factions',
        backgroundId: 'faction_agent',
        backgroundName: 'Faction Agent',
        title: 'Factions of the Sword Coast',
        sourceBook: 'Sword Coast Adventurer\'s Guide',
        options: options,
      ),
    ];
  }

  List<CompendiumNarrativeOptionGroup> _parsePamFactionGroups(String xml) {
    if (xml.isEmpty) {
      return const <CompendiumNarrativeOptionGroup>[];
    }

    final philosopher = _findElementByExactName(
      xml,
      'background',
      'Planar Philosopher',
    );
    if (philosopher == null) {
      return const <CompendiumNarrativeOptionGroup>[];
    }

    final factionsTrait = _findTraitElement(
      philosopher.innerXml,
      'Factions of Sigil',
    );
    final text = factionsTrait == null
        ? null
        : _extractRawTagText(factionsTrait.innerXml, 'text');
    if (text == null || text.isEmpty) {
      return const <CompendiumNarrativeOptionGroup>[];
    }

    final options = <CompendiumNarrativeOption>[];
    final matches = RegExp(
      r'•\s*([^:]+):\s*([^\n]+)',
    ).allMatches(_normalizeMultilineText(text));
    var index = 1;
    for (final match in matches) {
      final label = _normalizeText(match.group(1) ?? '');
      final description = _normalizeText(match.group(2) ?? '');
      if (label.isEmpty || description.isEmpty) {
        continue;
      }
      options.add(
        CompendiumNarrativeOption(
          id: 'narrative-sigil-faction-$index',
          optionIndex: index,
          label: label,
          text: description,
        ),
      );
      index += 1;
    }

    if (options.isEmpty) {
      return const <CompendiumNarrativeOptionGroup>[];
    }

    return <CompendiumNarrativeOptionGroup>[
      CompendiumNarrativeOptionGroup(
        id: 'narrative-sigil-factions',
        fieldKey: 'faction',
        sourceType: 'setting',
        packId: 'legacy-narrative-supplements',
        sourceId: 'sigil',
        sourceName: 'Factions of Sigil',
        backgroundId: 'planar_philosopher',
        backgroundName: 'Planar Philosopher',
        title: 'Factions of Sigil',
        sourceBook: 'Planescape: Adventures in the Multiverse',
        options: options,
      ),
    ];
  }

  List<CompendiumNarrativeOptionGroup> _parseGgrFactionGroups(String xml) {
    if (xml.isEmpty) {
      return const <CompendiumNarrativeOptionGroup>[];
    }

    final options = _extractElements(xml, 'background')
        .map(
          (background) =>
              _extractSingleTagText(background.innerXml, 'name') ?? '',
        )
        .map(_normalizeCatalogName)
        .where((name) => name.isNotEmpty)
        .toSet()
        .toList(growable: false);

    if (options.isEmpty) {
      return const <CompendiumNarrativeOptionGroup>[];
    }

    return <CompendiumNarrativeOptionGroup>[
      CompendiumNarrativeOptionGroup(
        id: 'narrative-ravnica-guilds',
        fieldKey: 'faction',
        sourceType: 'setting',
        packId: 'legacy-narrative-supplements',
        sourceId: 'ravnica',
        sourceName: 'Guilds of Ravnica',
        title: 'Guilds of Ravnica',
        sourceBook: "Guildmasters' Guide to Ravnica",
        options: options
            .asMap()
            .entries
            .map(
              (entry) => CompendiumNarrativeOption(
                id: 'narrative-ravnica-guild-${entry.key + 1}',
                optionIndex: entry.key + 1,
                label: entry.value,
                text: entry.value,
              ),
            )
            .toList(growable: false),
      ),
    ];
  }

  List<CompendiumNarrativeOptionGroup> _parseErlwFactionGroups(String xml) {
    if (xml.isEmpty) {
      return const <CompendiumNarrativeOptionGroup>[];
    }

    final houseAgent = _findElementByExactName(
      xml,
      'background',
      'House Agent',
    );
    if (houseAgent == null) {
      return const <CompendiumNarrativeOptionGroup>[];
    }

    final descriptionTrait = _findTraitElement(
      houseAgent.innerXml,
      'Description',
    );
    final text = descriptionTrait == null
        ? null
        : _extractRawTagText(descriptionTrait.innerXml, 'text');
    if (text == null || text.isEmpty) {
      return const <CompendiumNarrativeOptionGroup>[];
    }

    final section = _parseNamedTableSection(
      text,
      tableLabel: 'House Tool Proficiencies',
      firstColumnLabel: 'Your House',
    );
    if (section.isEmpty) {
      return const <CompendiumNarrativeOptionGroup>[];
    }

    return <CompendiumNarrativeOptionGroup>[
      CompendiumNarrativeOptionGroup(
        id: 'narrative-eberron-houses',
        fieldKey: 'faction',
        sourceType: 'setting',
        packId: 'legacy-narrative-supplements',
        sourceId: 'eberron',
        sourceName: 'Dragonmarked Houses',
        backgroundId: 'house_agent',
        backgroundName: 'House Agent',
        title: 'Dragonmarked Houses',
        sourceBook: 'Eberron: Rising from the Last War',
        options: section
            .asMap()
            .entries
            .map(
              (entry) => CompendiumNarrativeOption(
                id: 'narrative-eberron-house-${entry.key + 1}',
                optionIndex: entry.key + 1,
                label: entry.value.label,
                text: entry.value.text,
              ),
            )
            .toList(growable: false),
      ),
    ];
  }

  _XmlElement? _findTraitElement(String xml, String expectedName) {
    for (final trait in _extractElements(xml, 'trait')) {
      final name = _extractSingleTagText(trait.innerXml, 'name');
      if (_normalizeText(name ?? '') == expectedName) {
        return trait;
      }
    }
    return null;
  }

  String _findTraitTextByName(String xml, String expectedName) {
    final trait = _findTraitElement(xml, expectedName);
    if (trait == null) {
      return '';
    }
    return _extractRawTagText(trait.innerXml, 'text') ?? '';
  }

  String? _extractRawTagText(String xml, String tagName) {
    final match = RegExp(
      '<$tagName\\b[^>]*>([\\s\\S]*?)</$tagName>',
      caseSensitive: false,
    ).firstMatch(xml);
    if (match == null) {
      return null;
    }

    return _normalizeMultilineText(match.group(1) ?? '');
  }

  String _normalizeMultilineText(String text) {
    return text
        .replaceAll('&apos;', "'")
        .replaceAll('&quot;', '"')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('\r\n', '\n')
        .replaceAll('\r', '\n')
        .replaceAllMapped(RegExp(r'[ \t]+\n'), (match) => '\n')
        .trim();
  }

  _ParsedNarrativeTableSection? _parseNarrativeTableSection(
    String text, {
    required String tableLabel,
  }) {
    final normalized = _normalizeMultilineText(text);
    final lines = normalized.split('\n');
    final startIndex = lines.indexWhere((line) {
      final trimmed = _normalizeText(line);
      return trimmed.startsWith('d') && trimmed.endsWith(tableLabel);
    });
    if (startIndex == -1) {
      return null;
    }

    final options = <_ParsedNarrativeOption>[];
    for (final line in lines.skip(startIndex + 1)) {
      final trimmed = _normalizeText(line);
      if (trimmed.isEmpty) {
        continue;
      }
      if (trimmed.startsWith('d') && trimmed.contains('|')) {
        break;
      }
      final columns = trimmed.split('|');
      if (columns.length < 2) {
        continue;
      }
      final rollText = _normalizeText(columns.first);
      final rawText = _normalizeText(columns.sublist(1).join('|'));
      if (rawText.isEmpty) {
        continue;
      }
      final rollParts = rollText.split('-');
      final index = int.tryParse(rollParts.first) ?? options.length + 1;
      final rollMin = int.tryParse(rollParts.first);
      final rollMax = rollParts.length > 1
          ? int.tryParse(rollParts.last)
          : int.tryParse(rollParts.first);
      options.add(
        _ParsedNarrativeOption(
          optionIndex: index,
          rollMin: rollMin,
          rollMax: rollMax,
          label: _extractNarrativeOptionLabel(rawText),
          text: rawText,
        ),
      );
    }

    return options.isEmpty ? null : _ParsedNarrativeTableSection(options);
  }

  List<_NamedNarrativeOption> _parseNamedTableSection(
    String text, {
    required String tableLabel,
    required String firstColumnLabel,
  }) {
    final normalized = _normalizeMultilineText(text);
    final lines = normalized.split('\n');
    final startIndex = lines.indexWhere(
      (line) => _normalizeText(line) == '$tableLabel:',
    );
    if (startIndex == -1) {
      return const <_NamedNarrativeOption>[];
    }

    var headerIndex = -1;
    for (var i = startIndex + 1; i < lines.length; i += 1) {
      if (_normalizeText(lines[i]).startsWith('$firstColumnLabel |')) {
        headerIndex = i;
        break;
      }
    }
    if (headerIndex == -1) {
      return const <_NamedNarrativeOption>[];
    }

    final options = <_NamedNarrativeOption>[];
    for (final line in lines.skip(headerIndex + 1)) {
      final trimmed = _normalizeText(line);
      if (trimmed.isEmpty || !trimmed.contains('|')) {
        break;
      }
      final separatorIndex = trimmed.indexOf('|');
      final label = _normalizeText(trimmed.substring(0, separatorIndex));
      final description = _normalizeText(trimmed.substring(separatorIndex + 1));
      if (label.isEmpty || description.isEmpty) {
        continue;
      }
      options.add(_NamedNarrativeOption(label: label, text: description));
    }
    return options;
  }

  String? _extractNarrativeOptionLabel(String rawText) {
    final separatorIndex = rawText.indexOf('.');
    if (separatorIndex <= 0) {
      return null;
    }
    final candidate = rawText.substring(0, separatorIndex).trim();
    if (candidate.split(' ').length > 5) {
      return null;
    }
    return candidate;
  }

  Future<void> _persistNormalizedRuleReferences(
    AppDatabase database,
    CompendiumCatalog catalog,
  ) async {
    await database.delete(database.narrativeOptions).go();
    await database.delete(database.narrativeOptionGroups).go();

    await database.batch((Batch batch) {
      batch.insertAll(
        database.characterAdvancementDefinitions,
        catalog.characterAdvancement
            .map(
              (entry) => CharacterAdvancementDefinitionsCompanion(
                level: Value(entry.level),
                experience: Value(entry.experience),
                proficiencyBonus: Value(
                  _parseProficiencyBonus(entry.proficiencyBonus),
                ),
              ),
            )
            .toList(growable: false),
        mode: InsertMode.insertOrReplace,
      );
      batch.insertAll(
        database.classStandardArrayRecommendations,
        catalog.standardArrayByClass
            .map(
              (entry) => ClassStandardArrayRecommendationsCompanion(
                classId: Value(entry.classId),
                className: Value(entry.className),
                strength: Value(entry.strength),
                dexterity: Value(entry.dexterity),
                constitution: Value(entry.constitution),
                intelligence: Value(entry.intelligence),
                wisdom: Value(entry.wisdom),
                charisma: Value(entry.charisma),
              ),
            )
            .toList(growable: false),
        mode: InsertMode.insertOrReplace,
      );
      batch.insertAll(
        database.narrativeOptionGroups,
        catalog.narrativeOptionGroups
            .map(
              (group) => NarrativeOptionGroupsCompanion(
                id: Value(group.id),
                fieldKey: Value(group.fieldKey),
                sourceType: Value(group.sourceType),
                packId: Value(group.packId),
                sourceId: Value(group.sourceId),
                sourceName: Value(group.sourceName),
                backgroundId: Value(group.backgroundId),
                backgroundName: Value(group.backgroundName),
                title: Value(group.title),
                diceFormula: Value(group.diceFormula),
                optionCount: Value(group.options.length),
                sourceBook: Value(group.sourceBook),
              ),
            )
            .toList(growable: false),
        mode: InsertMode.insertOrReplace,
      );
      batch.insertAll(
        database.narrativeOptions,
        catalog.narrativeOptionGroups
            .expand(
              (group) => group.options.map(
                (option) => NarrativeOptionsCompanion(
                  id: Value(option.id),
                  groupId: Value(group.id),
                  optionIndex: Value(option.optionIndex),
                  rollMin: Value(option.rollMin),
                  rollMax: Value(option.rollMax),
                  label: Value(option.label),
                  content: Value(option.text),
                ),
              ),
            )
            .toList(growable: false),
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Future<void> _persistPackStates(
    AppDatabase database,
    CompendiumCatalog catalog,
  ) async {
    final defaultPackStates = catalog.packStates;
    final existingRows = await database
        .select(database.compendiumPackStates)
        .get();
    final existingById = <String, CompendiumPackState>{
      for (final row in existingRows) row.id: row,
    };
    await database.batch((batch) {
      batch.insertAll(
        database.compendiumPackStates,
        defaultPackStates
            .map((packState) {
              final existing = existingById[packState.id];
              return CompendiumPackStatesCompanion.insert(
                id: packState.id,
                title: packState.title,
                description: packState.description,
                kind: packState.kind,
                isFixed: Value(packState.isFixed),
                isActive: Value(
                  packState.isFixed
                      ? true
                      : existing?.isActive ?? packState.isActive,
                ),
                updatedAt: existing?.updatedAt ?? DateTime.now(),
              );
            })
            .toList(growable: false),
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Future<CompendiumCatalog> _loadCatalogWithNormalizedRules(
    AppDatabase database,
    CompendiumCatalog catalog,
  ) async {
    final advancementRows = await (database.select(
      database.characterAdvancementDefinitions,
    )..orderBy([(table) => OrderingTerm.asc(table.level)])).get();
    final standardArrayRows = await (database.select(
      database.classStandardArrayRecommendations,
    )..orderBy([(table) => OrderingTerm.asc(table.className)])).get();
    final narrativeGroupRows =
        await (database.select(database.narrativeOptionGroups)..orderBy([
              (table) => OrderingTerm.asc(table.fieldKey),
              (table) => OrderingTerm.asc(table.title),
            ]))
            .get();
    final narrativeOptionRows =
        await (database.select(database.narrativeOptions)..orderBy([
              (table) => OrderingTerm.asc(table.groupId),
              (table) => OrderingTerm.asc(table.optionIndex),
            ]))
            .get();
    final packStateRows =
        await (database.select(database.compendiumPackStates)..orderBy([
              (table) => OrderingTerm.asc(table.isFixed),
              (table) => OrderingTerm.asc(table.title),
            ]))
            .get();
    final optionsByGroupId = <String, List<NarrativeOption>>{};
    for (final row in narrativeOptionRows) {
      optionsByGroupId
          .putIfAbsent(row.groupId, () => <NarrativeOption>[])
          .add(row);
    }

    return catalog.copyWith(
      characterAdvancement: advancementRows
          .map(
            (row) => CharacterAdvancementEntry(
              level: row.level,
              experience: row.experience,
              proficiencyBonus: '+${row.proficiencyBonus}',
            ),
          )
          .toList(growable: false),
      standardArrayByClass: standardArrayRows
          .map(
            (row) => StandardArrayByClassEntry(
              classId: row.classId,
              className: row.className,
              strength: row.strength,
              dexterity: row.dexterity,
              constitution: row.constitution,
              intelligence: row.intelligence,
              wisdom: row.wisdom,
              charisma: row.charisma,
            ),
          )
          .toList(growable: false),
      narrativeOptionGroups: narrativeGroupRows
          .map(
            (row) => CompendiumNarrativeOptionGroup(
              id: row.id,
              fieldKey: row.fieldKey,
              sourceType: row.sourceType,
              packId: row.packId,
              sourceId: row.sourceId,
              sourceName: row.sourceName,
              backgroundId: row.backgroundId,
              backgroundName: row.backgroundName,
              title: row.title,
              diceFormula: row.diceFormula,
              sourceBook: row.sourceBook,
              options: (optionsByGroupId[row.id] ?? const <NarrativeOption>[])
                  .map(
                    (option) => CompendiumNarrativeOption(
                      id: option.id,
                      optionIndex: option.optionIndex,
                      rollMin: option.rollMin,
                      rollMax: option.rollMax,
                      label: option.label,
                      text: option.content,
                    ),
                  )
                  .toList(growable: false),
            ),
          )
          .toList(growable: false),
      packStates: packStateRows
          .map(
            (row) => CompendiumPackStateModel(
              id: row.id,
              title: row.title,
              description: row.description,
              kind: row.kind,
              isFixed: row.isFixed,
              isActive: row.isActive,
            ),
          )
          .toList(growable: false),
    );
  }

  CompendiumCatalog _updateCatalogPackState(
    CompendiumCatalog catalog,
    String packId,
    bool isActive,
  ) {
    return catalog.copyWith(
      packStates: catalog.packStates
          .map((packState) {
            if (packState.id != packId) {
              return packState;
            }
            if (packState.isFixed) {
              return packState.copyWith(isActive: true);
            }
            return packState.copyWith(isActive: isActive);
          })
          .toList(growable: false),
    );
  }

  List<CompendiumPackStateModel> _buildDefaultPackStates(
    CompendiumSourcePolicy sourcePolicy,
  ) {
    final packStates = <CompendiumPackStateModel>[
      CompendiumPackStateModel(
        id: 'bundled-base-compendium',
        title: 'Compendio base',
        description: sourcePolicy.activeSourceLabel,
        kind: 'bundled_base',
        isFixed: true,
        isActive: true,
      ),
    ];

    final narrativePolicy = sourcePolicy.sectionFor('narrative_options');
    if (narrativePolicy != null) {
      packStates.add(
        const CompendiumPackStateModel(
          id: 'legacy-narrative-supplements',
          title: 'Narrative supplements',
          description:
              'Legacy supplemental narrative tables for faction and background flavor.',
          kind: 'optional_bundle',
          isFixed: false,
          isActive: true,
        ),
      );
    }

    return List<CompendiumPackStateModel>.unmodifiable(packStates);
  }

  int _parseProficiencyBonus(String rawValue) {
    final normalized = rawValue.trim().replaceFirst('+', '');
    return int.tryParse(normalized) ?? 0;
  }

  CompendiumPackStateModel _buildImportedPackState(
    String rawXml,
    List<CompendiumPackStateModel> existingPackStates,
  ) {
    final normalizedXml = rawXml.trim();
    if (normalizedXml.isEmpty) {
      throw const FormatException('Pega un XML antes de intentar importarlo.');
    }
    if (!RegExp(
      r'<(compendium|collection)\b',
      caseSensitive: false,
    ).hasMatch(normalizedXml)) {
      throw const FormatException(
        'El XML debe incluir una raiz compendium o collection.',
      );
    }

    final supportedElementCount = RegExp(
      r'<(background|race|class|spell|feat|monster)\b',
      caseSensitive: false,
    ).allMatches(normalizedXml).length;
    if (supportedElementCount == 0) {
      throw const FormatException(
        'El XML no contiene entradas compatibles de backgrounds, races, classes, spells, feats o monsters.',
      );
    }

    final titleMatch = RegExp(
      r'<name>([^<]+)</name>',
      caseSensitive: false,
    ).firstMatch(normalizedXml);
    final rawTitle = titleMatch?.group(1)?.trim();
    final title = rawTitle == null || rawTitle.isEmpty
        ? 'Imported XML pack'
        : _normalizeCatalogName(rawTitle);
    final baseId = _slugifyImportedPackId(title);
    final id = _nextImportedPackId(baseId, existingPackStates);
    return CompendiumPackStateModel(
      id: id,
      title: title,
      description:
          'Imported XML pack with $supportedElementCount supported entries registered locally for future ingestion.',
      kind: 'imported_xml',
      isFixed: false,
      isActive: true,
    );
  }

  List<CompendiumPackStateModel> _mergeImportedPackState(
    List<CompendiumPackStateModel> packStates,
    CompendiumPackStateModel importedPackState,
  ) {
    return <CompendiumPackStateModel>[
      ...packStates.where((packState) => packState.id != importedPackState.id),
      importedPackState,
    ];
  }

  String _nextImportedPackId(
    String baseId,
    List<CompendiumPackStateModel> existingPackStates,
  ) {
    final existingIds = existingPackStates
        .map((packState) => packState.id)
        .toSet();
    var candidate = 'imported-$baseId';
    var suffix = 2;
    while (existingIds.contains(candidate)) {
      candidate = 'imported-$baseId-$suffix';
      suffix += 1;
    }
    return candidate;
  }

  String _slugifyImportedPackId(String text) {
    final slug = _normalizeCatalogName(text)
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
        .replaceAll(RegExp(r'^-+|-+$'), '');
    return slug.isEmpty ? 'xml-pack' : slug;
  }

  Future<CompendiumCatalog> _mergeImportedCompendiumContent(
    AppDatabase database,
    CompendiumCatalog catalog,
  ) async {
    final importedRows = await (database.select(
      database.importedCompendiumPacks,
    )..orderBy([(table) => OrderingTerm.asc(table.importedAt)])).get();
    final activeContents = importedRows
        .where((row) => catalog.isPackActive(row.id))
        .map(
          (row) => parseImportedCompendiumContent(
            packId: row.id,
            packTitle:
                catalog.packStateById(row.id)?.title ?? 'Imported XML pack',
            rawXml: row.rawXml,
          ),
        )
        .toList(growable: false);
    return _mergeImportedContent(catalog: catalog, contents: activeContents);
  }

  CompendiumCatalog _mergeImportedCompendiumContentFromMemory(
    CompendiumCatalog catalog,
  ) {
    final activeContents = _importedPackXmlById.entries
        .where((entry) => catalog.isPackActive(entry.key))
        .map(
          (entry) => parseImportedCompendiumContent(
            packId: entry.key,
            packTitle:
                catalog.packStateById(entry.key)?.title ?? 'Imported XML pack',
            rawXml: entry.value,
          ),
        )
        .toList(growable: false);
    return _mergeImportedContent(catalog: catalog, contents: activeContents);
  }

  CompendiumCatalog _mergeImportedContent({
    required CompendiumCatalog catalog,
    required List<ImportedCompendiumContent> contents,
  }) {
    return mergeImportedCompendiumContents(catalog, contents);
  }

  Future<CompendiumCatalog> _loadBaseCatalog() async {
    CompendiumCatalog? catalog;
    try {
      final backgroundsXml = await _bundle.loadString(_backgroundsAssetPath);
      final racesXml = await _bundle.loadString(_racesAssetPath);
      final classesXml = await _bundle.loadString(_classesAssetPath);
      final spellsXml = await _tryLoadString(_spellsAssetPath);
      final featsXml = await _tryLoadString(_featsAssetPath);
      final monstersXml = await _tryLoadString(_monstersAssetPath);
      final phbBackgroundsXml = await _tryLoadString(_phbBackgroundsAssetPath);
      final scagBackgroundsXml = await _tryLoadString(
        _scagBackgroundsAssetPath,
      );
      final pamBackgroundsXml = await _tryLoadString(_pamBackgroundsAssetPath);
      final ggrBackgroundsXml = await _tryLoadString(_ggrBackgroundsAssetPath);
      final erlwBackgroundsXml = await _tryLoadString(
        _erlwBackgroundsAssetPath,
      );
      catalog = _parseFightClubCatalog(
        backgroundsXml: backgroundsXml,
        racesXml: racesXml,
        classesXml: classesXml,
        spellsXml: spellsXml ?? '',
        featsXml: featsXml ?? '',
        monstersXml: monstersXml ?? '',
        phbBackgroundsXml: phbBackgroundsXml ?? '',
        scagBackgroundsXml: scagBackgroundsXml ?? '',
        pamBackgroundsXml: pamBackgroundsXml ?? '',
        ggrBackgroundsXml: ggrBackgroundsXml ?? '',
        erlwBackgroundsXml: erlwBackgroundsXml ?? '',
      );
    } catch (_) {
      final rawJson = await _bundle.loadString(_fallbackCatalogAssetPath);
      catalog = _parseJsonCatalog(rawJson);
    }

    final database = _database;
    if (database == null) {
      return catalog;
    }

    await _persistNormalizedRuleReferences(database, catalog);
    await _persistPackStates(database, catalog);
    return _loadCatalogWithNormalizedRules(database, catalog);
  }
}

class _XmlElement {
  const _XmlElement({required this.attributes, required this.innerXml});

  final Map<String, String> attributes;
  final String innerXml;
}

class _NarrativeTableField {
  const _NarrativeTableField({
    required this.fieldKey,
    required this.tableLabel,
    required this.groupTitle,
  });

  final String fieldKey;
  final String tableLabel;
  final String groupTitle;
}

class _ParsedNarrativeTableSection {
  const _ParsedNarrativeTableSection(this.options);

  final List<_ParsedNarrativeOption> options;
}

class _ParsedNarrativeOption {
  const _ParsedNarrativeOption({
    required this.optionIndex,
    required this.rollMin,
    required this.rollMax,
    required this.label,
    required this.text,
  });

  final int optionIndex;
  final int? rollMin;
  final int? rollMax;
  final String? label;
  final String text;
}

class _NamedNarrativeOption {
  const _NamedNarrativeOption({required this.label, required this.text});

  final String label;
  final String text;
}

const List<_NarrativeTableField> _narrativeTableFields = <_NarrativeTableField>[
  _NarrativeTableField(
    fieldKey: 'personality_traits',
    tableLabel: 'Personality Trait',
    groupTitle: 'Personality Traits',
  ),
  _NarrativeTableField(
    fieldKey: 'ideals',
    tableLabel: 'Ideal',
    groupTitle: 'Ideals',
  ),
  _NarrativeTableField(
    fieldKey: 'bonds',
    tableLabel: 'Bond',
    groupTitle: 'Bonds',
  ),
  _NarrativeTableField(
    fieldKey: 'flaws',
    tableLabel: 'Flaw',
    groupTitle: 'Flaws',
  ),
];
