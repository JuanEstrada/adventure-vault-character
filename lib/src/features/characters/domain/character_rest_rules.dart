import 'package:adventure_vault_character/src/features/characters/domain/character_spell_rules.dart';

class CharacterRestResult {
  const CharacterRestResult({
    required this.currentHitPoints,
    required this.maximumHitPoints,
    required this.temporaryHitPoints,
    required this.slotUsagesByLevel,
  });

  final int currentHitPoints;
  final int maximumHitPoints;
  final int temporaryHitPoints;
  final Map<int, int> slotUsagesByLevel;
}

class CharacterRestRules {
  const CharacterRestRules({
    CharacterSpellRules characterSpellRules = const CharacterSpellRules(),
  }) : _characterSpellRules = characterSpellRules;

  final CharacterSpellRules _characterSpellRules;

  CharacterRestResult applyShortRest({
    required String className,
    required int level,
    required int currentHitPoints,
    required int maximumHitPoints,
    required int temporaryHitPoints,
    required Map<int, int> slotUsagesByLevel,
  }) {
    return CharacterRestResult(
      currentHitPoints: currentHitPoints.clamp(0, maximumHitPoints),
      maximumHitPoints: maximumHitPoints,
      temporaryHitPoints: temporaryHitPoints,
      slotUsagesByLevel: _characterSpellRules.resetSlotUsagesForShortRest(
        className: className,
        level: level,
        currentUsages: slotUsagesByLevel,
      ),
    );
  }

  CharacterRestResult applyLongRest({
    required String className,
    required int level,
    required int maximumHitPoints,
  }) {
    return CharacterRestResult(
      currentHitPoints: maximumHitPoints,
      maximumHitPoints: maximumHitPoints,
      temporaryHitPoints: 0,
      slotUsagesByLevel: _characterSpellRules.resetSlotUsagesForLongRest(
        className: className,
        level: level,
      ),
    );
  }
}
