import 'dart:collection';

import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';

/// Domain helpers for searching and filtering compendium content.
///
/// The service operates on [CompendiumCatalog.entries] so it can work across
/// races, classes, backgrounds, spells, feats, monsters, and narrative option
/// groups without depending on presentation code.
class CompendiumSearchService {
  const CompendiumSearchService();

  List<CompendiumEntry> filterBySource(
    CompendiumCatalog catalog,
    String source,
  ) {
    return _filterEntries(
      catalog.entries(),
      predicate: (entry) => _matches(entry.source, source),
    );
  }

  List<CompendiumEntry> filterByPack(CompendiumCatalog catalog, String packId) {
    return _filterEntries(
      catalog.entries(),
      predicate: (entry) => _matches(entry.packId, packId),
    );
  }

  List<CompendiumEntry> filterByCategory(
    CompendiumCatalog catalog,
    String category,
  ) {
    return _filterEntries(
      catalog.entries(),
      predicate: (entry) => _matches(entry.category, category),
    );
  }

  Map<String, List<CompendiumEntry>> filterByCategories(
    CompendiumCatalog catalog,
    Iterable<String> categories,
  ) {
    final result = <String, List<CompendiumEntry>>{};
    for (final category in categories) {
      result[category] = filterByCategory(catalog, category);
    }
    return result;
  }

  List<CompendiumEntry> filterByCategoryAndSource(
    CompendiumCatalog catalog,
    String category,
    String source,
  ) {
    return _filterEntries(
      catalog.entries(),
      predicate: (entry) =>
          _matches(entry.category, category) && _matches(entry.source, source),
    );
  }

  List<CompendiumEntry> filterByCategoryAndPack(
    CompendiumCatalog catalog,
    String category,
    String packId,
  ) {
    return _filterEntries(
      catalog.entries(),
      predicate: (entry) =>
          _matches(entry.category, category) && _matches(entry.packId, packId),
    );
  }

  List<CompendiumEntry> filterByCategoryAndMultiplePacks(
    CompendiumCatalog catalog,
    String category,
    Iterable<String> packIds,
  ) {
    final normalizedPackIds = packIds
        .map(_normalize)
        .where((value) => value.isNotEmpty)
        .toSet();
    if (normalizedPackIds.isEmpty) {
      return const <CompendiumEntry>[];
    }

    return _filterEntries(
      catalog.entries(),
      predicate: (entry) =>
          _matches(entry.category, category) &&
          entry.packId != null &&
          normalizedPackIds.contains(_normalize(entry.packId)),
    );
  }

  List<CompendiumEntry> searchByName(CompendiumCatalog catalog, String query) {
    final normalizedQuery = _normalize(query);
    if (normalizedQuery.isEmpty) {
      return const <CompendiumEntry>[];
    }

    return _filterEntries(
      catalog.entries(),
      predicate: (entry) =>
          _contains(entry.name, normalizedQuery) ||
          _contains(entry.source, normalizedQuery) ||
          _contains(entry.packId, normalizedQuery) ||
          _contains(entry.category, normalizedQuery) ||
          _contains(entry.type, normalizedQuery),
    );
  }

  List<CompendiumEntry> searchBySource(
    CompendiumCatalog catalog,
    String source,
  ) {
    final normalizedQuery = _normalize(source);
    if (normalizedQuery.isEmpty) {
      return const <CompendiumEntry>[];
    }

    return _filterEntries(
      catalog.entries(),
      predicate: (entry) => _contains(entry.source, normalizedQuery),
    );
  }

  List<CompendiumEntry> searchByPack(CompendiumCatalog catalog, String packId) {
    final normalizedQuery = _normalize(packId);
    if (normalizedQuery.isEmpty) {
      return const <CompendiumEntry>[];
    }

    return _filterEntries(
      catalog.entries(),
      predicate: (entry) => _contains(entry.packId, normalizedQuery),
    );
  }

  int countBySource(CompendiumCatalog catalog, String source) {
    return filterBySource(catalog, source).length;
  }

  int countByCategory(CompendiumCatalog catalog, String category) {
    return filterByCategory(catalog, category).length;
  }

  Set<String> getUniqueSources(CompendiumCatalog catalog) {
    return _uniqueValues(catalog.entries().map((entry) => entry.source));
  }

  Set<String> getUniquePacks(CompendiumCatalog catalog) {
    return _uniqueValues(catalog.entries().map((entry) => entry.packId));
  }

  Set<String> getUniqueCategories(CompendiumCatalog catalog) {
    return _uniqueValues(catalog.entries().map((entry) => entry.category));
  }

  List<CompendiumEntry> entriesBySource(
    CompendiumCatalog catalog,
    String source,
  ) {
    return filterBySource(catalog, source);
  }

  List<CompendiumEntry> entriesByPack(
    CompendiumCatalog catalog,
    String packId,
  ) {
    return filterByPack(catalog, packId);
  }

  List<CompendiumEntry> entriesByCategory(
    CompendiumCatalog catalog,
    String category,
  ) {
    return filterByCategory(catalog, category);
  }

  List<CompendiumEntry> entriesByCategoryAndSource(
    CompendiumCatalog catalog,
    String category,
    String source,
  ) {
    return filterByCategoryAndSource(catalog, category, source);
  }

  List<CompendiumEntry> entriesByCategoryAndPack(
    CompendiumCatalog catalog,
    String category,
    String packId,
  ) {
    return filterByCategoryAndPack(catalog, category, packId);
  }

  List<CompendiumEntry> entriesByCategoryAndMultiplePacks(
    CompendiumCatalog catalog,
    String category,
    Iterable<String> packIds,
  ) {
    return filterByCategoryAndMultiplePacks(catalog, category, packIds);
  }

  List<CompendiumEntry> search(CompendiumCatalog catalog, String query) {
    return searchByName(catalog, query);
  }

  List<CompendiumEntry> _filterEntries(
    Iterable<CompendiumEntry> entries, {
    required bool Function(CompendiumEntry entry) predicate,
  }) {
    final filtered = entries.where(predicate).toList(growable: false);
    filtered.sort(_compareEntries);
    return filtered;
  }

  int _compareEntries(CompendiumEntry left, CompendiumEntry right) {
    final byName = _normalize(left.name).compareTo(_normalize(right.name));
    if (byName != 0) {
      return byName;
    }

    final byCategory = _normalize(
      left.category,
    ).compareTo(_normalize(right.category));
    if (byCategory != 0) {
      return byCategory;
    }

    return _normalize(left.id).compareTo(_normalize(right.id));
  }

  Set<String> _uniqueValues(Iterable<String?> values) {
    final uniqueValues = values
        .whereType<String>()
        .map((value) => value.trim())
        .where((value) => value.isNotEmpty)
        .toSet()
        .toList(growable: false);
    uniqueValues.sort(
      (left, right) => left.toLowerCase().compareTo(right.toLowerCase()),
    );
    return LinkedHashSet<String>.of(uniqueValues);
  }

  bool _matches(String? value, String filter) {
    final normalizedFilter = _normalize(filter);
    if (normalizedFilter.isEmpty) {
      return true;
    }
    return _normalize(value) == normalizedFilter;
  }

  bool _contains(String? value, String query) {
    final normalizedValue = _normalize(value);
    if (normalizedValue.isEmpty) {
      return false;
    }
    return normalizedValue.contains(query);
  }

  String _normalize(String? value) {
    return value?.trim().toLowerCase() ?? '';
  }
}
