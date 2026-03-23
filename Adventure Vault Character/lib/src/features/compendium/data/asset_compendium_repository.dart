import 'dart:convert';

import 'package:adventure_vault_character/src/features/characters/domain/character_sheet_view_data.dart';
import 'package:adventure_vault_character/src/features/compendium/data/compendium_repository.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';
import 'package:flutter/services.dart';

class AssetCompendiumRepository implements CompendiumRepository {
  AssetCompendiumRepository({
    AssetBundle? bundle,
    String catalogAssetPath = 'assets/compendium/catalog.json',
  })  : _bundle = bundle ?? rootBundle,
        _catalogAssetPath = catalogAssetPath;

  final AssetBundle _bundle;
  final String _catalogAssetPath;

  CompendiumCatalog? _cachedCatalog;

  @override
  Future<CompendiumCatalog> loadCatalog() async {
    final cachedCatalog = _cachedCatalog;
    if (cachedCatalog != null) {
      return cachedCatalog;
    }

    final raw = await _bundle.loadString(_catalogAssetPath);
    final Map<String, dynamic> json = jsonDecode(raw) as Map<String, dynamic>;

    final catalog = CompendiumCatalog(
      races: (json['races'] as List<dynamic>).cast<String>(),
      classes: (json['classes'] as List<dynamic>).cast<String>(),
      backgrounds: (json['backgrounds'] as List<dynamic>)
          .map(
            (background) {
              final map = Map<String, dynamic>.from(background as Map);
              return CompendiumBackground(
                id: map['id'] as String,
                name: map['name'] as String,
                summary: map['summary'] as String,
                bonuses: (map['bonuses'] as List<dynamic>).cast<String>(),
                socialPerks:
                    (map['socialPerks'] as List<dynamic>).cast<String>(),
              );
            },
          )
          .toList(growable: false),
      generatedAbilityScoreSet:
          (json['generatedAbilityScoreSet'] as List<dynamic>).cast<int>(),
      manualAbilityScoreOptions:
          (json['manualAbilityScoreOptions'] as List<dynamic>).cast<int>(),
      equipmentSummariesByClass:
          Map<String, dynamic>.from(json['equipmentSummariesByClass'] as Map).map(
        (key, value) {
          final map = Map<String, dynamic>.from(value as Map);
          return MapEntry(
            key,
            EquipmentSummaryViewData(
              statusLabel: map['statusLabel'] as String,
              description: map['description'] as String,
              highlightItems: (map['highlightItems'] as List<dynamic>).cast<String>(),
            ),
          );
        },
      ),
    );

    _cachedCatalog = catalog;
    return catalog;
  }
}
