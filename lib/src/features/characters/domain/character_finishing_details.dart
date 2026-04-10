import 'package:flutter/foundation.dart';

enum NarrativeFieldKey {
  alignment,
  faction,
  personalityTraits,
  ideals,
  bonds,
  flaws,
}

extension NarrativeFieldKeyX on NarrativeFieldKey {
  String get storageKey {
    return switch (this) {
      NarrativeFieldKey.alignment => 'alignment',
      NarrativeFieldKey.faction => 'faction',
      NarrativeFieldKey.personalityTraits => 'personality_traits',
      NarrativeFieldKey.ideals => 'ideals',
      NarrativeFieldKey.bonds => 'bonds',
      NarrativeFieldKey.flaws => 'flaws',
    };
  }

  String get label {
    return switch (this) {
      NarrativeFieldKey.alignment => 'Alignment',
      NarrativeFieldKey.faction => 'Faction',
      NarrativeFieldKey.personalityTraits => 'Personality traits',
      NarrativeFieldKey.ideals => 'Ideals',
      NarrativeFieldKey.bonds => 'Bonds',
      NarrativeFieldKey.flaws => 'Flaws',
    };
  }

  static NarrativeFieldKey? fromStorageKey(String raw) {
    for (final value in NarrativeFieldKey.values) {
      if (value.storageKey == raw) {
        return value;
      }
    }
    return null;
  }
}

enum NarrativeSelectionMode { empty, rolled, manual }

extension NarrativeSelectionModeX on NarrativeSelectionMode {
  String get storageKey {
    return switch (this) {
      NarrativeSelectionMode.empty => 'empty',
      NarrativeSelectionMode.rolled => 'rolled',
      NarrativeSelectionMode.manual => 'manual',
    };
  }

  String get label {
    return switch (this) {
      NarrativeSelectionMode.empty => 'Empty',
      NarrativeSelectionMode.rolled => 'Rolled',
      NarrativeSelectionMode.manual => 'Manual',
    };
  }

  static NarrativeSelectionMode? fromStorageKey(String raw) {
    for (final value in NarrativeSelectionMode.values) {
      if (value.storageKey == raw) {
        return value;
      }
    }
    return null;
  }
}

@immutable
class NarrativeSelection {
  const NarrativeSelection({
    required this.fieldKey,
    required this.mode,
    required this.valueText,
    this.groupId,
    this.optionId,
    this.rollValue,
  });

  const NarrativeSelection.empty(this.fieldKey)
    : mode = NarrativeSelectionMode.empty,
      valueText = null,
      groupId = null,
      optionId = null,
      rollValue = null;

  final NarrativeFieldKey fieldKey;
  final NarrativeSelectionMode mode;
  final String? valueText;
  final String? groupId;
  final String? optionId;
  final int? rollValue;

  bool get hasValue => valueText != null && valueText!.trim().isNotEmpty;

  NarrativeSelection copyWith({
    NarrativeSelectionMode? mode,
    String? valueText,
    String? groupId,
    String? optionId,
    int? rollValue,
    bool clearValueText = false,
    bool clearGroupId = false,
    bool clearOptionId = false,
    bool clearRollValue = false,
  }) {
    return NarrativeSelection(
      fieldKey: fieldKey,
      mode: mode ?? this.mode,
      valueText: clearValueText ? null : valueText ?? this.valueText,
      groupId: clearGroupId ? null : groupId ?? this.groupId,
      optionId: clearOptionId ? null : optionId ?? this.optionId,
      rollValue: clearRollValue ? null : rollValue ?? this.rollValue,
    );
  }
}

@immutable
class CharacterFinishingDetailsInput {
  const CharacterFinishingDetailsInput({
    required this.appearanceDetails,
    required this.narrativeNotes,
    required this.narrativeSelections,
    this.portraitAssetPath,
  });

  factory CharacterFinishingDetailsInput.empty({
    String? portraitAssetPath,
    String appearanceDetails = '',
    String narrativeNotes = '',
  }) {
    return CharacterFinishingDetailsInput(
      portraitAssetPath: portraitAssetPath,
      appearanceDetails: appearanceDetails,
      narrativeNotes: narrativeNotes,
      narrativeSelections: NarrativeFieldKey.values
          .map(NarrativeSelection.empty)
          .toList(growable: false),
    );
  }

  final String? portraitAssetPath;
  final String appearanceDetails;
  final String narrativeNotes;
  final List<NarrativeSelection> narrativeSelections;

  NarrativeSelection selectionFor(NarrativeFieldKey fieldKey) {
    for (final selection in narrativeSelections) {
      if (selection.fieldKey == fieldKey) {
        return selection;
      }
    }
    return NarrativeSelection.empty(fieldKey);
  }

  String? valueFor(NarrativeFieldKey fieldKey) {
    final value = selectionFor(fieldKey).valueText;
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    return value;
  }

  CharacterFinishingDetailsInput copyWith({
    String? portraitAssetPath,
    String? appearanceDetails,
    String? narrativeNotes,
    List<NarrativeSelection>? narrativeSelections,
    bool clearPortraitAssetPath = false,
  }) {
    return CharacterFinishingDetailsInput(
      portraitAssetPath: clearPortraitAssetPath
          ? null
          : portraitAssetPath ?? this.portraitAssetPath,
      appearanceDetails: appearanceDetails ?? this.appearanceDetails,
      narrativeNotes: narrativeNotes ?? this.narrativeNotes,
      narrativeSelections: narrativeSelections ?? this.narrativeSelections,
    );
  }
}

@immutable
class NarrativeFieldAvailability {
  const NarrativeFieldAvailability({
    required this.fieldKey,
    required this.groupIds,
    required this.hasOptions,
  });

  final NarrativeFieldKey fieldKey;
  final List<String> groupIds;
  final bool hasOptions;
}
