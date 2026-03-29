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
        'wizard': CharacterSpellSelectionMode.prepared,
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

  bool supportsPersistentSpellState(String className) =>
      selectionModeForClass(className) != null;

  CharacterSpellSelectionMode? selectionModeForClass(String className) =>
      _selectionModeByClass[_normalizeClassName(className)];

  List<CharacterSpellSlotProgression> slotProgressionFor({
    required String className,
    required int level,
  }) {
    final normalized = _normalizeClassName(className);
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

  String _normalizeClassName(String raw) => raw.trim().toLowerCase();
}
