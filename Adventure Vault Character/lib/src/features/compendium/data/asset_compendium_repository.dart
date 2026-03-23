import 'dart:convert';

import 'package:adventure_vault_character/src/features/characters/domain/character_sheet_view_data.dart';
import 'package:adventure_vault_character/src/features/compendium/data/compendium_repository.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';
import 'package:flutter/services.dart';

class AssetCompendiumRepository implements CompendiumRepository {
  AssetCompendiumRepository({
    AssetBundle? bundle,
    String xmlCatalogAssetPath = 'local-assets/srd_5_2_1_app_base.xml',
    String fallbackCatalogAssetPath = 'assets/compendium/catalog.json',
  }) : _bundle = bundle ?? rootBundle,
       _xmlCatalogAssetPath = xmlCatalogAssetPath,
       _fallbackCatalogAssetPath = fallbackCatalogAssetPath;

  final AssetBundle _bundle;
  final String _xmlCatalogAssetPath;
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
      catalog = _parseXmlCatalog(rawXml);
    } catch (_) {
      final rawJson = await _bundle.loadString(_fallbackCatalogAssetPath);
      catalog = _parseJsonCatalog(rawJson);
    }

    _cachedCatalog = catalog;
    return catalog;
  }

  CompendiumCatalog _parseXmlCatalog(String rawXml) {
    final abilityGeneration = _extractSection(rawXml, 'abilityGeneration');
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
