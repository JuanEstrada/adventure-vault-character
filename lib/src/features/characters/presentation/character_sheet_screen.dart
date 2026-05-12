import 'dart:async';

import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_finishing_details.dart';
import 'package:adventure_vault_character/src/features/characters/presentation/container_management_dialog.dart';
import 'package:adventure_vault_character/src/features/characters/presentation/transfer_to_container_dialog.dart';
import 'package:flutter/material.dart';

String _fallbackText(String value, String fallback) {
  final trimmed = value.trim();
  return trimmed.isEmpty ? fallback : trimmed;
}

Widget _mutationErrorBanner(BuildContext context, String message) {
  final theme = Theme.of(context);
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: theme.colorScheme.errorContainer,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      message,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: theme.colorScheme.onErrorContainer,
      ),
    ),
  );
}

Widget _landscapeSectionCard(BuildContext context, {required Widget child}) {
  final theme = Theme.of(context);

  return Card(
    clipBehavior: Clip.antiAlias,
    child: Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            width: 12,
            color: theme.colorScheme.primaryContainer,
          ),
        ),
      ),
      child: child,
    ),
  );
}

class CharacterSheetScreen extends _CharacterSheetScreen {
  const CharacterSheetScreen({
    required super.character,
    required super.isApplyingRest,
    required super.errorMessage,
    required super.onBack,
    required super.onEdit,
    required super.onApplyShortRest,
    required super.onApplyLongRest,
    required super.onSpendSpellSlot,
    required super.onRestoreSpellSlot,
    required super.onSetClassResourceUses,
    required super.onRecordDeathSaveSuccess,
    required super.onRecordDeathSaveFailure,
    required super.onResetDeathSaves,
    required super.onSetInventoryItemEquipped,
    required super.onSetInventoryItemCarried,
    required super.onSetInventoryItemQuantity,
    required super.onSpendInventoryItemQuantity,
    required super.onSetInventoryItemCharges,
    required super.onSetInventoryItemContainer,
    super.onSplitStack,
    super.onMergeStacks,
    super.onTransferToContainer,
    super.onDeleteContainer,
    super.onCreateContainer,
    super.key,
  });
}

class _CharacterSheetScreen extends StatefulWidget {
  const _CharacterSheetScreen({
    required this.character,
    required this.isApplyingRest,
    required this.errorMessage,
    required this.onBack,
    required this.onEdit,
    required this.onApplyShortRest,
    required this.onApplyLongRest,
    required this.onSpendSpellSlot,
    required this.onRestoreSpellSlot,
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
    this.onSplitStack,
    this.onMergeStacks,
    this.onTransferToContainer,
    this.onDeleteContainer,
    this.onCreateContainer,
    super.key,
  });

  final CharacterDomainModel character;
  final bool isApplyingRest;
  final String? errorMessage;
  final VoidCallback onBack;
  final VoidCallback onEdit;
  final Future<void> Function() onApplyShortRest;
  final Future<void> Function() onApplyLongRest;
  final Future<void> Function({required int spellLevel, required int slotIndex})
  onSpendSpellSlot;
  final Future<void> Function({required int spellLevel, required int slotIndex})
  onRestoreSpellSlot;
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
  final Future<void> Function(String itemId, int quantity)? onSplitStack;
  final Future<void> Function(List<String> stackIds, int quantity)?
  onMergeStacks;
  final Future<void> Function(
    String sourceItemId,
    String targetContainerInventoryItemId,
    int quantity,
  )?
  onTransferToContainer;
  final Future<void> Function(String containerId)? onDeleteContainer;
  final Future<String> Function(String characterId, String name)?
  onCreateContainer;

  @override
  State<_CharacterSheetScreen> createState() => _CharacterSheetScreenState();
}

class _CharacterSheetScreenState extends State<_CharacterSheetScreen> {
  bool get isApplyingRest => widget.isApplyingRest;
  String? get errorMessage => widget.errorMessage;
  Future<void> Function() get onApplyShortRest => widget.onApplyShortRest;
  Future<void> Function() get onApplyLongRest => widget.onApplyLongRest;
  Future<void> Function({required int spellLevel, required int slotIndex})
  get onSpendSpellSlot => widget.onSpendSpellSlot;
  Future<void> Function({required int spellLevel, required int slotIndex})
  get onRestoreSpellSlot => widget.onRestoreSpellSlot;
  Future<void> Function(String resourceKey, int currentUses)
  get onSetClassResourceUses => widget.onSetClassResourceUses;
  Future<void> Function() get onRecordDeathSaveSuccess =>
      widget.onRecordDeathSaveSuccess;
  Future<void> Function() get onRecordDeathSaveFailure =>
      widget.onRecordDeathSaveFailure;
  Future<void> Function() get onResetDeathSaves => widget.onResetDeathSaves;
  Future<void> Function(String inventoryItemId, bool isEquipped)
  get onSetInventoryItemEquipped => widget.onSetInventoryItemEquipped;
  Future<void> Function(String inventoryItemId, bool isCarried)
  get onSetInventoryItemCarried => widget.onSetInventoryItemCarried;
  Future<void> Function(String inventoryItemId, int quantity)
  get onSetInventoryItemQuantity => widget.onSetInventoryItemQuantity;
  Future<void> Function(String inventoryItemId, {int amount})
  get onSpendInventoryItemQuantity => widget.onSpendInventoryItemQuantity;
  Future<void> Function(
    String inventoryItemId, {
    int? chargesCurrent,
    int? chargesMax,
  })
  get onSetInventoryItemCharges => widget.onSetInventoryItemCharges;
  Future<void> Function(
    String inventoryItemId,
    String? containerInventoryItemId,
  )
  get onSetInventoryItemContainer => widget.onSetInventoryItemContainer;
  Future<void> Function(String itemId, int quantity) get onSplitStack =>
      widget.onSplitStack ?? _noopSplitStack;
  Future<void> Function(List<String> stackIds, int quantity)
  get onMergeStacks => widget.onMergeStacks ?? _noopMergeStacks;
  Future<void> Function(
    String sourceItemId,
    String targetContainerInventoryItemId,
    int quantity,
  )
  get onTransferToContainer =>
      widget.onTransferToContainer ?? _noopTransferToContainer;
  Future<void> Function(String containerId) get onDeleteContainer =>
      widget.onDeleteContainer ?? _noopDeleteContainer;
  Future<String> Function(String characterId, String name)
  get onCreateContainer => widget.onCreateContainer ?? _noopCreateContainer;

  bool get supportsShortRestRecovery {
    final supportsShortRestSlotRecovery =
        widget.character.identity.className.trim().toLowerCase() == 'warlock';
    final supportsShortRestResourceRecovery = widget
        .character
        .combat
        .classResources
        .any((resource) => resource.recoversOnShortRest);
    return supportsShortRestSlotRecovery || supportsShortRestResourceRecovery;
  }

  Future<void> _openContainerManagementDialog() async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => ContainerManagementDialog(
        containers: widget.character.equipment.items
            .where((candidate) => candidate.isContainer)
            .toList(growable: false),
        onDismiss: () => Navigator.of(dialogContext).pop(),
        onRename: (containerId, containerName) async {},
        onDelete: (containerId) async {
          await onDeleteContainer(containerId);
        },
        onAdd: (containerName) async {
          return onCreateContainer(widget.character.id, containerName);
        },
      ),
    );
  }

  List<Widget> _buildSheetPanels() {
    final panels = <Widget>[
      _IdentityPanel(character: widget.character),
      _CombatPanel(
        character: widget.character,
        isApplyingRest: isApplyingRest,
        errorMessage: errorMessage,
        supportsShortRestRecovery: supportsShortRestRecovery,
        onApplyShortRest: onApplyShortRest,
        onApplyLongRest: onApplyLongRest,
        onSetClassResourceUses: onSetClassResourceUses,
        onRecordDeathSaveSuccess: onRecordDeathSaveSuccess,
        onRecordDeathSaveFailure: onRecordDeathSaveFailure,
        onResetDeathSaves: onResetDeathSaves,
      ),
      _AbilitiesPanel(character: widget.character),
      if (widget.character.spellcasting != null)
        _SpellsPanel(
          character: widget.character,
          isApplyingRest: isApplyingRest,
          errorMessage: errorMessage,
          supportsShortRestRecovery: supportsShortRestRecovery,
          onApplyShortRest: onApplyShortRest,
          onApplyLongRest: onApplyLongRest,
          onSpendSpellSlot: onSpendSpellSlot,
          onRestoreSpellSlot: onRestoreSpellSlot,
        ),
      _FeaturesNotesPanel(character: widget.character),
      _EquipmentPanel(
        character: widget.character,
        isUpdating: isApplyingRest,
        errorMessage: errorMessage,
        onManageContainers: _openContainerManagementDialog,
        onSetInventoryItemEquipped: onSetInventoryItemEquipped,
        onSetInventoryItemCarried: onSetInventoryItemCarried,
        onSetInventoryItemQuantity: onSetInventoryItemQuantity,
        onSpendInventoryItemQuantity: onSpendInventoryItemQuantity,
        onSetInventoryItemCharges: onSetInventoryItemCharges,
        onSetInventoryItemContainer: onSetInventoryItemContainer,
        onSplitStack: onSplitStack,
        onMergeStacks: onMergeStacks,
        onTransferToContainer: onTransferToContainer,
      ),
    ];

    return panels;
  }

  Widget _buildPanelGrid(BoxConstraints constraints) {
    final isWide = constraints.maxWidth >= 1100;
    final panelWidth = isWide
        ? (constraints.maxWidth - 16) / 2
        : constraints.maxWidth;

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: _buildSheetPanels()
          .map((panel) => SizedBox(width: panelWidth, child: panel))
          .toList(growable: false),
    );
  }

  Future<void> _noopSplitStack(String itemId, int quantity) async {}
  Future<void> _noopMergeStacks(List<String> stackIds, int quantity) async {}
  Future<void> _noopTransferToContainer(
    String sourceItemId,
    String targetContainerInventoryItemId,
    int quantity,
  ) async {}
  Future<void> _noopDeleteContainer(String containerId) async {}
  Future<String> _noopCreateContainer(String characterId, String name) async =>
      '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FocusTraversalGroup(
      policy: OrderedTraversalPolicy(),
      child: FocusScope(
        autofocus: true,
        child: Scaffold(
          appBar: AppBar(
            leading: Semantics(
              container: true,
              label: 'Back',
              child: IconButton(
                onPressed: widget.onBack,
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            title: Semantics(
              container: true,
              label: widget.character.identity.name,
              child: ExcludeSemantics(
                child: Text(
                  _fallbackText(
                    widget.character.identity.name,
                    'Unnamed character',
                  ),
                ),
              ),
            ),
            actions: [
              Semantics(
                container: true,
                label: 'Edit character',
                child: TextButton(
                  onPressed: widget.onEdit,
                  child: const Text('Edit'),
                ),
              ),
            ],
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
                              Semantics(
                                container: true,
                                label:
                                    '${widget.character.identity.name}, ${_fallbackText(widget.character.identity.raceName, 'Unknown race')} ${_fallbackText(widget.character.identity.className, 'Unknown class')} Level ${widget.character.identity.progression.level}',
                                child: ExcludeSemantics(
                                  child: Text(
                                    _fallbackText(
                                      widget.character.identity.name,
                                      'Unnamed character',
                                    ),
                                    style: theme.textTheme.headlineSmall
                                        ?.copyWith(fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Semantics(
                                container: true,
                                label:
                                    'Race: ${_fallbackText(widget.character.identity.raceName, 'Unknown race')}, Class: ${_fallbackText(widget.character.identity.className, 'Unknown class')}, Level: ${widget.character.identity.progression.level}, XP: ${widget.character.identity.progression.experience}',
                                child: ExcludeSemantics(
                                  child: Text(
                                    '${_fallbackText(widget.character.identity.raceName, 'Unknown race')}  •  ${_fallbackText(widget.character.identity.className, 'Unknown class')}  •  Lv ${widget.character.identity.progression.level}  •  XP ${widget.character.identity.progression.experience}',
                                    style: theme.textTheme.titleMedium,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        _PortraitPreview(
                          portraitPath: widget
                              .character
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
                builder: (context, constraints) => _buildPanelGrid(constraints),
              ),
            ],
          ),
        ),
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

    return _landscapeSectionCard(
      context,
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
          Semantics(
            container: true,
            button: true,
            enabled: !isUpdating && resource.currentUses > 0,
            label: 'Spend use',
            child: IconButton(
              onPressed: isUpdating || resource.currentUses <= 0
                  ? null
                  : onDecrease,
              icon: const Icon(Icons.remove_circle_outline),
              tooltip: 'Spend use',
            ),
          ),
          Text(resource.usageSummary, style: theme.textTheme.bodyLarge),
          Semantics(
            container: true,
            button: true,
            enabled: !isUpdating && resource.currentUses < resource.maximumUses,
            label: 'Restore use',
            child: IconButton(
              onPressed:
                  isUpdating || resource.currentUses >= resource.maximumUses
                  ? null
                  : onIncrease,
              icon: const Icon(Icons.add_circle_outline),
              tooltip: 'Restore use',
            ),
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
    required this.errorMessage,
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
  final String? errorMessage;
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

    return _landscapeSectionCard(
      context,
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
            if (errorMessage != null) ...[
              const SizedBox(height: 10),
              _mutationErrorBanner(context, errorMessage!),
            ],
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
            Semantics(
              container: true,
              header: true,
              label: 'Attacks',
              child: ExcludeSemantics(
                child: Text('Attacks', style: theme.textTheme.titleMedium),
              ),
            ),
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
            Semantics(
              container: true,
              header: true,
              label: 'Death Saves',
              child: ExcludeSemantics(
                child: Text('Death Saves', style: theme.textTheme.titleMedium),
              ),
            ),
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
                Semantics(
                  container: true,
                  button: true,
                  enabled:
                      !isApplyingRest &&
                      character.combat.deathSaves.canRecordSuccess,
                  label: 'Record death save success',
                  child: OutlinedButton.icon(
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
                ),
                Semantics(
                  container: true,
                  button: true,
                  enabled:
                      !isApplyingRest &&
                      character.combat.deathSaves.canRecordFailure,
                  label: 'Record death save failure',
                  child: OutlinedButton.icon(
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
                ),
                Semantics(
                  container: true,
                  button: true,
                  enabled: !isApplyingRest,
                  label: 'Reset death saves',
                  child: OutlinedButton.icon(
                    onPressed: isApplyingRest
                        ? null
                        : () {
                            onResetDeathSaves();
                          },
                    icon: const Icon(Icons.refresh_outlined),
                    label: const Text('Reset death saves'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Semantics(
              container: true,
              header: true,
              label: 'Recovery',
              child: ExcludeSemantics(
                child: Text('Recovery', style: theme.textTheme.titleMedium),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Semantics(
                  container: true,
                  button: true,
                  enabled: !isApplyingRest && supportsShortRestRecovery,
                  label: 'Apply short rest',
                  child: OutlinedButton.icon(
                    onPressed: isApplyingRest || !supportsShortRestRecovery
                        ? null
                        : () {
                            onApplyShortRest();
                          },
                    icon: const Icon(Icons.timer_outlined),
                    label: const Text('Apply short rest'),
                  ),
                ),
                Semantics(
                  container: true,
                  button: true,
                  enabled: !isApplyingRest,
                  label: 'Apply long rest',
                  child: OutlinedButton.icon(
                    onPressed: isApplyingRest
                        ? null
                        : () {
                            onApplyLongRest();
                          },
                    icon: const Icon(Icons.bed_outlined),
                    label: const Text('Apply long rest'),
                  ),
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
              Semantics(
                container: true,
                header: true,
                label: 'Class resources',
                child: ExcludeSemantics(
                  child: Text(
                    'Class resources',
                    style: theme.textTheme.titleMedium,
                  ),
                ),
              ),
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
              Semantics(
                container: true,
                header: true,
                label: 'Saving Throws',
                child: ExcludeSemantics(
                  child: Text(
                    'Saving Throws',
                    style: theme.textTheme.titleMedium,
                  ),
                ),
              ),
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

    return _landscapeSectionCard(
      context,
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
    final background = character.featuresNotes.background;
    final backgroundName = _fallbackText(
      background.name,
      'Background unavailable',
    );
    final backgroundSummary = _fallbackText(
      background.summary,
      'No background summary available.',
    );
    final backgroundBonusDescriptions = background.bonusDescriptions;
    final backgroundSocialPerkDescriptions = background.socialPerkDescriptions;
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

    return _landscapeSectionCard(
      context,
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
              backgroundName,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(backgroundSummary, style: theme.textTheme.bodyLarge),
            const SizedBox(height: 12),
            Text('Bonuses', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            if (backgroundBonusDescriptions.isEmpty)
              Text(
                'No background bonuses recorded.',
                style: theme.textTheme.bodyMedium,
              )
            else
              ...backgroundBonusDescriptions.map((item) => Text('• $item')),
            const SizedBox(height: 12),
            Text('Social perks', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            if (backgroundSocialPerkDescriptions.isEmpty)
              Text(
                'No social perks recorded.',
                style: theme.textTheme.bodyMedium,
              )
            else
              ...backgroundSocialPerkDescriptions.map(
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
            ] else ...[
              const SizedBox(height: 12),
              Text(
                'No finishing details recorded.',
                style: theme.textTheme.bodyMedium,
              ),
            ],
            _FactRow(
              label: 'Appearance',
              value: _fallbackText(
                character.featuresNotes.appearanceDetails,
                'Not recorded',
              ),
            ),
            _FactRow(
              label: 'Notes',
              value: _fallbackText(
                character.featuresNotes.narrativeDetails,
                'Not recorded',
              ),
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
    required this.errorMessage,
    required this.supportsShortRestRecovery,
    required this.onApplyShortRest,
    required this.onApplyLongRest,
    required this.onSpendSpellSlot,
    required this.onRestoreSpellSlot,
  });

  final CharacterDomainModel character;
  final bool isApplyingRest;
  final String? errorMessage;
  final bool supportsShortRestRecovery;
  final Future<void> Function() onApplyShortRest;
  final Future<void> Function() onApplyLongRest;
  final Future<void> Function({required int spellLevel, required int slotIndex})
  onSpendSpellSlot;
  final Future<void> Function({required int spellLevel, required int slotIndex})
  onRestoreSpellSlot;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final spellcasting = character.spellcasting;
    if (spellcasting == null) {
      return const SizedBox.shrink();
    }

    return _landscapeSectionCard(
      context,
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
            if (errorMessage != null) ...[
              const SizedBox(height: 10),
              _mutationErrorBanner(context, errorMessage!),
            ],
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
                      Wrap(
                        spacing: 4,
                        runSpacing: 4,
                        children: List.generate(slot.slotsMax, (slotIndex) {
                          final index = slotIndex + 1;
                          final isSpent = slot.slotsExpended >= index;
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Semantics(
                                container: true,
                                button: true,
                                enabled: !isApplyingRest && !isSpent,
                                label: 'Spend slot $index',
                                child: ActionChip(
                                  label: ExcludeSemantics(
                                    child: Text('Spend $index'),
                                  ),
                                  onPressed: isApplyingRest || isSpent
                                      ? null
                                      : () {
                                          onSpendSpellSlot(
                                            spellLevel: slot.spellLevel,
                                            slotIndex: slot.slotIndex,
                                          );
                                        },
                                  disabledColor: Colors.grey.shade200,
                                ),
                              ),
                              if (isSpent) ...[
                                const SizedBox(width: 4),
                                Semantics(
                                  container: true,
                                  button: true,
                                  enabled: !isApplyingRest,
                                  label: 'Restore slot $index',
                                  child: ActionChip(
                                    label: const ExcludeSemantics(
                                      child: Text('Restore'),
                                    ),
                                    onPressed: isApplyingRest
                                        ? null
                                        : () {
                                            onRestoreSpellSlot(
                                              spellLevel: slot.spellLevel,
                                              slotIndex: slot.slotIndex,
                                            );
                                          },
                                  ),
                                ),
                              ],
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 8),
            Semantics(
              container: true,
              header: true,
              label: 'Session recovery',
              child: ExcludeSemantics(
                child: Text(
                  'Session recovery',
                  style: theme.textTheme.titleMedium,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Semantics(
                  container: true,
                  button: true,
                  enabled: !isApplyingRest && supportsShortRestRecovery,
                  label: 'Apply short rest',
                  child: OutlinedButton.icon(
                    onPressed: isApplyingRest || !supportsShortRestRecovery
                        ? null
                        : () {
                            onApplyShortRest();
                          },
                    icon: const Icon(Icons.timer_outlined),
                    label: const Text('Apply short rest'),
                  ),
                ),
                Semantics(
                  container: true,
                  button: true,
                  enabled: !isApplyingRest,
                  label: 'Apply long rest',
                  child: OutlinedButton.icon(
                    onPressed: isApplyingRest
                        ? null
                        : () {
                            onApplyLongRest();
                          },
                    icon: const Icon(Icons.bed_outlined),
                    label: const Text('Apply long rest'),
                  ),
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
                        (spell) => Semantics(
                          container: true,
                          label:
                              '${spell.name} (${spell.school}, ${spell.castingTime})',
                          child: ExcludeSemantics(
                            child: Text(
                              '• ${spell.name} (${spell.school}, ${spell.castingTime})',
                            ),
                          ),
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
    required this.onManageContainers,
    required this.onSetInventoryItemEquipped,
    required this.onSetInventoryItemCarried,
    required this.onSetInventoryItemQuantity,
    required this.onSpendInventoryItemQuantity,
    required this.onSetInventoryItemCharges,
    required this.onSetInventoryItemContainer,
    required this.onSplitStack,
    required this.onMergeStacks,
    required this.onTransferToContainer,
  });

  final CharacterDomainModel character;
  final bool isUpdating;
  final String? errorMessage;
  final Future<void> Function() onManageContainers;
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
  final Future<void> Function(String itemId, int quantity) onSplitStack;
  final Future<void> Function(List<String> stackIds, int quantity)
  onMergeStacks;
  final Future<void> Function(
    String sourceItemId,
    String targetContainerInventoryItemId,
    int quantity,
  )
  onTransferToContainer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return _landscapeSectionCard(
      context,
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
              _fallbackText(
                character.equipment.selectedEquipmentLabel,
                'Equipment loadout unavailable',
              ),
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
              _fallbackText(
                character.equipment.equipmentSummary.description,
                'No equipment summary available.',
              ),
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 12),
            Text(
              character.equipment.carrying.tierDescription,
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            Semantics(
              container: true,
              header: true,
              label: 'Inventory actions',
              child: ExcludeSemantics(
                child: Text(
                  'Inventory actions',
                  style: theme.textTheme.titleMedium,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Semantics(
                container: true,
                button: true,
                label: 'Manage containers',
                child: OutlinedButton.icon(
                  onPressed: onManageContainers,
                  icon: const Icon(Icons.inventory_2_outlined),
                  label: const Text('Manage containers'),
                ),
              ),
            ),
            const SizedBox(height: 12),
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
                onSplitStack: onSplitStack,
                onMergeStacks: onMergeStacks,
                onTransferToContainer: (sourceItemId, quantity) async {
                  await showDialog<void>(
                    context: context,
                    builder: (dialogContext) => TransferToContainerDialog(
                      sourceItemId: sourceItemId,
                      sourceQuantity: quantity,
                      sourceName: item.name,
                      onDismiss: () {
                        Navigator.of(dialogContext).pop();
                      },
                      onTransfer:
                          (containerId, containerName, transferQuantity) async {
                            await onTransferToContainer(
                              item.id,
                              containerId,
                              transferQuantity,
                            );
                          },
                      containers: character.equipment.items
                          .where((candidate) => candidate.id != item.id)
                          .where((candidate) => candidate.isContainer)
                          .toList(growable: false),
                    ),
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
    required this.onSplitStack,
    required this.onMergeStacks,
    required this.onTransferToContainer,
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
  final Future<void> Function(String itemId, int quantity) onSplitStack;
  final Future<void> Function(List<String> stackIds, int quantity)
  onMergeStacks;
  final Future<void> Function(String sourceItemId, int quantity)
  onTransferToContainer;

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
              Semantics(
                container: true,
                button: true,
                enabled: !isUpdating && item.quantity > 0,
                label: 'Decrease quantity',
                child: IconButton(
                  onPressed: isUpdating || item.quantity <= 0
                      ? null
                      : onDecreaseQuantity,
                  icon: const Icon(Icons.remove_circle_outline),
                ),
              ),
              Text('Qty ${item.quantity}'),
              Semantics(
                container: true,
                button: true,
                enabled: !isUpdating,
                label: 'Increase quantity',
                child: IconButton(
                  onPressed: isUpdating ? null : onIncreaseQuantity,
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ),
              if (item.isConsumable || item.isAmmunition) ...[
                const SizedBox(width: 8),
                Semantics(
                  container: true,
                  button: true,
                  enabled: !isUpdating && item.safeQuantity > 0,
                  label: 'Spend 1',
                  child: ActionChip(
                    label: const ExcludeSemantics(child: Text('Spend 1')),
                    onPressed: isUpdating || item.safeQuantity <= 0
                        ? null
                        : onSpendQuantity,
                  ),
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
              Semantics(
                container: true,
                button: true,
                selected: item.isEquipped,
                label: 'Toggle equipped',
                child: FilterChip(
                  label: const ExcludeSemantics(child: Text('Equipped')),
                  selected: item.isEquipped,
                  onSelected: isUpdating ? null : onSetEquipped,
                ),
              ),
              Semantics(
                container: true,
                button: true,
                selected: item.isCarried,
                label: 'Toggle carried',
                child: FilterChip(
                  label: const ExcludeSemantics(child: Text('Carried')),
                  selected: item.isCarried,
                  onSelected: isUpdating ? null : onSetCarried,
                ),
              ),
              if (item.hasCharges)
                Semantics(
                  container: true,
                  button: true,
                  label: 'Clear charges',
                  child: ActionChip(
                    label: const ExcludeSemantics(child: Text('Clear charges')),
                    onPressed: isUpdating
                        ? null
                        : () {
                            onSetCharges(
                              chargesCurrent: null,
                              chargesMax: null,
                            );
                          },
                  ),
                )
              else
                Semantics(
                  container: true,
                  button: true,
                  label: 'Track charges',
                  child: ActionChip(
                    label: const ExcludeSemantics(child: Text('Track charges')),
                    onPressed: isUpdating
                        ? null
                        : () {
                            onSetCharges(chargesCurrent: 1, chargesMax: 1);
                          },
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text('Charges: ${item.chargesLabel}'),
              if (item.hasCharges) ...[
                Semantics(
                  container: true,
                  button: true,
                  enabled: !isUpdating && item.safeChargesCurrent > 0,
                  label: 'Decrease charges',
                  child: IconButton(
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
                ),
                Semantics(
                  container: true,
                  button: true,
                  enabled:
                      !isUpdating &&
                      (item.chargesMax == null ||
                          item.safeChargesCurrent < item.chargesMax!),
                  label: 'Increase charges',
                  child: IconButton(
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
            Semantics(
              container: true,
              explicitChildNodes: true,
              label: 'Select container',
              child: ExcludeSemantics(
                child: DropdownButtonFormField<String?>(
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
              ),
            ),
            // Stack operation buttons (split/merge/transfer) - only for non-container items
            if (!item.isContainer && item.quantity > 1) ...[
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Semantics(
                    container: true,
                    button: true,
                    enabled: !isUpdating && item.quantity > 1,
                    label: 'Split stack',
                    child: IconButton(
                      onPressed: isUpdating || item.quantity <= 1
                          ? null
                          : () => onSplitStack(item.id, item.quantity ~/ 2),
                      icon: const Icon(Icons.call_split),
                      tooltip: 'Split stack',
                    ),
                  ),
                  if (containers.isNotEmpty) ...[
                    Semantics(
                      container: true,
                      button: true,
                      enabled: !isUpdating,
                      label: 'Transfer to container',
                      child: IconButton(
                        onPressed: isUpdating
                            ? null
                            : () =>
                                  onTransferToContainer(item.id, item.quantity),
                        icon: const Icon(Icons.inventory_2_outlined),
                        tooltip: 'Transfer to container',
                      ),
                    ),
                    Semantics(
                      container: true,
                      button: true,
                      enabled: !isUpdating,
                      label: 'Merge with containers',
                      child: IconButton(
                        onPressed: isUpdating
                            ? null
                            : () => onMergeStacks([
                                item.id,
                                ...containers.map((c) => c.id),
                              ], item.quantity),
                        icon: const Icon(Icons.merge_type),
                        tooltip: 'Merge with containers',
                      ),
                    ),
                  ],
                ],
              ),
            ],
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
