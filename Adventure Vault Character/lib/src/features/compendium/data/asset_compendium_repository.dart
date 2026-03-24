import 'dart:convert';

import 'package:adventure_vault_character/src/features/characters/domain/character_sheet_view_data.dart';
import 'package:adventure_vault_character/src/features/compendium/data/compendium_repository.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';
import 'package:flutter/services.dart';

class AssetCompendiumRepository implements CompendiumRepository {
  AssetCompendiumRepository({
    AssetBundle? bundle,
    String xmlCatalogAssetPath = 'local-assets/srd_5_2_1_app_base.xml',
    String spellsAndFeatsAssetPath = 'local-assets/Official Only 2024.xml',
    String monstersAssetPath = 'local-assets/Core Rulebooks.xml',
    String fallbackCatalogAssetPath = 'assets/compendium/catalog.json',
  }) : _bundle = bundle ?? rootBundle,
       _xmlCatalogAssetPath = xmlCatalogAssetPath,
       _spellsAndFeatsAssetPath = spellsAndFeatsAssetPath,
       _monstersAssetPath = monstersAssetPath,
       _fallbackCatalogAssetPath = fallbackCatalogAssetPath;

  final AssetBundle _bundle;
  final String _xmlCatalogAssetPath;
  final String _spellsAndFeatsAssetPath;
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
      final rawXml = await _bundle.loadString(_xmlCatalogAssetPath);
      final spellsAndFeatsXml = await _tryLoadString(_spellsAndFeatsAssetPath);
      final monstersXml = await _tryLoadString(_monstersAssetPath);
      catalog = _parseXmlCatalog(
        rawXml,
        spellsAndFeatsXml: spellsAndFeatsXml,
        monstersXml: monstersXml,
      );
    } catch (_) {
      final rawJson = await _bundle.loadString(_fallbackCatalogAssetPath);
      catalog = _parseJsonCatalog(rawJson);
    }

    _cachedCatalog = catalog;
    return catalog;
  }

  static const Map<int, List<String>> _spellSeedsByLevel = <int, List<String>>{
    0: <String>['Light [2024]'],
    1: <String>['Magic Missile [2024]'],
    2: <String>['Misty Step [2024]'],
    3: <String>['Fireball [2024]'],
    4: <String>['Dimension Door [2024]'],
    5: <String>['Cone of Cold [2024]'],
    6: <String>['Chain Lightning [2024]'],
    7: <String>['Teleport [2024]'],
    8: <String>['Dominate Monster [2024]'],
    9: <String>['Wish [2024]'],
  };

  static const List<String> _featSeeds = <String>[
    'Actor [2024]',
    'Alert [2024]',
    'Shield Master [2024]',
  ];

  static const List<String> _monsterSeeds = <String>[
    'Goblin',
    'Owlbear',
    'Adult Red Dragon',
  ];

  CompendiumCatalog _parseXmlCatalog(
    String rawXml, {
    String? spellsAndFeatsXml,
    String? monstersXml,
  }) {
    final abilityGeneration = _extractSection(rawXml, 'abilityGeneration');
    final levelProgressionSection = _extractSection(rawXml, 'levelProgression');
    final backgroundsSection = _extractSection(rawXml, 'backgrounds');
    final speciesSection = _extractSection(rawXml, 'speciesList');
    final classesSection = _extractSection(rawXml, 'classes');

    final races = _extractElements(speciesSection, 'species')
        .map((species) => _extractSingleTagText(species.innerXml, 'name'))
        .whereType<String>()
        .toList(growable: false);

    final classes = <String>[];
    final equipmentSummariesByClass = <String, EquipmentSummaryViewData>{};
    final equipmentLoadoutsByClass =
        <String, List<CompendiumEquipmentLoadout>>{};
    for (final classElement in _extractElements(classesSection, 'class')) {
      final className = _extractSingleTagText(classElement.innerXml, 'name');
      if (className == null || className.isEmpty) {
        continue;
      }

      classes.add(className);
      equipmentSummariesByClass[className] = _buildEquipmentSummary(
        classElement.innerXml,
      );
      equipmentLoadoutsByClass[className] = _buildEquipmentLoadouts(
        className: className,
        classId: classElement.attributes['id'] ?? className.toLowerCase(),
        classXml: classElement.innerXml,
      );
    }

    final backgrounds = _extractElements(
      backgroundsSection,
      'background',
    ).map(_parseBackground).toList(growable: false);
    final characterAdvancement =
        _extractSelfClosingElements(levelProgressionSection, 'level')
            .map((level) {
              return CharacterAdvancementEntry(
                level: int.parse(level.attributes['value']!),
                experience: int.parse(level.attributes['xp']!),
                proficiencyBonus: level.attributes['proficiencyBonus'] ?? '',
              );
            })
            .toList(growable: false);
    final standardArrayByClass =
        _extractSelfClosingElements(
              _extractSection(abilityGeneration, 'standardArrayByClass'),
              'classRef',
            )
            .map((entry) {
              final classId = entry.attributes['id'] ?? '';
              final className = classes.firstWhere(
                (item) => item.toLowerCase() == classId,
                orElse: () => classId,
              );
              return StandardArrayByClassEntry(
                classId: classId,
                className: className,
                strength: int.parse(entry.attributes['strength']!),
                dexterity: int.parse(entry.attributes['dexterity']!),
                constitution: int.parse(entry.attributes['constitution']!),
                intelligence: int.parse(entry.attributes['intelligence']!),
                wisdom: int.parse(entry.attributes['wisdom']!),
                charisma: int.parse(entry.attributes['charisma']!),
              );
            })
            .toList(growable: false);

    return CompendiumCatalog(
      races: races,
      classes: classes,
      backgrounds: backgrounds,
      generatedAbilityScoreSet: _extractAllTagTexts(
        _extractSection(abilityGeneration, 'standardArray'),
        'score',
      ).map(int.parse).toList(growable: false),
      manualAbilityScoreOptions:
          _extractSelfClosingElements(
                _extractSection(abilityGeneration, 'pointBuy'),
                'score',
              )
              .map((score) => int.parse(score.attributes['value']!))
              .toList(growable: false),
      characterAdvancement: characterAdvancement,
      standardArrayByClass: standardArrayByClass,
      spells: _parseSeededSpells(spellsAndFeatsXml ?? ''),
      feats: _parseSeededFeats(spellsAndFeatsXml ?? ''),
      monsters: _parseSeededMonsters(monstersXml ?? ''),
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

  CompendiumBackground _parseBackground(_XmlElement backgroundElement) {
    final xml = backgroundElement.innerXml;
    final abilityOptions = _extractAllTagTexts(
      _extractSection(xml, 'abilityOptions', required: false),
      'ability',
    );
    final skills = _extractAllTagTexts(
      _extractSection(xml, 'skillProficiencies', required: false),
      'skill',
    );
    final tool = _extractSingleTagText(xml, 'toolProficiency');
    final feat = _extractSingleTagText(xml, 'originFeat');
    final equipmentOptions = _extractAllTagTexts(
      _extractSection(xml, 'equipment', required: false),
      'option',
    );

    final bonuses = <String>[
      if (abilityOptions.isNotEmpty)
        'Ability options: ${abilityOptions.join(', ')}',
      if (skills.isNotEmpty) 'Skills: ${skills.join(', ')}',
      if (tool != null && tool.isNotEmpty) 'Tool: $tool',
    ];
    final socialPerks = <String>[
      if (feat != null && feat.isNotEmpty) 'Origin feat: $feat',
      ...equipmentOptions.map((option) => 'Starting equipment: $option'),
    ];

    return CompendiumBackground(
      id: backgroundElement.attributes['id'] ?? '',
      name: _extractSingleTagText(xml, 'name') ?? 'Unknown background',
      summary:
          _extractSingleTagText(xml, 'summary') ??
          'Background summary unavailable.',
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
            name: _extractSingleTagText(spellXml, 'name') ?? name,
            level: int.parse(_extractSingleTagText(spellXml, 'level') ?? '0'),
            school: _extractSingleTagText(spellXml, 'school') ?? '',
            castingTime: _extractSingleTagText(spellXml, 'time') ?? '',
            range: _extractSingleTagText(spellXml, 'range') ?? '',
            components: _extractSingleTagText(spellXml, 'components') ?? '',
            duration: _extractSingleTagText(spellXml, 'duration') ?? '',
            classes: _splitCsv(
              _extractSingleTagText(spellXml, 'classes') ?? '',
            ),
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
            name: _extractSingleTagText(featXml, 'name') ?? name,
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
            name: _extractSingleTagText(monsterXml, 'name') ?? name,
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
    final primaryAbility = _extractSingleTagText(classXml, 'primaryAbility');
    final hitDie = _extractSingleTagText(classXml, 'hitDie');
    final armorTraining = _extractSingleTagText(classXml, 'armorTraining');
    final weapons = _extractSingleTagText(classXml, 'weaponProficiencies');
    final features = _extractAllTagTexts(
      _extractSection(classXml, 'level1Features', required: false),
      'feature',
    );

    return EquipmentSummaryViewData(
      statusLabel: 'SRD base',
      description:
          'Primary ability: ${primaryAbility ?? 'Unknown'}. Hit Die: ${hitDie ?? 'Unknown'}. '
          'Armor: ${armorTraining ?? 'Unknown'}. Weapons: ${weapons ?? 'Unknown'}.',
      highlightItems: features.isEmpty
          ? const <String>['Level 1 feature data unavailable']
          : features,
    );
  }

  List<CompendiumEquipmentLoadout> _buildEquipmentLoadouts({
    required String className,
    required String classId,
    required String classXml,
  }) {
    final startingEquipment = _extractSection(
      classXml,
      'startingEquipment',
      required: false,
    );
    final options = _extractElements(startingEquipment, 'option');
    if (options.isEmpty) {
      return const <CompendiumEquipmentLoadout>[];
    }

    return options
        .map((option) {
          final rawText = _normalizeText(option.innerXml);
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
          final optionId = option.attributes['id'] ?? 'option';

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

  String _extractSection(String xml, String tagName, {bool required = true}) {
    if (xml.isEmpty) {
      return '';
    }

    final match = RegExp(
      '<$tagName\\b[^>]*>([\\s\\S]*?)</$tagName>',
      caseSensitive: false,
    ).firstMatch(xml);
    if (match == null) {
      if (required) {
        throw FormatException('Missing section <$tagName>.');
      }
      return '';
    }
    return match.group(1) ?? '';
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

  List<_XmlElement> _extractSelfClosingElements(String xml, String tagName) {
    if (xml.isEmpty) {
      return const <_XmlElement>[];
    }

    return RegExp('<$tagName\\b([^>]*)/>', caseSensitive: false)
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

          return _XmlElement(attributes: attributes, innerXml: '');
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
      if (name == expectedName) {
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
}

class _XmlElement {
  const _XmlElement({required this.attributes, required this.innerXml});

  final Map<String, String> attributes;
  final String innerXml;
}
