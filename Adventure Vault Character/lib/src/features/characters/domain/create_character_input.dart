import 'package:flutter/foundation.dart';

@immutable
class CreateCharacterInput {
  const CreateCharacterInput({
    required this.name,
    required this.raceName,
    required this.className,
    required this.level,
    this.portraitAssetPath,
  });

  final String name;
  final String raceName;
  final String className;
  final int level;
  final String? portraitAssetPath;
}
