import 'package:adventure_vault_character/src/features/compendium/data/compendium_repository.dart';
import 'package:adventure_vault_character/src/features/compendium/data/imported_compendium_content.dart';
import 'package:adventure_vault_character/src/features/compendium/data/xml_import_validation.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';

class InMemoryCompendiumRepository implements CompendiumRepository {
  InMemoryCompendiumRepository(CompendiumCatalog catalog)
    : _catalog = catalog,
      _importedPackXmlById = <String, String>{};

  CompendiumCatalog _catalog;
  final Map<String, String> _importedPackXmlById;

  @override
  Future<CompendiumCatalog> loadStartupCatalog() async {
    return _effectiveCatalog(_catalog);
  }

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
    final importBuild = buildImportedPackState(
      rawXml: rawXml,
      existingPackStates: _catalog.packStates,
    );
    final importedPackState = importBuild.packState;
    parseImportedCompendiumContent(
      packId: importedPackState.id,
      packTitle: importedPackState.title,
      rawXml: importBuild.normalizedXml,
    );
    _importedPackXmlById[importedPackState.id] = importBuild.normalizedXml;
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
