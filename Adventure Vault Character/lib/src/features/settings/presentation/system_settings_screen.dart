import 'package:flutter/material.dart';

class SystemSettingsScreen extends StatelessWidget {
  const SystemSettingsScreen({
    required this.includeCoinWeightInEncumbrance,
    required this.isSaving,
    required this.onBack,
    required this.onToggleIncludeCoinWeight,
    super.key,
  });

  final bool includeCoinWeightInEncumbrance;
  final bool isSaving;
  final VoidCallback onBack;
  final ValueChanged<bool> onToggleIncludeCoinWeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: onBack,
          icon: const Icon(Icons.arrow_back_rounded),
          tooltip: 'Back',
        ),
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            'System rules',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Configure optional rule behaviors that affect character sheet calculations.',
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: 20),
          SwitchListTile.adaptive(
            contentPadding: EdgeInsets.zero,
            title: const Text('Count coin weight in carried load'),
            subtitle: const Text(
              'When enabled, encumbrance calculations include carried coin weight at 50 coins per lb.',
            ),
            value: includeCoinWeightInEncumbrance,
            onChanged: isSaving ? null : onToggleIncludeCoinWeight,
          ),
          const SizedBox(height: 8),
          Text(
            includeCoinWeightInEncumbrance
                ? 'Current default: coin weight is included.'
                : 'Current default: coin weight is excluded.',
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
