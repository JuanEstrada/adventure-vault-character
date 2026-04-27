import 'package:flutter/foundation.dart';

/// Mode for wizard spellbook spell selection
enum WizardSpellSelectionMode {
  /// Select spells to prepare (limited by level)
  prepared,

  /// Select spells to know (no limit)
  known,
}

/// A wizard's spellbook containing prepared spells
@immutable
class CharacterSpellbookDomainModel {
  const CharacterSpellbookDomainModel({
    required this.spells,
    this.spellSelectionMode = WizardSpellSelectionMode.prepared,
    this.selectionLimit = 0,
  });

  final List<CharacterSpellReferenceDomainModel> spells;
  final WizardSpellSelectionMode spellSelectionMode;
  final int selectionLimit;

  int get spellCount => spells.length;

  String get displayModeLabel {
    switch (spellSelectionMode) {
      case WizardSpellSelectionMode.prepared:
        return 'Prepared spells';
      case WizardSpellSelectionMode.known:
        return 'Known spells';
    }
  }

  String get selectionSummary =>
      '$spellCount / ${selectionLimit > 0 ? selectionLimit : '∞'}';
}

@immutable
class CharacterSpellReferenceDomainModel {
  const CharacterSpellReferenceDomainModel({
    required this.id,
    required this.name,
    required this.level,
    required this.school,
    required this.castingTime,
    required this.range,
    required this.duration,
    required this.source,
  });

  final String id;
  final String name;
  final int level;
  final String school;
  final String castingTime;
  final String range;
  final String duration;
  final String source;

  bool get isCantrip => level == 0;

  String get levelLabel => isCantrip ? 'Cantrip' : 'Level $level';
}

/// Spell selection result for wizard spellbook
class SpellSelectionResult {
  const SpellSelectionResult({required this.spells, required this.spellCount});

  final List<CharacterSpellReferenceDomainModel> spells;
  final int spellCount;
}

/// Spellbook management service for wizard spellbook operations
class CharacterSpellbookService {
  const CharacterSpellbookService();

  /// Add a spell to the wizard's spellbook
  /// Returns: (newSpells, success, error)
  SpellSelectionResult? addSpell(
    List<CharacterSpellReferenceDomainModel> currentSpells,
    CharacterSpellReferenceDomainModel spell,
    int selectionLimit,
    WizardSpellSelectionMode mode,
  ) {
    if (mode == WizardSpellSelectionMode.prepared) {
      if (spell.selectionLimitExceeds(currentSpells, selectionLimit)) {
        return null;
      }
    }

    final updated = <CharacterSpellReferenceDomainModel>[
      ...currentSpells,
      spell,
    ];

    return SpellSelectionResult(spells: updated, spellCount: updated.length);
  }

  /// Remove a spell from the wizard's spellbook
  SpellSelectionResult? removeSpell(
    List<CharacterSpellReferenceDomainModel> currentSpells,
    String spellId,
  ) {
    final index = currentSpells.indexWhere((spell) => spell.id == spellId);

    if (index == -1) {
      return null;
    }

    final updated = <CharacterSpellReferenceDomainModel>[
      ...currentSpells.where((s) => s.id != spellId),
    ];

    return SpellSelectionResult(spells: updated, spellCount: updated.length);
  }

  /// Get spells grouped by level
  Map<int, List<CharacterSpellReferenceDomainModel>> getSpellsByLevel(
    List<CharacterSpellReferenceDomainModel> spells,
  ) {
    final byLevel = <int, List<CharacterSpellReferenceDomainModel>>{};

    for (final spell in spells) {
      byLevel
          .putIfAbsent(
            spell.level,
            () => <CharacterSpellReferenceDomainModel>[],
          )
          .add(spell);
    }

    return byLevel;
  }

  /// Check if adding a spell would exceed limits
  bool spellSelectionLimitExceeds(
    List<CharacterSpellReferenceDomainModel> currentSpells,
    CharacterSpellReferenceDomainModel newSpell,
    int selectionLimit,
    WizardSpellSelectionMode mode,
  ) {
    if (mode != WizardSpellSelectionMode.prepared) {
      return false;
    }

    final currentCount = currentSpells.length;
    final wouldBeCount = currentCount + 1;

    return wouldBeCount > selectionLimit;
  }
}

extension on CharacterSpellReferenceDomainModel {
  bool selectionLimitExceeds(
    List<CharacterSpellReferenceDomainModel> currentSpells,
    int selectionLimit,
  ) {
    final currentCount = currentSpells.length;
    final wouldBeCount = currentCount + 1;

    return wouldBeCount > selectionLimit;
  }
}
