import 'package:adventure_vault_character/src/features/characters/domain/character_sheet_view_data.dart';
import 'package:flutter/material.dart';

class CharacterSheetScreen extends StatelessWidget {
  const CharacterSheetScreen({
    required this.character,
    required this.onBack,
    super.key,
  });

  final CharacterSheetViewData character;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: onBack,
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(character.identity.name),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
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
                  character.identity.name,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${character.identity.raceName}  •  ${character.identity.className}  •  Nivel ${character.identity.level}  •  XP ${character.identity.experience}',
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _PanelChip(label: 'Combat'),
              _PanelChip(label: 'Abilities'),
              _PanelChip(label: 'Equipment'),
              _PanelChip(label: 'Features / Notes'),
            ],
          ),
          const SizedBox(height: 24),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 900;
              if (isWide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _IdentityPanel(character: character)),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        children: [
                          _CombatPanel(character: character),
                          const SizedBox(height: 16),
                          _AbilitiesPanel(character: character),
                          const SizedBox(height: 16),
                          _FeaturesNotesPanel(character: character),
                          const SizedBox(height: 16),
                          _EquipmentPanel(character: character),
                        ],
                      ),
                    ),
                  ],
                );
              }

              return Column(
                children: [
                  _IdentityPanel(character: character),
                  const SizedBox(height: 16),
                  _CombatPanel(character: character),
                  const SizedBox(height: 16),
                  _AbilitiesPanel(character: character),
                  const SizedBox(height: 16),
                  _FeaturesNotesPanel(character: character),
                  const SizedBox(height: 16),
                  _EquipmentPanel(character: character),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _IdentityPanel extends StatelessWidget {
  const _IdentityPanel({required this.character});

  final CharacterSheetViewData character;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resumen',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            _FactRow(label: 'Nombre', value: character.identity.name),
            _FactRow(label: 'Raza', value: character.identity.raceName),
            _FactRow(label: 'Clase', value: character.identity.className),
            _FactRow(
              label: 'Nivel',
              value: character.identity.level.toString(),
            ),
            _FactRow(
              label: 'XP',
              value: character.identity.experience.toString(),
            ),
            _FactRow(
              label: 'Prof.',
              value: '+${character.identity.proficiencyBonus}',
            ),
            _FactRow(
              label: 'Progress',
              value: '${character.identity.levelProgressPercent}%',
            ),
          ],
        ),
      ),
    );
  }
}

class _FactRow extends StatelessWidget {
  const _FactRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: 96,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(child: Text(value, style: theme.textTheme.bodyLarge)),
        ],
      ),
    );
  }
}

class _CombatPanel extends StatelessWidget {
  const _CombatPanel({required this.character});

  final CharacterSheetViewData character;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Combat',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            _FactRow(
              label: 'Current HP',
              value: '${character.combat.currentHitPoints}',
            ),
            _FactRow(
              label: 'Max HP',
              value: '${character.combat.maximumHitPoints}',
            ),
            _FactRow(
              label: 'Temp HP',
              value: '${character.combat.temporaryHitPoints}',
            ),
            if (character.combat.savingThrows.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text('Saving Throws', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: character.combat.savingThrows
                    .map(
                      (row) => Chip(
                        label: Text(
                          '${row.label} ${row.bonus >= 0 ? '+${row.bonus}' : row.bonus}',
                        ),
                      ),
                    )
                    .toList(growable: false),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _AbilitiesPanel extends StatelessWidget {
  const _AbilitiesPanel({required this.character});

  final CharacterSheetViewData character;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Abilities',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              character.abilities.abilityScoreMethodLabel,
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 12),
            ...character.abilities.abilityRows.map(
              (row) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    SizedBox(width: 120, child: Text(row.label)),
                    Text('${row.score}'),
                    const SizedBox(width: 12),
                    Text(
                      row.modifier >= 0
                          ? '+${row.modifier}'
                          : row.modifier.toString(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeaturesNotesPanel extends StatelessWidget {
  const _FeaturesNotesPanel({required this.character});

  final CharacterSheetViewData character;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Features / Notes',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              character.featuresNotes.backgroundName,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              character.featuresNotes.backgroundSummary,
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 12),
            Text('Bonuses', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            ...character.featuresNotes.backgroundBonuses.map(
              (item) => Text('• $item'),
            ),
            const SizedBox(height: 12),
            Text('Social perks', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            ...character.featuresNotes.backgroundSocialPerks.map(
              (item) => Text('• $item'),
            ),
            if (character.featuresNotes.proficientSkills.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text('Skill proficiencies', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              ...character.featuresNotes.proficientSkills.map(
                (item) => Text('• $item'),
              ),
            ],
            if (character.featuresNotes.otherProficiencies.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text('Other proficiencies', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              ...character.featuresNotes.otherProficiencies.map(
                (item) => Text('• $item'),
              ),
            ],
            const SizedBox(height: 12),
            _FactRow(
              label: 'Alignment',
              value: character.featuresNotes.alignment,
            ),
            if (character.featuresNotes.appearanceDetails.isNotEmpty)
              _FactRow(
                label: 'Appearance',
                value: character.featuresNotes.appearanceDetails,
              ),
            if (character.featuresNotes.narrativeDetails.isNotEmpty)
              _FactRow(
                label: 'Notes',
                value: character.featuresNotes.narrativeDetails,
              ),
          ],
        ),
      ),
    );
  }
}

class _EquipmentPanel extends StatelessWidget {
  const _EquipmentPanel({required this.character});

  final CharacterSheetViewData character;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Equipment',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              character.equipment.selectedEquipmentLabel,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            _FactRow(
              label: 'Starting money',
              value: character.equipment.currencySummary,
            ),
            const SizedBox(height: 4),
            Text(
              character.equipment.equipmentSummary.description,
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 12),
            ...character.equipment.selectedEquipmentItems.map(
              (item) => Text('• $item'),
            ),
          ],
        ),
      ),
    );
  }
}

class _PanelChip extends StatelessWidget {
  const _PanelChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(label: Text(label));
  }
}
