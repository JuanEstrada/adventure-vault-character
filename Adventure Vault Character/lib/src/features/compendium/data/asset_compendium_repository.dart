import 'dart:convert';

import 'package:adventure_vault_character/src/features/characters/domain/equipment_summary_view_data.dart';
import 'package:adventure_vault_character/src/features/compendium/data/compendium_repository.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';
import 'package:flutter/services.dart';

class AssetCompendiumRepository implements CompendiumRepository {
  AssetCompendiumRepository({
    AssetBundle? bundle,
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
    String fallbackCatalogAssetPath = 'assets/compendium/catalog.json',
  }) : _bundle = bundle ?? rootBundle,
       _backgroundsAssetPath = backgroundsAssetPath,
       _racesAssetPath = racesAssetPath,
       _classesAssetPath = classesAssetPath,
       _spellsAssetPath = spellsAssetPath,
       _featsAssetPath = featsAssetPath,
       _monstersAssetPath = monstersAssetPath,
       _fallbackCatalogAssetPath = fallbackCatalogAssetPath;

  final AssetBundle _bundle;
  final String _backgroundsAssetPath;
  final String _racesAssetPath;
  final String _classesAssetPath;
  final String _spellsAssetPath;
  final String _featsAssetPath;
  final String _monstersAssetPath;
  final String _fallbackCatalogAssetPath;

  CompendiumCatalog? _cachedCatalog;

  @override
  Future<CompendiumCatalog> loadCatalog() async {
    final cachedCatalog = _cachedCatalog;
    if (cachedCatalog != null) {
      return cachedCatalog;
    }

    CompendiumCatalog? catalog;
    try {
      final backgroundsXml = await _bundle.loadString(_backgroundsAssetPath);
      final racesXml = await _bundle.loadString(_racesAssetPath);
      final classesXml = await _bundle.loadString(_classesAssetPath);
      final spellsXml = await _tryLoadString(_spellsAssetPath);
      final featsXml = await _tryLoadString(_featsAssetPath);
      final monstersXml = await _tryLoadString(_monstersAssetPath);
      catalog = _parseFightClubCatalog(
        backgroundsXml: backgroundsXml,
        racesXml: racesXml,
        classesXml: classesXml,
        spellsXml: spellsXml ?? '',
        featsXml: featsXml ?? '',
        monstersXml: monstersXml ?? '',
      );
    } catch (_) {
      final rawJson = await _bundle.loadString(_fallbackCatalogAssetPath);
      catalog = _parseJsonCatalog(rawJson);
    }

    _cachedCatalog = catalog;
    return catalog;
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

    return CompendiumCatalog(
      races: races,
      classes: classes,
      backgrounds: backgrounds,
      generatedAbilityScoreSet: _generatedAbilityScoreSet,
      manualAbilityScoreOptions: _manualAbilityScoreOptions,
      characterAdvancement: _characterAdvancement,
      standardArrayByClass: _standardArrayByClass,
      spells: _parseSeededSpells(spellsXml),
      feats: _parseSeededFeats(featsXml),
      monsters: _parseSeededMonsters(monstersXml),
      equipmentSummariesByClass: equipmentSummariesByClass,
      equipmentLoadoutsByClass: equipmentLoadoutsByClass,
    );
  }

  CompendiumCatalog _parseJsonCatalog(String raw) {
    final Map<String, dynamic> json = jsonDecode(raw) as Map<String, dynamic>;

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
}

class _XmlElement {
  const _XmlElement({required this.attributes, required this.innerXml});

  final Map<String, String> attributes;
  final String innerXml;
}
