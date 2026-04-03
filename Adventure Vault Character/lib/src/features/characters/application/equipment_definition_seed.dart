import 'dart:convert';

class EquipmentDefinitionSeed {
  const EquipmentDefinitionSeed({
    this.category,
    this.subcategory,
    this.weight,
    this.isContainer,
    this.isStackable,
    this.weaponPropertiesJson,
    this.armorPropertiesJson,
  });

  final String? category;
  final String? subcategory;
  final int? weight;
  final bool? isContainer;
  final bool? isStackable;
  final String? weaponPropertiesJson;
  final String? armorPropertiesJson;

  static EquipmentDefinitionSeed resolve(String itemName) {
    final normalized = _normalize(itemName);
    final magicBonus = _extractMagicBonus(itemName);
    final weaponSeed = _resolveWeaponSeed(normalized, magicBonus: magicBonus);
    if (weaponSeed != null) {
      return weaponSeed;
    }

    final armorSeed = _resolveArmorSeed(normalized, magicBonus: magicBonus);
    if (armorSeed != null) {
      return armorSeed;
    }

    return const EquipmentDefinitionSeed();
  }

  static EquipmentDefinitionSeed? _resolveWeaponSeed(
    String normalized, {
    required int magicBonus,
  }) {
    final entry = _weaponByName.entries.firstWhere(
      (candidate) => normalized.contains(candidate.key),
      orElse: () => const MapEntry('', _WeaponSeed.empty()),
    );
    if (entry.key.isEmpty) {
      return null;
    }

    return EquipmentDefinitionSeed(
      category: 'weapon',
      subcategory: entry.value.weaponCategory,
      isContainer: false,
      isStackable: false,
      weaponPropertiesJson: jsonEncode(<String, Object>{
        'type': 'weapon',
        'weapon_category': entry.value.weaponCategory,
        'is_ranged': entry.value.isRanged,
        'is_finesse': entry.value.isFinesse,
        'damage_dice': entry.value.damageDice,
        'damage_type': entry.value.damageType,
        'proficiency_key': entry.value.proficiencyKey,
        if (magicBonus > 0) 'attack_bonus': magicBonus,
        if (magicBonus > 0) 'damage_bonus': magicBonus,
      }),
    );
  }

  static EquipmentDefinitionSeed? _resolveArmorSeed(
    String normalized, {
    required int magicBonus,
  }) {
    final entry = _armorByName.entries.firstWhere(
      (candidate) => normalized.contains(candidate.key),
      orElse: () => const MapEntry('', _ArmorSeed.empty()),
    );
    if (entry.key.isEmpty) {
      return null;
    }

    final armorSeed = entry.value;
    final armorClassBonus = armorSeed.baseShieldBonus + magicBonus;
    return EquipmentDefinitionSeed(
      category: 'armor',
      subcategory: armorSeed.armorType,
      isContainer: false,
      isStackable: false,
      armorPropertiesJson: jsonEncode(<String, Object>{
        'type': armorSeed.armorType,
        if (armorSeed.baseArmorClass != null)
          'base_armor_class': armorSeed.baseArmorClass!,
        if (armorSeed.maxDexterityModifier != null)
          'max_dexterity_modifier': armorSeed.maxDexterityModifier!,
        if (armorSeed.isShield) 'is_shield': true,
        if (armorClassBonus > 0) 'armor_class_bonus': armorClassBonus,
      }),
    );
  }

  static String _normalize(String raw) {
    return raw.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
  }

  static int _extractMagicBonus(String itemName) {
    final match = RegExp(r'\+(\d+)').firstMatch(itemName);
    return int.tryParse(match?.group(1) ?? '') ?? 0;
  }
}

const Map<String, _WeaponSeed> _weaponByName = <String, _WeaponSeed>{
  'heavy crossbow': _WeaponSeed.martial(
    damageDice: '1d10',
    damageType: 'piercing',
    isRanged: true,
  ),
  'hand crossbow': _WeaponSeed.martial(
    damageDice: '1d6',
    damageType: 'piercing',
    isRanged: true,
  ),
  'light crossbow': _WeaponSeed.simple(
    damageDice: '1d8',
    damageType: 'piercing',
    isRanged: true,
  ),
  'light hammer': _WeaponSeed.simple(
    damageDice: '1d4',
    damageType: 'bludgeoning',
  ),
  'shortsword': _WeaponSeed.martial(
    damageDice: '1d6',
    damageType: 'piercing',
    isFinesse: true,
  ),
  'greatsword': _WeaponSeed.martial(damageDice: '2d6', damageType: 'slashing'),
  'greatclub': _WeaponSeed.simple(damageDice: '1d8', damageType: 'bludgeoning'),
  'quarterstaff': _WeaponSeed.simple(
    damageDice: '1d6',
    damageType: 'bludgeoning',
  ),
  'morningstar': _WeaponSeed.martial(damageDice: '1d8', damageType: 'piercing'),
  'battleaxe': _WeaponSeed.martial(damageDice: '1d8', damageType: 'slashing'),
  'greataxe': _WeaponSeed.martial(damageDice: '1d12', damageType: 'slashing'),
  'longsword': _WeaponSeed.martial(damageDice: '1d8', damageType: 'slashing'),
  'warhammer': _WeaponSeed.martial(
    damageDice: '1d8',
    damageType: 'bludgeoning',
  ),
  'shortbow': _WeaponSeed.simple(
    damageDice: '1d6',
    damageType: 'piercing',
    isRanged: true,
  ),
  'longbow': _WeaponSeed.martial(
    damageDice: '1d8',
    damageType: 'piercing',
    isRanged: true,
  ),
  'war pick': _WeaponSeed.martial(damageDice: '1d8', damageType: 'piercing'),
  'scimitar': _WeaponSeed.martial(
    damageDice: '1d6',
    damageType: 'slashing',
    isFinesse: true,
  ),
  'rapier': _WeaponSeed.martial(
    damageDice: '1d8',
    damageType: 'piercing',
    isFinesse: true,
  ),
  'handaxe': _WeaponSeed.simple(damageDice: '1d6', damageType: 'slashing'),
  'trident': _WeaponSeed.martial(damageDice: '1d6', damageType: 'piercing'),
  'halberd': _WeaponSeed.martial(damageDice: '1d10', damageType: 'slashing'),
  'crossbow': _WeaponSeed.simple(
    damageDice: '1d8',
    damageType: 'piercing',
    isRanged: true,
  ),
  'javelin': _WeaponSeed.simple(damageDice: '1d6', damageType: 'piercing'),
  'spear': _WeaponSeed.simple(damageDice: '1d6', damageType: 'piercing'),
  'dagger': _WeaponSeed.simple(
    damageDice: '1d4',
    damageType: 'piercing',
    isFinesse: true,
    isRanged: true,
  ),
  'lance': _WeaponSeed.martial(damageDice: '1d12', damageType: 'piercing'),
  'maul': _WeaponSeed.martial(damageDice: '2d6', damageType: 'bludgeoning'),
  'glaive': _WeaponSeed.martial(damageDice: '1d10', damageType: 'slashing'),
  'sickle': _WeaponSeed.simple(damageDice: '1d4', damageType: 'slashing'),
  'blowgun': _WeaponSeed.martial(
    damageDice: '1',
    damageType: 'piercing',
    isRanged: true,
  ),
  'flail': _WeaponSeed.martial(damageDice: '1d8', damageType: 'bludgeoning'),
  'whip': _WeaponSeed.martial(
    damageDice: '1d4',
    damageType: 'slashing',
    isFinesse: true,
  ),
  'pike': _WeaponSeed.martial(damageDice: '1d10', damageType: 'piercing'),
  'sling': _WeaponSeed.simple(
    damageDice: '1d4',
    damageType: 'bludgeoning',
    isRanged: true,
  ),
  'mace': _WeaponSeed.simple(damageDice: '1d6', damageType: 'bludgeoning'),
  'club': _WeaponSeed.simple(damageDice: '1d4', damageType: 'bludgeoning'),
  'dart': _WeaponSeed.simple(
    damageDice: '1d4',
    damageType: 'piercing',
    isFinesse: true,
    isRanged: true,
  ),
};

const Map<String, _ArmorSeed> _armorByName = <String, _ArmorSeed>{
  'studded leather armor': _ArmorSeed.light(baseArmorClass: 12),
  'leather armor': _ArmorSeed.light(baseArmorClass: 11),
  'padded armor': _ArmorSeed.light(baseArmorClass: 11),
  'chain shirt': _ArmorSeed.medium(baseArmorClass: 13),
  'scale mail': _ArmorSeed.medium(baseArmorClass: 14),
  'half plate': _ArmorSeed.medium(baseArmorClass: 15),
  'breastplate': _ArmorSeed.medium(baseArmorClass: 14),
  'hide armor': _ArmorSeed.medium(baseArmorClass: 12),
  'chain mail': _ArmorSeed.heavy(baseArmorClass: 16),
  'ring mail': _ArmorSeed.heavy(baseArmorClass: 14),
  'plate armor': _ArmorSeed.heavy(baseArmorClass: 18),
  'splint': _ArmorSeed.heavy(baseArmorClass: 17),
  'plate': _ArmorSeed.heavy(baseArmorClass: 18),
  'shield': _ArmorSeed.shield(baseBonusArmorClass: 2),
};

class _WeaponSeed {
  const _WeaponSeed({
    required this.weaponCategory,
    required this.damageDice,
    required this.damageType,
    required this.isRanged,
    required this.isFinesse,
    required this.proficiencyKey,
  });

  const _WeaponSeed.simple({
    required String damageDice,
    required String damageType,
    bool isRanged = false,
    bool isFinesse = false,
  }) : this(
         weaponCategory: 'simple',
         damageDice: damageDice,
         damageType: damageType,
         isRanged: isRanged,
         isFinesse: isFinesse,
         proficiencyKey: 'simple-weapons',
       );

  const _WeaponSeed.martial({
    required String damageDice,
    required String damageType,
    bool isRanged = false,
    bool isFinesse = false,
  }) : this(
         weaponCategory: 'martial',
         damageDice: damageDice,
         damageType: damageType,
         isRanged: isRanged,
         isFinesse: isFinesse,
         proficiencyKey: 'martial-weapons',
       );

  const _WeaponSeed.empty()
    : this(
        weaponCategory: '',
        damageDice: '',
        damageType: '',
        isRanged: false,
        isFinesse: false,
        proficiencyKey: '',
      );

  final String weaponCategory;
  final String damageDice;
  final String damageType;
  final bool isRanged;
  final bool isFinesse;
  final String proficiencyKey;
}

class _ArmorSeed {
  const _ArmorSeed({
    required this.armorType,
    required this.baseArmorClass,
    required this.maxDexterityModifier,
    required this.isShield,
    required this.baseShieldBonus,
  });

  const _ArmorSeed.light({required int baseArmorClass})
    : this(
        armorType: 'light',
        baseArmorClass: baseArmorClass,
        maxDexterityModifier: null,
        isShield: false,
        baseShieldBonus: 0,
      );

  const _ArmorSeed.medium({required int baseArmorClass})
    : this(
        armorType: 'medium',
        baseArmorClass: baseArmorClass,
        maxDexterityModifier: 2,
        isShield: false,
        baseShieldBonus: 0,
      );

  const _ArmorSeed.heavy({required int baseArmorClass})
    : this(
        armorType: 'heavy',
        baseArmorClass: baseArmorClass,
        maxDexterityModifier: 0,
        isShield: false,
        baseShieldBonus: 0,
      );

  const _ArmorSeed.shield({required int baseBonusArmorClass})
    : this(
        armorType: 'shield',
        baseArmorClass: null,
        maxDexterityModifier: null,
        isShield: true,
        baseShieldBonus: baseBonusArmorClass,
      );

  const _ArmorSeed.empty()
    : this(
        armorType: '',
        baseArmorClass: null,
        maxDexterityModifier: null,
        isShield: false,
        baseShieldBonus: 0,
      );

  final String armorType;
  final int? baseArmorClass;
  final int? maxDexterityModifier;
  final bool isShield;
  final int baseShieldBonus;
}
