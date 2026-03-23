import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:flutter/material.dart';

class CreateCharacterScreen extends StatefulWidget {
  const CreateCharacterScreen({
    required this.catalog,
    required this.isSaving,
    required this.errorMessage,
    required this.onCancel,
    required this.onSave,
    super.key,
  });

  final CompendiumCatalog catalog;
  final bool isSaving;
  final String? errorMessage;
  final VoidCallback onCancel;
  final ValueChanged<CreateCharacterInput> onSave;

  @override
  State<CreateCharacterScreen> createState() => _CreateCharacterScreenState();
}

class _CreateCharacterScreenState extends State<CreateCharacterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _appearanceController = TextEditingController();
  final _narrativeController = TextEditingController();
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

  late String _selectedRace;
  late CompendiumBackground _selectedBackground;
  String _selectedAbilityMethod = 'generatedSetAssignment';
  late String _selectedClass;
  int _selectedLevel = 1;
  String _selectedAlignment = 'Neutral';
  late CompendiumEquipmentLoadout _selectedEquipmentLoadout;

  static const List<String> _abilityOrder = <String>[
    'Strength',
    'Dexterity',
    'Constitution',
    'Intelligence',
    'Wisdom',
    'Charisma',
  ];

  static const List<String> _alignments = <String>[
    'Lawful Good',
    'Neutral Good',
    'Chaotic Good',
    'Lawful Neutral',
    'Neutral',
    'Chaotic Neutral',
    'Lawful Evil',
    'Neutral Evil',
    'Chaotic Evil',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _appearanceController.dispose();
    _narrativeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _selectedRace = widget.catalog.races.first;
    _selectedBackground = widget.catalog.backgrounds.first;
    _selectedClass = widget.catalog.classes.first;
    _selectedEquipmentLoadout = widget.catalog
        .equipmentLoadoutsForClass(_selectedClass)
        .first;
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
        experience: (_selectedLevel - 1) * 300,
        equipmentLoadoutId: _selectedEquipmentLoadout.id,
        equipmentLoadoutLabel: _selectedEquipmentLoadout.label,
        startingMoneySummary: _selectedEquipmentLoadout.startingMoneySummary,
        selectedEquipmentItems: _selectedEquipmentLoadout.selectedItems,
        currentHitPoints: 10,
        maximumHitPoints: 10,
        temporaryHitPoints: 0,
        alignment: _selectedAlignment,
        appearanceDetails: _appearanceController.text.trim(),
        narrativeDetails: _narrativeController.text.trim(),
      ),
    );
  }

  String _buildAbilityProvenance(Map<String, int> assignments) {
    final values = _abilityOrder
        .map((ability) => '$ability=${assignments[ability]}')
        .join(';');
    return 'method=$_selectedAbilityMethod;$values';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final equipmentOptions = widget.catalog.equipmentLoadoutsForClass(
      _selectedClass,
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: widget.isSaving ? null : widget.onCancel,
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Crear personaje'),
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
                    _SectionCard(
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
                                  (race) => DropdownMenuItem<String>(
                                    value: race,
                                    child: Text(race),
                                  ),
                                )
                                .toList(growable: false),
                            onChanged: widget.isSaving
                                ? null
                                : (value) {
                                    if (value == null) return;
                                    setState(() {
                                      _selectedRace = value;
                                    });
                                  },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _SectionCard(
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
                                  (background) =>
                                      DropdownMenuItem<CompendiumBackground>(
                                        value: background,
                                        child: Text(background.name),
                                      ),
                                )
                                .toList(growable: false),
                            onChanged: widget.isSaving
                                ? null
                                : (value) {
                                    if (value == null) return;
                                    setState(() {
                                      _selectedBackground = value;
                                    });
                                  },
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _selectedBackground.summary,
                            style: theme.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _SectionCard(
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
                            options:
                                _selectedAbilityMethod ==
                                    'generatedSetAssignment'
                                ? widget.catalog.generatedAbilityScoreSet
                                : widget.catalog.manualAbilityScoreOptions,
                            values:
                                _selectedAbilityMethod ==
                                    'generatedSetAssignment'
                                ? _generatedAssignments
                                : _manualAssignments,
                            enabled: !widget.isSaving,
                            onChanged: (ability, score) {
                              setState(() {
                                final target =
                                    _selectedAbilityMethod ==
                                        'generatedSetAssignment'
                                    ? _generatedAssignments
                                    : _manualAssignments;
                                target[ability] = score;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _SectionCard(
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
                                    if (value == null) return;
                                    setState(() {
                                      _selectedClass = value;
                                      _selectedEquipmentLoadout = widget.catalog
                                          .equipmentLoadoutsForClass(value)
                                          .first;
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
                                    if (value == null) return;
                                    setState(() {
                                      _selectedLevel = value;
                                    });
                                  },
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Experience inicial: ${(_selectedLevel - 1) * 300}',
                              style: theme.textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _SectionCard(
                      title: 'Equipment',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Selecciona un loadout inicial basado en la clase actual.',
                            style: theme.textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 12),
                          ...equipmentOptions.map(
                            (loadout) => RadioListTile<String>(
                              value: loadout.id,
                              groupValue: _selectedEquipmentLoadout.id,
                              contentPadding: EdgeInsets.zero,
                              title: Text(loadout.label),
                              subtitle: Text(
                                '${loadout.startingMoneySummary}\n${loadout.selectedItems.join(', ')}',
                              ),
                              onChanged: widget.isSaving
                                  ? null
                                  : (value) {
                                      if (value == null) return;
                                      setState(() {
                                        _selectedEquipmentLoadout =
                                            equipmentOptions.firstWhere(
                                              (option) => option.id == value,
                                            );
                                      });
                                    },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    _SectionCard(
                      title: 'Finishing details',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DropdownButtonFormField<String>(
                            initialValue: _selectedAlignment,
                            decoration: const InputDecoration(
                              labelText: 'Alignment',
                              border: OutlineInputBorder(),
                            ),
                            items: _alignments
                                .map(
                                  (alignment) => DropdownMenuItem<String>(
                                    value: alignment,
                                    child: Text(alignment),
                                  ),
                                )
                                .toList(growable: false),
                            onChanged: widget.isSaving
                                ? null
                                : (value) {
                                    if (value == null) return;
                                    setState(() {
                                      _selectedAlignment = value;
                                    });
                                  },
                          ),
                          const SizedBox(height: 16),
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
                          TextFormField(
                            controller: _narrativeController,
                            enabled: !widget.isSaving,
                            maxLines: 3,
                            decoration: const InputDecoration(
                              labelText: 'Narrative details',
                              border: OutlineInputBorder(),
                              hintText:
                                  'Traits, ideals, bonds, flaws o notas breves.',
                            ),
                          ),
                        ],
                      ),
                    ),
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
                          onPressed: widget.isSaving ? null : _submit,
                          child: Text(
                            widget.isSaving ? 'Guardando...' : 'Guardar draft',
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
                        if (value == null) return;
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
