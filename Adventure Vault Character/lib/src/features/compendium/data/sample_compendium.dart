import 'package:adventure_vault_character/src/features/characters/domain/character_sheet_view_data.dart';

const List<String> kSampleRaceOptions = <String>[
  'Human',
  'Dragonborn (Black)',
  'Elf',
  'Dwarf',
  'Halfling',
];

const List<String> kSampleClassOptions = <String>[
  'Fighter',
  'Ranger',
  'Wizard',
  'Rogue',
  'Cleric',
];

const List<int> kGeneratedAbilityScoreSet = <int>[15, 14, 13, 12, 10, 8];

const List<int> kManualAbilityScoreOptions = <int>[8, 9, 10, 11, 12, 13, 14, 15];

const List<SampleBackgroundOption> kSampleBackgroundOptions =
    <SampleBackgroundOption>[
  SampleBackgroundOption(
    id: 'acolyte',
    name: 'Acolyte',
    summary:
        'Has servido en un templo y actuas como intermediario entre lo sagrado y el mundo mortal.',
    bonuses: <String>[
      'Skills: Insight, Religion',
      'Languages: any two of your choice',
    ],
    socialPerks: <String>[
      'Shelter of the Faithful',
      'Temple support',
    ],
  ),
  SampleBackgroundOption(
    id: 'soldier',
    name: 'Soldier',
    summary:
        'Tu entrenamiento militar te da disciplina, presencia y experiencia siguiendo cadenas de mando.',
    bonuses: <String>[
      'Chain of command',
      'Martial routine',
    ],
    socialPerks: <String>[
      'Barracks familiarity',
      'Veteran rapport',
    ],
  ),
  SampleBackgroundOption(
    id: 'wanderer',
    name: 'Wanderer',
    summary:
        'Pasaste anos en camino, resolviendo problemas con recursos limitados y trato con desconocidos.',
    bonuses: <String>[
      'Pathfinding',
      'Travel resilience',
    ],
    socialPerks: <String>[
      'Road gossip',
      'Campfire trust',
    ],
  ),
];

class SampleBackgroundOption {
  const SampleBackgroundOption({
    required this.id,
    required this.name,
    required this.summary,
    required this.bonuses,
    required this.socialPerks,
  });

  final String id;
  final String name;
  final String summary;
  final List<String> bonuses;
  final List<String> socialPerks;
}

SampleBackgroundOption? findSampleBackgroundById(String? id) {
  for (final background in kSampleBackgroundOptions) {
    if (background.id == id) {
      return background;
    }
  }
  return null;
}

EquipmentSummaryViewData equipmentSummaryForClass(String className) {
  return switch (className) {
    'Fighter' => const EquipmentSummaryViewData(
        statusLabel: 'MVP minimal',
        description:
            'La hoja ya reserva un espacio para el loadout del personaje, con foco futuro en armas, armadura y gear.',
        highlightItems: <String>[
          'Weapon loadout pending',
          'Armor summary pending',
          'Gear list pending',
        ],
      ),
    'Wizard' => const EquipmentSummaryViewData(
        statusLabel: 'MVP minimal',
        description:
            'El detalle de implementos arcanos y gear inicial sigue pendiente de mapeo completo en la hoja.',
        highlightItems: <String>[
          'Arcane focus pending',
          'Gear list pending',
        ],
      ),
    _ => const EquipmentSummaryViewData(
        statusLabel: 'MVP minimal',
        description:
            'Equipment sigue como panel controlado mientras el flujo de seleccion y persistencia se expande.',
        highlightItems: <String>[
          'Equipment mapping pending',
        ],
      ),
  };
}
