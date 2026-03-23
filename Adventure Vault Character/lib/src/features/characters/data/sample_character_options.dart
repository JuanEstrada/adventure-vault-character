const List<String> kSampleRaceOptions = <String>[
  'Human',
  'Elf',
  'Dwarf',
  'Halfling',
];

const List<String> kSampleClassOptions = <String>[
  'Fighter',
  'Wizard',
  'Rogue',
  'Cleric',
];

const List<SampleBackgroundOption> kSampleBackgroundOptions =
    <SampleBackgroundOption>[
  SampleBackgroundOption(
    id: 'scholar',
    name: 'Scholar',
    summary:
        'Aprendiste a investigar, recordar detalles y moverte con soltura en archivos y bibliotecas.',
  ),
  SampleBackgroundOption(
    id: 'soldier',
    name: 'Soldier',
    summary:
        'Tu entrenamiento militar te da disciplina, presencia y experiencia siguiendo cadenas de mando.',
  ),
  SampleBackgroundOption(
    id: 'wanderer',
    name: 'Wanderer',
    summary:
        'Pasaste anos en camino, resolviendo problemas con recursos limitados y trato con desconocidos.',
  ),
];

const List<int> kGeneratedAbilityScoreSet = <int>[15, 14, 13, 12, 10, 8];

const List<int> kManualAbilityScoreOptions = <int>[8, 9, 10, 11, 12, 13, 14, 15];

class SampleBackgroundOption {
  const SampleBackgroundOption({
    required this.id,
    required this.name,
    required this.summary,
  });

  final String id;
  final String name;
  final String summary;
}
