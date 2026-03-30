import 'package:adventure_vault_character/src/features/compendium/data/compendium_repository.dart';
import 'package:adventure_vault_character/src/features/compendium/data/imported_compendium_content.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';

class InMemoryCompendiumRepository implements CompendiumRepository {
  InMemoryCompendiumRepository(CompendiumCatalog catalog)
    : _catalog = catalog,
      _importedPackXmlById = <String, String>{};

  CompendiumCatalog _catalog;
  final Map<String, String> _importedPackXmlById;

  @override
  Future<CompendiumCatalog> loadCatalog() async => _effectiveCatalog(_catalog);

  @override
  Future<CompendiumCatalog> setPackActive(String packId, bool isActive) async {
    final updatedPackStates = _catalog.packStates
        .map((packState) {
          if (packState.id != packId) {
            return packState;
          }
          if (packState.isFixed) {
            return packState.copyWith(isActive: true);
          }
          return packState.copyWith(isActive: isActive);
        })
        .toList(growable: false);
    _catalog = _catalog.copyWith(packStates: updatedPackStates);
    return _effectiveCatalog(_catalog);
  }

  @override
  Future<CompendiumCatalog> importXmlPack(String rawXml) async {
    final importedPackState = _buildImportedPackState(
      rawXml,
      _catalog.packStates,
    );
    parseImportedCompendiumContent(
      packId: importedPackState.id,
      packTitle: importedPackState.title,
      rawXml: rawXml,
    );
    _importedPackXmlById[importedPackState.id] = rawXml;
    _catalog = _catalog.copyWith(
      packStates: <CompendiumPackStateModel>[
        ..._catalog.packStates.where(
          (packState) => packState.id != importedPackState.id,
        ),
        importedPackState,
      ],
    );
    return _effectiveCatalog(_catalog);
  }

  CompendiumPackStateModel _buildImportedPackState(
    String rawXml,
    List<CompendiumPackStateModel> existingPackStates,
  ) {
    final normalizedXml = rawXml.trim();
    if (normalizedXml.isEmpty) {
      throw const FormatException(
        'Paste XML content before attempting import.',
      );
    }
    if (!RegExp(
      r'<(compendium|collection)\b',
      caseSensitive: false,
    ).hasMatch(normalizedXml)) {
      throw const FormatException(
        'XML content must include a compendium or collection root node.',
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
        : rawTitle;
    final baseId = _slugify(title);
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

  String _slugify(String value) {
    final slug = value
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
        .replaceAll(RegExp(r'^-|-$'), '');
    return slug.isEmpty ? 'xml-pack' : slug;
  }

  CompendiumCatalog _effectiveCatalog(CompendiumCatalog catalog) {
    final importedContents = _importedPackXmlById.entries
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
    return mergeImportedCompendiumContents(
      catalog,
      importedContents,
    ).applyPackStateEffects();
  }
}
