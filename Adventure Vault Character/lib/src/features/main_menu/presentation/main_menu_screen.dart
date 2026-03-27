import 'package:adventure_vault_character/src/features/characters/domain/character_summary.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';
import 'package:adventure_vault_character/src/features/main_menu/presentation/character_card.dart';
import 'package:flutter/material.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({
    required this.characterSummaries,
    required this.compendiumCatalog,
    required this.onCreateCharacter,
    required this.onOpenCharacter,
    super.key,
  });

  final List<CharacterSummary> characterSummaries;
  final CompendiumCatalog compendiumCatalog;
  final VoidCallback onCreateCharacter;
  final ValueChanged<String> onOpenCharacter;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adventure Vault Character'),
        actions: const [
          _TopAction(label: 'Compendio'),
          _TopAction(label: 'Reglas'),
          _TopAction(label: 'Settings'),
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
                    'Personajes',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Entrada local para hoja de personaje, creacion guiada y '
                    'futuro flujo XML.',
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      FilledButton(
                        onPressed: onCreateCharacter,
                        child: const Text('Crear personaje nuevo'),
                      ),
                      OutlinedButton(
                        onPressed: () {},
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
                        'Todavia no hay personajes guardados. '
                        'Crear personaje nuevo debe permanecer visible.',
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
  const _TopAction({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton(onPressed: () {}, child: Text(label)),
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
            'Compendio activo',
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
        'Modo fallback: ${policy.fallbackSourceLabel}',
        'Cobertura reducida: el catalogo usa el JSON compacto empaquetado.',
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
        'Base de reglas: SRD 5.5e FightClub XML para ${buildSections.join(', ')}.',
      if (narrative != null)
        'Narrativa: ${narrative.primarySources.length + narrative.supplementalSources.length} fuentes XML heredadas para traits, ideals, bonds, flaws y faction.',
      'Fallback disponible: ${policy.fallbackSourceLabel}',
    ];
  }
}
