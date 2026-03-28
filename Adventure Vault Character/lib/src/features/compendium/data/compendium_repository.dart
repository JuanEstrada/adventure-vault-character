import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';

abstract interface class CompendiumRepository {
  Future<CompendiumCatalog> loadCatalog();

  Future<CompendiumCatalog> setPackActive(String packId, bool isActive);

  Future<CompendiumCatalog> importXmlPack(String rawXml);
}
