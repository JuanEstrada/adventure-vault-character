import 'package:flutter/foundation.dart';

@immutable
class CharacterSummary {
  const CharacterSummary({
    required this.id,
    required this.name,
    required this.raceName,
    required this.className,
    required this.level,
    this.portraitAssetPath,
  });

  final String id;
  final String name;
  final String raceName;
  final String className;
  final int level;
  final String? portraitAssetPath;
}
