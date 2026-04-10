import 'dart:convert';

class CharacterArmorClassResult {
  const CharacterArmorClassResult({
    required this.armorClass,
    required this.hasArmorConflict,
  });

  final int armorClass;
  final bool hasArmorConflict;
}

class CharacterArmorProfile {
  const CharacterArmorProfile({
    required this.name,
    required this.isEquipped,
    this.category,
    this.armorPropertiesJson,
  });

  final String name;
  final bool isEquipped;
  final String? category;
  final String? armorPropertiesJson;
}

class CharacterWeaponProfile {
  const CharacterWeaponProfile({
    required this.name,
    required this.isEquipped,
    this.category,
    this.subcategory,
    this.weaponPropertiesJson,
  });

  final String name;
  final bool isEquipped;
  final String? category;
  final String? subcategory;
  final String? weaponPropertiesJson;
}

class CharacterWeaponAttackResult {
  const CharacterWeaponAttackResult({
    required this.name,
    required this.attackAbilityKey,
    required this.attackBonus,
    required this.damageModifier,
    required this.isProficient,
    this.damageDice,
    this.damageType,
  });

  final String name;
  final String attackAbilityKey;
  final int attackBonus;
  final int damageModifier;
  final bool isProficient;
  final String? damageDice;
  final String? damageType;
}

class CharacterDeathSaveTransitionResult {
  const CharacterDeathSaveTransitionResult({
    required this.successCount,
    required this.failureCount,
  });

  final int successCount;
  final int failureCount;
}

class CharacterCombatRules {
  const CharacterCombatRules();

  int deriveInitiativeModifier({required int dexterityModifier}) {
    return dexterityModifier;
  }

  CharacterArmorClassResult deriveArmorClass({
    required int dexterityModifier,
    required List<CharacterArmorProfile> equippedItems,
  }) {
    final equipped = equippedItems.where((item) => item.isEquipped).toList();
    final parsed = equipped
        .map(_parseArmorPiece)
        .whereType<_ArmorPiece>()
        .toList(growable: false);

    final wornArmor = parsed.where((piece) => !piece.isShield).toList();
    final shieldBonus = parsed
        .where((piece) => piece.isShield)
        .fold<int>(0, (total, piece) => total + piece.bonusArmorClass);

    final baseUnarmoredArmorClass = 10 + dexterityModifier;
    var armorClassFromArmor = baseUnarmoredArmorClass;
    if (wornArmor.isNotEmpty) {
      armorClassFromArmor = wornArmor
          .map((piece) => piece.armorClassFor(dexterityModifier))
          .reduce((best, next) => best >= next ? best : next);
    }

    return CharacterArmorClassResult(
      armorClass: armorClassFromArmor + shieldBonus,
      hasArmorConflict: wornArmor.length > 1,
    );
  }

  List<CharacterWeaponAttackResult> deriveWeaponAttacks({
    required int strengthModifier,
    required int dexterityModifier,
    required int proficiencyBonus,
    required Set<String> weaponProficiencyKeys,
    required List<CharacterWeaponProfile> equippedItems,
  }) {
    final normalizedProficiencies = weaponProficiencyKeys
        .map(_normalizeProficiencyKey)
        .where((value) => value.isNotEmpty)
        .toSet();

    return equippedItems
        .where((item) => item.isEquipped)
        .map(_parseWeaponPiece)
        .whereType<_WeaponPiece>()
        .map((weapon) {
          final attackAbilityKey = _selectAttackAbility(
            strengthModifier: strengthModifier,
            dexterityModifier: dexterityModifier,
            weapon: weapon,
          );
          final attackAbilityModifier = attackAbilityKey == 'dex'
              ? dexterityModifier
              : strengthModifier;
          final isProficient = _isWeaponProficient(
            weapon: weapon,
            normalizedProficiencies: normalizedProficiencies,
          );
          return CharacterWeaponAttackResult(
            name: weapon.name,
            attackAbilityKey: attackAbilityKey,
            attackBonus:
                attackAbilityModifier +
                (isProficient ? proficiencyBonus : 0) +
                weapon.attackBonusModifier,
            damageModifier: attackAbilityModifier + weapon.damageBonusModifier,
            isProficient: isProficient,
            damageDice: weapon.damageDice,
            damageType: weapon.damageType,
          );
        })
        .toList(growable: false);
  }

  CharacterDeathSaveTransitionResult registerSuccess({
    required int successCount,
    required int failureCount,
  }) {
    final normalized = _normalizeDeathSaveCounts(
      successCount: successCount,
      failureCount: failureCount,
    );
    if (normalized.successCount >= 3 || normalized.failureCount >= 3) {
      return normalized;
    }

    return CharacterDeathSaveTransitionResult(
      successCount: (normalized.successCount + 1).clamp(0, 3),
      failureCount: normalized.failureCount,
    );
  }

  CharacterDeathSaveTransitionResult registerFailure({
    required int successCount,
    required int failureCount,
  }) {
    final normalized = _normalizeDeathSaveCounts(
      successCount: successCount,
      failureCount: failureCount,
    );
    if (normalized.successCount >= 3 || normalized.failureCount >= 3) {
      return normalized;
    }

    return CharacterDeathSaveTransitionResult(
      successCount: normalized.successCount,
      failureCount: (normalized.failureCount + 1).clamp(0, 3),
    );
  }

  CharacterDeathSaveTransitionResult resetDeathSaves() {
    return const CharacterDeathSaveTransitionResult(
      successCount: 0,
      failureCount: 0,
    );
  }

  CharacterDeathSaveTransitionResult _normalizeDeathSaveCounts({
    required int successCount,
    required int failureCount,
  }) {
    return CharacterDeathSaveTransitionResult(
      successCount: successCount.clamp(0, 3),
      failureCount: failureCount.clamp(0, 3),
    );
  }

  _ArmorPiece? _parseArmorPiece(CharacterArmorProfile profile) {
    final normalizedName = profile.name.trim().toLowerCase();
    final fromJson = _parseArmorPieceFromJson(
      profile.armorPropertiesJson,
      fallbackName: normalizedName,
    );
    if (fromJson != null) {
      return fromJson;
    }

    return _parseArmorPieceFromName(normalizedName);
  }

  _WeaponPiece? _parseWeaponPiece(CharacterWeaponProfile profile) {
    final normalizedName = profile.name.trim().toLowerCase();
    final fromJson = _parseWeaponPieceFromJson(
      profile.weaponPropertiesJson,
      fallbackName: profile.name,
      category: profile.category,
      subcategory: profile.subcategory,
    );
    if (fromJson != null) {
      return fromJson;
    }

    final fromName = _parseWeaponPieceFromName(profile.name);
    if (fromName != null) {
      return fromName;
    }

    final normalizedCategory = profile.category?.trim().toLowerCase();
    if (normalizedCategory == 'weapon') {
      return _WeaponPiece(
        name: profile.name,
        weaponCategory: _normalizeWeaponCategory(profile.subcategory),
        isRanged: _looksRangedWeapon(normalizedName),
        isFinesse: normalizedName.contains('finesse'),
      );
    }

    return null;
  }

  _WeaponPiece? _parseWeaponPieceFromJson(
    String? rawJson, {
    required String fallbackName,
    String? category,
    String? subcategory,
  }) {
    if (rawJson == null || rawJson.trim().isEmpty) {
      return null;
    }

    try {
      final decoded = jsonDecode(rawJson);
      if (decoded is! Map<String, dynamic>) {
        return null;
      }

      final normalized = <String, dynamic>{
        for (final entry in decoded.entries)
          entry.key.trim().toLowerCase(): entry.value,
      };
      final properties = _readStringList(normalized, const <String>[
        'properties',
        'weaponproperties',
        'weapon_properties',
      ]);
      final isFinesse =
          _readBool(normalized, const <String>['isfinesse', 'is_finesse']) ||
          properties.contains('finesse');
      final isRanged =
          _readBool(normalized, const <String>['isranged', 'is_ranged']) ||
          _readString(normalized, const <String>['range', 'range_text']) !=
              null ||
          properties.contains('ranged') ||
          properties.contains('ammunition');
      final abilityKey = _normalizeAbilityKey(
        _readString(normalized, const <String>[
          'attackability',
          'attack_ability',
          'ability',
        ]),
      );
      final categoryFromJson = _normalizeWeaponCategory(
        _readString(normalized, const <String>[
          'weaponcategory',
          'weapon_category',
          'weapongroup',
          'weapon_group',
          'proficiencygroup',
          'proficiency_group',
          'category',
          'type',
        ]),
      );
      final damageDice =
          _extractDamageDiceFromMap(normalized) ??
          _extractDamageDice(properties);
      final damageType = _readString(normalized, const <String>[
        'damagetype',
        'damage_type',
      ]);
      final attackBonusModifier = _readInt(normalized, const <String>[
        'attackbonus',
        'attack_bonus',
        'tohitbonus',
        'to_hit_bonus',
      ]);
      final damageBonusModifier = _readInt(normalized, const <String>[
        'damagebonus',
        'damage_bonus',
        'damagemodifier',
        'damage_modifier',
      ]);
      final proficiencyKey = _readString(normalized, const <String>[
        'proficiencykey',
        'proficiency_key',
      ]);
      final explicitWeaponType = _readString(normalized, const <String>[
        'type',
        'category',
      ]);
      final isWeapon =
          explicitWeaponType == 'weapon' ||
          category?.trim().toLowerCase() == 'weapon' ||
          damageDice != null;
      if (!isWeapon) {
        return null;
      }

      return _WeaponPiece(
        name: fallbackName,
        weaponCategory:
            categoryFromJson ?? _normalizeWeaponCategory(subcategory),
        isRanged: isRanged,
        isFinesse: isFinesse,
        abilityOverrideKey: abilityKey,
        attackBonusModifier: attackBonusModifier ?? 0,
        damageBonusModifier: damageBonusModifier ?? 0,
        damageDice: damageDice,
        damageType: damageType,
        proficiencyKey: proficiencyKey,
      );
    } catch (_) {
      return null;
    }
  }

  _WeaponPiece? _parseWeaponPieceFromName(String name) {
    final normalizedName = name.trim().toLowerCase();
    for (final entry in _weaponByName.entries) {
      if (normalizedName.contains(entry.key)) {
        return entry.value.copyWith(name: name);
      }
    }

    if (_looksWeaponLikeName(normalizedName)) {
      return _WeaponPiece(
        name: name,
        isRanged: _looksRangedWeapon(normalizedName),
        isFinesse: normalizedName.contains('finesse'),
      );
    }

    return null;
  }

  bool _looksWeaponLikeName(String normalizedName) {
    return normalizedName.contains('sword') ||
        normalizedName.contains('axe') ||
        normalizedName.contains('mace') ||
        normalizedName.contains('staff') ||
        normalizedName.contains('club') ||
        normalizedName.contains('hammer') ||
        normalizedName.contains('spear') ||
        normalizedName.contains('bow') ||
        normalizedName.contains('crossbow') ||
        normalizedName.contains('sling') ||
        normalizedName.contains('dagger') ||
        normalizedName.contains('javelin') ||
        normalizedName.contains('dart') ||
        normalizedName.contains('whip') ||
        normalizedName.contains('flail') ||
        normalizedName.contains('halberd') ||
        normalizedName.contains('glaive') ||
        normalizedName.contains('pike') ||
        normalizedName.contains('trident');
  }

  bool _looksRangedWeapon(String normalizedName) {
    return normalizedName.contains('bow') ||
        normalizedName.contains('crossbow') ||
        normalizedName.contains('sling') ||
        normalizedName.contains('dart');
  }

  String _selectAttackAbility({
    required int strengthModifier,
    required int dexterityModifier,
    required _WeaponPiece weapon,
  }) {
    if (weapon.abilityOverrideKey != null) {
      return weapon.abilityOverrideKey!;
    }
    if (weapon.isFinesse) {
      return dexterityModifier >= strengthModifier ? 'dex' : 'str';
    }
    if (weapon.isRanged) {
      return 'dex';
    }
    return 'str';
  }

  bool _isWeaponProficient({
    required _WeaponPiece weapon,
    required Set<String> normalizedProficiencies,
  }) {
    if (normalizedProficiencies.isEmpty) {
      return false;
    }

    final normalizedName = _normalizeProficiencyKey(weapon.name);
    final singularName = normalizedName.endsWith('s')
        ? normalizedName.substring(0, normalizedName.length - 1)
        : normalizedName;
    if (normalizedProficiencies.contains(normalizedName) ||
        normalizedProficiencies.contains(singularName)) {
      return true;
    }

    final directKey = weapon.proficiencyKey;
    if (directKey != null &&
        normalizedProficiencies.contains(_normalizeProficiencyKey(directKey))) {
      return true;
    }

    return switch (weapon.weaponCategory) {
      'simple' =>
        normalizedProficiencies.contains('simple-weapons') ||
            normalizedProficiencies.contains('simple-weapon'),
      'martial' =>
        normalizedProficiencies.contains('martial-weapons') ||
            normalizedProficiencies.contains('martial-weapon'),
      _ => false,
    };
  }

  String _normalizeProficiencyKey(String raw) {
    return raw.trim().toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '-');
  }

  String? _normalizeWeaponCategory(String? rawCategory) {
    final normalized = rawCategory?.trim().toLowerCase();
    if (normalized == null || normalized.isEmpty) {
      return null;
    }
    if (normalized.contains('simple')) {
      return 'simple';
    }
    if (normalized.contains('martial')) {
      return 'martial';
    }
    return null;
  }

  String? _normalizeAbilityKey(String? raw) {
    final normalized = raw?.trim().toLowerCase();
    if (normalized == null || normalized.isEmpty) {
      return null;
    }
    if (normalized.length <= 3) {
      return normalized;
    }
    return switch (normalized) {
      'strength' => 'str',
      'dexterity' => 'dex',
      _ => normalized.substring(0, 3),
    };
  }

  String? _extractDamageDiceFromMap(Map<String, dynamic> map) {
    final explicit = _readString(map, const <String>[
      'damagedice',
      'damage_dice',
      'dice',
    ]);
    if (explicit != null && explicit.isNotEmpty) {
      return explicit;
    }

    final damageText = _readString(map, const <String>[
      'damage',
      'damageexpression',
      'damage_expression',
    ]);
    if (damageText == null) {
      return null;
    }
    return _extractDamageDice(<String>[damageText]);
  }

  String? _extractDamageDice(List<String> values) {
    for (final value in values) {
      final match = RegExp(r'\d+d\d+').firstMatch(value.toLowerCase());
      if (match != null) {
        return match.group(0);
      }
    }
    return null;
  }

  _ArmorPiece? _parseArmorPieceFromJson(
    String? rawJson, {
    required String fallbackName,
  }) {
    if (rawJson == null || rawJson.trim().isEmpty) {
      return null;
    }

    try {
      final decoded = jsonDecode(rawJson);
      if (decoded is! Map<String, dynamic>) {
        return null;
      }

      final normalized = <String, dynamic>{
        for (final entry in decoded.entries)
          entry.key.trim().toLowerCase(): entry.value,
      };
      final isShield =
          _readBool(normalized, const <String>['isshield', 'is_shield']) ||
          _readString(normalized, const <String>['type', 'armor_type']) ==
              'shield';
      final armorType = _readString(normalized, const <String>[
        'type',
        'armor_type',
      ]);
      final baseArmorClass = _readInt(normalized, const <String>[
        'basearmorclass',
        'base_armor_class',
        'armorclass',
        'armor_class',
      ]);
      final armorClassBonus = _readInt(normalized, const <String>[
        'armorclassbonus',
        'armor_class_bonus',
        'acbonus',
        'ac_bonus',
      ]);
      final maxDexterityModifier = _readInt(normalized, const <String>[
        'maxdexteritymodifier',
        'max_dexterity_modifier',
        'maxdexmodifier',
        'max_dex_modifier',
      ]);

      return _ArmorPiece(
        name: fallbackName,
        armorType: armorType,
        isShield: isShield,
        baseArmorClass: baseArmorClass,
        maxDexterityModifier: maxDexterityModifier,
        bonusArmorClass: armorClassBonus ?? 0,
      );
    } catch (_) {
      return null;
    }
  }

  _ArmorPiece? _parseArmorPieceFromName(String normalizedName) {
    if (normalizedName.contains('shield')) {
      return _ArmorPiece.shield(name: normalizedName, bonusArmorClass: 2);
    }

    const armorByName = <String, _ArmorPiece>{
      'padded armor': _ArmorPiece.light(baseArmorClass: 11, name: 'padded'),
      'leather armor': _ArmorPiece.light(baseArmorClass: 11, name: 'leather'),
      'studded leather armor': _ArmorPiece.light(
        baseArmorClass: 12,
        name: 'studded leather',
      ),
      'hide armor': _ArmorPiece.medium(baseArmorClass: 12, name: 'hide'),
      'chain shirt': _ArmorPiece.medium(
        baseArmorClass: 13,
        name: 'chain shirt',
      ),
      'scale mail': _ArmorPiece.medium(baseArmorClass: 14, name: 'scale mail'),
      'breastplate': _ArmorPiece.medium(
        baseArmorClass: 14,
        name: 'breastplate',
      ),
      'half plate': _ArmorPiece.medium(baseArmorClass: 15, name: 'half plate'),
      'ring mail': _ArmorPiece.heavy(baseArmorClass: 14, name: 'ring mail'),
      'chain mail': _ArmorPiece.heavy(baseArmorClass: 16, name: 'chain mail'),
      'splint': _ArmorPiece.heavy(baseArmorClass: 17, name: 'splint'),
      'plate armor': _ArmorPiece.heavy(baseArmorClass: 18, name: 'plate'),
      'plate': _ArmorPiece.heavy(baseArmorClass: 18, name: 'plate'),
    };
    for (final entry in armorByName.entries) {
      if (normalizedName.contains(entry.key)) {
        return entry.value;
      }
    }

    if (normalizedName.contains('armor')) {
      return _ArmorPiece.medium(baseArmorClass: 13, name: normalizedName);
    }

    return null;
  }

  bool _readBool(Map<String, dynamic> map, List<String> keys) {
    for (final key in keys) {
      final value = map[key];
      if (value is bool) {
        return value;
      }
      if (value is num) {
        return value != 0;
      }
      if (value is String) {
        final normalized = value.trim().toLowerCase();
        if (normalized == 'true' || normalized == '1' || normalized == 'yes') {
          return true;
        }
      }
    }
    return false;
  }

  int? _readInt(Map<String, dynamic> map, List<String> keys) {
    for (final key in keys) {
      final value = map[key];
      if (value is int) {
        return value;
      }
      if (value is double) {
        return value.round();
      }
      if (value is String) {
        final parsed = int.tryParse(value.trim());
        if (parsed != null) {
          return parsed;
        }
      }
    }
    return null;
  }

  List<String> _readStringList(Map<String, dynamic> map, List<String> keys) {
    for (final key in keys) {
      final value = map[key];
      if (value is List) {
        return value
            .whereType<Object>()
            .map((item) => item.toString().trim().toLowerCase())
            .where((item) => item.isNotEmpty)
            .toList(growable: false);
      }
      if (value is String) {
        return value
            .split(RegExp(r'[,;|]'))
            .map((item) => item.trim().toLowerCase())
            .where((item) => item.isNotEmpty)
            .toList(growable: false);
      }
    }

    return const <String>[];
  }

  String? _readString(Map<String, dynamic> map, List<String> keys) {
    for (final key in keys) {
      final value = map[key];
      if (value is String && value.trim().isNotEmpty) {
        return value.trim().toLowerCase();
      }
    }
    return null;
  }
}

const Map<String, _WeaponPiece> _weaponByName = <String, _WeaponPiece>{
  'greatclub': _WeaponPiece.simple(
    damageDice: '1d8',
    damageType: 'bludgeoning',
  ),
  'club': _WeaponPiece.simple(damageDice: '1d4', damageType: 'bludgeoning'),
  'dagger': _WeaponPiece.simple(
    damageDice: '1d4',
    damageType: 'piercing',
    isFinesse: true,
    isRanged: true,
  ),
  'handaxe': _WeaponPiece.simple(damageDice: '1d6', damageType: 'slashing'),
  'javelin': _WeaponPiece.simple(damageDice: '1d6', damageType: 'piercing'),
  'light hammer': _WeaponPiece.simple(
    damageDice: '1d4',
    damageType: 'bludgeoning',
  ),
  'mace': _WeaponPiece.simple(damageDice: '1d6', damageType: 'bludgeoning'),
  'quarterstaff': _WeaponPiece.simple(
    damageDice: '1d6',
    damageType: 'bludgeoning',
  ),
  'sickle': _WeaponPiece.simple(damageDice: '1d4', damageType: 'slashing'),
  'spear': _WeaponPiece.simple(damageDice: '1d6', damageType: 'piercing'),
  'light crossbow': _WeaponPiece.simpleRanged(
    damageDice: '1d8',
    damageType: 'piercing',
  ),
  'dart': _WeaponPiece.simpleRanged(
    damageDice: '1d4',
    damageType: 'piercing',
    isFinesse: true,
  ),
  'shortbow': _WeaponPiece.simpleRanged(
    damageDice: '1d6',
    damageType: 'piercing',
  ),
  'sling': _WeaponPiece.simpleRanged(
    damageDice: '1d4',
    damageType: 'bludgeoning',
  ),
  'battleaxe': _WeaponPiece.martial(damageDice: '1d8', damageType: 'slashing'),
  'flail': _WeaponPiece.martial(damageDice: '1d8', damageType: 'bludgeoning'),
  'glaive': _WeaponPiece.martial(damageDice: '1d10', damageType: 'slashing'),
  'greataxe': _WeaponPiece.martial(damageDice: '1d12', damageType: 'slashing'),
  'greatsword': _WeaponPiece.martial(damageDice: '2d6', damageType: 'slashing'),
  'halberd': _WeaponPiece.martial(damageDice: '1d10', damageType: 'slashing'),
  'lance': _WeaponPiece.martial(damageDice: '1d12', damageType: 'piercing'),
  'longsword': _WeaponPiece.martial(damageDice: '1d8', damageType: 'slashing'),
  'maul': _WeaponPiece.martial(damageDice: '2d6', damageType: 'bludgeoning'),
  'morningstar': _WeaponPiece.martial(
    damageDice: '1d8',
    damageType: 'piercing',
  ),
  'pike': _WeaponPiece.martial(damageDice: '1d10', damageType: 'piercing'),
  'rapier': _WeaponPiece.martial(
    damageDice: '1d8',
    damageType: 'piercing',
    isFinesse: true,
  ),
  'scimitar': _WeaponPiece.martial(
    damageDice: '1d6',
    damageType: 'slashing',
    isFinesse: true,
  ),
  'shortsword': _WeaponPiece.martial(
    damageDice: '1d6',
    damageType: 'piercing',
    isFinesse: true,
  ),
  'trident': _WeaponPiece.martial(damageDice: '1d6', damageType: 'piercing'),
  'war pick': _WeaponPiece.martial(damageDice: '1d8', damageType: 'piercing'),
  'warhammer': _WeaponPiece.martial(
    damageDice: '1d8',
    damageType: 'bludgeoning',
  ),
  'whip': _WeaponPiece.martial(
    damageDice: '1d4',
    damageType: 'slashing',
    isFinesse: true,
  ),
  'blowgun': _WeaponPiece.martialRanged(
    damageDice: '1',
    damageType: 'piercing',
  ),
  'hand crossbow': _WeaponPiece.martialRanged(
    damageDice: '1d6',
    damageType: 'piercing',
  ),
  'heavy crossbow': _WeaponPiece.martialRanged(
    damageDice: '1d10',
    damageType: 'piercing',
  ),
  'longbow': _WeaponPiece.martialRanged(
    damageDice: '1d8',
    damageType: 'piercing',
  ),
};

class _ArmorPiece {
  const _ArmorPiece({
    required this.name,
    required this.armorType,
    required this.isShield,
    required this.baseArmorClass,
    required this.maxDexterityModifier,
    required this.bonusArmorClass,
  });

  const _ArmorPiece.light({required int baseArmorClass, required String name})
    : this(
        name: name,
        armorType: 'light',
        isShield: false,
        baseArmorClass: baseArmorClass,
        maxDexterityModifier: null,
        bonusArmorClass: 0,
      );

  const _ArmorPiece.medium({required int baseArmorClass, required String name})
    : this(
        name: name,
        armorType: 'medium',
        isShield: false,
        baseArmorClass: baseArmorClass,
        maxDexterityModifier: 2,
        bonusArmorClass: 0,
      );

  const _ArmorPiece.heavy({required int baseArmorClass, required String name})
    : this(
        name: name,
        armorType: 'heavy',
        isShield: false,
        baseArmorClass: baseArmorClass,
        maxDexterityModifier: 0,
        bonusArmorClass: 0,
      );

  const _ArmorPiece.shield({required String name, required int bonusArmorClass})
    : this(
        name: name,
        armorType: 'shield',
        isShield: true,
        baseArmorClass: null,
        maxDexterityModifier: null,
        bonusArmorClass: bonusArmorClass,
      );

  final String name;
  final String? armorType;
  final bool isShield;
  final int? baseArmorClass;
  final int? maxDexterityModifier;
  final int bonusArmorClass;

  int armorClassFor(int dexterityModifier) {
    final normalizedType = armorType?.toLowerCase();
    final base = baseArmorClass ?? 10;
    return switch (normalizedType) {
      'heavy' => base,
      'shield' => base,
      _ => base + dexterityModifier.clamp(-99, maxDexterityModifier ?? 99),
    };
  }
}

class _WeaponPiece {
  const _WeaponPiece({
    required this.name,
    this.weaponCategory,
    this.damageDice,
    this.damageType,
    this.abilityOverrideKey,
    this.proficiencyKey,
    this.isRanged = false,
    this.isFinesse = false,
    this.attackBonusModifier = 0,
    this.damageBonusModifier = 0,
  });

  const _WeaponPiece.simple({
    required String damageDice,
    required String damageType,
    bool isFinesse = false,
    bool isRanged = false,
  }) : this(
         name: '',
         weaponCategory: 'simple',
         damageDice: damageDice,
         damageType: damageType,
         isFinesse: isFinesse,
         isRanged: isRanged,
       );

  const _WeaponPiece.martial({
    required String damageDice,
    required String damageType,
    bool isFinesse = false,
    bool isRanged = false,
  }) : this(
         name: '',
         weaponCategory: 'martial',
         damageDice: damageDice,
         damageType: damageType,
         isFinesse: isFinesse,
         isRanged: isRanged,
       );

  const _WeaponPiece.simpleRanged({
    required String damageDice,
    required String damageType,
    bool isFinesse = false,
  }) : this.simple(
         damageDice: damageDice,
         damageType: damageType,
         isFinesse: isFinesse,
         isRanged: true,
       );

  const _WeaponPiece.martialRanged({
    required String damageDice,
    required String damageType,
    bool isFinesse = false,
  }) : this.martial(
         damageDice: damageDice,
         damageType: damageType,
         isFinesse: isFinesse,
         isRanged: true,
       );

  final String name;
  final String? weaponCategory;
  final String? damageDice;
  final String? damageType;
  final String? abilityOverrideKey;
  final String? proficiencyKey;
  final bool isRanged;
  final bool isFinesse;
  final int attackBonusModifier;
  final int damageBonusModifier;

  _WeaponPiece copyWith({String? name}) {
    return _WeaponPiece(
      name: name ?? this.name,
      weaponCategory: weaponCategory,
      damageDice: damageDice,
      damageType: damageType,
      abilityOverrideKey: abilityOverrideKey,
      proficiencyKey: proficiencyKey,
      isRanged: isRanged,
      isFinesse: isFinesse,
      attackBonusModifier: attackBonusModifier,
      damageBonusModifier: damageBonusModifier,
    );
  }
}
