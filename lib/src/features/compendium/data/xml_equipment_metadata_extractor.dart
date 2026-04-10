import 'dart:convert';

class CompendiumEquipmentMetadata {
  const CompendiumEquipmentMetadata({
    required this.id,
    required this.key,
    required this.name,
    required this.category,
    this.subcategory,
    this.weight,
    this.costValue,
    this.costUnit,
    this.description,
    this.weaponPropertiesJson,
    this.armorPropertiesJson,
  });

  final String id;
  final String key;
  final String name;
  final String category;
  final String? subcategory;
  final int? weight;
  final int? costValue;
  final String? costUnit;
  final String? description;
  final String? weaponPropertiesJson;
  final String? armorPropertiesJson;
}

List<CompendiumEquipmentMetadata>
extractCompendiumEquipmentMetadataFromXmlSources(Iterable<String> xmlSources) {
  final mergedById = <String, CompendiumEquipmentMetadata>{};
  for (final xml in xmlSources) {
    if (xml.trim().isEmpty) {
      continue;
    }
    for (final metadata in _extractCompendiumEquipmentMetadata(xml)) {
      mergedById.putIfAbsent(metadata.id, () => metadata);
    }
  }
  return List<CompendiumEquipmentMetadata>.unmodifiable(mergedById.values);
}

List<CompendiumEquipmentMetadata> _extractCompendiumEquipmentMetadata(
  String xml,
) {
  final items = _extractElements(xml, 'item');
  if (items.isEmpty) {
    return const <CompendiumEquipmentMetadata>[];
  }

  return items
      .map((item) => _parseEquipmentMetadata(item.innerXml))
      .whereType<CompendiumEquipmentMetadata>()
      .toList(growable: false);
}

CompendiumEquipmentMetadata? _parseEquipmentMetadata(String itemXml) {
  final name = _normalizeName(_extractSingleTagText(itemXml, 'name') ?? '');
  if (name.isEmpty) {
    return null;
  }

  final type = (_extractSingleTagText(itemXml, 'type') ?? '').toLowerCase();
  final isArmor = _isArmorItem(name: name, type: type, itemXml: itemXml);
  final isWeapon = _isWeaponItem(name: name, type: type, itemXml: itemXml);
  if (!isArmor && !isWeapon) {
    return null;
  }

  final normalizedName = _normalizeText(name);
  final magicBonus = _extractMagicBonus(normalizedName);
  final key = _slugify(normalizedName);
  final id = 'equipment-$key';
  final weight = _parseWeight(_extractSingleTagText(itemXml, 'weight'));
  final cost = _parseCost(_extractSingleTagText(itemXml, 'value'));
  final description = _extractDescription(itemXml);

  if (isArmor) {
    final armorType = _resolveArmorType(type: type, name: normalizedName);
    final armorClassValue = _parseInt(_extractSingleTagText(itemXml, 'ac'));
    final maxDexterityModifier = _parseArmorMaxDexterityModifier(
      itemXml,
      armorType: armorType,
    );
    final armorJson = <String, Object>{
      'type': armorType,
      if (armorType == 'shield' && armorClassValue != null)
        'armor_class_bonus': armorClassValue + magicBonus,
      if (armorType == 'shield' && armorClassValue == null && magicBonus > 0)
        'armor_class_bonus': magicBonus,
      if (armorType != 'shield' && armorClassValue != null)
        'base_armor_class': armorClassValue,
      if (armorType != 'shield' && maxDexterityModifier != null)
        'max_dexterity_modifier': maxDexterityModifier,
      if (armorType == 'shield') 'is_shield': true,
    };
    if (armorJson.length <= 1) {
      return null;
    }

    return CompendiumEquipmentMetadata(
      id: id,
      key: key,
      name: normalizedName,
      category: 'armor',
      subcategory: armorType,
      weight: weight,
      costValue: cost?.value,
      costUnit: cost?.unit,
      description: description,
      armorPropertiesJson: jsonEncode(armorJson),
    );
  }

  final properties = _extractWeaponProperties(itemXml);
  final isFinesse = properties.contains('finesse');
  final isRanged =
      type.contains('ranged') ||
      properties.contains('ammunition') ||
      properties.contains('thrown') ||
      (_extractSingleTagText(itemXml, 'range') ?? '').trim().isNotEmpty;
  final weaponCategory = _resolveWeaponCategory(type);
  final damageDice = _extractDamageDice(itemXml);
  final damageType = _extractDamageType(itemXml);
  final proficiencyKey = _slugify(_stripMagicSuffix(normalizedName));

  final weaponJson = <String, Object>{
    'type': 'weapon',
    if (weaponCategory != null) 'weapon_category': weaponCategory,
    if (isRanged) 'is_ranged': true,
    if (isFinesse) 'is_finesse': true,
    if (damageDice != null) 'damage_dice': damageDice,
    if (damageType != null) 'damage_type': damageType,
    if (proficiencyKey.isNotEmpty) 'proficiency_key': proficiencyKey,
    if (magicBonus > 0) 'attack_bonus': magicBonus,
    if (magicBonus > 0) 'damage_bonus': magicBonus,
    if (properties.isNotEmpty) 'properties': properties,
  };

  if (!weaponJson.containsKey('damage_dice') &&
      !weaponJson.containsKey('attack_bonus') &&
      !weaponJson.containsKey('damage_bonus')) {
    return null;
  }

  return CompendiumEquipmentMetadata(
    id: id,
    key: key,
    name: normalizedName,
    category: 'weapon',
    subcategory: weaponCategory,
    weight: weight,
    costValue: cost?.value,
    costUnit: cost?.unit,
    description: description,
    weaponPropertiesJson: jsonEncode(weaponJson),
  );
}

bool _isArmorItem({
  required String name,
  required String type,
  required String itemXml,
}) {
  if (type.contains('armor') ||
      type == 'la' ||
      type == 'ma' ||
      type == 'ha' ||
      type == 's') {
    return true;
  }
  if (name.toLowerCase().contains('shield') ||
      name.toLowerCase().contains('armor')) {
    return true;
  }
  return _extractSingleTagText(itemXml, 'ac') != null;
}

bool _isWeaponItem({
  required String name,
  required String type,
  required String itemXml,
}) {
  if (type.contains('weapon') ||
      type == 'm' ||
      type == 'r' ||
      type.contains('simple') ||
      type.contains('martial')) {
    return true;
  }
  if (_extractSingleTagText(itemXml, 'dmg1') != null ||
      _extractSingleTagText(itemXml, 'damage') != null) {
    return true;
  }
  final lowerName = name.toLowerCase();
  return lowerName.contains('sword') ||
      lowerName.contains('axe') ||
      lowerName.contains('bow') ||
      lowerName.contains('crossbow') ||
      lowerName.contains('dagger') ||
      lowerName.contains('mace') ||
      lowerName.contains('hammer');
}

String _resolveArmorType({required String type, required String name}) {
  final lowerName = name.toLowerCase();
  if (type == 's' || lowerName.contains('shield')) {
    return 'shield';
  }
  if (type == 'la' || type.contains('light')) {
    return 'light';
  }
  if (type == 'ma' || type.contains('medium')) {
    return 'medium';
  }
  if (type == 'ha' || type.contains('heavy')) {
    return 'heavy';
  }
  if (lowerName.contains('chain mail') ||
      lowerName.contains('plate') ||
      lowerName.contains('splint') ||
      lowerName.contains('ring mail')) {
    return 'heavy';
  }
  if (lowerName.contains('half plate') ||
      lowerName.contains('scale mail') ||
      lowerName.contains('breastplate') ||
      lowerName.contains('chain shirt') ||
      lowerName.contains('hide')) {
    return 'medium';
  }
  return 'light';
}

int? _parseArmorMaxDexterityModifier(
  String itemXml, {
  required String armorType,
}) {
  final explicit = _parseInt(_extractSingleTagText(itemXml, 'dex'));
  if (explicit != null) {
    return explicit;
  }
  return switch (armorType) {
    'medium' => 2,
    'heavy' => 0,
    _ => null,
  };
}

String? _resolveWeaponCategory(String type) {
  if (type.contains('martial')) {
    return 'martial';
  }
  if (type.contains('simple')) {
    return 'simple';
  }
  return null;
}

List<String> _extractWeaponProperties(String itemXml) {
  final properties = <String>{};
  for (final value in _extractAllTagTexts(itemXml, 'property')) {
    for (final token in value.split(',')) {
      final normalized = _normalizeText(
        token,
      ).toLowerCase().replaceAll(RegExp(r'\s*\(.*\)$'), '');
      if (normalized.isNotEmpty) {
        properties.add(normalized);
      }
    }
  }
  return List<String>.unmodifiable(properties);
}

String? _extractDamageDice(String itemXml) {
  final direct = _extractSingleTagText(itemXml, 'dmg1');
  final fromDirect = _extractDamageDiceFromText(direct);
  if (fromDirect != null) {
    return fromDirect;
  }
  return _extractDamageDiceFromText(_extractSingleTagText(itemXml, 'damage'));
}

String? _extractDamageType(String itemXml) {
  final explicit = _extractSingleTagText(itemXml, 'dmgType');
  if (explicit != null && explicit.isNotEmpty) {
    return _normalizeDamageType(explicit);
  }

  final damage = _extractSingleTagText(itemXml, 'damage');
  if (damage == null || damage.isEmpty) {
    return null;
  }

  final lowercase = damage.toLowerCase();
  for (final entry in _damageTypeTokens.entries) {
    if (lowercase.contains(entry.key)) {
      return entry.value;
    }
  }
  final codeMatch = RegExp(r'\b([bpsacflnr])\b').firstMatch(lowercase);
  if (codeMatch == null) {
    return null;
  }
  return _damageTypeCodeMap[codeMatch.group(1)];
}

String? _extractDamageDiceFromText(String? value) {
  if (value == null || value.trim().isEmpty) {
    return null;
  }
  final match = RegExp(r'\d+d\d+(?:\s*[+-]\s*\d+)?').firstMatch(value);
  return match?.group(0)?.replaceAll(' ', '');
}

_ParsedCost? _parseCost(String? value) {
  if (value == null || value.trim().isEmpty) {
    return null;
  }
  final match = RegExp(
    r'^(\d+)\s*(cp|sp|ep|gp|pp)\b',
    caseSensitive: false,
  ).firstMatch(value.trim());
  if (match == null) {
    return null;
  }
  final parsedValue = int.tryParse(match.group(1) ?? '');
  final parsedUnit = match.group(2)?.toLowerCase();
  if (parsedValue == null || parsedUnit == null) {
    return null;
  }
  return _ParsedCost(value: parsedValue, unit: parsedUnit);
}

int? _parseWeight(String? value) {
  if (value == null || value.trim().isEmpty) {
    return null;
  }
  return int.tryParse(value.trim());
}

String? _extractDescription(String itemXml) {
  final textLines = _extractAllTagTexts(
    itemXml,
    'text',
  ).where((line) => !line.startsWith('Source:')).toList(growable: false);
  if (textLines.isEmpty) {
    return null;
  }
  return textLines.join('\n');
}

int _extractMagicBonus(String itemName) {
  final match = RegExp(r'\+(\d+)').firstMatch(itemName);
  return int.tryParse(match?.group(1) ?? '') ?? 0;
}

String _stripMagicSuffix(String value) {
  return value.replaceAll(RegExp(r'\s*\+\d+\s*$'), '').trim();
}

String _normalizeName(String raw) {
  return _normalizeText(
    raw.replaceAll(
      RegExp(r'\s*\[(?:2024|5\.5e)\]\s*$', caseSensitive: false),
      '',
    ),
  );
}

String _normalizeText(String text) {
  return text
      .replaceAll('&apos;', "'")
      .replaceAll('&quot;', '"')
      .replaceAll('&amp;', '&')
      .replaceAll('&lt;', '<')
      .replaceAll('&gt;', '>')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
}

String _slugify(String raw) {
  return raw
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
      .replaceAll(RegExp(r'^-|-$'), '');
}

String? _extractSingleTagText(String xml, String tagName) {
  final match = RegExp(
    '<$tagName\\b[^>]*>([\\s\\S]*?)</$tagName>',
    caseSensitive: false,
  ).firstMatch(xml);
  if (match == null) {
    return null;
  }
  return _normalizeText(match.group(1) ?? '');
}

List<String> _extractAllTagTexts(String xml, String tagName) {
  if (xml.isEmpty) {
    return const <String>[];
  }
  return RegExp(
        '<$tagName\\b[^>]*>([\\s\\S]*?)</$tagName>',
        caseSensitive: false,
      )
      .allMatches(xml)
      .map((match) => _normalizeText(match.group(1) ?? ''))
      .where((text) => text.isNotEmpty)
      .toList(growable: false);
}

List<_XmlElement> _extractElements(String xml, String tagName) {
  if (xml.isEmpty) {
    return const <_XmlElement>[];
  }

  return RegExp(
        '<$tagName\\b([^>]*)>([\\s\\S]*?)</$tagName>',
        caseSensitive: false,
      )
      .allMatches(xml)
      .map(
        (match) => _XmlElement(
          attributes: const <String, String>{},
          innerXml: match.group(2) ?? '',
        ),
      )
      .toList(growable: false);
}

int? _parseInt(String? value) {
  if (value == null || value.trim().isEmpty) {
    return null;
  }
  return int.tryParse(value.trim());
}

String _normalizeDamageType(String raw) {
  final normalized = raw.trim().toLowerCase();
  if (_damageTypeCodeMap.containsKey(normalized)) {
    return _damageTypeCodeMap[normalized]!;
  }
  for (final entry in _damageTypeTokens.entries) {
    if (normalized.contains(entry.key)) {
      return entry.value;
    }
  }
  return normalized;
}

const Map<String, String> _damageTypeCodeMap = <String, String>{
  'b': 'bludgeoning',
  'p': 'piercing',
  's': 'slashing',
  'a': 'acid',
  'c': 'cold',
  'f': 'fire',
  'l': 'lightning',
  'n': 'necrotic',
  'r': 'radiant',
};

const Map<String, String> _damageTypeTokens = <String, String>{
  'bludgeoning': 'bludgeoning',
  'piercing': 'piercing',
  'slashing': 'slashing',
  'acid': 'acid',
  'cold': 'cold',
  'fire': 'fire',
  'lightning': 'lightning',
  'necrotic': 'necrotic',
  'radiant': 'radiant',
};

class _ParsedCost {
  const _ParsedCost({required this.value, required this.unit});

  final int value;
  final String unit;
}

class _XmlElement {
  const _XmlElement({required this.attributes, required this.innerXml});

  final Map<String, String> attributes;
  final String innerXml;
}
