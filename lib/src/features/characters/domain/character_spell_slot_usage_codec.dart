class CharacterSpellSlotUsageCodec {
  const CharacterSpellSlotUsageCodec._();

  static int expendedCountFromSerialized(String serialized) {
    final trimmed = serialized.trim();
    if (trimmed.isEmpty) {
      return 0;
    }

    final parts = trimmed
        .split(',')
        .map((value) => value.trim())
        .where((value) => value.isNotEmpty)
        .toList(growable: false);
    if (parts.isEmpty) {
      return 0;
    }
    if (parts.length > 1) {
      return parts.length;
    }

    final parsed = int.tryParse(parts.single);
    if (parsed == null || parsed <= 0) {
      return 0;
    }
    return parsed;
  }

  static bool hasExplicitIndices(String serialized) {
    return serialized.contains(',');
  }

  static List<String> explicitIndicesFromSerialized(String serialized) {
    final trimmed = serialized.trim();
    if (trimmed.isEmpty) {
      return const <String>[];
    }

    if (trimmed.contains(',')) {
      return trimmed
          .split(',')
          .map((value) => value.trim())
          .where((value) => value.isNotEmpty)
          .toList(growable: false);
    }

    final count = int.tryParse(trimmed);
    if (count == null || count <= 0) {
      return const <String>[];
    }

    return List<String>.generate(count, (index) => index.toString());
  }

  static String serializeInputIndices(List<String> indices) {
    final cleaned = indices
        .map((value) => value.trim())
        .where((value) => value.isNotEmpty)
        .toSet()
        .toList(growable: false);
    if (cleaned.isEmpty) {
      return '';
    }
    if (cleaned.length == 1) {
      return cleaned.single == '0' ? '' : cleaned.single;
    }

    cleaned.sort(_compareNumericStrings);
    return cleaned.join(',');
  }

  static String serializeUpdatedIndices({
    required String? currentSerialized,
    required int expendedCount,
  }) {
    if (expendedCount <= 0) {
      return '';
    }
    if (expendedCount == 1) {
      return '1';
    }

    final current = currentSerialized?.trim() ?? '';
    if (current.isNotEmpty &&
        expendedCountFromSerialized(current) == expendedCount) {
      return current;
    }

    return List<String>.generate(
      expendedCount,
      (index) => index.toString(),
    ).join(',');
  }

  static int _compareNumericStrings(String left, String right) {
    final leftValue = int.tryParse(left);
    final rightValue = int.tryParse(right);
    if (leftValue != null && rightValue != null) {
      return leftValue.compareTo(rightValue);
    }
    return left.compareTo(right);
  }
}
