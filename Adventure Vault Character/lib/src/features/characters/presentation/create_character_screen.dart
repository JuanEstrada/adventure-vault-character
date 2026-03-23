import 'package:adventure_vault_character/src/features/characters/data/sample_character_options.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:flutter/material.dart';

class CreateCharacterScreen extends StatefulWidget {
  const CreateCharacterScreen({
    required this.isSaving,
    required this.errorMessage,
    required this.onCancel,
    required this.onSave,
    super.key,
  });

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

  String _selectedRace = kSampleRaceOptions.first;
  String _selectedClass = kSampleClassOptions.first;
  int _selectedLevel = 1;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    widget.onSave(
      CreateCharacterInput(
        name: _nameController.text.trim(),
        raceName: _selectedRace,
        className: _selectedClass,
        level: _selectedLevel,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
          constraints: const BoxConstraints(maxWidth: 760),
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              Text(
                'Slice minimo de creacion',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Este flujo guarda nombre, raza, clase y nivel en Drift para '
                'completar el recorrido crear -> guardar -> card -> sheet.',
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
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
                          textInputAction: TextInputAction.done,
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
                          items: kSampleRaceOptions
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
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          initialValue: _selectedClass,
                          decoration: const InputDecoration(
                            labelText: 'Clase',
                            border: OutlineInputBorder(),
                          ),
                          items: kSampleClassOptions
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
                                widget.isSaving
                                    ? 'Guardando...'
                                    : 'Guardar personaje',
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
