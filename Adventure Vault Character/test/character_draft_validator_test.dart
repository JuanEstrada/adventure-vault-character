import 'package:adventure_vault_character/src/features/characters/domain/character_draft_validator.dart';
import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const validator = CharacterDraftValidator();

  test('validator accepts a complete draft', () {
    final result = validator.validate(_validInput());

    expect(result.isValid, isTrue);
    expect(result.missingSections, isEmpty);
  });

  test('validator reports missing sections with user-facing names', () {
    final result = validator.validate(
      _validInput(
        name: '',
        backgroundId: '',
        abilityScoreMethod: '',
        className: '',
      ),
    );

    expect(result.isValid, isFalse);
    expect(
      result.missingSections,
      containsAll(<String>[
        'Race + name',
        'Background',
        'Ability scores',
        'Class / level / experience',
      ]),
    );
  });
}

CreateCharacterInput _validInput({
  String name = 'Aelar',
  String raceName = 'Human',
  String backgroundId = 'scholar',
  String backgroundName = 'Scholar',
  String backgroundSummary = 'Learns and researches.',
  String abilityScoreMethod = 'generatedSetAssignment',
  String abilityScoreProvenance = 'method=generatedSetAssignment',
  int strength = 15,
  int dexterity = 14,
  int constitution = 13,
  int intelligence = 12,
  int wisdom = 10,
  int charisma = 8,
  String className = 'Fighter',
  int level = 1,
  int experience = 0,
  int currentHitPoints = 10,
  int maximumHitPoints = 10,
  int temporaryHitPoints = 0,
}) {
  return CreateCharacterInput(
    name: name,
    raceName: raceName,
    backgroundId: backgroundId,
    backgroundName: backgroundName,
    backgroundSummary: backgroundSummary,
    abilityScoreMethod: abilityScoreMethod,
    abilityScoreProvenance: abilityScoreProvenance,
    strength: strength,
    dexterity: dexterity,
    constitution: constitution,
    intelligence: intelligence,
    wisdom: wisdom,
    charisma: charisma,
    className: className,
    level: level,
    experience: experience,
    currentHitPoints: currentHitPoints,
    maximumHitPoints: maximumHitPoints,
    temporaryHitPoints: temporaryHitPoints,
  );
}
