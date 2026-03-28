import 'package:adventure_vault_character/src/features/compendium/data/compendium_repository.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';

class InMemoryCompendiumRepository implements CompendiumRepository {
  InMemoryCompendiumRepository(CompendiumCatalog catalog) : _catalog = catalog;

  CompendiumCatalog _catalog;

  @override
  Future<CompendiumCatalog> loadCatalog() async => _catalog;

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
    return _catalog;
  }
}
