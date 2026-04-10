import 'package:adventure_vault_character/src/features/characters/domain/character_summary.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';
import 'package:adventure_vault_character/src/features/main_menu/presentation/character_card.dart';
import 'package:flutter/material.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({
    required this.characterSummaries,
    required this.compendiumCatalog,
    required this.onOpenCompendium,
    required this.onOpenRules,
    required this.onLoadXml,
    required this.onOpenSettings,
    required this.onCreateCharacter,
    required this.onOpenCharacter,
    super.key,
  });

  final List<CharacterSummary> characterSummaries;
  final CompendiumCatalog compendiumCatalog;
  final VoidCallback onOpenCompendium;
  final VoidCallback onOpenRules;
  final VoidCallback onLoadXml;
  final VoidCallback onOpenSettings;
  final VoidCallback onCreateCharacter;
  final ValueChanged<String> onOpenCharacter;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adventure Vault Character'),
        actions: [
          _TopAction(label: 'Compendium', onPressed: onOpenCompendium),
          _TopAction(label: 'Rules', onPressed: onOpenRules),
          _TopAction(label: 'Settings', onPressed: onOpenSettings),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFE8DDCB),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Characters',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Local entry point for character sheets, guided creation, '
                    'and the future XML flow.',
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      FilledButton(
                        onPressed: onCreateCharacter,
                        child: const Text('Create character'),
                      ),
                      OutlinedButton(
                        onPressed: onLoadXml,
                        child: const Text('LOAD XML'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _CompendiumStatusCard(catalog: compendiumCatalog),
            const SizedBox(height: 24),
            Expanded(
              child: characterSummaries.isEmpty
                  ? Center(
                      child: Text(
                        'No saved characters are available yet. '
                        'Create character should remain visible.',
                        style: theme.textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: characterSummaries.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        return CharacterSummaryCard(
                          summary: characterSummaries[index],
                          onTap: () =>
                              onOpenCharacter(characterSummaries[index].id),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopAction extends StatelessWidget {
  const _TopAction({required this.label, this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton(onPressed: onPressed ?? () {}, child: Text(label)),
    );
  }
}

class _CompendiumStatusCard extends StatelessWidget {
  const _CompendiumStatusCard({required this.catalog});

  final CompendiumCatalog catalog;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final rows = _buildRows(catalog.sourcePolicy);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF0E6D6),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFD1BEA1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Active compendium',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            catalog.sourcePolicy.activeSourceLabel,
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          ...rows.map(
            (row) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(row, style: theme.textTheme.bodySmall),
            ),
          ),
        ],
      ),
    );
  }

  List<String> _buildRows(CompendiumSourcePolicy policy) {
    if (policy.activeSourceType == 'fallback_json') {
      return <String>[
        'Fallback mode: ${policy.fallbackSourceLabel}',
        'Reduced coverage: the catalog is using bundled compact JSON.',
      ];
    }

    final buildSections = <String>[
      if (catalog.sourcePolicyForSection('backgrounds') != null) 'backgrounds',
      if (catalog.sourcePolicyForSection('races') != null) 'races',
      if (catalog.sourcePolicyForSection('classes') != null) 'classes',
      if (catalog.sourcePolicyForSection('spells') != null) 'spells',
      if (catalog.sourcePolicyForSection('feats') != null) 'feats',
      if (catalog.sourcePolicyForSection('monsters') != null) 'monsters',
    ];
    final narrative = catalog.sourcePolicyForSection('narrative_options');

    return <String>[
      if (buildSections.isNotEmpty)
        'Rules baseline: SRD 5.5e FightClub XML for ${buildSections.join(', ')}.',
      if (narrative != null)
        'Narrative: ${narrative.primarySources.length + narrative.supplementalSources.length} legacy XML sources for traits, ideals, bonds, flaws, and faction.',
      'Fallback available: ${policy.fallbackSourceLabel}',
    ];
  }
}
