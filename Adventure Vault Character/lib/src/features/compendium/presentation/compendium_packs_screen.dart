import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';
import 'package:flutter/material.dart';

class CompendiumPacksScreen extends StatelessWidget {
  const CompendiumPacksScreen({
    required this.catalog,
    required this.onBack,
    required this.onSetPackActive,
    super.key,
  });

  final CompendiumCatalog catalog;
  final VoidCallback onBack;
  final Future<void> Function(String packId, bool isActive) onSetPackActive;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: onBack,
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Manage packs'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Container(
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
                  'Current state',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Activation is stored locally. Registered XML sources '
                  'appear here as optional packs while full content ingestion '
                  'continues to expand.',
                  style: theme.textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ...catalog.packStates.map(
            (packState) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _PackStateCard(
                packState: packState,
                onSetPackActive: onSetPackActive,
              ),
            ),
          ),
          if (catalog.packStates.isEmpty)
            const _EmptyPackStateCard()
          else ...[
            const SizedBox(height: 24),
            Text(
              'Planned next step',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'The next iteration should connect this persisted state to '
              'a full XML import flow and to active compendium-content filtering.',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ],
      ),
    );
  }
}

class _PackStateCard extends StatelessWidget {
  const _PackStateCard({
    required this.packState,
    required this.onSetPackActive,
  });

  final CompendiumPackStateModel packState;
  final Future<void> Function(String packId, bool isActive) onSetPackActive;

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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      packState.title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _statusLabel(packState),
                      style: theme.textTheme.labelLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF6B563A),
                      ),
                    ),
                  ],
                ),
              ),
              Switch(
                value: packState.isActive,
                onChanged: packState.isFixed
                    ? null
                    : (value) => onSetPackActive(packState.id, value),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(packState.description, style: theme.textTheme.bodyMedium),
          const SizedBox(height: 8),
          Text('Type: ${packState.kind}', style: theme.textTheme.bodySmall),
        ],
      ),
    );
  }

  String _statusLabel(CompendiumPackStateModel packState) {
    if (packState.isFixed) {
      return 'Fixed active';
    }
    return packState.isActive ? 'Active' : 'Inactive';
  }
}

class _EmptyPackStateCard extends StatelessWidget {
  const _EmptyPackStateCard();

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
        'No persisted pack state is available for this catalog yet.',
      ),
    );
  }
}
