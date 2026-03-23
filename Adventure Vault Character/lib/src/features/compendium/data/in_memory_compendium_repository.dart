import 'package:adventure_vault_character/src/features/compendium/data/compendium_repository.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';

class InMemoryCompendiumRepository implements CompendiumRepository {
  const InMemoryCompendiumRepository(this.catalog);

  final CompendiumCatalog catalog;

  @override
  Future<CompendiumCatalog> loadCatalog() async => catalog;
}
