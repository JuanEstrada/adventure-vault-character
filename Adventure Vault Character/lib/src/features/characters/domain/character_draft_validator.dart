import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:flutter/foundation.dart';

@immutable
class CharacterDraftValidationResult {
  const CharacterDraftValidationResult.valid()
    : missingSections = const <String>[];

  const CharacterDraftValidationResult.invalid(this.missingSections);

  final List<String> missingSections;

  bool get isValid => missingSections.isEmpty;

  String toUserMessage() {
    if (isValid) {
      return '';
    }

    return 'Faltan o son invalidas estas secciones: '
        '${missingSections.join(', ')}.';
  }
}

class CharacterDraftValidator {
  const CharacterDraftValidator();

  CharacterDraftValidationResult validate(CreateCharacterInput input) {
    final missingSections = <String>[];

    if (input.name.trim().isEmpty || input.raceName.trim().isEmpty) {
      missingSections.add('Race + name');
    }

    if (input.backgroundId.trim().isEmpty ||
        input.backgroundName.trim().isEmpty ||
        input.backgroundSummary.trim().isEmpty) {
      missingSections.add('Background');
    }

    if (!_isAbilitySectionValid(input)) {
      missingSections.add('Ability scores');
    }

    if (!_isClassProgressionSectionValid(input)) {
      missingSections.add('Class / level / experience');
    }

    return missingSections.isEmpty
        ? const CharacterDraftValidationResult.valid()
        : CharacterDraftValidationResult.invalid(
            List<String>.unmodifiable(missingSections),
          );
  }

  bool _isAbilitySectionValid(CreateCharacterInput input) {
    if (input.abilityScoreMethod.trim().isEmpty ||
        input.abilityScoreProvenance.trim().isEmpty) {
      return false;
    }

    const minimumScore = 1;
    final scores = <int>[
      input.strength,
      input.dexterity,
      input.constitution,
      input.intelligence,
      input.wisdom,
      input.charisma,
    ];

    return scores.every((score) => score >= minimumScore);
  }

  bool _isClassProgressionSectionValid(CreateCharacterInput input) {
    if (input.className.trim().isEmpty) {
      return false;
    }

    if (input.level < 1) {
      return false;
    }

    if (input.experience < 0) {
      return false;
    }

    if (input.currentHitPoints < 0 ||
        input.maximumHitPoints < 0 ||
        input.temporaryHitPoints < 0) {
      return false;
    }

    if (input.currentHitPoints > input.maximumHitPoints) {
      return false;
    }

    return true;
  }
}
