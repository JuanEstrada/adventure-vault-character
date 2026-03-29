import 'package:adventure_vault_character/src/features/characters/application/finishing_details_service.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_finishing_details.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_rules.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_spell_rules.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';
import 'package:flutter/material.dart';

class CreateCharacterScreen extends StatefulWidget {
  const CreateCharacterScreen({
    required this.catalog,
    required this.isSaving,
    required this.errorMessage,
    required this.onCancel,
    required this.onSave,
    this.initialDraft,
    this.screenTitle = 'Crear personaje',
    this.submitLabel = 'Guardar draft',
    super.key,
  });

  final CompendiumCatalog catalog;
  final bool isSaving;
  final String? errorMessage;
  final VoidCallback onCancel;
  final ValueChanged<CreateCharacterInput> onSave;
  final CreateCharacterInput? initialDraft;
  final String screenTitle;
  final String submitLabel;

  @override
  State<CreateCharacterScreen> createState() => _CreateCharacterScreenState();
}

class _CreateCharacterScreenState extends State<CreateCharacterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _appearanceController = TextEditingController();
  final _narrativeNotesController = TextEditingController();
  final _finishingDetailsService = const FinishingDetailsService();
  final _characterSpellRules = const CharacterSpellRules();
  final Map<String, int> _generatedAssignments = <String, int>{
    'Strength': 15,
    'Dexterity': 14,
    'Constitution': 13,
    'Intelligence': 12,
    'Wisdom': 10,
    'Charisma': 8,
  };
  final Map<String, int> _manualAssignments = <String, int>{
    'Strength': 10,
    'Dexterity': 10,
    'Constitution': 10,
    'Intelligence': 10,
    'Wisdom': 10,
    'Charisma': 10,
  };
  final Map<NarrativeFieldKey, NarrativeSelection> _narrativeSelections =
      <NarrativeFieldKey, NarrativeSelection>{};
  final Map<NarrativeFieldKey, String?> _selectedGroupIds =
      <NarrativeFieldKey, String?>{};

  late String _selectedRace;
  late CompendiumBackground _selectedBackground;
  String _selectedAbilityMethod = 'generatedSetAssignment';
  late String _selectedClass;
  int _selectedLevel = 1;
  int _selectedExperience = 0;
  late CompendiumEquipmentLoadout _selectedEquipmentLoadout;
  int _currentHitPoints = 10;
  int _maximumHitPoints = 10;
  int _temporaryHitPoints = 0;
  String? _portraitAssetPath;
  final Set<String> _selectedSpellIds = <String>{};
  final Map<int, int> _spellSlotUsages = <int, int>{};

  static const List<String> _abilityOrder = <String>[
    'Strength',
    'Dexterity',
    'Constitution',
    'Intelligence',
    'Wisdom',
    'Charisma',
  ];

  bool get _hasRequiredCatalogData => _missingCatalogSections.isEmpty;

  bool get _hasSupportedEquipmentSelection =>
      _selectedEquipmentLoadout.id != 'fallback-loadout' &&
      _selectedEquipmentLoadout.selectedItems.every(
        (item) => !_isPlaceholderEquipmentItem(item),
      );

  List<String> get _missingCatalogSections {
    final missing = <String>[];
    if (widget.catalog.races.isEmpty) {
      missing.add('Race');
    }
    if (widget.catalog.backgrounds.isEmpty) {
      missing.add('Background');
    }
    if (widget.catalog.classes.isEmpty) {
      missing.add('Class');
    }
    return missing;
  }

  @override
  void initState() {
    super.initState();
    if (!_hasRequiredCatalogData) {
      return;
    }
    final initialDraft = widget.initialDraft;
    _selectedRace =
        initialDraft != null &&
            widget.catalog.races.contains(initialDraft.raceName)
        ? initialDraft.raceName
        : widget.catalog.races.first;
    _selectedBackground =
        widget.catalog.backgroundById(initialDraft?.backgroundId) ??
        widget.catalog.backgrounds.first;
    _selectedClass =
        initialDraft != null &&
            widget.catalog.classes.contains(initialDraft.className)
        ? initialDraft.className
        : widget.catalog.classes.first;
    _selectedAbilityMethod =
        initialDraft?.abilityScoreMethod ?? 'generatedSetAssignment';
    _selectedLevel = initialDraft?.level ?? 1;
    _selectedExperience =
        initialDraft?.experience ??
        CharacterRules.experienceFloorForLevel(_selectedLevel);
    _currentHitPoints = initialDraft?.currentHitPoints ?? 10;
    _maximumHitPoints = initialDraft?.maximumHitPoints ?? 10;
    _temporaryHitPoints = initialDraft?.temporaryHitPoints ?? 0;
    _portraitAssetPath = initialDraft?.portraitAssetPath;
    _nameController.text = initialDraft?.name ?? '';
    _appearanceController.text = initialDraft?.appearanceDetails ?? '';
    _narrativeNotesController.text = initialDraft?.narrativeDetails ?? '';

    _applyGeneratedAssignmentsForClass(_selectedClass);
    if (initialDraft != null) {
      _generatedAssignments
        ..['Strength'] = initialDraft.strength
        ..['Dexterity'] = initialDraft.dexterity
        ..['Constitution'] = initialDraft.constitution
        ..['Intelligence'] = initialDraft.intelligence
        ..['Wisdom'] = initialDraft.wisdom
        ..['Charisma'] = initialDraft.charisma;
      _manualAssignments
        ..['Strength'] = initialDraft.strength
        ..['Dexterity'] = initialDraft.dexterity
        ..['Constitution'] = initialDraft.constitution
        ..['Intelligence'] = initialDraft.intelligence
        ..['Wisdom'] = initialDraft.wisdom
        ..['Charisma'] = initialDraft.charisma;
    }

    final equipmentOptions = widget.catalog.equipmentLoadoutsForClass(
      _selectedClass,
    );
    _selectedEquipmentLoadout = initialDraft == null
        ? equipmentOptions.first
        : equipmentOptions.firstWhere(
            (option) => option.id == initialDraft.equipmentLoadoutId,
            orElse: () => equipmentOptions.first,
          );
    _selectedSpellIds
      ..clear()
      ..addAll(
        initialDraft?.spellState.selectedSpells
                .map((spell) => spell.spellId)
                .toList(growable: false) ??
            const <String>[],
      );
    _spellSlotUsages
      ..clear()
      ..addEntries(
        initialDraft?.spellState.slotUsages.map(
              (usage) => MapEntry(usage.spellLevel, usage.slotsExpended),
            ) ??
            const Iterable<MapEntry<int, int>>.empty(),
      );

    final initialSelections =
        initialDraft?.finishingDetails.narrativeSelections ??
        CharacterFinishingDetailsInput.empty().narrativeSelections;
    for (final fieldKey in NarrativeFieldKey.values) {
      final selection = initialSelections.firstWhere(
        (item) => item.fieldKey == fieldKey,
        orElse: () => NarrativeSelection.empty(fieldKey),
      );
      _narrativeSelections[fieldKey] = selection;
      _selectedGroupIds[fieldKey] = selection.groupId;
    }
    _syncNarrativeStateForBackground(forceResetInvalidSelections: false);
    _syncSpellStateForClassLevel();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _appearanceController.dispose();
    _narrativeNotesController.dispose();
    super.dispose();
  }

  void _applyGeneratedAssignmentsForClass(String className) {
    StandardArrayByClassEntry? classArray;
    for (final entry in widget.catalog.standardArrayByClass) {
      if (entry.className == className) {
        classArray = entry;
        break;
      }
    }
    if (classArray == null) {
      return;
    }
    _generatedAssignments
      ..['Strength'] = classArray.strength
      ..['Dexterity'] = classArray.dexterity
      ..['Constitution'] = classArray.constitution
      ..['Intelligence'] = classArray.intelligence
      ..['Wisdom'] = classArray.wisdom
      ..['Charisma'] = classArray.charisma;
  }

  void _syncNarrativeStateForBackground({
    required bool forceResetInvalidSelections,
  }) {
    for (final fieldKey in NarrativeFieldKey.values) {
      final groups = _groupsFor(fieldKey);
      final current =
          _narrativeSelections[fieldKey] ?? NarrativeSelection.empty(fieldKey);
      final selectedGroupId = _selectedGroupIds[fieldKey];

      if (groups.isEmpty) {
        _selectedGroupIds[fieldKey] = null;
        if (forceResetInvalidSelections || current.groupId != null) {
          _narrativeSelections[fieldKey] = NarrativeSelection.empty(fieldKey);
        }
        continue;
      }

      final resolvedGroupId = groups.any((group) => group.id == selectedGroupId)
          ? selectedGroupId
          : groups.first.id;
      _selectedGroupIds[fieldKey] = resolvedGroupId;

      final group = groups.firstWhere((item) => item.id == resolvedGroupId);
      final optionStillValid =
          current.optionId != null &&
          group.options.any((option) => option.id == current.optionId);

      if (current.mode == NarrativeSelectionMode.rolled) {
        _narrativeSelections[fieldKey] = _finishingDetailsService
            .rolledSelection(
              fieldKey: fieldKey,
              group: group,
              seed: _rollSeed(fieldKey, group.id),
            );
      } else if (current.mode == NarrativeSelectionMode.manual &&
          !optionStillValid &&
          forceResetInvalidSelections) {
        _narrativeSelections[fieldKey] = NarrativeSelection(
          fieldKey: fieldKey,
          mode: NarrativeSelectionMode.manual,
          valueText: null,
          groupId: resolvedGroupId,
          optionId: null,
          rollValue: null,
        );
      }
    }
  }

  List<CompendiumNarrativeOptionGroup> _groupsFor(NarrativeFieldKey fieldKey) {
    return _finishingDetailsService.availableGroups(
      catalog: widget.catalog,
      fieldKey: fieldKey,
      backgroundId: _selectedBackground.id,
    );
  }

  String _rollSeed(NarrativeFieldKey fieldKey, String groupId) {
    return [
      _nameController.text.trim(),
      _selectedBackground.id,
      _selectedClass,
      _selectedLevel.toString(),
      fieldKey.storageKey,
      groupId,
    ].join('|');
  }

  String _buildAbilityProvenance(Map<String, int> assignments) {
    final values = _abilityOrder
        .map((ability) => '$ability=${assignments[ability]}')
        .join(';');
    return 'method=$_selectedAbilityMethod;$values';
  }

  CharacterSpellSelectionMode? get _spellSelectionMode =>
      _characterSpellRules.selectionModeForClass(_selectedClass);

  bool get _showsSpellSection =>
      _characterSpellRules.supportsPersistentSpellState(_selectedClass);

  List<CompendiumSpell> get _availableSpellOptions {
    final highestSpellLevel = _characterSpellRules.highestCastableSpellLevel(
      className: _selectedClass,
      level: _selectedLevel,
    );
    return widget.catalog.spells
        .where(
          (spell) =>
              spell.classes.any(
                (item) =>
                    item.trim().toLowerCase() ==
                    _selectedClass.trim().toLowerCase(),
              ) &&
              spell.level <= highestSpellLevel,
        )
        .toList(growable: false)
      ..sort((left, right) {
        final byLevel = left.level.compareTo(right.level);
        if (byLevel != 0) {
          return byLevel;
        }
        return left.name.compareTo(right.name);
      });
  }

  List<CharacterSpellSlotProgression> get _spellSlotProgression =>
      _characterSpellRules.slotProgressionFor(
        className: _selectedClass,
        level: _selectedLevel,
      );

  Map<String, int> get _activeAbilityAssignments =>
      _selectedAbilityMethod == 'generatedSetAssignment'
      ? _generatedAssignments
      : _manualAssignments;

  int get _spellSelectionLimit {
    return _characterSpellRules.selectionLimitFor(
      className: _selectedClass,
      level: _selectedLevel,
      abilityModifier: CharacterRules.abilityModifier(
        _spellcastingAbilityScore,
      ),
    );
  }

  int get _spellcastingAbilityScore {
    final assignments = _activeAbilityAssignments;
    return switch (_selectedClass.trim().toLowerCase()) {
      'bard' ||
      'paladin' ||
      'sorcerer' ||
      'warlock' => assignments['Charisma'] ?? 0,
      'cleric' || 'druid' || 'ranger' => assignments['Wisdom'] ?? 0,
      'wizard' => assignments['Intelligence'] ?? 0,
      _ => 0,
    };
  }

  bool get _hasReachedSpellSelectionLimit =>
      _selectedSpellIds.length >= _spellSelectionLimit;

  void _syncSpellStateForClassLevel() {
    if (!_showsSpellSection) {
      _selectedSpellIds.clear();
      _spellSlotUsages.clear();
      return;
    }

    final allowedSpellIds = _availableSpellOptions
        .map((spell) => spell.id)
        .toSet();
    _selectedSpellIds.removeWhere(
      (spellId) => !allowedSpellIds.contains(spellId),
    );
    _trimSelectedSpellsToLimit();

    final allowedSlotLevels = _spellSlotProgression
        .map((slot) => slot.spellLevel)
        .toSet();
    _spellSlotUsages.removeWhere(
      (spellLevel, _) => !allowedSlotLevels.contains(spellLevel),
    );
    for (final slot in _spellSlotProgression) {
      final current = _spellSlotUsages[slot.spellLevel] ?? 0;
      _spellSlotUsages[slot.spellLevel] = current.clamp(0, slot.slotsMax);
    }
  }

  void _trimSelectedSpellsToLimit() {
    final selectionLimit = _spellSelectionLimit;
    if (_selectedSpellIds.length <= selectionLimit) {
      return;
    }

    final orderedSelectedIds = _availableSpellOptions
        .map((spell) => spell.id)
        .where(_selectedSpellIds.contains)
        .take(selectionLimit)
        .toSet();
    _selectedSpellIds
      ..clear()
      ..addAll(orderedSelectedIds);
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final assignments = _selectedAbilityMethod == 'generatedSetAssignment'
        ? _generatedAssignments
        : _manualAssignments;

    widget.onSave(
      CreateCharacterInput(
        name: _nameController.text.trim(),
        raceName: _selectedRace,
        backgroundId: _selectedBackground.id,
        backgroundName: _selectedBackground.name,
        backgroundSummary: _selectedBackground.summary,
        abilityScoreMethod: _selectedAbilityMethod,
        abilityScoreProvenance: _buildAbilityProvenance(assignments),
        strength: assignments['Strength']!,
        dexterity: assignments['Dexterity']!,
        constitution: assignments['Constitution']!,
        intelligence: assignments['Intelligence']!,
        wisdom: assignments['Wisdom']!,
        charisma: assignments['Charisma']!,
        className: _selectedClass,
        level: _selectedLevel,
        experience: _selectedExperience,
        equipmentLoadoutId: _selectedEquipmentLoadout.id,
        equipmentLoadoutLabel: _selectedEquipmentLoadout.label,
        startingMoneySummary: _selectedEquipmentLoadout.startingMoneySummary,
        selectedEquipmentItems: _selectedEquipmentLoadout.selectedItems,
        currentHitPoints: _currentHitPoints,
        maximumHitPoints: _maximumHitPoints,
        temporaryHitPoints: _temporaryHitPoints,
        spellState: CharacterSpellStateInput(
          selectionMode: _spellSelectionMode,
          selectedSpells: _availableSpellOptions
              .where((spell) => _selectedSpellIds.contains(spell.id))
              .map(
                (spell) => CharacterSpellSelectionInput(
                  spellId: spell.id,
                  spellName: spell.name,
                  selectionMode: _spellSelectionMode!,
                ),
              )
              .toList(growable: false),
          slotUsages: _spellSlotProgression
              .map(
                (slot) => CharacterSpellSlotUsageInput(
                  spellLevel: slot.spellLevel,
                  slotsExpended: _spellSlotUsages[slot.spellLevel] ?? 0,
                ),
              )
              .toList(growable: false),
        ),
        finishingDetails: CharacterFinishingDetailsInput(
          portraitAssetPath: _portraitAssetPath,
          appearanceDetails: _appearanceController.text.trim(),
          narrativeNotes: _narrativeNotesController.text.trim(),
          narrativeSelections: NarrativeFieldKey.values
              .map(
                (fieldKey) =>
                    _narrativeSelections[fieldKey] ??
                    NarrativeSelection.empty(fieldKey),
              )
              .toList(growable: false),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (!_hasRequiredCatalogData) {
      final missingSections = _missingCatalogSections.join(', ');
      final blockedMessage =
          widget.errorMessage ??
          'No se puede abrir la creacion guiada porque faltan datos del compendio para: '
              '$missingSections.';
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: widget.onCancel,
            icon: const Icon(Icons.arrow_back),
          ),
          title: Text(widget.screenTitle),
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Compendio incompleto',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(blockedMessage, style: theme.textTheme.bodyLarge),
                      const SizedBox(height: 20),
                      OutlinedButton(
                        onPressed: widget.onCancel,
                        child: const Text('Volver al menu'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    final equipmentOptions = widget.catalog.equipmentLoadoutsForClass(
      _selectedClass,
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: widget.isSaving ? null : widget.onCancel,
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(widget.screenTitle),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 920),
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Text(
                'Draft guiado inicial',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Este draft ya captura Background y Ability Scores y ahora se '
                'extiende hasta Equipment y Finishing details antes de persistir.',
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildIdentitySection(),
                    const SizedBox(height: 16),
                    _buildBackgroundSection(theme),
                    const SizedBox(height: 16),
                    _buildClassSection(theme),
                    const SizedBox(height: 16),
                    if (_showsSpellSection) ...[
                      _buildSpellSection(theme),
                      const SizedBox(height: 16),
                    ],
                    _buildAbilitySection(theme),
                    const SizedBox(height: 16),
                    _buildEquipmentSection(theme, equipmentOptions),
                    const SizedBox(height: 16),
                    _buildFinishingDetailsSection(theme),
                    if (widget.errorMessage != null) ...[
                      const SizedBox(height: 16),
                      Text(
                        widget.errorMessage!,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.error,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        FilledButton(
                          onPressed:
                              widget.isSaving ||
                                  !_hasSupportedEquipmentSelection
                              ? null
                              : _submit,
                          child: Text(
                            widget.isSaving ? 'Saving...' : widget.submitLabel,
                          ),
                        ),
                        OutlinedButton(
                          onPressed: widget.isSaving ? null : widget.onCancel,
                          child: const Text('Cancelar'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIdentitySection() {
    return _SectionCard(
      title: 'Race + Name',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _nameController,
            enabled: !widget.isSaving,
            decoration: const InputDecoration(
              labelText: 'Nombre del personaje',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Ingresa un nombre.';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: _selectedRace,
            decoration: const InputDecoration(
              labelText: 'Raza',
              border: OutlineInputBorder(),
            ),
            items: widget.catalog.races
                .map(
                  (race) =>
                      DropdownMenuItem<String>(value: race, child: Text(race)),
                )
                .toList(growable: false),
            onChanged: widget.isSaving
                ? null
                : (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedRace = value;
                    });
                  },
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundSection(ThemeData theme) {
    return _SectionCard(
      title: 'Background',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<CompendiumBackground>(
            initialValue: _selectedBackground,
            decoration: const InputDecoration(
              labelText: 'Background',
              border: OutlineInputBorder(),
            ),
            items: widget.catalog.backgrounds
                .map(
                  (background) => DropdownMenuItem<CompendiumBackground>(
                    value: background,
                    child: Text(background.name),
                  ),
                )
                .toList(growable: false),
            onChanged: widget.isSaving
                ? null
                : (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedBackground = value;
                      _syncNarrativeStateForBackground(
                        forceResetInvalidSelections: true,
                      );
                    });
                  },
          ),
          const SizedBox(height: 16),
          Text(_selectedBackground.summary, style: theme.textTheme.bodyLarge),
        ],
      ),
    );
  }

  Widget _buildClassSection(ThemeData theme) {
    return _SectionCard(
      title: 'Class / Level / Experience',
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            initialValue: _selectedClass,
            decoration: const InputDecoration(
              labelText: 'Clase',
              border: OutlineInputBorder(),
            ),
            items: widget.catalog.classes
                .map(
                  (characterClass) => DropdownMenuItem<String>(
                    value: characterClass,
                    child: Text(characterClass),
                  ),
                )
                .toList(growable: false),
            onChanged: widget.isSaving
                ? null
                : (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedClass = value;
                      _applyGeneratedAssignmentsForClass(value);
                      _selectedEquipmentLoadout = widget.catalog
                          .equipmentLoadoutsForClass(value)
                          .first;
                      _syncSpellStateForClassLevel();
                    });
                  },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<int>(
            initialValue: _selectedLevel,
            decoration: const InputDecoration(
              labelText: 'Nivel',
              border: OutlineInputBorder(),
            ),
            items: List<int>.generate(5, (index) => index + 1)
                .map(
                  (level) => DropdownMenuItem<int>(
                    value: level,
                    child: Text('Nivel $level'),
                  ),
                )
                .toList(growable: false),
            onChanged: widget.isSaving
                ? null
                : (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedLevel = value;
                      _selectedExperience =
                          CharacterRules.experienceFloorForLevel(value);
                      _syncSpellStateForClassLevel();
                    });
                  },
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Experience inicial: $_selectedExperience',
              style: theme.textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAbilitySection(ThemeData theme) {
    return _SectionCard(
      title: 'Ability Scores',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SegmentedButton<String>(
            segments: const [
              ButtonSegment<String>(
                value: 'generatedSetAssignment',
                label: Text('Generated set'),
              ),
              ButtonSegment<String>(
                value: 'manualPointAllocation',
                label: Text('Manual'),
              ),
            ],
            selected: <String>{_selectedAbilityMethod},
            onSelectionChanged: widget.isSaving
                ? null
                : (selection) {
                    setState(() {
                      _selectedAbilityMethod = selection.first;
                      _syncSpellStateForClassLevel();
                    });
                  },
          ),
          const SizedBox(height: 16),
          Text(
            _selectedAbilityMethod == 'generatedSetAssignment'
                ? 'Asignacion visible del set 15, 14, 13, 12, 10, 8.'
                : 'Asignacion manual inicial con valores editables por habilidad.',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          _AbilityGrid(
            abilities: _abilityOrder,
            options: _selectedAbilityMethod == 'generatedSetAssignment'
                ? widget.catalog.generatedAbilityScoreSet
                : widget.catalog.manualAbilityScoreOptions,
            values: _selectedAbilityMethod == 'generatedSetAssignment'
                ? _generatedAssignments
                : _manualAssignments,
            enabled: !widget.isSaving,
            onChanged: (ability, score) {
              setState(() {
                _activeAbilityAssignments[ability] = score;
                _syncSpellStateForClassLevel();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSpellSection(ThemeData theme) {
    final availableSpells = _availableSpellOptions;
    final slotProgression = _spellSlotProgression;
    final selectionLimit = _spellSelectionLimit;
    final selectionLabel = switch (_spellSelectionMode) {
      CharacterSpellSelectionMode.prepared => 'Prepared spells',
      CharacterSpellSelectionMode.known => 'Known spells',
      _ => 'Selected spells',
    };

    return _SectionCard(
      title: 'Spells',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Casting ability: ${_spellcastingAbilityLabelForClass(_selectedClass)}',
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: 8),
          Text(
            '$selectionLabel • ${_selectedSpellIds.length} / $selectionLimit selected',
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          if (_hasReachedSpellSelectionLimit && availableSpells.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                'Current class limit reached. Unselect a spell to choose another.',
                style: theme.textTheme.bodyMedium,
              ),
            ),
          if (availableSpells.isEmpty)
            Text(
              'No local spells available for the current class and level yet.',
              style: theme.textTheme.bodyMedium,
            )
          else
            ...availableSpells.map((spell) {
              final isSelected = _selectedSpellIds.contains(spell.id);
              final isDisabled =
                  widget.isSaving ||
                  (!isSelected && _hasReachedSpellSelectionLimit);
              return CheckboxListTile(
                value: isSelected,
                contentPadding: EdgeInsets.zero,
                title: Text(
                  spell.level == 0
                      ? '${spell.name} (Cantrip)'
                      : '${spell.name} (Level ${spell.level})',
                ),
                subtitle: Text('${spell.school} • ${spell.castingTime}'),
                onChanged: isDisabled
                    ? null
                    : (value) {
                        setState(() {
                          if (value ?? false) {
                            _selectedSpellIds.add(spell.id);
                          } else {
                            _selectedSpellIds.remove(spell.id);
                          }
                        });
                      },
              );
            }),
          const SizedBox(height: 12),
          Text('Spell slots', style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          if (slotProgression.isEmpty)
            Text(
              'No spell slots available at this level yet.',
              style: theme.textTheme.bodyMedium,
            )
          else
            ...slotProgression.map(
              (slot) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Expanded(child: Text('Level ${slot.spellLevel} slots')),
                    SizedBox(
                      width: 180,
                      child: DropdownButtonFormField<int>(
                        initialValue: _spellSlotUsages[slot.spellLevel] ?? 0,
                        decoration: InputDecoration(
                          labelText: 'Expended / ${slot.slotsMax}',
                          border: const OutlineInputBorder(),
                        ),
                        items:
                            List<int>.generate(
                                  slot.slotsMax + 1,
                                  (index) => index,
                                )
                                .map(
                                  (value) => DropdownMenuItem<int>(
                                    value: value,
                                    child: Text(value.toString()),
                                  ),
                                )
                                .toList(growable: false),
                        onChanged: widget.isSaving
                            ? null
                            : (value) {
                                if (value == null) {
                                  return;
                                }
                                setState(() {
                                  _spellSlotUsages[slot.spellLevel] = value;
                                });
                              },
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEquipmentSection(
    ThemeData theme,
    List<CompendiumEquipmentLoadout> equipmentOptions,
  ) {
    return _SectionCard(
      title: 'Equipment',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selecciona un loadout inicial basado en la clase actual.',
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: 12),
          IgnorePointer(
            ignoring: widget.isSaving,
            child: RadioGroup<String>(
              groupValue: _selectedEquipmentLoadout.id,
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                setState(() {
                  _selectedEquipmentLoadout = equipmentOptions.firstWhere(
                    (option) => option.id == value,
                  );
                });
              },
              child: Column(
                children: equipmentOptions
                    .map(
                      (loadout) => RadioListTile<String>(
                        value: loadout.id,
                        contentPadding: EdgeInsets.zero,
                        title: Text(loadout.label),
                        subtitle: Text(
                          '${loadout.startingMoneySummary}\n${loadout.selectedItems.join(', ')}',
                        ),
                      ),
                    )
                    .toList(growable: false),
              ),
            ),
          ),
          if (!_hasSupportedEquipmentSelection) ...[
            const SizedBox(height: 12),
            Text(
              'Esta clase todavia no tiene un loadout de equipo persistible. Selecciona una clase con equipo real.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFinishingDetailsSection(ThemeData theme) {
    return _SectionCard(
      title: 'Finishing details',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: _appearanceController,
            enabled: !widget.isSaving,
            maxLines: 2,
            decoration: const InputDecoration(
              labelText: 'Appearance details',
              border: OutlineInputBorder(),
              hintText: 'Edad, altura, rasgos visibles, etc.',
            ),
          ),
          const SizedBox(height: 16),
          ...NarrativeFieldKey.values.map(
            (fieldKey) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _NarrativeFieldEditor(
                fieldKey: fieldKey,
                selection:
                    _narrativeSelections[fieldKey] ??
                    NarrativeSelection.empty(fieldKey),
                groups: _groupsFor(fieldKey),
                selectedGroupId: _selectedGroupIds[fieldKey],
                enabled: !widget.isSaving,
                onModeChanged: (mode) =>
                    _onNarrativeModeChanged(fieldKey, mode),
                onGroupChanged: (groupId) =>
                    _onNarrativeGroupChanged(fieldKey, groupId),
                onRollPressed: () => _onNarrativeRollPressed(fieldKey),
                onManualOptionChanged: (optionId) =>
                    _onNarrativeOptionChanged(fieldKey, optionId),
              ),
            ),
          ),
          TextFormField(
            controller: _narrativeNotesController,
            enabled: !widget.isSaving,
            maxLines: 3,
            decoration: const InputDecoration(
              labelText: 'Notes',
              border: OutlineInputBorder(),
              hintText: 'Notas libres de compatibilidad para la hoja actual.',
            ),
          ),
        ],
      ),
    );
  }

  void _onNarrativeModeChanged(
    NarrativeFieldKey fieldKey,
    NarrativeSelectionMode mode,
  ) {
    setState(() {
      final groups = _groupsFor(fieldKey);
      final selectedGroupId =
          _selectedGroupIds[fieldKey] ??
          (groups.isNotEmpty ? groups.first.id : null);
      _selectedGroupIds[fieldKey] = selectedGroupId;

      if (mode == NarrativeSelectionMode.empty ||
          groups.isEmpty ||
          selectedGroupId == null) {
        _narrativeSelections[fieldKey] = NarrativeSelection.empty(fieldKey);
        return;
      }

      final group = groups.firstWhere((item) => item.id == selectedGroupId);
      if (mode == NarrativeSelectionMode.rolled) {
        _narrativeSelections[fieldKey] = _finishingDetailsService
            .rolledSelection(
              fieldKey: fieldKey,
              group: group,
              seed: _rollSeed(fieldKey, selectedGroupId),
            );
        return;
      }

      _narrativeSelections[fieldKey] = NarrativeSelection(
        fieldKey: fieldKey,
        mode: NarrativeSelectionMode.manual,
        valueText: null,
        groupId: selectedGroupId,
        optionId: null,
        rollValue: null,
      );
    });
  }

  void _onNarrativeGroupChanged(NarrativeFieldKey fieldKey, String groupId) {
    setState(() {
      _selectedGroupIds[fieldKey] = groupId;
      final selection =
          _narrativeSelections[fieldKey] ?? NarrativeSelection.empty(fieldKey);
      final group = _groupsFor(
        fieldKey,
      ).firstWhere((item) => item.id == groupId);

      if (selection.mode == NarrativeSelectionMode.rolled) {
        _narrativeSelections[fieldKey] = _finishingDetailsService
            .rolledSelection(
              fieldKey: fieldKey,
              group: group,
              seed: _rollSeed(fieldKey, group.id),
            );
        return;
      }

      if (selection.mode == NarrativeSelectionMode.manual) {
        _narrativeSelections[fieldKey] = NarrativeSelection(
          fieldKey: fieldKey,
          mode: NarrativeSelectionMode.manual,
          valueText: null,
          groupId: groupId,
          optionId: null,
          rollValue: null,
        );
      }
    });
  }

  void _onNarrativeRollPressed(NarrativeFieldKey fieldKey) {
    final group = _finishingDetailsService.groupById(
      catalog: widget.catalog,
      fieldKey: fieldKey,
      backgroundId: _selectedBackground.id,
      groupId: _selectedGroupIds[fieldKey],
    );
    if (group == null) {
      return;
    }
    setState(() {
      _narrativeSelections[fieldKey] = _finishingDetailsService.rolledSelection(
        fieldKey: fieldKey,
        group: group,
        seed: _rollSeed(fieldKey, group.id),
      );
    });
  }

  void _onNarrativeOptionChanged(NarrativeFieldKey fieldKey, String? optionId) {
    final group = _finishingDetailsService.groupById(
      catalog: widget.catalog,
      fieldKey: fieldKey,
      backgroundId: _selectedBackground.id,
      groupId: _selectedGroupIds[fieldKey],
    );
    if (group == null || optionId == null) {
      return;
    }
    final option = _finishingDetailsService.optionById(
      group: group,
      optionId: optionId,
    );
    if (option == null) {
      return;
    }
    setState(() {
      _narrativeSelections[fieldKey] = _finishingDetailsService.manualSelection(
        fieldKey: fieldKey,
        group: group,
        option: option,
      );
    });
  }
}

String _spellcastingAbilityLabelForClass(String className) {
  return switch (className.trim().toLowerCase()) {
    'bard' || 'paladin' || 'sorcerer' || 'warlock' => 'Charisma',
    'cleric' || 'druid' || 'ranger' => 'Wisdom',
    'wizard' => 'Intelligence',
    _ => 'Unknown',
  };
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.title, required this.child});

  final String title;
  final Widget child;

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
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

class _AbilityGrid extends StatelessWidget {
  const _AbilityGrid({
    required this.abilities,
    required this.options,
    required this.values,
    required this.enabled,
    required this.onChanged,
  });

  final List<String> abilities;
  final List<int> options;
  final Map<String, int> values;
  final bool enabled;
  final void Function(String ability, int score) onChanged;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: abilities
          .map(
            (ability) => SizedBox(
              width: 190,
              child: DropdownButtonFormField<int>(
                key: ValueKey<String>(
                  '$ability-${values[ability]}-${options.join(",")}',
                ),
                initialValue: values[ability],
                decoration: InputDecoration(
                  labelText: ability,
                  border: const OutlineInputBorder(),
                ),
                items: options
                    .map(
                      (score) => DropdownMenuItem<int>(
                        value: score,
                        child: Text(score.toString()),
                      ),
                    )
                    .toList(growable: false),
                onChanged: enabled
                    ? (value) {
                        if (value == null) {
                          return;
                        }
                        onChanged(ability, value);
                      }
                    : null,
              ),
            ),
          )
          .toList(growable: false),
    );
  }
}

class _NarrativeFieldEditor extends StatelessWidget {
  const _NarrativeFieldEditor({
    required this.fieldKey,
    required this.selection,
    required this.groups,
    required this.selectedGroupId,
    required this.enabled,
    required this.onModeChanged,
    required this.onGroupChanged,
    required this.onRollPressed,
    required this.onManualOptionChanged,
  });

  final NarrativeFieldKey fieldKey;
  final NarrativeSelection selection;
  final List<CompendiumNarrativeOptionGroup> groups;
  final String? selectedGroupId;
  final bool enabled;
  final ValueChanged<NarrativeSelectionMode> onModeChanged;
  final ValueChanged<String> onGroupChanged;
  final VoidCallback onRollPressed;
  final ValueChanged<String?> onManualOptionChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedGroup = groups
        .cast<CompendiumNarrativeOptionGroup?>()
        .firstWhere(
          (group) => group?.id == selectedGroupId,
          orElse: () => groups.isNotEmpty ? groups.first : null,
        );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outlineVariant),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fieldKey.label,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          SegmentedButton<NarrativeSelectionMode>(
            segments: NarrativeSelectionMode.values
                .map(
                  (mode) => ButtonSegment<NarrativeSelectionMode>(
                    value: mode,
                    label: Text(mode.label),
                  ),
                )
                .toList(growable: false),
            selected: <NarrativeSelectionMode>{selection.mode},
            onSelectionChanged: enabled
                ? (selectionSet) => onModeChanged(selectionSet.first)
                : null,
          ),
          if (groups.isEmpty) ...[
            const SizedBox(height: 12),
            Text(
              'No hay opciones oficiales cargadas para este campo con el background actual.',
              style: theme.textTheme.bodyMedium,
            ),
          ] else ...[
            const SizedBox(height: 12),
            if (groups.length > 1) ...[
              DropdownButtonFormField<String>(
                initialValue: selectedGroup?.id,
                decoration: const InputDecoration(
                  labelText: 'Official source',
                  border: OutlineInputBorder(),
                ),
                items: groups
                    .map(
                      (group) => DropdownMenuItem<String>(
                        value: group.id,
                        child: Text(group.title),
                      ),
                    )
                    .toList(growable: false),
                onChanged: enabled
                    ? (value) {
                        if (value == null) {
                          return;
                        }
                        onGroupChanged(value);
                      }
                    : null,
              ),
              const SizedBox(height: 12),
            ] else
              Text(
                'Official source: ${groups.first.title}',
                style: theme.textTheme.bodyMedium,
              ),
            if (selection.mode == NarrativeSelectionMode.rolled) ...[
              const SizedBox(height: 12),
              FilledButton.tonal(
                onPressed: enabled ? onRollPressed : null,
                child: const Text('Roll from official options'),
              ),
              if (selection.hasValue) ...[
                const SizedBox(height: 8),
                Text(selection.valueText!, style: theme.textTheme.bodyLarge),
              ],
            ],
            if (selection.mode == NarrativeSelectionMode.manual) ...[
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: selection.optionId,
                decoration: const InputDecoration(
                  labelText: 'Official option',
                  border: OutlineInputBorder(),
                ),
                items:
                    (selectedGroup?.options ??
                            const <CompendiumNarrativeOption>[])
                        .map(
                          (option) => DropdownMenuItem<String>(
                            value: option.id,
                            child: Text(option.label ?? option.text),
                          ),
                        )
                        .toList(growable: false),
                onChanged: enabled ? onManualOptionChanged : null,
              ),
              if (selection.hasValue) ...[
                const SizedBox(height: 8),
                Text(selection.valueText!, style: theme.textTheme.bodyLarge),
              ],
            ],
          ],
        ],
      ),
    );
  }
}

bool _isPlaceholderEquipmentItem(String item) {
  final normalized = item.trim().toLowerCase();
  return normalized.contains('pending');
}
