import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_finishing_details.dart';
import 'package:flutter/material.dart';

class CharacterSheetScreen extends StatelessWidget {
  const CharacterSheetScreen({
    required this.character,
    required this.isApplyingRest,
    required this.onBack,
    required this.onEdit,
    required this.onApplyShortRest,
    required this.onApplyLongRest,
    required this.onSetClassResourceUses,
    required this.onSetInventoryItemEquipped,
    required this.onSetInventoryItemCarried,
    required this.onSetInventoryItemQuantity,
    super.key,
  });

  final CharacterDomainModel character;
  final bool isApplyingRest;
  final VoidCallback onBack;
  final VoidCallback onEdit;
  final Future<void> Function() onApplyShortRest;
  final Future<void> Function() onApplyLongRest;
  final Future<void> Function(String resourceKey, int currentUses)
  onSetClassResourceUses;
  final Future<void> Function(String inventoryItemId, bool isEquipped)
  onSetInventoryItemEquipped;
  final Future<void> Function(String inventoryItemId, bool isCarried)
  onSetInventoryItemCarried;
  final Future<void> Function(String inventoryItemId, int quantity)
  onSetInventoryItemQuantity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final supportsShortRestSlotRecovery =
        character.identity.className.trim().toLowerCase() == 'warlock';
    final supportsShortRestResourceRecovery = character.combat.classResources
        .any((resource) => resource.recoversOnShortRest);
    final supportsShortRestRecovery =
        supportsShortRestSlotRecovery || supportsShortRestResourceRecovery;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: onBack,
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(character.identity.name),
        actions: [TextButton(onPressed: onEdit, child: const Text('Edit'))],
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
                  '${character.identity.raceName}  •  ${character.identity.className}  •  Nivel ${character.identity.progression.level}  •  XP ${character.identity.progression.experience}',
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
              _PanelChip(label: 'Spells'),
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
                          _CombatPanel(
                            character: character,
                            isApplyingRest: isApplyingRest,
                            supportsShortRestRecovery:
                                supportsShortRestRecovery,
                            onApplyShortRest: onApplyShortRest,
                            onApplyLongRest: onApplyLongRest,
                            onSetClassResourceUses: onSetClassResourceUses,
                          ),
                          const SizedBox(height: 16),
                          _AbilitiesPanel(character: character),
                          const SizedBox(height: 16),
                          if (character.spellcasting != null) ...[
                            _SpellsPanel(character: character),
                            const SizedBox(height: 16),
                          ],
                          _FeaturesNotesPanel(character: character),
                          const SizedBox(height: 16),
                          _EquipmentPanel(
                            character: character,
                            isUpdating: isApplyingRest,
                            onSetInventoryItemEquipped:
                                onSetInventoryItemEquipped,
                            onSetInventoryItemCarried:
                                onSetInventoryItemCarried,
                            onSetInventoryItemQuantity:
                                onSetInventoryItemQuantity,
                          ),
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
                  _CombatPanel(
                    character: character,
                    isApplyingRest: isApplyingRest,
                    supportsShortRestRecovery: supportsShortRestRecovery,
                    onApplyShortRest: onApplyShortRest,
                    onApplyLongRest: onApplyLongRest,
                    onSetClassResourceUses: onSetClassResourceUses,
                  ),
                  const SizedBox(height: 16),
                  _AbilitiesPanel(character: character),
                  const SizedBox(height: 16),
                  if (character.spellcasting != null) ...[
                    _SpellsPanel(character: character),
                    const SizedBox(height: 16),
                  ],
                  _FeaturesNotesPanel(character: character),
                  const SizedBox(height: 16),
                  _EquipmentPanel(
                    character: character,
                    isUpdating: isApplyingRest,
                    onSetInventoryItemEquipped: onSetInventoryItemEquipped,
                    onSetInventoryItemCarried: onSetInventoryItemCarried,
                    onSetInventoryItemQuantity: onSetInventoryItemQuantity,
                  ),
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

  final CharacterDomainModel character;

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
              value: character.identity.progression.level.toString(),
            ),
            _FactRow(
              label: 'XP',
              value: character.identity.progression.experience.toString(),
            ),
            _FactRow(
              label: 'Prof.',
              value: '+${character.identity.progression.proficiencyBonus}',
            ),
            _FactRow(
              label: 'Progress',
              value: '${character.identity.progression.levelProgressPercent}%',
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

class _ClassResourceRow extends StatelessWidget {
  const _ClassResourceRow({
    required this.resource,
    required this.isUpdating,
    required this.onDecrease,
    required this.onIncrease,
  });

  final CharacterClassResourceDomainModel resource;
  final bool isUpdating;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  resource.label,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Recovers on ${resource.recoveryLabel}',
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 2),
                Text(
                  'Last changed: ${_formatTimestamp(resource.lastChangedAt)} via ${resource.lastChangedSourceLabel}',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: isUpdating || resource.currentUses <= 0
                ? null
                : onDecrease,
            icon: const Icon(Icons.remove_circle_outline),
            tooltip: 'Spend use',
          ),
          Text(resource.usageSummary, style: theme.textTheme.bodyLarge),
          IconButton(
            onPressed:
                isUpdating || resource.currentUses >= resource.maximumUses
                ? null
                : onIncrease,
            icon: const Icon(Icons.add_circle_outline),
            tooltip: 'Restore use',
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime value) {
    final year = value.year.toString().padLeft(4, '0');
    final month = value.month.toString().padLeft(2, '0');
    final day = value.day.toString().padLeft(2, '0');
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '$year-$month-$day $hour:$minute';
  }
}

class _CombatPanel extends StatelessWidget {
  const _CombatPanel({
    required this.character,
    required this.isApplyingRest,
    required this.supportsShortRestRecovery,
    required this.onApplyShortRest,
    required this.onApplyLongRest,
    required this.onSetClassResourceUses,
  });

  final CharacterDomainModel character;
  final bool isApplyingRest;
  final bool supportsShortRestRecovery;
  final Future<void> Function() onApplyShortRest;
  final Future<void> Function() onApplyLongRest;
  final Future<void> Function(String resourceKey, int currentUses)
  onSetClassResourceUses;

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
              value: '${character.combat.hitPoints.current}',
            ),
            _FactRow(
              label: 'Max HP',
              value: '${character.combat.hitPoints.maximum}',
            ),
            _FactRow(
              label: 'Temp HP',
              value: '${character.combat.hitPoints.temporary}',
            ),
            const SizedBox(height: 8),
            Text('Recovery', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                OutlinedButton.icon(
                  onPressed: isApplyingRest || !supportsShortRestRecovery
                      ? null
                      : () {
                          onApplyShortRest();
                        },
                  icon: const Icon(Icons.timer_outlined),
                  label: const Text('Apply short rest'),
                ),
                OutlinedButton.icon(
                  onPressed: isApplyingRest
                      ? null
                      : () {
                          onApplyLongRest();
                        },
                  icon: const Icon(Icons.bed_outlined),
                  label: const Text('Apply long rest'),
                ),
              ],
            ),
            if (!supportsShortRestRecovery)
              Padding(
                padding: const EdgeInsets.only(top: 6, bottom: 2),
                child: Text(
                  'Short rest recovery currently applies only to pact magic and short-rest class resources.',
                  style: theme.textTheme.bodySmall,
                ),
              ),
            if (character.combat.classResources.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text('Class resources', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              ...character.combat.classResources.map(
                (resource) => _ClassResourceRow(
                  resource: resource,
                  isUpdating: isApplyingRest,
                  onDecrease: () {
                    onSetClassResourceUses(
                      resource.resourceKey,
                      resource.currentUses - 1,
                    );
                  },
                  onIncrease: () {
                    onSetClassResourceUses(
                      resource.resourceKey,
                      resource.currentUses + 1,
                    );
                  },
                ),
              ),
            ],
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
                        label: Text('${row.displayLabel} ${row.displayBonus}'),
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

  final CharacterDomainModel character;

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
              character.abilities.methodLabel,
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 12),
            ...character.abilities.entries.map(
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
                          : '${row.modifier}',
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

  final CharacterDomainModel character;

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
              character.featuresNotes.background.name,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              character.featuresNotes.background.summary,
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 12),
            Text('Bonuses', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            ...character.featuresNotes.background.bonusDescriptions.map(
              (item) => Text('• $item'),
            ),
            const SizedBox(height: 12),
            Text('Social perks', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            ...character.featuresNotes.background.socialPerkDescriptions.map(
              (item) => Text('• $item'),
            ),
            if (character.featuresNotes.proficientSkills.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text('Skill proficiencies', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              ...character.featuresNotes.proficientSkillLabels.map(
                (item) => Text('• $item'),
              ),
            ],
            if (character.featuresNotes.otherProficiencies.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text('Other proficiencies', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              ...character.featuresNotes.otherProficiencyLabels.map(
                (item) => Text('• $item'),
              ),
            ],
            if (character
                .featuresNotes
                .finishingDetails
                .visibleSelections
                .isNotEmpty) ...[
              const SizedBox(height: 12),
              Text('Finishing details', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              ...character.featuresNotes.finishingDetails.visibleSelections.map(
                (item) => _FactRow(
                  label: item.fieldKey.label,
                  value: item.valueText!,
                ),
              ),
            ],
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

class _SpellsPanel extends StatelessWidget {
  const _SpellsPanel({required this.character});

  final CharacterDomainModel character;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final spellcasting = character.spellcasting;
    if (spellcasting == null) {
      return const SizedBox.shrink();
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Spells',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            _FactRow(
              label: 'Casting ability',
              value: spellcasting.abilityLabel,
            ),
            _FactRow(
              label: 'Ability mod',
              value: spellcasting.displayAbilityModifier,
            ),
            _FactRow(
              label: 'Spell save DC',
              value: '${spellcasting.spellSaveDc}',
            ),
            _FactRow(
              label: 'Spell attack',
              value: spellcasting.displaySpellAttackBonus,
            ),
            const SizedBox(height: 8),
            Text(
              spellcasting.selectionLabel,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            _FactRow(
              label: 'Selected / max',
              value: spellcasting.selectionSummary,
            ),
            const SizedBox(height: 8),
            if (spellcasting.selectedSpells.isEmpty)
              Text(
                'No persisted spells selected yet.',
                style: theme.textTheme.bodyLarge,
              )
            else
              ...spellcasting.selectedSpellsByLevel.map(
                (levelGroup) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        levelGroup.label,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      ...levelGroup.spells.map(
                        (spell) => Text('• ${spell.name}'),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 8),
            Text('Spell slots', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            if (spellcasting.slotProgression.isEmpty)
              Text(
                'No spell slots available at this level.',
                style: theme.textTheme.bodyLarge,
              )
            else
              ...spellcasting.slotProgression.map(
                (slot) =>
                    _FactRow(label: slot.label, value: slot.displaySummary),
              ),
            const SizedBox(height: 8),
            Text('Available spells', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            if (spellcasting.availableSpells.isEmpty)
              Text(
                'No local spells available for this class yet.',
                style: theme.textTheme.bodyLarge,
              )
            else
              ...spellcasting.spellsByLevel.map(
                (levelGroup) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        levelGroup.label,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      ...levelGroup.spells.map(
                        (spell) => Text(
                          '• ${spell.name} (${spell.school}, ${spell.castingTime})',
                        ),
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

class _EquipmentPanel extends StatelessWidget {
  const _EquipmentPanel({
    required this.character,
    required this.isUpdating,
    required this.onSetInventoryItemEquipped,
    required this.onSetInventoryItemCarried,
    required this.onSetInventoryItemQuantity,
  });

  final CharacterDomainModel character;
  final bool isUpdating;
  final Future<void> Function(String inventoryItemId, bool isEquipped)
  onSetInventoryItemEquipped;
  final Future<void> Function(String inventoryItemId, bool isCarried)
  onSetInventoryItemCarried;
  final Future<void> Function(String inventoryItemId, int quantity)
  onSetInventoryItemQuantity;

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
              value: character.equipment.money.currencySummary,
            ),
            _FactRow(
              label: 'Total load',
              value:
                  '${character.equipment.carrying.totalWeight} lb / ${character.equipment.carrying.capacity} lb',
            ),
            _FactRow(
              label: 'Encumbrance',
              value: character.equipment.carrying.tierLabel,
            ),
            _FactRow(
              label: 'Coins',
              value:
                  '${character.equipment.carrying.coinWeightLabel} (${character.equipment.carrying.coinWeight} lb)',
            ),
            const SizedBox(height: 4),
            Text(
              character.equipment.equipmentSummary.description,
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 12),
            Text(
              character.equipment.carrying.tierDescription,
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 10),
            ...character.equipment.items.map(
              (item) => _InventoryItemRow(
                item: item,
                isUpdating: isUpdating,
                onSetEquipped: (value) {
                  onSetInventoryItemEquipped(item.id, value);
                },
                onSetCarried: (value) {
                  onSetInventoryItemCarried(item.id, value);
                },
                onIncreaseQuantity: () {
                  onSetInventoryItemQuantity(item.id, item.quantity + 1);
                },
                onDecreaseQuantity: () {
                  onSetInventoryItemQuantity(item.id, item.quantity - 1);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InventoryItemRow extends StatelessWidget {
  const _InventoryItemRow({
    required this.item,
    required this.isUpdating,
    required this.onSetEquipped,
    required this.onSetCarried,
    required this.onIncreaseQuantity,
    required this.onDecreaseQuantity,
  });

  final CharacterEquipmentItemDomainModel item;
  final bool isUpdating;
  final ValueChanged<bool> onSetEquipped;
  final ValueChanged<bool> onSetCarried;
  final VoidCallback onIncreaseQuantity;
  final VoidCallback onDecreaseQuantity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.name,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              IconButton(
                onPressed: isUpdating || item.quantity <= 0
                    ? null
                    : onDecreaseQuantity,
                icon: const Icon(Icons.remove_circle_outline),
              ),
              Text('Qty ${item.quantity}'),
              IconButton(
                onPressed: isUpdating ? null : onIncreaseQuantity,
                icon: const Icon(Icons.add_circle_outline),
              ),
              const SizedBox(width: 12),
              Text('Weight ${item.totalWeight} lb'),
            ],
          ),
          Wrap(
            spacing: 10,
            runSpacing: 4,
            children: [
              FilterChip(
                label: const Text('Equipped'),
                selected: item.isEquipped,
                onSelected: isUpdating ? null : onSetEquipped,
              ),
              FilterChip(
                label: const Text('Carried'),
                selected: item.isCarried,
                onSelected: isUpdating ? null : onSetCarried,
              ),
            ],
          ),
        ],
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
