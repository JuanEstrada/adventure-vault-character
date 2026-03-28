import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';

class ImportedCompendiumContent {
  const ImportedCompendiumContent({
    required this.packId,
    required this.packTitle,
    required this.races,
    required this.classes,
    required this.backgrounds,
    required this.spells,
    required this.feats,
    required this.monsters,
  });

  final String packId;
  final String packTitle;
  final List<String> races;
  final List<String> classes;
  final List<CompendiumBackground> backgrounds;
  final List<CompendiumSpell> spells;
  final List<CompendiumFeat> feats;
  final List<CompendiumMonster> monsters;

  int get supportedEntryCount =>
      races.length +
      classes.length +
      backgrounds.length +
      spells.length +
      feats.length +
      monsters.length;

  int countForSection(String sectionKey) {
    return switch (sectionKey) {
      'races' => races.length,
      'classes' => classes.length,
      'backgrounds' => backgrounds.length,
      'spells' => spells.length,
      'feats' => feats.length,
      'monsters' => monsters.length,
      _ => 0,
    };
  }
}

ImportedCompendiumContent parseImportedCompendiumContent({
  required String packId,
  required String packTitle,
  required String rawXml,
}) {
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

  final races = _extractElements(normalizedXml, 'race')
      .map(
        (element) => _normalizeCatalogName(
          _extractSingleTagText(element.innerXml, 'name') ?? '',
        ),
      )
      .where((name) => name.isNotEmpty)
      .toList(growable: false);
  final classes = _extractElements(normalizedXml, 'class')
      .map(
        (element) => _normalizeCatalogName(
          _extractSingleTagText(element.innerXml, 'name') ?? '',
        ),
      )
      .where((name) => name.isNotEmpty)
      .toList(growable: false);
  final backgrounds = _extractElements(normalizedXml, 'background')
      .map(_parseBackground)
      .whereType<CompendiumBackground>()
      .toList(growable: false);
  final spells = _extractElements(
    normalizedXml,
    'spell',
  ).map(_parseSpell).whereType<CompendiumSpell>().toList(growable: false);
  final feats = _extractElements(
    normalizedXml,
    'feat',
  ).map(_parseFeat).whereType<CompendiumFeat>().toList(growable: false);
  final monsters = _extractElements(
    normalizedXml,
    'monster',
  ).map(_parseMonster).whereType<CompendiumMonster>().toList(growable: false);

  final content = ImportedCompendiumContent(
    packId: packId,
    packTitle: packTitle,
    races: races,
    classes: classes,
    backgrounds: backgrounds,
    spells: spells,
    feats: feats,
    monsters: monsters,
  );
  if (content.supportedEntryCount == 0) {
    throw const FormatException(
      'El XML no contiene entradas compatibles de backgrounds, races, classes, spells, feats o monsters.',
    );
  }

  return content;
}

CompendiumCatalog mergeImportedCompendiumContents(
  CompendiumCatalog catalog,
  List<ImportedCompendiumContent> contents,
) {
  if (contents.isEmpty) {
    return catalog;
  }

  final mergedRaces = _mergeUniqueStrings(
    catalog.races,
    contents.expand((content) => content.races),
  );
  final mergedClasses = _mergeUniqueStrings(
    catalog.classes,
    contents.expand((content) => content.classes),
  );
  final mergedBackgrounds = _mergeUniqueBackgrounds(
    catalog.backgrounds,
    contents.expand((content) => content.backgrounds),
  );
  final mergedSpells = _mergeUniqueByName<CompendiumSpell>(
    catalog.spells,
    contents.expand((content) => content.spells),
    (item) => item.name,
  );
  final mergedFeats = _mergeUniqueByName<CompendiumFeat>(
    catalog.feats,
    contents.expand((content) => content.feats),
    (item) => item.name,
  );
  final mergedMonsters = _mergeUniqueByName<CompendiumMonster>(
    catalog.monsters,
    contents.expand((content) => content.monsters),
    (item) => item.name,
  );
  final importedPackCount = contents.length;
  final importedLabel = importedPackCount == 1
      ? '1 imported XML pack'
      : '$importedPackCount imported XML packs';

  return catalog.copyWith(
    races: mergedRaces,
    classes: mergedClasses,
    backgrounds: mergedBackgrounds,
    spells: mergedSpells,
    feats: mergedFeats,
    monsters: mergedMonsters,
    sourcePolicy: CompendiumSourcePolicy(
      activeSourceType: catalog.sourcePolicy.activeSourceType,
      activeSourceLabel:
          '${catalog.sourcePolicy.activeSourceLabel} + $importedLabel',
      fallbackSourceLabel: catalog.sourcePolicy.fallbackSourceLabel,
      sections: catalog.sourcePolicy.sections
          .map((section) => _appendImportedSourceNote(section, contents))
          .toList(growable: false),
    ),
  );
}

CompendiumSectionSourcePolicy _appendImportedSourceNote(
  CompendiumSectionSourcePolicy section,
  List<ImportedCompendiumContent> contents,
) {
  final contributions = contents
      .map((content) {
        final count = content.countForSection(section.sectionKey);
        if (count == 0) {
          return null;
        }
        return '${content.packTitle} ($count)';
      })
      .whereType<String>()
      .toList(growable: false);
  if (contributions.isEmpty) {
    return section;
  }

  final importedNote =
      'Imported XML packs active: ${contributions.join(', ')}.';
  return CompendiumSectionSourcePolicy(
    sectionKey: section.sectionKey,
    sectionLabel: section.sectionLabel,
    sourceType: section.sourceType,
    primarySources: section.primarySources,
    supplementalSources: section.supplementalSources,
    supplementalPackId: section.supplementalPackId,
    notes: section.notes == null
        ? importedNote
        : '${section.notes} $importedNote',
  );
}

List<String> _mergeUniqueStrings(
  List<String> baseValues,
  Iterable<String> importedValues,
) {
  final merged = <String>[...baseValues];
  final known = baseValues.toSet();
  for (final value in importedValues) {
    if (known.add(value)) {
      merged.add(value);
    }
  }
  return List<String>.unmodifiable(merged);
}

List<CompendiumBackground> _mergeUniqueBackgrounds(
  List<CompendiumBackground> baseValues,
  Iterable<CompendiumBackground> importedValues,
) {
  final merged = <CompendiumBackground>[...baseValues];
  final knownIds = baseValues.map((item) => item.id).toSet();
  for (final value in importedValues) {
    if (knownIds.add(value.id)) {
      merged.add(value);
    }
  }
  return List<CompendiumBackground>.unmodifiable(merged);
}

List<T> _mergeUniqueByName<T>(
  List<T> baseValues,
  Iterable<T> importedValues,
  String Function(T value) nameSelector,
) {
  final merged = <T>[...baseValues];
  final knownNames = baseValues.map(nameSelector).toSet();
  for (final value in importedValues) {
    if (knownNames.add(nameSelector(value))) {
      merged.add(value);
    }
  }
  return List<T>.unmodifiable(merged);
}

CompendiumBackground? _parseBackground(_XmlElement element) {
  final name = _normalizeCatalogName(
    _extractSingleTagText(element.innerXml, 'name') ?? '',
  );
  if (name.isEmpty) {
    return null;
  }
  final description = _extractTraitText(element.innerXml, 'Description');
  return CompendiumBackground(
    id: _slugifyName(name),
    name: name,
    summary: description.isEmpty ? 'Imported XML background.' : description,
    bonuses: const <String>['Imported XML background'],
    socialPerks: const <String>['Imported XML pack'],
  );
}

CompendiumSpell? _parseSpell(_XmlElement element) {
  final xml = element.innerXml;
  final name = _normalizeCatalogName(_extractSingleTagText(xml, 'name') ?? '');
  if (name.isEmpty) {
    return null;
  }
  return CompendiumSpell(
    name: name,
    level: int.tryParse(_extractSingleTagText(xml, 'level') ?? '0') ?? 0,
    school: _extractSingleTagText(xml, 'school') ?? '',
    castingTime: _extractSingleTagText(xml, 'time') ?? '',
    range: _extractSingleTagText(xml, 'range') ?? '',
    components: _extractSingleTagText(xml, 'components') ?? '',
    duration: _extractSingleTagText(xml, 'duration') ?? '',
    classes: _splitCsv(
      _extractSingleTagText(xml, 'classes') ?? '',
    ).map(_normalizeCatalogName).toList(growable: false),
    description: _extractTextParagraphs(xml),
    source: _extractSource(xml),
  );
}

CompendiumFeat? _parseFeat(_XmlElement element) {
  final xml = element.innerXml;
  final name = _normalizeCatalogName(_extractSingleTagText(xml, 'name') ?? '');
  if (name.isEmpty) {
    return null;
  }

  return CompendiumFeat(
    name: name,
    prerequisite: _extractSingleTagText(xml, 'prerequisite') ?? '',
    description: _extractTextParagraphs(xml),
    modifiers: _extractElements(xml, 'modifier')
        .map((modifier) => _normalizeMultilineText(modifier.innerXml))
        .where((text) => text.isNotEmpty)
        .toList(growable: false),
    source: _extractSource(xml),
  );
}

CompendiumMonster? _parseMonster(_XmlElement element) {
  final xml = element.innerXml;
  final name = _normalizeCatalogName(_extractSingleTagText(xml, 'name') ?? '');
  if (name.isEmpty) {
    return null;
  }

  return CompendiumMonster(
    name: name,
    size: _extractSingleTagText(xml, 'size') ?? '',
    type: _extractSingleTagText(xml, 'type') ?? '',
    alignment: _extractSingleTagText(xml, 'alignment') ?? '',
    armorClass: _extractSingleTagText(xml, 'ac') ?? '',
    hitPoints: _extractSingleTagText(xml, 'hp') ?? '',
    speed: _extractSingleTagText(xml, 'speed') ?? '',
    challengeRating: _extractSingleTagText(xml, 'cr') ?? '',
    senses: _extractSingleTagText(xml, 'senses') ?? '',
    languages: _extractSingleTagText(xml, 'languages') ?? '',
    traits: _extractElements(xml, 'trait')
        .map((trait) => _extractSingleTagText(trait.innerXml, 'name') ?? '')
        .where((text) => text.trim().isNotEmpty)
        .toList(growable: false),
    actions: _extractElements(xml, 'action')
        .map((action) => _extractSingleTagText(action.innerXml, 'name') ?? '')
        .where((text) => text.trim().isNotEmpty)
        .toList(growable: false),
    source: _extractSource(xml),
  );
}

List<String> _extractTextParagraphs(String xml) {
  final paragraphs = _extractElements(xml, 'text')
      .map((element) => _normalizeMultilineText(element.innerXml))
      .where((text) => text.isNotEmpty)
      .toList(growable: false);
  return paragraphs.isEmpty
      ? const <String>['Imported XML entry.']
      : paragraphs;
}

String _extractSource(String xml) {
  final source = _extractSingleTagText(xml, 'source');
  if (source != null && source.trim().isNotEmpty) {
    return _normalizeCatalogName(source);
  }
  return 'Imported XML';
}

String _extractTraitText(String xml, String expectedName) {
  for (final trait in _extractElements(xml, 'trait')) {
    final name = _normalizeText(
      _extractSingleTagText(trait.innerXml, 'name') ?? '',
    );
    if (name == expectedName) {
      return _extractRawTagText(trait.innerXml, 'text') ?? '';
    }
  }
  return '';
}

String _slugifyName(String text) {
  return _normalizeCatalogName(text)
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
      .replaceAll(RegExp(r'^_+|_+$'), '');
}

List<String> _splitCsv(String rawValue) {
  return rawValue
      .split(',')
      .map(_normalizeCatalogName)
      .where((value) => value.isNotEmpty)
      .toList(growable: false);
}

String _normalizeCatalogName(String text) {
  return _normalizeMultilineText(
    text,
  ).replaceAll(RegExp(r'\s*\[(5\.5e|5e)\]$', caseSensitive: false), '').trim();
}

String _normalizeText(String text) {
  return _normalizeMultilineText(text).replaceAll(RegExp(r'\s+'), ' ').trim();
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

String? _extractSingleTagText(String xml, String tagName) {
  final match = RegExp(
    '<$tagName\\b[^>]*>([\\s\\S]*?)</$tagName>',
    caseSensitive: false,
  ).firstMatch(xml);
  if (match == null) {
    return null;
  }
  return _normalizeMultilineText(match.group(1) ?? '');
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

List<_XmlElement> _extractElements(String xml, String tagName) {
  final pattern = RegExp(
    '<$tagName\\b([^>]*)>([\\s\\S]*?)</$tagName>',
    caseSensitive: false,
  );
  return pattern
      .allMatches(xml)
      .map((match) => _XmlElement(innerXml: match.group(2) ?? ''))
      .toList(growable: false);
}

class _XmlElement {
  const _XmlElement({required this.innerXml});

  final String innerXml;
}
