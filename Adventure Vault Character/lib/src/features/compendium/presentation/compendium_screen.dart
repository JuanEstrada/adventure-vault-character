import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';
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
    final configurablePacks = catalog.packStates
        .where((packState) => !packState.isFixed)
        .toList(growable: false);
    final activeConfigurablePackCount = configurablePacks
        .where((packState) => packState.isActive)
        .length;
    final importedPacksStatus = configurablePacks.isEmpty
        ? 'No configurable packs'
        : '$activeConfigurablePackCount active';

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
            label: 'Imported packs',
            value: importedPacksStatus,
            description: configurablePacks.isEmpty
                ? 'No optional persisted packs are available for this catalog yet.'
                : 'Local activation is persisted and can be reviewed in Manage packs.',
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
            'The flow already allows pasted XML registration as an optional local pack. '
            'Full content ingestion is still deferred.',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _ActionChipButton(
                label: 'Import XML',
                detail: 'Registrar pack',
                onPressed: onOpenCompendiumImport,
              ),
              _ActionChipButton(
                label: 'Manage packs',
                detail: 'Pending',
                onPressed: onOpenCompendiumPacks,
              ),
            ],
          ),
        ],
      ),
    );
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
