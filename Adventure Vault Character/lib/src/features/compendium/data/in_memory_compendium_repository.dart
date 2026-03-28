import 'package:adventure_vault_character/src/features/compendium/data/compendium_repository.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';

class InMemoryCompendiumRepository implements CompendiumRepository {
  InMemoryCompendiumRepository(CompendiumCatalog catalog) : _catalog = catalog;

  CompendiumCatalog _catalog;

  @override
  Future<CompendiumCatalog> loadCatalog() async =>
      _catalog.applyPackStateEffects();

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
    return _catalog.applyPackStateEffects();
  }

  @override
  Future<CompendiumCatalog> importXmlPack(String rawXml) async {
    final importedPackState = _buildImportedPackState(
      rawXml,
      _catalog.packStates,
    );
    _catalog = _catalog.copyWith(
      packStates: <CompendiumPackStateModel>[
        ..._catalog.packStates.where(
          (packState) => packState.id != importedPackState.id,
        ),
        importedPackState,
      ],
    );
    return _catalog.applyPackStateEffects();
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
}
