import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_search_service.dart';
import 'package:flutter/material.dart';

class CompendiumScreen extends StatelessWidget {
  const CompendiumScreen({
    required this.catalog,
    required this.onBack,
    required this.onOpenCompendiumPacks,
    required this.onOpenCompendiumImport,
    super.key,
  });

  final CompendiumCatalog catalog;
  final VoidCallback onBack;
  final VoidCallback onOpenCompendiumPacks;
  final VoidCallback onOpenCompendiumImport;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sections = catalog.sourcePolicy.sections;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: onBack,
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Compendium'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _SummaryCard(catalog: catalog),
          const SizedBox(height: 16),
          _ManagementCard(
            catalog: catalog,
            onOpenCompendiumPacks: onOpenCompendiumPacks,
            onOpenCompendiumImport: onOpenCompendiumImport,
          ),
          const SizedBox(height: 24),
          _SearchAndFilterCard(catalog: catalog),
          const SizedBox(height: 24),
          Text(
            'Current coverage',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _CoverageChip(label: 'Races', value: '${catalog.races.length}'),
              _CoverageChip(
                label: 'Classes',
                value: '${catalog.classes.length}',
              ),
              _CoverageChip(
                label: 'Backgrounds',
                value: '${catalog.backgrounds.length}',
              ),
              _CoverageChip(
                label: 'Narrative groups',
                value: '${catalog.narrativeOptionGroups.length}',
              ),
              _CoverageChip(label: 'Spells', value: '${catalog.spells.length}'),
              _CoverageChip(label: 'Feats', value: '${catalog.feats.length}'),
              _CoverageChip(
                label: 'Monsters',
                value: '${catalog.monsters.length}',
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Source policy',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          if (sections.isEmpty)
            const _EmptyPolicyCard()
          else
            ...sections.map(
              (section) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _SourceSectionCard(section: section),
              ),
            ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.catalog});

  final CompendiumCatalog catalog;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final policy = catalog.sourcePolicy;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE8DDCB),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFD1BEA1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Active source',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(policy.activeSourceLabel, style: theme.textTheme.bodyLarge),
          const SizedBox(height: 12),
          Text(
            'Fallback available: ${policy.fallbackSourceLabel}',
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

class _ManagementCard extends StatelessWidget {
  const _ManagementCard({
    required this.catalog,
    required this.onOpenCompendiumPacks,
    required this.onOpenCompendiumImport,
  });

  final CompendiumCatalog catalog;
  final VoidCallback onOpenCompendiumPacks;
  final VoidCallback onOpenCompendiumImport;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final policy = catalog.sourcePolicy;
    final optionalPacksStatus = !catalog.hasOptionalPacks
        ? 'No configurable packs'
        : '${catalog.activeOptionalPackCount} active';

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F1E8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFD8C8B0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Content management',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          _StatusRow(
            label: 'Bundled base',
            value: 'Always active',
            description: policy.activeSourceLabel,
          ),
          const SizedBox(height: 12),
          _StatusRow(
            label: 'Optional packs',
            value: optionalPacksStatus,
            description: !catalog.hasOptionalPacks
                ? 'No optional persisted packs are available for this catalog yet.'
                : 'Local activation is persisted and immediately affects active catalog sections.',
          ),
          const SizedBox(height: 16),
          Text(
            'XML import',
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'The flow supports pasted XML registration and active-pack ingestion for currently '
            'supported sections. Broader section coverage remains a future iteration.',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _ActionChipButton(
                label: 'Import XML',
                detail: 'Register pack',
                onPressed: onOpenCompendiumImport,
              ),
              _ActionChipButton(
                label: 'Manage packs',
                detail: 'Configure',
                onPressed: onOpenCompendiumPacks,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SearchAndFilterCard extends StatefulWidget {
  const _SearchAndFilterCard({required this.catalog});

  final CompendiumCatalog catalog;

  @override
  State<_SearchAndFilterCard> createState() => _SearchAndFilterCardState();
}

class _SearchAndFilterCardState extends State<_SearchAndFilterCard> {
  static const _allValue = '';

  final CompendiumSearchService _searchService =
      const CompendiumSearchService();
  String _selectedCategory = _allValue;
  String _selectedSource = _allValue;
  String _selectedPack = _allValue;

  List<CompendiumEntry> get _filteredEntries {
    Iterable<CompendiumEntry> entries = widget.catalog.entries();

    if (_selectedCategory.isNotEmpty) {
      entries = entries.where(
        (entry) => _matches(entry.category, _selectedCategory),
      );
    }
    if (_selectedSource.isNotEmpty) {
      entries = entries.where(
        (entry) => _matches(entry.source, _selectedSource),
      );
    }
    if (_selectedPack.isNotEmpty) {
      entries = entries.where((entry) => _matches(entry.packId, _selectedPack));
    }

    final results = entries.toList(growable: false);
    results.sort((left, right) {
      final byName = left.name.toLowerCase().compareTo(
        right.name.toLowerCase(),
      );
      if (byName != 0) {
        return byName;
      }
      final byCategory = left.category.toLowerCase().compareTo(
        right.category.toLowerCase(),
      );
      if (byCategory != 0) {
        return byCategory;
      }
      return left.id.toLowerCase().compareTo(right.id.toLowerCase());
    });
    return results;
  }

  List<String> get _categories =>
      _searchService.getUniqueCategories(widget.catalog).toList();
  List<String> get _sources =>
      _searchService.getUniqueSources(widget.catalog).toList();
  List<String> get _packs =>
      _searchService.getUniquePacks(widget.catalog).toList();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final results = _filteredEntries;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F4EC),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFD8C8B0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick search',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Narrow the compendium by category, source, or pack and jump directly to matching entries.',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              SizedBox(
                width: 220,
                child: _buildDropdown(
                  key: const Key('compendium-category-filter'),
                  label: 'Category',
                  value: _selectedCategory,
                  options: _categories,
                  onChanged: (value) => setState(() {
                    _selectedCategory = value ?? _allValue;
                  }),
                ),
              ),
              SizedBox(
                width: 220,
                child: _buildDropdown(
                  key: const Key('compendium-source-filter'),
                  label: 'Source',
                  value: _selectedSource,
                  options: _sources,
                  onChanged: (value) => setState(() {
                    _selectedSource = value ?? _allValue;
                  }),
                ),
              ),
              SizedBox(
                width: 220,
                child: _buildDropdown(
                  key: const Key('compendium-pack-filter'),
                  label: 'Pack',
                  value: _selectedPack,
                  options: _packs,
                  onChanged: (value) => setState(() {
                    _selectedPack = value ?? _allValue;
                  }),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '${results.length} matching entries',
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          if (results.isEmpty)
            const Text('No entries match the selected filters.')
          else
            ListView.separated(
              itemCount: results.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final entry = results[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  title: Text(entry.name),
                  subtitle: Text(_entryMetadata(entry)),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildDropdown({
    required Key key,
    required String label,
    required String value,
    required List<String> options,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      key: key,
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        isDense: true,
        filled: true,
        fillColor: Colors.white,
      ),
      items: [
        const DropdownMenuItem<String>(value: _allValue, child: Text('All')),
        ...options.map(
          (option) =>
              DropdownMenuItem<String>(value: option, child: Text(option)),
        ),
      ],
      onChanged: onChanged,
    );
  }

  bool _matches(String? value, String filter) {
    return value != null &&
        value.trim().toLowerCase() == filter.trim().toLowerCase();
  }

  String _entryMetadata(CompendiumEntry entry) {
    final parts = <String>[
      entry.category,
      if ((entry.source ?? '').trim().isNotEmpty) entry.source!.trim(),
      if ((entry.packId ?? '').trim().isNotEmpty) entry.packId!.trim(),
    ];
    return parts.join(' • ');
  }
}

class _StatusRow extends StatelessWidget {
  const _StatusRow({
    required this.label,
    required this.value,
    required this.description,
  });

  final String label;
  final String value;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text(
              value,
              style: theme.textTheme.labelLarge?.copyWith(
                color: const Color(0xFF6B563A),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(description, style: theme.textTheme.bodySmall),
      ],
    );
  }
}

class _ActionChipButton extends StatelessWidget {
  const _ActionChipButton({
    required this.label,
    required this.detail,
    required this.onPressed,
  });

  final String label;
  final String detail;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        backgroundColor: const Color(0xFFE9E1D5),
        side: const BorderSide(color: Color(0xFFD1BEA1)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(detail, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _CoverageChip extends StatelessWidget {
  const _CoverageChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD8C8B0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _SourceSectionCard extends StatelessWidget {
  const _SourceSectionCard({required this.section});

  final CompendiumSectionSourcePolicy section;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F1E8),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFD8C8B0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            section.sectionLabel,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Tipo: ${section.sourceType}',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 10),
          Text(
            'Fuentes primarias',
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          ...section.primarySources.map(
            (source) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(source, style: theme.textTheme.bodySmall),
            ),
          ),
          if (section.supplementalSources.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              'Fuentes suplementarias',
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            ...section.supplementalSources.map(
              (source) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(source, style: theme.textTheme.bodySmall),
              ),
            ),
          ],
          if (section.notes != null && section.notes!.trim().isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(section.notes!, style: theme.textTheme.bodySmall),
          ],
        ],
      ),
    );
  }
}

class _EmptyPolicyCard extends StatelessWidget {
  const _EmptyPolicyCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F1E8),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFD8C8B0)),
      ),
      child: const Text(
        'The current compendium does not publish detailed source sections.',
      ),
    );
  }
}
