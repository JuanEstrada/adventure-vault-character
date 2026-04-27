import 'package:adventure_vault_character/src/features/characters/domain/character_finishing_details.dart';
import 'package:adventure_vault_character/src/features/characters/domain/deterministic_roller.dart';
import 'package:adventure_vault_character/src/features/compendium/domain/compendium_catalog.dart';

class FinishingDetailsService {
  const FinishingDetailsService({
    DeterministicRoller deterministicRoller = const HashDeterministicRoller(),
  }) : _deterministicRoller = deterministicRoller;

  final DeterministicRoller _deterministicRoller;

  List<CompendiumNarrativeOptionGroup> availableGroups({
    required CompendiumCatalog catalog,
    required NarrativeFieldKey fieldKey,
    required String? backgroundId,
  }) {
    final backgroundGroups = backgroundId == null || backgroundId.trim().isEmpty
        ? const <CompendiumNarrativeOptionGroup>[]
        : catalog.narrativeGroupsForBackground(
            backgroundId,
            fieldKey.storageKey,
          );
    if (backgroundGroups.isNotEmpty) {
      return backgroundGroups;
    }
    return catalog.narrativeGroupsForField(fieldKey.storageKey);
  }

  NarrativeSelection emptySelection(NarrativeFieldKey fieldKey) {
    return NarrativeSelection.empty(fieldKey);
  }

  NarrativeSelection manualSelection({
    required NarrativeFieldKey fieldKey,
    required CompendiumNarrativeOptionGroup group,
    required CompendiumNarrativeOption option,
  }) {
    _validateOptionBelongsToGroup(group: group, option: option);
    return NarrativeSelection(
      fieldKey: fieldKey,
      mode: NarrativeSelectionMode.manual,
      valueText: option.text,
      groupId: group.id,
      optionId: option.id,
      rollValue: null,
    );
  }

  NarrativeSelection rolledSelection({
    required NarrativeFieldKey fieldKey,
    required CompendiumNarrativeOptionGroup group,
    required String seed,
  }) {
    if (group.options.isEmpty) {
      return NarrativeSelection.empty(fieldKey);
    }

    final sides = _rollSidesForGroup(group);
    final rollValue = _deterministicRoller.roll(
      seed: '$seed|${fieldKey.storageKey}|${group.id}',
      sides: sides,
    );
    final option = _optionForRoll(group: group, rollValue: rollValue);

    return NarrativeSelection(
      fieldKey: fieldKey,
      mode: NarrativeSelectionMode.rolled,
      valueText: option.text,
      groupId: group.id,
      optionId: option.id,
      rollValue: rollValue,
    );
  }

  CompendiumNarrativeOptionGroup? groupById({
    required CompendiumCatalog catalog,
    required NarrativeFieldKey fieldKey,
    required String? backgroundId,
    required String? groupId,
  }) {
    if (groupId == null || groupId.trim().isEmpty) {
      return null;
    }
    for (final group in availableGroups(
      catalog: catalog,
      fieldKey: fieldKey,
      backgroundId: backgroundId,
    )) {
      if (group.id == groupId) {
        return group;
      }
    }
    return null;
  }

  CompendiumNarrativeOption? optionById({
    required CompendiumNarrativeOptionGroup group,
    required String? optionId,
  }) {
    if (optionId == null || optionId.trim().isEmpty) {
      return null;
    }
    for (final option in group.options) {
      if (option.id == optionId) {
        return option;
      }
    }
    return null;
  }

  List<NarrativeFieldAvailability> availabilityForBackground({
    required CompendiumCatalog catalog,
    required String? backgroundId,
  }) {
    return NarrativeFieldKey.values
        .map((fieldKey) {
          final groups = availableGroups(
            catalog: catalog,
            fieldKey: fieldKey,
            backgroundId: backgroundId,
          );
          return NarrativeFieldAvailability(
            fieldKey: fieldKey,
            groupIds: groups.map((group) => group.id).toList(growable: false),
            hasOptions: groups.any((group) => group.options.isNotEmpty),
          );
        })
        .toList(growable: false);
  }

  int _rollSidesForGroup(CompendiumNarrativeOptionGroup group) {
    final raw = group.diceFormula;
    if (raw == null || raw.trim().isEmpty) {
      return group.options.length;
    }

    final match = RegExp(r'1d(\d+)', caseSensitive: false).firstMatch(raw);
    final parsed = int.tryParse(match?.group(1) ?? '');
    if (parsed == null || parsed < 1) {
      return group.options.length;
    }
    return parsed;
  }

  CompendiumNarrativeOption _optionForRoll({
    required CompendiumNarrativeOptionGroup group,
    required int rollValue,
  }) {
    for (final option in group.options) {
      final rollMin = option.rollMin;
      final rollMax = option.rollMax;
      if (rollMin != null && rollMax != null) {
        if (rollValue >= rollMin && rollValue <= rollMax) {
          return option;
        }
      } else if (option.optionIndex == rollValue) {
        return option;
      }
    }

    return group.options[(rollValue - 1) % group.options.length];
  }

  void _validateOptionBelongsToGroup({
    required CompendiumNarrativeOptionGroup group,
    required CompendiumNarrativeOption option,
  }) {
    final matches = group.options.any((candidate) => candidate.id == option.id);
    if (!matches) {
      throw StateError(
        'Selected narrative option does not belong to the group.',
      );
    }
  }
}
