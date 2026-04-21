import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_finishing_details.dart';
import 'package:flutter/material.dart';

class CharacterSheetScreen extends StatelessWidget {
  const CharacterSheetScreen({
    required this.character,
    required this.isApplyingRest,
    required this.errorMessage,
    required this.onBack,
    required this.onEdit,
    required this.onApplyShortRest,
    required this.onApplyLongRest,
    required this.onSpendSpellSlot,
    required this.onSetClassResourceUses,
    required this.onRecordDeathSaveSuccess,
    required this.onRecordDeathSaveFailure,
    required this.onResetDeathSaves,
    required this.onSetInventoryItemEquipped,
    required this.onSetInventoryItemCarried,
    required this.onSetInventoryItemQuantity,
    required this.onSpendInventoryItemQuantity,
    required this.onSetInventoryItemCharges,
    required this.onSetInventoryItemContainer,
    super.key,
  });

  final CharacterDomainModel character;
  final bool isApplyingRest;
  final String? errorMessage;
  final VoidCallback onBack;
  final VoidCallback onEdit;
  final Future<void> Function() onApplyShortRest;
   final Future<void> Function() onApplyLongRest;
   final Future<void> Function({required int spellLevel}) onSpendSpellSlot;
   final Future<void> Function({required int spellLevel}) onRestoreSpellSlot;
   final Future<void> Function(String resourceKey, int currentUses)
   onSetClassResourceUses;
  final Future<void> Function() onRecordDeathSaveSuccess;
  final Future<void> Function() onRecordDeathSaveFailure;
  final Future<void> Function() onResetDeathSaves;
  final Future<void> Function(String inventoryItemId, bool isEquipped)
  onSetInventoryItemEquipped;
  final Future<void> Function(String inventoryItemId, bool isCarried)
  onSetInventoryItemCarried;
  final Future<void> Function(String inventoryItemId, int quantity)
  onSetInventoryItemQuantity;
  final Future<void> Function(String inventoryItemId, {int amount})
  onSpendInventoryItemQuantity;
  final Future<void> Function(
    String inventoryItemId, {
    int? chargesCurrent,
    int? chargesMax,
  })
  onSetInventoryItemCharges;
  final Future<void> Function(
    String inventoryItemId,
    String? containerInventoryItemId,
  )
  onSetInventoryItemContainer;

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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
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
                            '${character.identity.raceName}  •  ${character.identity.className}  •  Lv ${character.identity.progression.level}  •  XP ${character.identity.progression.experience}',
                            style: theme.textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    _PortraitPreview(
                      portraitPath: character
                          .featuresNotes
                          .finishingDetails
                          .portraitAssetPath,
                    ),
                  ],
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
                            onRecordDeathSaveSuccess: onRecordDeathSaveSuccess,
                            onRecordDeathSaveFailure: onRecordDeathSaveFailure,
                            onResetDeathSaves: onResetDeathSaves,
                          ),
                          const SizedBox(height: 16),
                          _AbilitiesPanel(character: character),
                          const SizedBox(height: 16),
                          if (character.spellcasting != null) ...[
                            _SpellsPanel(
                              character: character,
                              isApplyingRest: isApplyingRest,
                              supportsShortRestRecovery:
                                  supportsShortRestRecovery,
                              onApplyShortRest: onApplyShortRest,
                              onApplyLongRest: onApplyLongRest,
                              onSpendSpellSlot: onSpendSpellSlot,
                            ),
                            const SizedBox(height: 16),
                          ],
                          _FeaturesNotesPanel(character: character),
                          const SizedBox(height: 16),
                          _EquipmentPanel(
                            character: character,
                            isUpdating: isApplyingRest,
                            errorMessage: errorMessage,
                            onSetInventoryItemEquipped:
                                onSetInventoryItemEquipped,
                            onSetInventoryItemCarried:
                                onSetInventoryItemCarried,
                            onSetInventoryItemQuantity:
                                onSetInventoryItemQuantity,
                            onSpendInventoryItemQuantity:
                                onSpendInventoryItemQuantity,
                            onSetInventoryItemCharges:
                                onSetInventoryItemCharges,
                            onSetInventoryItemContainer:
                                onSetInventoryItemContainer,
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
                    onRecordDeathSaveSuccess: onRecordDeathSaveSuccess,
                    onRecordDeathSaveFailure: onRecordDeathSaveFailure,
                    onResetDeathSaves: onResetDeathSaves,
                  ),
                  const SizedBox(height: 16),
                  _AbilitiesPanel(character: character),
                  const SizedBox(height: 16),
                  if (character.spellcasting != null) ...[
                    _SpellsPanel(
                      character: character,
                      isApplyingRest: isApplyingRest,
                        supportsShortRestRecovery: supportsShortRestRecovery,
                        onApplyShortRest: onApplyShortRest,
                        onApplyLongRest: onApplyLongRest,
                        onSpendSpellSlot: onSpendSpellSlot,
                      ),
                    const SizedBox(height: 16),
                  ],
                  _FeaturesNotesPanel(character: character),
                  const SizedBox(height: 16),
                  _EquipmentPanel(
                    character: character,
                    isUpdating: isApplyingRest,
                    errorMessage: errorMessage,
                    onSetInventoryItemEquipped: onSetInventoryItemEquipped,
                    onSetInventoryItemCarried: onSetInventoryItemCarried,
                    onSetInventoryItemQuantity: onSetInventoryItemQuantity,
                    onSpendInventoryItemQuantity: onSpendInventoryItemQuantity,
                    onSetInventoryItemCharges: onSetInventoryItemCharges,
                    onSetInventoryItemContainer: onSetInventoryItemContainer,
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
              'Summary',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            _FactRow(label: 'Name', value: character.identity.name),
            _FactRow(label: 'Race', value: character.identity.raceName),
            _FactRow(label: 'Class', value: character.identity.className),
            _FactRow(
              label: 'Level',
              value: character.identity.progression.level.toString(),
            ),
            _FactRow(
              label: 'XP',
              value: character.identity.progression.experience.toString(),
            ),
            _FactRow(
              label: 'Proficiency',
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
    required this.onRecordDeathSaveSuccess,
    required this.onRecordDeathSaveFailure,
    required this.onResetDeathSaves,
  });

  final CharacterDomainModel character;
  final bool isApplyingRest;
  final bool supportsShortRestRecovery;
  final Future<void> Function() onApplyShortRest;
  final Future<void> Function() onApplyLongRest;
  final Future<void> Function(String resourceKey, int currentUses)
  onSetClassResourceUses;
  final Future<void> Function() onRecordDeathSaveSuccess;
  final Future<void> Function() onRecordDeathSaveFailure;
  final Future<void> Function() onResetDeathSaves;

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
            _FactRow(
              label: 'Armor Class',
              value: '${character.combat.armorClass}',
            ),
            _FactRow(
              label: 'Initiative',
              value: character.combat.displayInitiativeModifier,
            ),
            _FactRow(
              label: 'Passive Perception',
              value: '${character.passivePerception}',
            ),
            if (character.combat.hasArmorConfigurationConflict)
              Padding(
                padding: const EdgeInsets.only(top: 4, bottom: 8),
                child: Text(
                  'Multiple body armors are equipped. Highest valid armor class is shown.',
                  style: theme.textTheme.bodySmall,
                ),
              ),
            const SizedBox(height: 8),
            Text('Attacks', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            if (character.combat.weaponAttacks.isEmpty)
              Text(
                'No equipped weapons with attack helpers available.',
                style: theme.textTheme.bodySmall,
              )
            else
              ...character.combat.weaponAttacks.map(
                (attack) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        attack.name,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      _FactRow(
                        label: 'Attack',
                        value:
                            '${attack.attackAbilityLabel} ${attack.displayAttackBonus}${attack.isProficient ? ' (proficient)' : ''}',
                      ),
                      _FactRow(
                        label: 'Damage',
                        value: attack.displayDamageExpression,
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 8),
            Text('Death Saves', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            _FactRow(
              label: 'Successes',
              value:
                  '${character.combat.deathSaves.successCount} / 3${character.combat.deathSaves.isStable ? ' (Stable)' : ''}',
            ),
            _FactRow(
              label: 'Failures',
              value:
                  '${character.combat.deathSaves.failureCount} / 3${character.combat.deathSaves.isDead ? ' (Dead)' : ''}',
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                OutlinedButton.icon(
                  onPressed:
                      isApplyingRest ||
                          !character.combat.deathSaves.canRecordSuccess
                      ? null
                      : () {
                          onRecordDeathSaveSuccess();
                        },
                  icon: const Icon(Icons.add_circle_outline),
                  label: const Text('Mark success'),
                ),
                OutlinedButton.icon(
                  onPressed:
                      isApplyingRest ||
                          !character.combat.deathSaves.canRecordFailure
                      ? null
                      : () {
                          onRecordDeathSaveFailure();
                        },
                  icon: const Icon(Icons.highlight_off_outlined),
                  label: const Text('Mark failure'),
                ),
                OutlinedButton.icon(
                  onPressed: isApplyingRest
                      ? null
                      : () {
                          onResetDeathSaves();
                        },
                  icon: const Icon(Icons.refresh_outlined),
                  label: const Text('Reset death saves'),
                ),
              ],
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
            if (character.featuresNotes.skills.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text('Skills', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: character.featuresNotes.skills
                    .map((skill) => _SkillChip(skill: skill))
                    .toList(growable: false),
              ),
            ],
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
    final languageProficiencies =
        character.featuresNotes.otherProficiencies
            .where(
              (item) => item.proficiencyType.trim().toLowerCase() == 'language',
            )
            .toList(growable: false)
          ..sort(
            (left, right) =>
                left.referenceLabel.compareTo(right.referenceLabel),
          );
    final groupedProficiencies =
        <String, List<CharacterProficiencyDomainModel>>{};
    for (final proficiency in character.featuresNotes.otherProficiencies) {
      if (proficiency.proficiencyType.trim().toLowerCase() == 'language') {
        continue;
      }

      groupedProficiencies
          .putIfAbsent(
            proficiency.proficiencyTypeLabel,
            () => <CharacterProficiencyDomainModel>[],
          )
          .add(proficiency);
    }
    final groupedProficiencyWidgets = <Widget>[];
    final groupedEntries = groupedProficiencies.entries.toList(growable: false)
      ..sort((left, right) => left.key.compareTo(right.key));
    for (final entry in groupedEntries) {
      final labels =
          entry.value
              .map((item) => item.referenceLabel)
              .toSet()
              .toList(growable: false)
            ..sort();
      groupedProficiencyWidgets.add(
        Text(
          entry.key,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      );
      groupedProficiencyWidgets.add(const SizedBox(height: 4));
      for (final label in labels) {
        groupedProficiencyWidgets.add(Text('• $label'));
      }
      groupedProficiencyWidgets.add(const SizedBox(height: 8));
    }

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
              if (languageProficiencies.isNotEmpty) ...[
                Text('Languages', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                ...languageProficiencies.map(
                  (item) => Text('• ${item.referenceLabel}'),
                ),
              ],
              if (groupedProficiencies.isNotEmpty) ...[
                if (languageProficiencies.isNotEmpty)
                  const SizedBox(height: 12),
                Text('Other proficiencies', style: theme.textTheme.titleMedium),
                const SizedBox(height: 8),
                ...groupedProficiencyWidgets,
              ],
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
  const _SpellsPanel({
    required this.character,
    required this.isApplyingRest,
    required this.supportsShortRestRecovery,
    required this.onApplyShortRest,
    required this.onApplyLongRest,
    required this.onSpendSpellSlot,
  });

  final CharacterDomainModel character;
  final bool isApplyingRest;
  final bool supportsShortRestRecovery;
  final Future<void> Function() onApplyShortRest;
  final Future<void> Function() onApplyLongRest;
  final Future<void> Function({required int spellLevel}) onSpendSpellSlot;

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
                (slot) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _FactRow(label: slot.label, value: slot.displaySummary),
                      const SizedBox(height: 6),
                      LinearProgressIndicator(
                        value: slot.slotsMax == 0
                            ? 0
                            : slot.slotsRemaining / slot.slotsMax,
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ActionChip(
                          label: const Text('Spend 1'),
                          onPressed: isApplyingRest || slot.slotsRemaining <= 0
                              ? null
                              : () {
                                  onSpendSpellSlot(spellLevel: slot.spellLevel);
                                },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 8),
            Text('Session recovery', style: theme.textTheme.titleMedium),
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
    required this.errorMessage,
    required this.onSetInventoryItemEquipped,
    required this.onSetInventoryItemCarried,
    required this.onSetInventoryItemQuantity,
    required this.onSpendInventoryItemQuantity,
    required this.onSetInventoryItemCharges,
    required this.onSetInventoryItemContainer,
  });

  final CharacterDomainModel character;
  final bool isUpdating;
  final String? errorMessage;
  final Future<void> Function(String inventoryItemId, bool isEquipped)
  onSetInventoryItemEquipped;
  final Future<void> Function(String inventoryItemId, bool isCarried)
  onSetInventoryItemCarried;
  final Future<void> Function(String inventoryItemId, int quantity)
  onSetInventoryItemQuantity;
  final Future<void> Function(String inventoryItemId, {int amount})
  onSpendInventoryItemQuantity;
  final Future<void> Function(
    String inventoryItemId, {
    int? chargesCurrent,
    int? chargesMax,
  })
  onSetInventoryItemCharges;
  final Future<void> Function(
    String inventoryItemId,
    String? containerInventoryItemId,
  )
  onSetInventoryItemContainer;

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
            if (errorMessage != null) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.errorContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  errorMessage!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onErrorContainer,
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
            ...character.equipment.items.map(
              (item) => _InventoryItemRow(
                item: item,
                isUpdating: isUpdating,
                containerState: character.equipment.containerStateFor(item.id),
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
                onSpendQuantity: () {
                  onSpendInventoryItemQuantity(item.id);
                },
                onSetCharges: ({chargesCurrent, chargesMax}) {
                  return onSetInventoryItemCharges(
                    item.id,
                    chargesCurrent: chargesCurrent,
                    chargesMax: chargesMax,
                  );
                },
                containers: character.equipment.items
                    .where((candidate) => candidate.id != item.id)
                    .where((candidate) => candidate.isContainer)
                    .toList(growable: false),
                onSetContainer: (containerInventoryItemId) {
                  return onSetInventoryItemContainer(
                    item.id,
                    containerInventoryItemId,
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

class _InventoryItemRow extends StatelessWidget {
  const _InventoryItemRow({
    required this.item,
    required this.isUpdating,
    required this.containerState,
    required this.onSetEquipped,
    required this.onSetCarried,
    required this.onIncreaseQuantity,
    required this.onDecreaseQuantity,
    required this.onSpendQuantity,
    required this.onSetCharges,
    required this.containers,
    required this.onSetContainer,
  });

  final CharacterEquipmentItemDomainModel item;
  final bool isUpdating;
  final CharacterInventoryContainerStateDomainModel? containerState;
  final ValueChanged<bool> onSetEquipped;
  final ValueChanged<bool> onSetCarried;
  final VoidCallback onIncreaseQuantity;
  final VoidCallback onDecreaseQuantity;
  final VoidCallback onSpendQuantity;
  final Future<void> Function({int? chargesCurrent, int? chargesMax})
  onSetCharges;
  final List<CharacterEquipmentItemDomainModel> containers;
  final Future<void> Function(String? containerInventoryItemId) onSetContainer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasSelectedContainer = containers.any(
      (container) => container.id == item.containerInventoryItemId,
    );
    final selectedContainerId = hasSelectedContainer
        ? item.containerInventoryItemId
        : null;
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
          Text(item.stackStateLabel, style: theme.textTheme.bodySmall),
          const SizedBox(height: 2),
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
              if (item.isConsumable || item.isAmmunition) ...[
                const SizedBox(width: 8),
                ActionChip(
                  label: const Text('Spend 1'),
                  onPressed: isUpdating || item.safeQuantity <= 0
                      ? null
                      : onSpendQuantity,
                ),
              ],
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
              if (item.hasCharges)
                ActionChip(
                  label: const Text('Clear charges'),
                  onPressed: isUpdating
                      ? null
                      : () {
                          onSetCharges(chargesCurrent: null, chargesMax: null);
                        },
                )
              else
                ActionChip(
                  label: const Text('Track charges'),
                  onPressed: isUpdating
                      ? null
                      : () {
                          onSetCharges(chargesCurrent: 1, chargesMax: 1);
                        },
                ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text('Charges: ${item.chargesLabel}'),
              if (item.hasCharges) ...[
                IconButton(
                  onPressed: isUpdating || item.safeChargesCurrent <= 0
                      ? null
                      : () {
                          onSetCharges(
                            chargesCurrent: item.safeChargesCurrent - 1,
                            chargesMax: item.chargesMax,
                          );
                        },
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                IconButton(
                  onPressed:
                      isUpdating ||
                          item.chargesMax == null ||
                          item.safeChargesCurrent >= item.chargesMax!
                      ? null
                      : () {
                          onSetCharges(
                            chargesCurrent: item.safeChargesCurrent + 1,
                            chargesMax: item.chargesMax,
                          );
                        },
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ],
          ),
          if (item.hasCharges) ...[
            const SizedBox(height: 6),
            LinearProgressIndicator(
              value: item.chargesMax == null || item.chargesMax == 0
                  ? 0
                  : item.safeChargesCurrent / item.chargesMax!,
            ),
          ],
          if (!item.isContainer) ...[
            const SizedBox(height: 8),
            DropdownButtonFormField<String?>(
              initialValue: selectedContainerId,
              decoration: const InputDecoration(
                labelText: 'Container',
                isDense: true,
              ),
              items: <DropdownMenuItem<String?>>[
                const DropdownMenuItem<String?>(
                  value: null,
                  child: Text('None'),
                ),
                ...containers.map(
                  (container) => DropdownMenuItem<String?>(
                    value: container.id,
                    child: Text(container.name),
                  ),
                ),
              ],
              onChanged: isUpdating
                  ? null
                  : (value) {
                      onSetContainer(value);
                    },
            ),
            if (containers.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'No container items available.',
                  style: theme.textTheme.bodySmall,
                ),
              )
            else if (item.containerDisplayName != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  item.containerLabel,
                  style: theme.textTheme.bodySmall,
                ),
              ),
          ] else ...[
            const SizedBox(height: 8),
            Text(item.containerLabel),
            if (containerState != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  containerState!.summaryLabel,
                  style: theme.textTheme.bodySmall,
                ),
              ),
          ],
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

class _SkillChip extends StatelessWidget {
  const _SkillChip({required this.skill});

  final CharacterSkillDomainModel skill;

  @override
  Widget build(BuildContext context) {
    final masterySuffix = skill.hasExpertise
        ? ' (exp)'
        : skill.isProficient
        ? ' (prof)'
        : '';
    return Chip(
      label: Text('${skill.name} ${skill.displayBonus}$masterySuffix'),
    );
  }
}

class _PortraitPreview extends StatelessWidget {
  const _PortraitPreview({required this.portraitPath});

  final String? portraitPath;

  @override
  Widget build(BuildContext context) {
    final trimmedPath = portraitPath?.trim() ?? '';
    if (trimmedPath.isEmpty) {
      return const SizedBox.shrink();
    }

    final imageProvider = _resolveImageProvider(trimmedPath);
    return CircleAvatar(
      radius: 34,
      backgroundColor: Colors.brown.shade100,
      child: ClipOval(
        child: imageProvider == null
            ? const Icon(Icons.person, size: 34)
            : Image(
                image: imageProvider,
                width: 68,
                height: 68,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const Icon(Icons.person, size: 34),
              ),
      ),
    );
  }

  ImageProvider<Object>? _resolveImageProvider(String value) {
    if (value.startsWith('http://') || value.startsWith('https://')) {
      return NetworkImage(value);
    }

    if (value.startsWith('assets/')) {
      return AssetImage(value);
    }

    return null;
  }
}
