enum CharacterResourceRecoveryCadence { shortOrLongRest, longRest }

class CharacterClassResourceDefinition {
  const CharacterClassResourceDefinition({
    required this.resourceKey,
    required this.label,
    required this.maximumUses,
    required this.recoveryCadence,
  });

  final String resourceKey;
  final String label;
  final int maximumUses;
  final CharacterResourceRecoveryCadence recoveryCadence;

  bool get recoversOnShortRest =>
      recoveryCadence == CharacterResourceRecoveryCadence.shortOrLongRest;
}

class CharacterClassResourceRules {
  const CharacterClassResourceRules();

  List<CharacterClassResourceDefinition> resourcesFor({
    required String className,
    required int level,
  }) {
    final normalizedClassName = className.trim().toLowerCase();
    final clampedLevel = level.clamp(1, 20);
    return switch (normalizedClassName) {
      'barbarian' => <CharacterClassResourceDefinition>[
        CharacterClassResourceDefinition(
          resourceKey: 'rage',
          label: 'Rage',
          maximumUses: _barbarianRagesForLevel(clampedLevel),
          recoveryCadence: CharacterResourceRecoveryCadence.longRest,
        ),
      ],
      'monk' => <CharacterClassResourceDefinition>[
        CharacterClassResourceDefinition(
          resourceKey: 'ki-points',
          label: 'Ki points',
          maximumUses: clampedLevel,
          recoveryCadence: CharacterResourceRecoveryCadence.shortOrLongRest,
        ),
      ],
      'cleric' => <CharacterClassResourceDefinition>[
        CharacterClassResourceDefinition(
          resourceKey: 'channel-divinity',
          label: 'Channel Divinity',
          maximumUses: _clericChannelDivinityForLevel(clampedLevel),
          recoveryCadence: CharacterResourceRecoveryCadence.shortOrLongRest,
        ),
      ],
      'druid' => const <CharacterClassResourceDefinition>[
        CharacterClassResourceDefinition(
          resourceKey: 'wild-shape',
          label: 'Wild Shape',
          maximumUses: 2,
          recoveryCadence: CharacterResourceRecoveryCadence.shortOrLongRest,
        ),
      ],
      _ => const <CharacterClassResourceDefinition>[],
    };
  }

  bool supportsShortRestRecovery({
    required String className,
    required int level,
  }) {
    return resourcesFor(
      className: className,
      level: level,
    ).any((resource) => resource.recoversOnShortRest);
  }

  int _barbarianRagesForLevel(int level) {
    if (level >= 17) {
      return 6;
    }
    if (level >= 12) {
      return 5;
    }
    if (level >= 6) {
      return 4;
    }
    if (level >= 3) {
      return 3;
    }
    return 2;
  }

  int _clericChannelDivinityForLevel(int level) {
    if (level >= 18) {
      return 3;
    }
    if (level >= 6) {
      return 2;
    }
    return 1;
  }
}
