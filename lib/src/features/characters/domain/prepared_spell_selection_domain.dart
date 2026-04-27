import 'package:flutter/foundation.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_domain_model.dart';

/// Prepared spell selection result
@immutable
class PreparedSpellSelectionResult {
  const PreparedSpellSelectionResult({
    required this.spells,
    required this.selectedSpells,
    required this.spellCount,
  });

  final List<CharacterSpellReferenceDomainModel> spells;
  final List<CharacterSpellReferenceDomainModel> selectedSpells;
  final int spellCount;

  String get selectionSummary =>
      '${selectedSpells.length} / ${spells.length} selected';
}

/// Service for prepared spell selection (cleric, paladin, druid, bard)
class PreparedSpellSelectionService {
  const PreparedSpellSelectionService();

  /// Select/deselect a prepared spell
  /// Returns: (updatedSpells, success, error)
  PreparedSpellSelectionResult? selectSpell(
    List<CharacterSpellReferenceDomainModel> currentSpells,
    CharacterSpellReferenceDomainModel spell,
  ) {
    final index = currentSpells.indexWhere((s) => s.id == spell.id);

    if (index != -1) {
      // Spell already selected, remove it
      final updated = <CharacterSpellReferenceDomainModel>[
        ...currentSpells.where((s) => s.id != spell.id),
      ];
      return PreparedSpellSelectionResult(
        spells: updated,
        selectedSpells: updated,
        spellCount: updated.length,
      );
    }

    // Add new spell
    final updated = <CharacterSpellReferenceDomainModel>[
      ...currentSpells,
      spell,
    ];
    return PreparedSpellSelectionResult(
      spells: updated,
      selectedSpells: updated,
      spellCount: updated.length,
    );
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

  /// Check if spell can be selected (not already selected)
  bool canSelectSpell(
    List<CharacterSpellReferenceDomainModel> currentSpells,
    CharacterSpellReferenceDomainModel spell,
  ) {
    for (final s in currentSpells) {
      if (s.id == spell.id) {
        return false;
      }
    }
    return true;
  }
}
