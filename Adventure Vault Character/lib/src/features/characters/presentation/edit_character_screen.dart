import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:adventure_vault_character/src/features/characters/presentation/character_editor_controller.dart';
import 'package:adventure_vault_character/src/features/characters/presentation/create_character_screen.dart';
import 'package:flutter/material.dart';

class EditCharacterScreen extends StatelessWidget {
  const EditCharacterScreen({
    required this.controller,
    required this.isSaving,
    required this.errorMessage,
    required this.onCancel,
    required this.onSave,
    super.key,
  });

  final CharacterEditorController controller;
  final bool isSaving;
  final String? errorMessage;
  final VoidCallback onCancel;
  final ValueChanged<CreateCharacterInput> onSave;

  @override
  Widget build(BuildContext context) {
    return CreateCharacterScreen(
      catalog: controller.catalog,
      isSaving: isSaving,
      errorMessage: errorMessage,
      onCancel: onCancel,
      onSave: (input) {
        controller.replaceDraft(input);
        onSave(input);
      },
      initialDraft: controller.draft,
      screenTitle: 'Edit character',
      submitLabel: 'Save changes',
    );
  }
}
