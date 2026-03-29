import 'package:adventure_vault_character/src/features/characters/domain/create_character_input.dart';
import 'package:flutter/foundation.dart';

@immutable
class CharacterSpellSlotProgression {
  const CharacterSpellSlotProgression({
    required this.spellLevel,
    required this.slotsMax,
  });

  final int spellLevel;
  final int slotsMax;
}

class CharacterSpellRules {
  const CharacterSpellRules();

  static const Map<String, CharacterSpellSelectionMode> _selectionModeByClass =
      <String, CharacterSpellSelectionMode>{
        'bard': CharacterSpellSelectionMode.known,
        'cleric': CharacterSpellSelectionMode.prepared,
        'druid': CharacterSpellSelectionMode.prepared,
        'paladin': CharacterSpellSelectionMode.prepared,
        'ranger': CharacterSpellSelectionMode.known,
        'sorcerer': CharacterSpellSelectionMode.known,
        'warlock': CharacterSpellSelectionMode.known,
        'wizard': CharacterSpellSelectionMode.spellbook,
      };

  static const Map<int, List<int>> _fullCasterSlots = <int, List<int>>{
    1: <int>[2],
    2: <int>[3],
    3: <int>[4, 2],
    4: <int>[4, 3],
    5: <int>[4, 3, 2],
    6: <int>[4, 3, 3],
    7: <int>[4, 3, 3, 1],
    8: <int>[4, 3, 3, 2],
    9: <int>[4, 3, 3, 3, 1],
    10: <int>[4, 3, 3, 3, 2],
    11: <int>[4, 3, 3, 3, 2, 1],
    12: <int>[4, 3, 3, 3, 2, 1],
    13: <int>[4, 3, 3, 3, 2, 1, 1],
    14: <int>[4, 3, 3, 3, 2, 1, 1],
    15: <int>[4, 3, 3, 3, 2, 1, 1, 1],
    16: <int>[4, 3, 3, 3, 2, 1, 1, 1],
    17: <int>[4, 3, 3, 3, 2, 1, 1, 1, 1],
    18: <int>[4, 3, 3, 3, 3, 1, 1, 1, 1],
    19: <int>[4, 3, 3, 3, 3, 2, 1, 1, 1],
    20: <int>[4, 3, 3, 3, 3, 2, 2, 1, 1],
  };

  static const Map<int, List<int>> _halfCasterSlots = <int, List<int>>{
    1: <int>[],
    2: <int>[2],
    3: <int>[3],
    4: <int>[3],
    5: <int>[4, 2],
    6: <int>[4, 2],
    7: <int>[4, 3],
    8: <int>[4, 3],
    9: <int>[4, 3, 2],
    10: <int>[4, 3, 2],
    11: <int>[4, 3, 3],
    12: <int>[4, 3, 3],
    13: <int>[4, 3, 3, 1],
    14: <int>[4, 3, 3, 1],
    15: <int>[4, 3, 3, 2],
    16: <int>[4, 3, 3, 2],
    17: <int>[4, 3, 3, 3, 1],
    18: <int>[4, 3, 3, 3, 1],
    19: <int>[4, 3, 3, 3, 2],
    20: <int>[4, 3, 3, 3, 2],
  };

  static const Map<int, CharacterSpellSlotProgression> _warlockPactSlots =
      <int, CharacterSpellSlotProgression>{
        1: CharacterSpellSlotProgression(spellLevel: 1, slotsMax: 1),
        2: CharacterSpellSlotProgression(spellLevel: 1, slotsMax: 2),
        3: CharacterSpellSlotProgression(spellLevel: 2, slotsMax: 2),
        4: CharacterSpellSlotProgression(spellLevel: 2, slotsMax: 2),
        5: CharacterSpellSlotProgression(spellLevel: 3, slotsMax: 2),
        6: CharacterSpellSlotProgression(spellLevel: 3, slotsMax: 2),
        7: CharacterSpellSlotProgression(spellLevel: 4, slotsMax: 2),
        8: CharacterSpellSlotProgression(spellLevel: 4, slotsMax: 2),
        9: CharacterSpellSlotProgression(spellLevel: 5, slotsMax: 2),
        10: CharacterSpellSlotProgression(spellLevel: 5, slotsMax: 2),
        11: CharacterSpellSlotProgression(spellLevel: 5, slotsMax: 3),
        12: CharacterSpellSlotProgression(spellLevel: 5, slotsMax: 3),
        13: CharacterSpellSlotProgression(spellLevel: 5, slotsMax: 3),
        14: CharacterSpellSlotProgression(spellLevel: 5, slotsMax: 3),
        15: CharacterSpellSlotProgression(spellLevel: 5, slotsMax: 3),
        16: CharacterSpellSlotProgression(spellLevel: 5, slotsMax: 3),
        17: CharacterSpellSlotProgression(spellLevel: 5, slotsMax: 4),
        18: CharacterSpellSlotProgression(spellLevel: 5, slotsMax: 4),
        19: CharacterSpellSlotProgression(spellLevel: 5, slotsMax: 4),
        20: CharacterSpellSlotProgression(spellLevel: 5, slotsMax: 4),
      };

  static const Map<int, int> _bardKnownSpellsByLevel = <int, int>{
    1: 2,
    2: 3,
    3: 4,
    4: 5,
    5: 6,
    6: 7,
    7: 8,
    8: 9,
    9: 10,
    10: 11,
    11: 12,
    12: 14,
    13: 15,
    14: 15,
    15: 16,
    16: 18,
    17: 19,
    18: 20,
    19: 22,
    20: 22,
  };

  static const Map<int, int> _rangerKnownSpellsByLevel = <int, int>{
    1: 0,
    2: 2,
    3: 3,
    4: 3,
    5: 4,
    6: 4,
    7: 5,
    8: 5,
    9: 6,
    10: 6,
    11: 7,
    12: 7,
    13: 8,
    14: 8,
    15: 9,
    16: 9,
    17: 10,
    18: 10,
    19: 11,
    20: 11,
  };

  static const Map<int, int> _sorcererKnownSpellsByLevel = <int, int>{
    1: 2,
    2: 3,
    3: 4,
    4: 5,
    5: 6,
    6: 7,
    7: 8,
    8: 9,
    9: 10,
    10: 11,
    11: 12,
    12: 12,
    13: 13,
    14: 13,
    15: 14,
    16: 14,
    17: 15,
    18: 15,
    19: 15,
    20: 15,
  };

  static const Map<int, int> _warlockKnownSpellsByLevel = <int, int>{
    1: 2,
    2: 3,
    3: 4,
    4: 5,
    5: 6,
    6: 7,
    7: 8,
    8: 9,
    9: 10,
    10: 10,
    11: 11,
    12: 11,
    13: 12,
    14: 12,
    15: 13,
    16: 13,
    17: 14,
    18: 14,
    19: 15,
    20: 15,
  };

  bool supportsPersistentSpellState(String className) =>
      selectionModeForClass(className) != null;

  CharacterSpellSelectionMode? selectionModeForClass(String className) =>
      _selectionModeByClass[_normalizeClassName(className)];

  List<CharacterSpellSlotProgression> slotProgressionFor({
    required String className,
    required int level,
  }) {
    final normalized = _normalizeClassName(className);
    if (normalized == 'warlock') {
      final pactSlot = _warlockPactSlots[level];
      if (pactSlot == null) {
        return const <CharacterSpellSlotProgression>[];
      }
      return List<CharacterSpellSlotProgression>.unmodifiable(
        <CharacterSpellSlotProgression>[pactSlot],
      );
    }

    final slots =
        normalized == 'bard' ||
            normalized == 'cleric' ||
            normalized == 'druid' ||
            normalized == 'sorcerer' ||
            normalized == 'wizard'
        ? (_fullCasterSlots[level] ?? const <int>[])
        : normalized == 'paladin' || normalized == 'ranger'
        ? (_halfCasterSlots[level] ?? const <int>[])
        : const <int>[];

    final progression = slots
        .asMap()
        .entries
        .where((entry) => entry.value > 0)
        .map(
          (entry) => CharacterSpellSlotProgression(
            spellLevel: entry.key + 1,
            slotsMax: entry.value,
          ),
        )
        .toList(growable: false);
    return List<CharacterSpellSlotProgression>.unmodifiable(progression);
  }

  int highestCastableSpellLevel({
    required String className,
    required int level,
  }) {
    final progression = slotProgressionFor(className: className, level: level);
    if (progression.isEmpty) {
      return 0;
    }
    return progression.last.spellLevel;
  }

  Map<int, int> resetSlotUsagesForShortRest({
    required String className,
    required int level,
    required Map<int, int> currentUsages,
  }) {
    final normalized = _normalizeClassName(className);
    if (normalized != 'warlock') {
      return Map<int, int>.unmodifiable(currentUsages);
    }

    final slots = slotProgressionFor(className: className, level: level);
    return Map<int, int>.unmodifiable(<int, int>{
      for (final slot in slots) slot.spellLevel: 0,
    });
  }

  Map<int, int> resetSlotUsagesForLongRest({
    required String className,
    required int level,
  }) {
    final slots = slotProgressionFor(className: className, level: level);
    return Map<int, int>.unmodifiable(<int, int>{
      for (final slot in slots) slot.spellLevel: 0,
    });
  }

  int selectionLimitFor({
    required String className,
    required int level,
    required int abilityModifier,
  }) {
    final normalized = _normalizeClassName(className);
    return switch (normalized) {
      'bard' => _bardKnownSpellsByLevel[level] ?? 0,
      'ranger' => _rangerKnownSpellsByLevel[level] ?? 0,
      'sorcerer' => _sorcererKnownSpellsByLevel[level] ?? 0,
      'warlock' => _warlockKnownSpellsByLevel[level] ?? 0,
      'cleric' || 'druid' || 'wizard' => _preparedLimit(
        baseCount: level,
        abilityModifier: abilityModifier,
      ),
      'paladin' => _preparedLimit(
        baseCount: level ~/ 2,
        abilityModifier: abilityModifier,
      ),
      _ => 0,
    };
  }

  int _preparedLimit({required int baseCount, required int abilityModifier}) {
    return (baseCount + abilityModifier).clamp(1, 999);
  }

  String _normalizeClassName(String raw) => raw.trim().toLowerCase();
}
