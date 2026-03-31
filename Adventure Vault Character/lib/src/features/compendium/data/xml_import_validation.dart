import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';

const String _emptyXmlMessage = 'Paste XML content before attempting import.';
const String _missingRootMessage =
    'XML content must include a compendium or collection root node.';
const String _malformedXmlMessage =
    'XML content appears malformed. Ensure all imported entries have matching opening and closing tags.';
const String _unsupportedEntriesMessage =
    'XML content does not contain compatible background, race, class, spell, feat, or monster entries.';

class XmlImportValidationResult {
  const XmlImportValidationResult({
    required this.normalizedXml,
    required this.supportedElementCount,
    required this.suggestedTitle,
  });

  final String normalizedXml;
  final int supportedElementCount;
  final String suggestedTitle;
}

class ImportedPackStateBuildResult {
  const ImportedPackStateBuildResult({
    required this.packState,
    required this.normalizedXml,
  });

  final CompendiumPackStateModel packState;
  final String normalizedXml;
}

XmlImportValidationResult validateXmlImportPayload(String rawXml) {
  final normalizedXml = rawXml.trim();
  if (normalizedXml.isEmpty) {
    throw const FormatException(_emptyXmlMessage);
  }

  final rootMatch = RegExp(
    r'<(compendium|collection)\b',
    caseSensitive: false,
  ).firstMatch(normalizedXml);
  if (rootMatch == null) {
    throw const FormatException(_missingRootMessage);
  }

  final rootTag = rootMatch.group(1)?.toLowerCase();
  if (rootTag == null || !_hasBalancedTag(normalizedXml, rootTag)) {
    throw const FormatException(_malformedXmlMessage);
  }

  for (final tagName in _structuralTags) {
    if (!_hasBalancedTag(normalizedXml, tagName)) {
      throw const FormatException(_malformedXmlMessage);
    }
  }

  final supportedElementCount = RegExp(
    r'<(background|race|class|spell|feat|monster)\b',
    caseSensitive: false,
  ).allMatches(normalizedXml).length;
  if (supportedElementCount == 0) {
    throw const FormatException(_unsupportedEntriesMessage);
  }

  final rawTitle = RegExp(
    r'<name>([^<]+)</name>',
    caseSensitive: false,
  ).firstMatch(normalizedXml)?.group(1);
  final normalizedTitle = _normalizeCatalogName(rawTitle ?? '');

  return XmlImportValidationResult(
    normalizedXml: normalizedXml,
    supportedElementCount: supportedElementCount,
    suggestedTitle: normalizedTitle.isEmpty
        ? 'Imported XML pack'
        : normalizedTitle,
  );
}

ImportedPackStateBuildResult buildImportedPackState({
  required String rawXml,
  required List<CompendiumPackStateModel> existingPackStates,
}) {
  final validation = validateXmlImportPayload(rawXml);
  final title = _nextImportedPackTitle(
    validation.suggestedTitle,
    existingPackStates,
  );
  final baseId = _slugifyImportedPackId(title);
  final id = _nextImportedPackId(baseId, existingPackStates);

  return ImportedPackStateBuildResult(
    normalizedXml: validation.normalizedXml,
    packState: CompendiumPackStateModel(
      id: id,
      title: title,
      description:
          'Imported XML pack with ${validation.supportedElementCount} supported entries registered locally for future ingestion.',
      kind: 'imported_xml',
      isFixed: false,
      isActive: true,
    ),
  );
}

const List<String> _supportedTags = <String>[
  'background',
  'race',
  'class',
  'spell',
  'feat',
  'monster',
];

const List<String> _structuralTags = <String>[
  ..._supportedTags,
  'name',
  'text',
  'trait',
  'source',
  'proficiency',
  'level',
  'school',
  'time',
  'range',
  'components',
  'duration',
  'classes',
  'prerequisite',
  'size',
  'type',
  'alignment',
  'ac',
  'hp',
  'speed',
  'cr',
  'senses',
  'languages',
  'action',
  'modifier',
];

bool _hasBalancedTag(String xml, String tagName) {
  final openCount = RegExp(
    '<$tagName\\b[^>]*?(?<!/)>',
    caseSensitive: false,
  ).allMatches(xml).length;
  final closeCount = RegExp(
    '</$tagName>',
    caseSensitive: false,
  ).allMatches(xml).length;
  return openCount == closeCount;
}

String _nextImportedPackTitle(
  String baseTitle,
  List<CompendiumPackStateModel> existingPackStates,
) {
  final existingTitles = existingPackStates
      .map((packState) => _normalizeCatalogName(packState.title).toLowerCase())
      .toSet();
  var candidate = baseTitle;
  var suffix = 2;
  while (existingTitles.contains(
    _normalizeCatalogName(candidate).toLowerCase(),
  )) {
    candidate = '$baseTitle ($suffix)';
    suffix += 1;
  }
  return candidate;
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

String _normalizeCatalogName(String text) {
  return text
      .replaceAll('&apos;', "'")
      .replaceAll('&quot;', '"')
      .replaceAll('&amp;', '&')
      .replaceAll('&lt;', '<')
      .replaceAll('&gt;', '>')
      .replaceAll(RegExp(r'\s+'), ' ')
      .replaceAll(RegExp(r'\s*\[(5\.5e|5e)\]$', caseSensitive: false), '')
      .trim();
}
