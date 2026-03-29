// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CharactersTable extends Characters
    with TableInfo<$CharactersTable, Character> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CharactersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _raceNameMeta = const VerificationMeta(
    'raceName',
  );
  @override
  late final GeneratedColumn<String> raceName = GeneratedColumn<String>(
    'race_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _classDefinitionIdMeta = const VerificationMeta(
    'classDefinitionId',
  );
  @override
  late final GeneratedColumn<String> classDefinitionId =
      GeneratedColumn<String>(
        'class_definition_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _backgroundDefinitionRefIdMeta =
      const VerificationMeta('backgroundDefinitionRefId');
  @override
  late final GeneratedColumn<String> backgroundDefinitionRefId =
      GeneratedColumn<String>(
        'background_definition_ref_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _classNameMeta = const VerificationMeta(
    'className',
  );
  @override
  late final GeneratedColumn<String> className = GeneratedColumn<String>(
    'class_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _experienceMeta = const VerificationMeta(
    'experience',
  );
  @override
  late final GeneratedColumn<int> experience = GeneratedColumn<int>(
    'experience',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    raceName,
    classDefinitionId,
    backgroundDefinitionRefId,
    className,
    level,
    experience,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'characters';
  @override
  VerificationContext validateIntegrity(
    Insertable<Character> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('race_name')) {
      context.handle(
        _raceNameMeta,
        raceName.isAcceptableOrUnknown(data['race_name']!, _raceNameMeta),
      );
    } else if (isInserting) {
      context.missing(_raceNameMeta);
    }
    if (data.containsKey('class_definition_id')) {
      context.handle(
        _classDefinitionIdMeta,
        classDefinitionId.isAcceptableOrUnknown(
          data['class_definition_id']!,
          _classDefinitionIdMeta,
        ),
      );
    }
    if (data.containsKey('background_definition_ref_id')) {
      context.handle(
        _backgroundDefinitionRefIdMeta,
        backgroundDefinitionRefId.isAcceptableOrUnknown(
          data['background_definition_ref_id']!,
          _backgroundDefinitionRefIdMeta,
        ),
      );
    }
    if (data.containsKey('class_name')) {
      context.handle(
        _classNameMeta,
        className.isAcceptableOrUnknown(data['class_name']!, _classNameMeta),
      );
    } else if (isInserting) {
      context.missing(_classNameMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('experience')) {
      context.handle(
        _experienceMeta,
        experience.isAcceptableOrUnknown(data['experience']!, _experienceMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Character map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Character(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      raceName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}race_name'],
      )!,
      classDefinitionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}class_definition_id'],
      ),
      backgroundDefinitionRefId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}background_definition_ref_id'],
      ),
      className: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}class_name'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}level'],
      )!,
      experience: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}experience'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CharactersTable createAlias(String alias) {
    return $CharactersTable(attachedDatabase, alias);
  }
}

class Character extends DataClass implements Insertable<Character> {
  final String id;
  final String name;
  final String raceName;
  final String? classDefinitionId;
  final String? backgroundDefinitionRefId;
  final String className;
  final int level;
  final int? experience;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Character({
    required this.id,
    required this.name,
    required this.raceName,
    this.classDefinitionId,
    this.backgroundDefinitionRefId,
    required this.className,
    required this.level,
    this.experience,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['race_name'] = Variable<String>(raceName);
    if (!nullToAbsent || classDefinitionId != null) {
      map['class_definition_id'] = Variable<String>(classDefinitionId);
    }
    if (!nullToAbsent || backgroundDefinitionRefId != null) {
      map['background_definition_ref_id'] = Variable<String>(
        backgroundDefinitionRefId,
      );
    }
    map['class_name'] = Variable<String>(className);
    map['level'] = Variable<int>(level);
    if (!nullToAbsent || experience != null) {
      map['experience'] = Variable<int>(experience);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CharactersCompanion toCompanion(bool nullToAbsent) {
    return CharactersCompanion(
      id: Value(id),
      name: Value(name),
      raceName: Value(raceName),
      classDefinitionId: classDefinitionId == null && nullToAbsent
          ? const Value.absent()
          : Value(classDefinitionId),
      backgroundDefinitionRefId:
          backgroundDefinitionRefId == null && nullToAbsent
          ? const Value.absent()
          : Value(backgroundDefinitionRefId),
      className: Value(className),
      level: Value(level),
      experience: experience == null && nullToAbsent
          ? const Value.absent()
          : Value(experience),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Character.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Character(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      raceName: serializer.fromJson<String>(json['raceName']),
      classDefinitionId: serializer.fromJson<String?>(
        json['classDefinitionId'],
      ),
      backgroundDefinitionRefId: serializer.fromJson<String?>(
        json['backgroundDefinitionRefId'],
      ),
      className: serializer.fromJson<String>(json['className']),
      level: serializer.fromJson<int>(json['level']),
      experience: serializer.fromJson<int?>(json['experience']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'raceName': serializer.toJson<String>(raceName),
      'classDefinitionId': serializer.toJson<String?>(classDefinitionId),
      'backgroundDefinitionRefId': serializer.toJson<String?>(
        backgroundDefinitionRefId,
      ),
      'className': serializer.toJson<String>(className),
      'level': serializer.toJson<int>(level),
      'experience': serializer.toJson<int?>(experience),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Character copyWith({
    String? id,
    String? name,
    String? raceName,
    Value<String?> classDefinitionId = const Value.absent(),
    Value<String?> backgroundDefinitionRefId = const Value.absent(),
    String? className,
    int? level,
    Value<int?> experience = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Character(
    id: id ?? this.id,
    name: name ?? this.name,
    raceName: raceName ?? this.raceName,
    classDefinitionId: classDefinitionId.present
        ? classDefinitionId.value
        : this.classDefinitionId,
    backgroundDefinitionRefId: backgroundDefinitionRefId.present
        ? backgroundDefinitionRefId.value
        : this.backgroundDefinitionRefId,
    className: className ?? this.className,
    level: level ?? this.level,
    experience: experience.present ? experience.value : this.experience,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Character copyWithCompanion(CharactersCompanion data) {
    return Character(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      raceName: data.raceName.present ? data.raceName.value : this.raceName,
      classDefinitionId: data.classDefinitionId.present
          ? data.classDefinitionId.value
          : this.classDefinitionId,
      backgroundDefinitionRefId: data.backgroundDefinitionRefId.present
          ? data.backgroundDefinitionRefId.value
          : this.backgroundDefinitionRefId,
      className: data.className.present ? data.className.value : this.className,
      level: data.level.present ? data.level.value : this.level,
      experience: data.experience.present
          ? data.experience.value
          : this.experience,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Character(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('raceName: $raceName, ')
          ..write('classDefinitionId: $classDefinitionId, ')
          ..write('backgroundDefinitionRefId: $backgroundDefinitionRefId, ')
          ..write('className: $className, ')
          ..write('level: $level, ')
          ..write('experience: $experience, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    raceName,
    classDefinitionId,
    backgroundDefinitionRefId,
    className,
    level,
    experience,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Character &&
          other.id == this.id &&
          other.name == this.name &&
          other.raceName == this.raceName &&
          other.classDefinitionId == this.classDefinitionId &&
          other.backgroundDefinitionRefId == this.backgroundDefinitionRefId &&
          other.className == this.className &&
          other.level == this.level &&
          other.experience == this.experience &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CharactersCompanion extends UpdateCompanion<Character> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> raceName;
  final Value<String?> classDefinitionId;
  final Value<String?> backgroundDefinitionRefId;
  final Value<String> className;
  final Value<int> level;
  final Value<int?> experience;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CharactersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.raceName = const Value.absent(),
    this.classDefinitionId = const Value.absent(),
    this.backgroundDefinitionRefId = const Value.absent(),
    this.className = const Value.absent(),
    this.level = const Value.absent(),
    this.experience = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CharactersCompanion.insert({
    required String id,
    required String name,
    required String raceName,
    this.classDefinitionId = const Value.absent(),
    this.backgroundDefinitionRefId = const Value.absent(),
    required String className,
    required int level,
    this.experience = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       raceName = Value(raceName),
       className = Value(className),
       level = Value(level),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Character> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? raceName,
    Expression<String>? classDefinitionId,
    Expression<String>? backgroundDefinitionRefId,
    Expression<String>? className,
    Expression<int>? level,
    Expression<int>? experience,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (raceName != null) 'race_name': raceName,
      if (classDefinitionId != null) 'class_definition_id': classDefinitionId,
      if (backgroundDefinitionRefId != null)
        'background_definition_ref_id': backgroundDefinitionRefId,
      if (className != null) 'class_name': className,
      if (level != null) 'level': level,
      if (experience != null) 'experience': experience,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CharactersCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? raceName,
    Value<String?>? classDefinitionId,
    Value<String?>? backgroundDefinitionRefId,
    Value<String>? className,
    Value<int>? level,
    Value<int?>? experience,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return CharactersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      raceName: raceName ?? this.raceName,
      classDefinitionId: classDefinitionId ?? this.classDefinitionId,
      backgroundDefinitionRefId:
          backgroundDefinitionRefId ?? this.backgroundDefinitionRefId,
      className: className ?? this.className,
      level: level ?? this.level,
      experience: experience ?? this.experience,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (raceName.present) {
      map['race_name'] = Variable<String>(raceName.value);
    }
    if (classDefinitionId.present) {
      map['class_definition_id'] = Variable<String>(classDefinitionId.value);
    }
    if (backgroundDefinitionRefId.present) {
      map['background_definition_ref_id'] = Variable<String>(
        backgroundDefinitionRefId.value,
      );
    }
    if (className.present) {
      map['class_name'] = Variable<String>(className.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (experience.present) {
      map['experience'] = Variable<int>(experience.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CharactersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('raceName: $raceName, ')
          ..write('classDefinitionId: $classDefinitionId, ')
          ..write('backgroundDefinitionRefId: $backgroundDefinitionRefId, ')
          ..write('className: $className, ')
          ..write('level: $level, ')
          ..write('experience: $experience, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CharacterAbilityScoresTable extends CharacterAbilityScores
    with TableInfo<$CharacterAbilityScoresTable, CharacterAbilityScore> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CharacterAbilityScoresTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _characterIdMeta = const VerificationMeta(
    'characterId',
  );
  @override
  late final GeneratedColumn<String> characterId = GeneratedColumn<String>(
    'character_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES characters (id)',
    ),
  );
  static const VerificationMeta _strengthScoreMeta = const VerificationMeta(
    'strengthScore',
  );
  @override
  late final GeneratedColumn<int> strengthScore = GeneratedColumn<int>(
    'strength_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dexterityScoreMeta = const VerificationMeta(
    'dexterityScore',
  );
  @override
  late final GeneratedColumn<int> dexterityScore = GeneratedColumn<int>(
    'dexterity_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _constitutionScoreMeta = const VerificationMeta(
    'constitutionScore',
  );
  @override
  late final GeneratedColumn<int> constitutionScore = GeneratedColumn<int>(
    'constitution_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _intelligenceScoreMeta = const VerificationMeta(
    'intelligenceScore',
  );
  @override
  late final GeneratedColumn<int> intelligenceScore = GeneratedColumn<int>(
    'intelligence_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wisdomScoreMeta = const VerificationMeta(
    'wisdomScore',
  );
  @override
  late final GeneratedColumn<int> wisdomScore = GeneratedColumn<int>(
    'wisdom_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _charismaScoreMeta = const VerificationMeta(
    'charismaScore',
  );
  @override
  late final GeneratedColumn<int> charismaScore = GeneratedColumn<int>(
    'charisma_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _strengthModifierMeta = const VerificationMeta(
    'strengthModifier',
  );
  @override
  late final GeneratedColumn<int> strengthModifier = GeneratedColumn<int>(
    'strength_modifier',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dexterityModifierMeta = const VerificationMeta(
    'dexterityModifier',
  );
  @override
  late final GeneratedColumn<int> dexterityModifier = GeneratedColumn<int>(
    'dexterity_modifier',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _constitutionModifierMeta =
      const VerificationMeta('constitutionModifier');
  @override
  late final GeneratedColumn<int> constitutionModifier = GeneratedColumn<int>(
    'constitution_modifier',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _intelligenceModifierMeta =
      const VerificationMeta('intelligenceModifier');
  @override
  late final GeneratedColumn<int> intelligenceModifier = GeneratedColumn<int>(
    'intelligence_modifier',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _wisdomModifierMeta = const VerificationMeta(
    'wisdomModifier',
  );
  @override
  late final GeneratedColumn<int> wisdomModifier = GeneratedColumn<int>(
    'wisdom_modifier',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _charismaModifierMeta = const VerificationMeta(
    'charismaModifier',
  );
  @override
  late final GeneratedColumn<int> charismaModifier = GeneratedColumn<int>(
    'charisma_modifier',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    characterId,
    strengthScore,
    dexterityScore,
    constitutionScore,
    intelligenceScore,
    wisdomScore,
    charismaScore,
    strengthModifier,
    dexterityModifier,
    constitutionModifier,
    intelligenceModifier,
    wisdomModifier,
    charismaModifier,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'character_ability_scores';
  @override
  VerificationContext validateIntegrity(
    Insertable<CharacterAbilityScore> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('character_id')) {
      context.handle(
        _characterIdMeta,
        characterId.isAcceptableOrUnknown(
          data['character_id']!,
          _characterIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_characterIdMeta);
    }
    if (data.containsKey('strength_score')) {
      context.handle(
        _strengthScoreMeta,
        strengthScore.isAcceptableOrUnknown(
          data['strength_score']!,
          _strengthScoreMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_strengthScoreMeta);
    }
    if (data.containsKey('dexterity_score')) {
      context.handle(
        _dexterityScoreMeta,
        dexterityScore.isAcceptableOrUnknown(
          data['dexterity_score']!,
          _dexterityScoreMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dexterityScoreMeta);
    }
    if (data.containsKey('constitution_score')) {
      context.handle(
        _constitutionScoreMeta,
        constitutionScore.isAcceptableOrUnknown(
          data['constitution_score']!,
          _constitutionScoreMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_constitutionScoreMeta);
    }
    if (data.containsKey('intelligence_score')) {
      context.handle(
        _intelligenceScoreMeta,
        intelligenceScore.isAcceptableOrUnknown(
          data['intelligence_score']!,
          _intelligenceScoreMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_intelligenceScoreMeta);
    }
    if (data.containsKey('wisdom_score')) {
      context.handle(
        _wisdomScoreMeta,
        wisdomScore.isAcceptableOrUnknown(
          data['wisdom_score']!,
          _wisdomScoreMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_wisdomScoreMeta);
    }
    if (data.containsKey('charisma_score')) {
      context.handle(
        _charismaScoreMeta,
        charismaScore.isAcceptableOrUnknown(
          data['charisma_score']!,
          _charismaScoreMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_charismaScoreMeta);
    }
    if (data.containsKey('strength_modifier')) {
      context.handle(
        _strengthModifierMeta,
        strengthModifier.isAcceptableOrUnknown(
          data['strength_modifier']!,
          _strengthModifierMeta,
        ),
      );
    }
    if (data.containsKey('dexterity_modifier')) {
      context.handle(
        _dexterityModifierMeta,
        dexterityModifier.isAcceptableOrUnknown(
          data['dexterity_modifier']!,
          _dexterityModifierMeta,
        ),
      );
    }
    if (data.containsKey('constitution_modifier')) {
      context.handle(
        _constitutionModifierMeta,
        constitutionModifier.isAcceptableOrUnknown(
          data['constitution_modifier']!,
          _constitutionModifierMeta,
        ),
      );
    }
    if (data.containsKey('intelligence_modifier')) {
      context.handle(
        _intelligenceModifierMeta,
        intelligenceModifier.isAcceptableOrUnknown(
          data['intelligence_modifier']!,
          _intelligenceModifierMeta,
        ),
      );
    }
    if (data.containsKey('wisdom_modifier')) {
      context.handle(
        _wisdomModifierMeta,
        wisdomModifier.isAcceptableOrUnknown(
          data['wisdom_modifier']!,
          _wisdomModifierMeta,
        ),
      );
    }
    if (data.containsKey('charisma_modifier')) {
      context.handle(
        _charismaModifierMeta,
        charismaModifier.isAcceptableOrUnknown(
          data['charisma_modifier']!,
          _charismaModifierMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {characterId};
  @override
  CharacterAbilityScore map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CharacterAbilityScore(
      characterId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}character_id'],
      )!,
      strengthScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}strength_score'],
      )!,
      dexterityScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dexterity_score'],
      )!,
      constitutionScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}constitution_score'],
      )!,
      intelligenceScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}intelligence_score'],
      )!,
      wisdomScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wisdom_score'],
      )!,
      charismaScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}charisma_score'],
      )!,
      strengthModifier: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}strength_modifier'],
      ),
      dexterityModifier: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dexterity_modifier'],
      ),
      constitutionModifier: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}constitution_modifier'],
      ),
      intelligenceModifier: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}intelligence_modifier'],
      ),
      wisdomModifier: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wisdom_modifier'],
      ),
      charismaModifier: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}charisma_modifier'],
      ),
    );
  }

  @override
  $CharacterAbilityScoresTable createAlias(String alias) {
    return $CharacterAbilityScoresTable(attachedDatabase, alias);
  }
}

class CharacterAbilityScore extends DataClass
    implements Insertable<CharacterAbilityScore> {
  final String characterId;
  final int strengthScore;
  final int dexterityScore;
  final int constitutionScore;
  final int intelligenceScore;
  final int wisdomScore;
  final int charismaScore;
  final int? strengthModifier;
  final int? dexterityModifier;
  final int? constitutionModifier;
  final int? intelligenceModifier;
  final int? wisdomModifier;
  final int? charismaModifier;
  const CharacterAbilityScore({
    required this.characterId,
    required this.strengthScore,
    required this.dexterityScore,
    required this.constitutionScore,
    required this.intelligenceScore,
    required this.wisdomScore,
    required this.charismaScore,
    this.strengthModifier,
    this.dexterityModifier,
    this.constitutionModifier,
    this.intelligenceModifier,
    this.wisdomModifier,
    this.charismaModifier,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['character_id'] = Variable<String>(characterId);
    map['strength_score'] = Variable<int>(strengthScore);
    map['dexterity_score'] = Variable<int>(dexterityScore);
    map['constitution_score'] = Variable<int>(constitutionScore);
    map['intelligence_score'] = Variable<int>(intelligenceScore);
    map['wisdom_score'] = Variable<int>(wisdomScore);
    map['charisma_score'] = Variable<int>(charismaScore);
    if (!nullToAbsent || strengthModifier != null) {
      map['strength_modifier'] = Variable<int>(strengthModifier);
    }
    if (!nullToAbsent || dexterityModifier != null) {
      map['dexterity_modifier'] = Variable<int>(dexterityModifier);
    }
    if (!nullToAbsent || constitutionModifier != null) {
      map['constitution_modifier'] = Variable<int>(constitutionModifier);
    }
    if (!nullToAbsent || intelligenceModifier != null) {
      map['intelligence_modifier'] = Variable<int>(intelligenceModifier);
    }
    if (!nullToAbsent || wisdomModifier != null) {
      map['wisdom_modifier'] = Variable<int>(wisdomModifier);
    }
    if (!nullToAbsent || charismaModifier != null) {
      map['charisma_modifier'] = Variable<int>(charismaModifier);
    }
    return map;
  }

  CharacterAbilityScoresCompanion toCompanion(bool nullToAbsent) {
    return CharacterAbilityScoresCompanion(
      characterId: Value(characterId),
      strengthScore: Value(strengthScore),
      dexterityScore: Value(dexterityScore),
      constitutionScore: Value(constitutionScore),
      intelligenceScore: Value(intelligenceScore),
      wisdomScore: Value(wisdomScore),
      charismaScore: Value(charismaScore),
      strengthModifier: strengthModifier == null && nullToAbsent
          ? const Value.absent()
          : Value(strengthModifier),
      dexterityModifier: dexterityModifier == null && nullToAbsent
          ? const Value.absent()
          : Value(dexterityModifier),
      constitutionModifier: constitutionModifier == null && nullToAbsent
          ? const Value.absent()
          : Value(constitutionModifier),
      intelligenceModifier: intelligenceModifier == null && nullToAbsent
          ? const Value.absent()
          : Value(intelligenceModifier),
      wisdomModifier: wisdomModifier == null && nullToAbsent
          ? const Value.absent()
          : Value(wisdomModifier),
      charismaModifier: charismaModifier == null && nullToAbsent
          ? const Value.absent()
          : Value(charismaModifier),
    );
  }

  factory CharacterAbilityScore.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CharacterAbilityScore(
      characterId: serializer.fromJson<String>(json['characterId']),
      strengthScore: serializer.fromJson<int>(json['strengthScore']),
      dexterityScore: serializer.fromJson<int>(json['dexterityScore']),
      constitutionScore: serializer.fromJson<int>(json['constitutionScore']),
      intelligenceScore: serializer.fromJson<int>(json['intelligenceScore']),
      wisdomScore: serializer.fromJson<int>(json['wisdomScore']),
      charismaScore: serializer.fromJson<int>(json['charismaScore']),
      strengthModifier: serializer.fromJson<int?>(json['strengthModifier']),
      dexterityModifier: serializer.fromJson<int?>(json['dexterityModifier']),
      constitutionModifier: serializer.fromJson<int?>(
        json['constitutionModifier'],
      ),
      intelligenceModifier: serializer.fromJson<int?>(
        json['intelligenceModifier'],
      ),
      wisdomModifier: serializer.fromJson<int?>(json['wisdomModifier']),
      charismaModifier: serializer.fromJson<int?>(json['charismaModifier']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'characterId': serializer.toJson<String>(characterId),
      'strengthScore': serializer.toJson<int>(strengthScore),
      'dexterityScore': serializer.toJson<int>(dexterityScore),
      'constitutionScore': serializer.toJson<int>(constitutionScore),
      'intelligenceScore': serializer.toJson<int>(intelligenceScore),
      'wisdomScore': serializer.toJson<int>(wisdomScore),
      'charismaScore': serializer.toJson<int>(charismaScore),
      'strengthModifier': serializer.toJson<int?>(strengthModifier),
      'dexterityModifier': serializer.toJson<int?>(dexterityModifier),
      'constitutionModifier': serializer.toJson<int?>(constitutionModifier),
      'intelligenceModifier': serializer.toJson<int?>(intelligenceModifier),
      'wisdomModifier': serializer.toJson<int?>(wisdomModifier),
      'charismaModifier': serializer.toJson<int?>(charismaModifier),
    };
  }

  CharacterAbilityScore copyWith({
    String? characterId,
    int? strengthScore,
    int? dexterityScore,
    int? constitutionScore,
    int? intelligenceScore,
    int? wisdomScore,
    int? charismaScore,
    Value<int?> strengthModifier = const Value.absent(),
    Value<int?> dexterityModifier = const Value.absent(),
    Value<int?> constitutionModifier = const Value.absent(),
    Value<int?> intelligenceModifier = const Value.absent(),
    Value<int?> wisdomModifier = const Value.absent(),
    Value<int?> charismaModifier = const Value.absent(),
  }) => CharacterAbilityScore(
    characterId: characterId ?? this.characterId,
    strengthScore: strengthScore ?? this.strengthScore,
    dexterityScore: dexterityScore ?? this.dexterityScore,
    constitutionScore: constitutionScore ?? this.constitutionScore,
    intelligenceScore: intelligenceScore ?? this.intelligenceScore,
    wisdomScore: wisdomScore ?? this.wisdomScore,
    charismaScore: charismaScore ?? this.charismaScore,
    strengthModifier: strengthModifier.present
        ? strengthModifier.value
        : this.strengthModifier,
    dexterityModifier: dexterityModifier.present
        ? dexterityModifier.value
        : this.dexterityModifier,
    constitutionModifier: constitutionModifier.present
        ? constitutionModifier.value
        : this.constitutionModifier,
    intelligenceModifier: intelligenceModifier.present
        ? intelligenceModifier.value
        : this.intelligenceModifier,
    wisdomModifier: wisdomModifier.present
        ? wisdomModifier.value
        : this.wisdomModifier,
    charismaModifier: charismaModifier.present
        ? charismaModifier.value
        : this.charismaModifier,
  );
  CharacterAbilityScore copyWithCompanion(
    CharacterAbilityScoresCompanion data,
  ) {
    return CharacterAbilityScore(
      characterId: data.characterId.present
          ? data.characterId.value
          : this.characterId,
      strengthScore: data.strengthScore.present
          ? data.strengthScore.value
          : this.strengthScore,
      dexterityScore: data.dexterityScore.present
          ? data.dexterityScore.value
          : this.dexterityScore,
      constitutionScore: data.constitutionScore.present
          ? data.constitutionScore.value
          : this.constitutionScore,
      intelligenceScore: data.intelligenceScore.present
          ? data.intelligenceScore.value
          : this.intelligenceScore,
      wisdomScore: data.wisdomScore.present
          ? data.wisdomScore.value
          : this.wisdomScore,
      charismaScore: data.charismaScore.present
          ? data.charismaScore.value
          : this.charismaScore,
      strengthModifier: data.strengthModifier.present
          ? data.strengthModifier.value
          : this.strengthModifier,
      dexterityModifier: data.dexterityModifier.present
          ? data.dexterityModifier.value
          : this.dexterityModifier,
      constitutionModifier: data.constitutionModifier.present
          ? data.constitutionModifier.value
          : this.constitutionModifier,
      intelligenceModifier: data.intelligenceModifier.present
          ? data.intelligenceModifier.value
          : this.intelligenceModifier,
      wisdomModifier: data.wisdomModifier.present
          ? data.wisdomModifier.value
          : this.wisdomModifier,
      charismaModifier: data.charismaModifier.present
          ? data.charismaModifier.value
          : this.charismaModifier,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CharacterAbilityScore(')
          ..write('characterId: $characterId, ')
          ..write('strengthScore: $strengthScore, ')
          ..write('dexterityScore: $dexterityScore, ')
          ..write('constitutionScore: $constitutionScore, ')
          ..write('intelligenceScore: $intelligenceScore, ')
          ..write('wisdomScore: $wisdomScore, ')
          ..write('charismaScore: $charismaScore, ')
          ..write('strengthModifier: $strengthModifier, ')
          ..write('dexterityModifier: $dexterityModifier, ')
          ..write('constitutionModifier: $constitutionModifier, ')
          ..write('intelligenceModifier: $intelligenceModifier, ')
          ..write('wisdomModifier: $wisdomModifier, ')
          ..write('charismaModifier: $charismaModifier')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    characterId,
    strengthScore,
    dexterityScore,
    constitutionScore,
    intelligenceScore,
    wisdomScore,
    charismaScore,
    strengthModifier,
    dexterityModifier,
    constitutionModifier,
    intelligenceModifier,
    wisdomModifier,
    charismaModifier,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CharacterAbilityScore &&
          other.characterId == this.characterId &&
          other.strengthScore == this.strengthScore &&
          other.dexterityScore == this.dexterityScore &&
          other.constitutionScore == this.constitutionScore &&
          other.intelligenceScore == this.intelligenceScore &&
          other.wisdomScore == this.wisdomScore &&
          other.charismaScore == this.charismaScore &&
          other.strengthModifier == this.strengthModifier &&
          other.dexterityModifier == this.dexterityModifier &&
          other.constitutionModifier == this.constitutionModifier &&
          other.intelligenceModifier == this.intelligenceModifier &&
          other.wisdomModifier == this.wisdomModifier &&
          other.charismaModifier == this.charismaModifier);
}

class CharacterAbilityScoresCompanion
    extends UpdateCompanion<CharacterAbilityScore> {
  final Value<String> characterId;
  final Value<int> strengthScore;
  final Value<int> dexterityScore;
  final Value<int> constitutionScore;
  final Value<int> intelligenceScore;
  final Value<int> wisdomScore;
  final Value<int> charismaScore;
  final Value<int?> strengthModifier;
  final Value<int?> dexterityModifier;
  final Value<int?> constitutionModifier;
  final Value<int?> intelligenceModifier;
  final Value<int?> wisdomModifier;
  final Value<int?> charismaModifier;
  final Value<int> rowid;
  const CharacterAbilityScoresCompanion({
    this.characterId = const Value.absent(),
    this.strengthScore = const Value.absent(),
    this.dexterityScore = const Value.absent(),
    this.constitutionScore = const Value.absent(),
    this.intelligenceScore = const Value.absent(),
    this.wisdomScore = const Value.absent(),
    this.charismaScore = const Value.absent(),
    this.strengthModifier = const Value.absent(),
    this.dexterityModifier = const Value.absent(),
    this.constitutionModifier = const Value.absent(),
    this.intelligenceModifier = const Value.absent(),
    this.wisdomModifier = const Value.absent(),
    this.charismaModifier = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CharacterAbilityScoresCompanion.insert({
    required String characterId,
    required int strengthScore,
    required int dexterityScore,
    required int constitutionScore,
    required int intelligenceScore,
    required int wisdomScore,
    required int charismaScore,
    this.strengthModifier = const Value.absent(),
    this.dexterityModifier = const Value.absent(),
    this.constitutionModifier = const Value.absent(),
    this.intelligenceModifier = const Value.absent(),
    this.wisdomModifier = const Value.absent(),
    this.charismaModifier = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : characterId = Value(characterId),
       strengthScore = Value(strengthScore),
       dexterityScore = Value(dexterityScore),
       constitutionScore = Value(constitutionScore),
       intelligenceScore = Value(intelligenceScore),
       wisdomScore = Value(wisdomScore),
       charismaScore = Value(charismaScore);
  static Insertable<CharacterAbilityScore> custom({
    Expression<String>? characterId,
    Expression<int>? strengthScore,
    Expression<int>? dexterityScore,
    Expression<int>? constitutionScore,
    Expression<int>? intelligenceScore,
    Expression<int>? wisdomScore,
    Expression<int>? charismaScore,
    Expression<int>? strengthModifier,
    Expression<int>? dexterityModifier,
    Expression<int>? constitutionModifier,
    Expression<int>? intelligenceModifier,
    Expression<int>? wisdomModifier,
    Expression<int>? charismaModifier,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (characterId != null) 'character_id': characterId,
      if (strengthScore != null) 'strength_score': strengthScore,
      if (dexterityScore != null) 'dexterity_score': dexterityScore,
      if (constitutionScore != null) 'constitution_score': constitutionScore,
      if (intelligenceScore != null) 'intelligence_score': intelligenceScore,
      if (wisdomScore != null) 'wisdom_score': wisdomScore,
      if (charismaScore != null) 'charisma_score': charismaScore,
      if (strengthModifier != null) 'strength_modifier': strengthModifier,
      if (dexterityModifier != null) 'dexterity_modifier': dexterityModifier,
      if (constitutionModifier != null)
        'constitution_modifier': constitutionModifier,
      if (intelligenceModifier != null)
        'intelligence_modifier': intelligenceModifier,
      if (wisdomModifier != null) 'wisdom_modifier': wisdomModifier,
      if (charismaModifier != null) 'charisma_modifier': charismaModifier,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CharacterAbilityScoresCompanion copyWith({
    Value<String>? characterId,
    Value<int>? strengthScore,
    Value<int>? dexterityScore,
    Value<int>? constitutionScore,
    Value<int>? intelligenceScore,
    Value<int>? wisdomScore,
    Value<int>? charismaScore,
    Value<int?>? strengthModifier,
    Value<int?>? dexterityModifier,
    Value<int?>? constitutionModifier,
    Value<int?>? intelligenceModifier,
    Value<int?>? wisdomModifier,
    Value<int?>? charismaModifier,
    Value<int>? rowid,
  }) {
    return CharacterAbilityScoresCompanion(
      characterId: characterId ?? this.characterId,
      strengthScore: strengthScore ?? this.strengthScore,
      dexterityScore: dexterityScore ?? this.dexterityScore,
      constitutionScore: constitutionScore ?? this.constitutionScore,
      intelligenceScore: intelligenceScore ?? this.intelligenceScore,
      wisdomScore: wisdomScore ?? this.wisdomScore,
      charismaScore: charismaScore ?? this.charismaScore,
      strengthModifier: strengthModifier ?? this.strengthModifier,
      dexterityModifier: dexterityModifier ?? this.dexterityModifier,
      constitutionModifier: constitutionModifier ?? this.constitutionModifier,
      intelligenceModifier: intelligenceModifier ?? this.intelligenceModifier,
      wisdomModifier: wisdomModifier ?? this.wisdomModifier,
      charismaModifier: charismaModifier ?? this.charismaModifier,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (characterId.present) {
      map['character_id'] = Variable<String>(characterId.value);
    }
    if (strengthScore.present) {
      map['strength_score'] = Variable<int>(strengthScore.value);
    }
    if (dexterityScore.present) {
      map['dexterity_score'] = Variable<int>(dexterityScore.value);
    }
    if (constitutionScore.present) {
      map['constitution_score'] = Variable<int>(constitutionScore.value);
    }
    if (intelligenceScore.present) {
      map['intelligence_score'] = Variable<int>(intelligenceScore.value);
    }
    if (wisdomScore.present) {
      map['wisdom_score'] = Variable<int>(wisdomScore.value);
    }
    if (charismaScore.present) {
      map['charisma_score'] = Variable<int>(charismaScore.value);
    }
    if (strengthModifier.present) {
      map['strength_modifier'] = Variable<int>(strengthModifier.value);
    }
    if (dexterityModifier.present) {
      map['dexterity_modifier'] = Variable<int>(dexterityModifier.value);
    }
    if (constitutionModifier.present) {
      map['constitution_modifier'] = Variable<int>(constitutionModifier.value);
    }
    if (intelligenceModifier.present) {
      map['intelligence_modifier'] = Variable<int>(intelligenceModifier.value);
    }
    if (wisdomModifier.present) {
      map['wisdom_modifier'] = Variable<int>(wisdomModifier.value);
    }
    if (charismaModifier.present) {
      map['charisma_modifier'] = Variable<int>(charismaModifier.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CharacterAbilityScoresCompanion(')
          ..write('characterId: $characterId, ')
          ..write('strengthScore: $strengthScore, ')
          ..write('dexterityScore: $dexterityScore, ')
          ..write('constitutionScore: $constitutionScore, ')
          ..write('intelligenceScore: $intelligenceScore, ')
          ..write('wisdomScore: $wisdomScore, ')
          ..write('charismaScore: $charismaScore, ')
          ..write('strengthModifier: $strengthModifier, ')
          ..write('dexterityModifier: $dexterityModifier, ')
          ..write('constitutionModifier: $constitutionModifier, ')
          ..write('intelligenceModifier: $intelligenceModifier, ')
          ..write('wisdomModifier: $wisdomModifier, ')
          ..write('charismaModifier: $charismaModifier, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CharacterAbilityScoreProvenancesTable
    extends CharacterAbilityScoreProvenances
    with
        TableInfo<
          $CharacterAbilityScoreProvenancesTable,
          CharacterAbilityScoreProvenance
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CharacterAbilityScoreProvenancesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _characterIdMeta = const VerificationMeta(
    'characterId',
  );
  @override
  late final GeneratedColumn<String> characterId = GeneratedColumn<String>(
    'character_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES characters (id)',
    ),
  );
  static const VerificationMeta _methodKeyMeta = const VerificationMeta(
    'methodKey',
  );
  @override
  late final GeneratedColumn<String> methodKey = GeneratedColumn<String>(
    'method_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _strengthAssignedScoreMeta =
      const VerificationMeta('strengthAssignedScore');
  @override
  late final GeneratedColumn<int> strengthAssignedScore = GeneratedColumn<int>(
    'strength_assigned_score',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dexterityAssignedScoreMeta =
      const VerificationMeta('dexterityAssignedScore');
  @override
  late final GeneratedColumn<int> dexterityAssignedScore = GeneratedColumn<int>(
    'dexterity_assigned_score',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _constitutionAssignedScoreMeta =
      const VerificationMeta('constitutionAssignedScore');
  @override
  late final GeneratedColumn<int> constitutionAssignedScore =
      GeneratedColumn<int>(
        'constitution_assigned_score',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _intelligenceAssignedScoreMeta =
      const VerificationMeta('intelligenceAssignedScore');
  @override
  late final GeneratedColumn<int> intelligenceAssignedScore =
      GeneratedColumn<int>(
        'intelligence_assigned_score',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _wisdomAssignedScoreMeta =
      const VerificationMeta('wisdomAssignedScore');
  @override
  late final GeneratedColumn<int> wisdomAssignedScore = GeneratedColumn<int>(
    'wisdom_assigned_score',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _charismaAssignedScoreMeta =
      const VerificationMeta('charismaAssignedScore');
  @override
  late final GeneratedColumn<int> charismaAssignedScore = GeneratedColumn<int>(
    'charisma_assigned_score',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    characterId,
    methodKey,
    strengthAssignedScore,
    dexterityAssignedScore,
    constitutionAssignedScore,
    intelligenceAssignedScore,
    wisdomAssignedScore,
    charismaAssignedScore,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'character_ability_score_provenances';
  @override
  VerificationContext validateIntegrity(
    Insertable<CharacterAbilityScoreProvenance> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('character_id')) {
      context.handle(
        _characterIdMeta,
        characterId.isAcceptableOrUnknown(
          data['character_id']!,
          _characterIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_characterIdMeta);
    }
    if (data.containsKey('method_key')) {
      context.handle(
        _methodKeyMeta,
        methodKey.isAcceptableOrUnknown(data['method_key']!, _methodKeyMeta),
      );
    }
    if (data.containsKey('strength_assigned_score')) {
      context.handle(
        _strengthAssignedScoreMeta,
        strengthAssignedScore.isAcceptableOrUnknown(
          data['strength_assigned_score']!,
          _strengthAssignedScoreMeta,
        ),
      );
    }
    if (data.containsKey('dexterity_assigned_score')) {
      context.handle(
        _dexterityAssignedScoreMeta,
        dexterityAssignedScore.isAcceptableOrUnknown(
          data['dexterity_assigned_score']!,
          _dexterityAssignedScoreMeta,
        ),
      );
    }
    if (data.containsKey('constitution_assigned_score')) {
      context.handle(
        _constitutionAssignedScoreMeta,
        constitutionAssignedScore.isAcceptableOrUnknown(
          data['constitution_assigned_score']!,
          _constitutionAssignedScoreMeta,
        ),
      );
    }
    if (data.containsKey('intelligence_assigned_score')) {
      context.handle(
        _intelligenceAssignedScoreMeta,
        intelligenceAssignedScore.isAcceptableOrUnknown(
          data['intelligence_assigned_score']!,
          _intelligenceAssignedScoreMeta,
        ),
      );
    }
    if (data.containsKey('wisdom_assigned_score')) {
      context.handle(
        _wisdomAssignedScoreMeta,
        wisdomAssignedScore.isAcceptableOrUnknown(
          data['wisdom_assigned_score']!,
          _wisdomAssignedScoreMeta,
        ),
      );
    }
    if (data.containsKey('charisma_assigned_score')) {
      context.handle(
        _charismaAssignedScoreMeta,
        charismaAssignedScore.isAcceptableOrUnknown(
          data['charisma_assigned_score']!,
          _charismaAssignedScoreMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {characterId};
  @override
  CharacterAbilityScoreProvenance map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CharacterAbilityScoreProvenance(
      characterId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}character_id'],
      )!,
      methodKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}method_key'],
      ),
      strengthAssignedScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}strength_assigned_score'],
      ),
      dexterityAssignedScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dexterity_assigned_score'],
      ),
      constitutionAssignedScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}constitution_assigned_score'],
      ),
      intelligenceAssignedScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}intelligence_assigned_score'],
      ),
      wisdomAssignedScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wisdom_assigned_score'],
      ),
      charismaAssignedScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}charisma_assigned_score'],
      ),
    );
  }

  @override
  $CharacterAbilityScoreProvenancesTable createAlias(String alias) {
    return $CharacterAbilityScoreProvenancesTable(attachedDatabase, alias);
  }
}

class CharacterAbilityScoreProvenance extends DataClass
    implements Insertable<CharacterAbilityScoreProvenance> {
  final String characterId;
  final String? methodKey;
  final int? strengthAssignedScore;
  final int? dexterityAssignedScore;
  final int? constitutionAssignedScore;
  final int? intelligenceAssignedScore;
  final int? wisdomAssignedScore;
  final int? charismaAssignedScore;
  const CharacterAbilityScoreProvenance({
    required this.characterId,
    this.methodKey,
    this.strengthAssignedScore,
    this.dexterityAssignedScore,
    this.constitutionAssignedScore,
    this.intelligenceAssignedScore,
    this.wisdomAssignedScore,
    this.charismaAssignedScore,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['character_id'] = Variable<String>(characterId);
    if (!nullToAbsent || methodKey != null) {
      map['method_key'] = Variable<String>(methodKey);
    }
    if (!nullToAbsent || strengthAssignedScore != null) {
      map['strength_assigned_score'] = Variable<int>(strengthAssignedScore);
    }
    if (!nullToAbsent || dexterityAssignedScore != null) {
      map['dexterity_assigned_score'] = Variable<int>(dexterityAssignedScore);
    }
    if (!nullToAbsent || constitutionAssignedScore != null) {
      map['constitution_assigned_score'] = Variable<int>(
        constitutionAssignedScore,
      );
    }
    if (!nullToAbsent || intelligenceAssignedScore != null) {
      map['intelligence_assigned_score'] = Variable<int>(
        intelligenceAssignedScore,
      );
    }
    if (!nullToAbsent || wisdomAssignedScore != null) {
      map['wisdom_assigned_score'] = Variable<int>(wisdomAssignedScore);
    }
    if (!nullToAbsent || charismaAssignedScore != null) {
      map['charisma_assigned_score'] = Variable<int>(charismaAssignedScore);
    }
    return map;
  }

  CharacterAbilityScoreProvenancesCompanion toCompanion(bool nullToAbsent) {
    return CharacterAbilityScoreProvenancesCompanion(
      characterId: Value(characterId),
      methodKey: methodKey == null && nullToAbsent
          ? const Value.absent()
          : Value(methodKey),
      strengthAssignedScore: strengthAssignedScore == null && nullToAbsent
          ? const Value.absent()
          : Value(strengthAssignedScore),
      dexterityAssignedScore: dexterityAssignedScore == null && nullToAbsent
          ? const Value.absent()
          : Value(dexterityAssignedScore),
      constitutionAssignedScore:
          constitutionAssignedScore == null && nullToAbsent
          ? const Value.absent()
          : Value(constitutionAssignedScore),
      intelligenceAssignedScore:
          intelligenceAssignedScore == null && nullToAbsent
          ? const Value.absent()
          : Value(intelligenceAssignedScore),
      wisdomAssignedScore: wisdomAssignedScore == null && nullToAbsent
          ? const Value.absent()
          : Value(wisdomAssignedScore),
      charismaAssignedScore: charismaAssignedScore == null && nullToAbsent
          ? const Value.absent()
          : Value(charismaAssignedScore),
    );
  }

  factory CharacterAbilityScoreProvenance.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CharacterAbilityScoreProvenance(
      characterId: serializer.fromJson<String>(json['characterId']),
      methodKey: serializer.fromJson<String?>(json['methodKey']),
      strengthAssignedScore: serializer.fromJson<int?>(
        json['strengthAssignedScore'],
      ),
      dexterityAssignedScore: serializer.fromJson<int?>(
        json['dexterityAssignedScore'],
      ),
      constitutionAssignedScore: serializer.fromJson<int?>(
        json['constitutionAssignedScore'],
      ),
      intelligenceAssignedScore: serializer.fromJson<int?>(
        json['intelligenceAssignedScore'],
      ),
      wisdomAssignedScore: serializer.fromJson<int?>(
        json['wisdomAssignedScore'],
      ),
      charismaAssignedScore: serializer.fromJson<int?>(
        json['charismaAssignedScore'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'characterId': serializer.toJson<String>(characterId),
      'methodKey': serializer.toJson<String?>(methodKey),
      'strengthAssignedScore': serializer.toJson<int?>(strengthAssignedScore),
      'dexterityAssignedScore': serializer.toJson<int?>(dexterityAssignedScore),
      'constitutionAssignedScore': serializer.toJson<int?>(
        constitutionAssignedScore,
      ),
      'intelligenceAssignedScore': serializer.toJson<int?>(
        intelligenceAssignedScore,
      ),
      'wisdomAssignedScore': serializer.toJson<int?>(wisdomAssignedScore),
      'charismaAssignedScore': serializer.toJson<int?>(charismaAssignedScore),
    };
  }

  CharacterAbilityScoreProvenance copyWith({
    String? characterId,
    Value<String?> methodKey = const Value.absent(),
    Value<int?> strengthAssignedScore = const Value.absent(),
    Value<int?> dexterityAssignedScore = const Value.absent(),
    Value<int?> constitutionAssignedScore = const Value.absent(),
    Value<int?> intelligenceAssignedScore = const Value.absent(),
    Value<int?> wisdomAssignedScore = const Value.absent(),
    Value<int?> charismaAssignedScore = const Value.absent(),
  }) => CharacterAbilityScoreProvenance(
    characterId: characterId ?? this.characterId,
    methodKey: methodKey.present ? methodKey.value : this.methodKey,
    strengthAssignedScore: strengthAssignedScore.present
        ? strengthAssignedScore.value
        : this.strengthAssignedScore,
    dexterityAssignedScore: dexterityAssignedScore.present
        ? dexterityAssignedScore.value
        : this.dexterityAssignedScore,
    constitutionAssignedScore: constitutionAssignedScore.present
        ? constitutionAssignedScore.value
        : this.constitutionAssignedScore,
    intelligenceAssignedScore: intelligenceAssignedScore.present
        ? intelligenceAssignedScore.value
        : this.intelligenceAssignedScore,
    wisdomAssignedScore: wisdomAssignedScore.present
        ? wisdomAssignedScore.value
        : this.wisdomAssignedScore,
    charismaAssignedScore: charismaAssignedScore.present
        ? charismaAssignedScore.value
        : this.charismaAssignedScore,
  );
  CharacterAbilityScoreProvenance copyWithCompanion(
    CharacterAbilityScoreProvenancesCompanion data,
  ) {
    return CharacterAbilityScoreProvenance(
      characterId: data.characterId.present
          ? data.characterId.value
          : this.characterId,
      methodKey: data.methodKey.present ? data.methodKey.value : this.methodKey,
      strengthAssignedScore: data.strengthAssignedScore.present
          ? data.strengthAssignedScore.value
          : this.strengthAssignedScore,
      dexterityAssignedScore: data.dexterityAssignedScore.present
          ? data.dexterityAssignedScore.value
          : this.dexterityAssignedScore,
      constitutionAssignedScore: data.constitutionAssignedScore.present
          ? data.constitutionAssignedScore.value
          : this.constitutionAssignedScore,
      intelligenceAssignedScore: data.intelligenceAssignedScore.present
          ? data.intelligenceAssignedScore.value
          : this.intelligenceAssignedScore,
      wisdomAssignedScore: data.wisdomAssignedScore.present
          ? data.wisdomAssignedScore.value
          : this.wisdomAssignedScore,
      charismaAssignedScore: data.charismaAssignedScore.present
          ? data.charismaAssignedScore.value
          : this.charismaAssignedScore,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CharacterAbilityScoreProvenance(')
          ..write('characterId: $characterId, ')
          ..write('methodKey: $methodKey, ')
          ..write('strengthAssignedScore: $strengthAssignedScore, ')
          ..write('dexterityAssignedScore: $dexterityAssignedScore, ')
          ..write('constitutionAssignedScore: $constitutionAssignedScore, ')
          ..write('intelligenceAssignedScore: $intelligenceAssignedScore, ')
          ..write('wisdomAssignedScore: $wisdomAssignedScore, ')
          ..write('charismaAssignedScore: $charismaAssignedScore')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    characterId,
    methodKey,
    strengthAssignedScore,
    dexterityAssignedScore,
    constitutionAssignedScore,
    intelligenceAssignedScore,
    wisdomAssignedScore,
    charismaAssignedScore,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CharacterAbilityScoreProvenance &&
          other.characterId == this.characterId &&
          other.methodKey == this.methodKey &&
          other.strengthAssignedScore == this.strengthAssignedScore &&
          other.dexterityAssignedScore == this.dexterityAssignedScore &&
          other.constitutionAssignedScore == this.constitutionAssignedScore &&
          other.intelligenceAssignedScore == this.intelligenceAssignedScore &&
          other.wisdomAssignedScore == this.wisdomAssignedScore &&
          other.charismaAssignedScore == this.charismaAssignedScore);
}

class CharacterAbilityScoreProvenancesCompanion
    extends UpdateCompanion<CharacterAbilityScoreProvenance> {
  final Value<String> characterId;
  final Value<String?> methodKey;
  final Value<int?> strengthAssignedScore;
  final Value<int?> dexterityAssignedScore;
  final Value<int?> constitutionAssignedScore;
  final Value<int?> intelligenceAssignedScore;
  final Value<int?> wisdomAssignedScore;
  final Value<int?> charismaAssignedScore;
  final Value<int> rowid;
  const CharacterAbilityScoreProvenancesCompanion({
    this.characterId = const Value.absent(),
    this.methodKey = const Value.absent(),
    this.strengthAssignedScore = const Value.absent(),
    this.dexterityAssignedScore = const Value.absent(),
    this.constitutionAssignedScore = const Value.absent(),
    this.intelligenceAssignedScore = const Value.absent(),
    this.wisdomAssignedScore = const Value.absent(),
    this.charismaAssignedScore = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CharacterAbilityScoreProvenancesCompanion.insert({
    required String characterId,
    this.methodKey = const Value.absent(),
    this.strengthAssignedScore = const Value.absent(),
    this.dexterityAssignedScore = const Value.absent(),
    this.constitutionAssignedScore = const Value.absent(),
    this.intelligenceAssignedScore = const Value.absent(),
    this.wisdomAssignedScore = const Value.absent(),
    this.charismaAssignedScore = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : characterId = Value(characterId);
  static Insertable<CharacterAbilityScoreProvenance> custom({
    Expression<String>? characterId,
    Expression<String>? methodKey,
    Expression<int>? strengthAssignedScore,
    Expression<int>? dexterityAssignedScore,
    Expression<int>? constitutionAssignedScore,
    Expression<int>? intelligenceAssignedScore,
    Expression<int>? wisdomAssignedScore,
    Expression<int>? charismaAssignedScore,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (characterId != null) 'character_id': characterId,
      if (methodKey != null) 'method_key': methodKey,
      if (strengthAssignedScore != null)
        'strength_assigned_score': strengthAssignedScore,
      if (dexterityAssignedScore != null)
        'dexterity_assigned_score': dexterityAssignedScore,
      if (constitutionAssignedScore != null)
        'constitution_assigned_score': constitutionAssignedScore,
      if (intelligenceAssignedScore != null)
        'intelligence_assigned_score': intelligenceAssignedScore,
      if (wisdomAssignedScore != null)
        'wisdom_assigned_score': wisdomAssignedScore,
      if (charismaAssignedScore != null)
        'charisma_assigned_score': charismaAssignedScore,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CharacterAbilityScoreProvenancesCompanion copyWith({
    Value<String>? characterId,
    Value<String?>? methodKey,
    Value<int?>? strengthAssignedScore,
    Value<int?>? dexterityAssignedScore,
    Value<int?>? constitutionAssignedScore,
    Value<int?>? intelligenceAssignedScore,
    Value<int?>? wisdomAssignedScore,
    Value<int?>? charismaAssignedScore,
    Value<int>? rowid,
  }) {
    return CharacterAbilityScoreProvenancesCompanion(
      characterId: characterId ?? this.characterId,
      methodKey: methodKey ?? this.methodKey,
      strengthAssignedScore:
          strengthAssignedScore ?? this.strengthAssignedScore,
      dexterityAssignedScore:
          dexterityAssignedScore ?? this.dexterityAssignedScore,
      constitutionAssignedScore:
          constitutionAssignedScore ?? this.constitutionAssignedScore,
      intelligenceAssignedScore:
          intelligenceAssignedScore ?? this.intelligenceAssignedScore,
      wisdomAssignedScore: wisdomAssignedScore ?? this.wisdomAssignedScore,
      charismaAssignedScore:
          charismaAssignedScore ?? this.charismaAssignedScore,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (characterId.present) {
      map['character_id'] = Variable<String>(characterId.value);
    }
    if (methodKey.present) {
      map['method_key'] = Variable<String>(methodKey.value);
    }
    if (strengthAssignedScore.present) {
      map['strength_assigned_score'] = Variable<int>(
        strengthAssignedScore.value,
      );
    }
    if (dexterityAssignedScore.present) {
      map['dexterity_assigned_score'] = Variable<int>(
        dexterityAssignedScore.value,
      );
    }
    if (constitutionAssignedScore.present) {
      map['constitution_assigned_score'] = Variable<int>(
        constitutionAssignedScore.value,
      );
    }
    if (intelligenceAssignedScore.present) {
      map['intelligence_assigned_score'] = Variable<int>(
        intelligenceAssignedScore.value,
      );
    }
    if (wisdomAssignedScore.present) {
      map['wisdom_assigned_score'] = Variable<int>(wisdomAssignedScore.value);
    }
    if (charismaAssignedScore.present) {
      map['charisma_assigned_score'] = Variable<int>(
        charismaAssignedScore.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CharacterAbilityScoreProvenancesCompanion(')
          ..write('characterId: $characterId, ')
          ..write('methodKey: $methodKey, ')
          ..write('strengthAssignedScore: $strengthAssignedScore, ')
          ..write('dexterityAssignedScore: $dexterityAssignedScore, ')
          ..write('constitutionAssignedScore: $constitutionAssignedScore, ')
          ..write('intelligenceAssignedScore: $intelligenceAssignedScore, ')
          ..write('wisdomAssignedScore: $wisdomAssignedScore, ')
          ..write('charismaAssignedScore: $charismaAssignedScore, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CharacterHitPointsTable extends CharacterHitPoints
    with TableInfo<$CharacterHitPointsTable, CharacterHitPoint> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CharacterHitPointsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _characterIdMeta = const VerificationMeta(
    'characterId',
  );
  @override
  late final GeneratedColumn<String> characterId = GeneratedColumn<String>(
    'character_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES characters (id)',
    ),
  );
  static const VerificationMeta _currentMeta = const VerificationMeta(
    'current',
  );
  @override
  late final GeneratedColumn<int> current = GeneratedColumn<int>(
    'current_hit_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maximumMeta = const VerificationMeta(
    'maximum',
  );
  @override
  late final GeneratedColumn<int> maximum = GeneratedColumn<int>(
    'maximum_hit_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _temporaryMeta = const VerificationMeta(
    'temporary',
  );
  @override
  late final GeneratedColumn<int> temporary = GeneratedColumn<int>(
    'temporary_hit_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    characterId,
    current,
    maximum,
    temporary,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'character_hit_points';
  @override
  VerificationContext validateIntegrity(
    Insertable<CharacterHitPoint> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('character_id')) {
      context.handle(
        _characterIdMeta,
        characterId.isAcceptableOrUnknown(
          data['character_id']!,
          _characterIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_characterIdMeta);
    }
    if (data.containsKey('current_hit_points')) {
      context.handle(
        _currentMeta,
        current.isAcceptableOrUnknown(
          data['current_hit_points']!,
          _currentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currentMeta);
    }
    if (data.containsKey('maximum_hit_points')) {
      context.handle(
        _maximumMeta,
        maximum.isAcceptableOrUnknown(
          data['maximum_hit_points']!,
          _maximumMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_maximumMeta);
    }
    if (data.containsKey('temporary_hit_points')) {
      context.handle(
        _temporaryMeta,
        temporary.isAcceptableOrUnknown(
          data['temporary_hit_points']!,
          _temporaryMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_temporaryMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {characterId};
  @override
  CharacterHitPoint map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CharacterHitPoint(
      characterId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}character_id'],
      )!,
      current: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_hit_points'],
      )!,
      maximum: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}maximum_hit_points'],
      )!,
      temporary: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}temporary_hit_points'],
      )!,
    );
  }

  @override
  $CharacterHitPointsTable createAlias(String alias) {
    return $CharacterHitPointsTable(attachedDatabase, alias);
  }
}

class CharacterHitPoint extends DataClass
    implements Insertable<CharacterHitPoint> {
  final String characterId;
  final int current;
  final int maximum;
  final int temporary;
  const CharacterHitPoint({
    required this.characterId,
    required this.current,
    required this.maximum,
    required this.temporary,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['character_id'] = Variable<String>(characterId);
    map['current_hit_points'] = Variable<int>(current);
    map['maximum_hit_points'] = Variable<int>(maximum);
    map['temporary_hit_points'] = Variable<int>(temporary);
    return map;
  }

  CharacterHitPointsCompanion toCompanion(bool nullToAbsent) {
    return CharacterHitPointsCompanion(
      characterId: Value(characterId),
      current: Value(current),
      maximum: Value(maximum),
      temporary: Value(temporary),
    );
  }

  factory CharacterHitPoint.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CharacterHitPoint(
      characterId: serializer.fromJson<String>(json['characterId']),
      current: serializer.fromJson<int>(json['current']),
      maximum: serializer.fromJson<int>(json['maximum']),
      temporary: serializer.fromJson<int>(json['temporary']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'characterId': serializer.toJson<String>(characterId),
      'current': serializer.toJson<int>(current),
      'maximum': serializer.toJson<int>(maximum),
      'temporary': serializer.toJson<int>(temporary),
    };
  }

  CharacterHitPoint copyWith({
    String? characterId,
    int? current,
    int? maximum,
    int? temporary,
  }) => CharacterHitPoint(
    characterId: characterId ?? this.characterId,
    current: current ?? this.current,
    maximum: maximum ?? this.maximum,
    temporary: temporary ?? this.temporary,
  );
  CharacterHitPoint copyWithCompanion(CharacterHitPointsCompanion data) {
    return CharacterHitPoint(
      characterId: data.characterId.present
          ? data.characterId.value
          : this.characterId,
      current: data.current.present ? data.current.value : this.current,
      maximum: data.maximum.present ? data.maximum.value : this.maximum,
      temporary: data.temporary.present ? data.temporary.value : this.temporary,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CharacterHitPoint(')
          ..write('characterId: $characterId, ')
          ..write('current: $current, ')
          ..write('maximum: $maximum, ')
          ..write('temporary: $temporary')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(characterId, current, maximum, temporary);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CharacterHitPoint &&
          other.characterId == this.characterId &&
          other.current == this.current &&
          other.maximum == this.maximum &&
          other.temporary == this.temporary);
}

class CharacterHitPointsCompanion extends UpdateCompanion<CharacterHitPoint> {
  final Value<String> characterId;
  final Value<int> current;
  final Value<int> maximum;
  final Value<int> temporary;
  final Value<int> rowid;
  const CharacterHitPointsCompanion({
    this.characterId = const Value.absent(),
    this.current = const Value.absent(),
    this.maximum = const Value.absent(),
    this.temporary = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CharacterHitPointsCompanion.insert({
    required String characterId,
    required int current,
    required int maximum,
    required int temporary,
    this.rowid = const Value.absent(),
  }) : characterId = Value(characterId),
       current = Value(current),
       maximum = Value(maximum),
       temporary = Value(temporary);
  static Insertable<CharacterHitPoint> custom({
    Expression<String>? characterId,
    Expression<int>? current,
    Expression<int>? maximum,
    Expression<int>? temporary,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (characterId != null) 'character_id': characterId,
      if (current != null) 'current_hit_points': current,
      if (maximum != null) 'maximum_hit_points': maximum,
      if (temporary != null) 'temporary_hit_points': temporary,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CharacterHitPointsCompanion copyWith({
    Value<String>? characterId,
    Value<int>? current,
    Value<int>? maximum,
    Value<int>? temporary,
    Value<int>? rowid,
  }) {
    return CharacterHitPointsCompanion(
      characterId: characterId ?? this.characterId,
      current: current ?? this.current,
      maximum: maximum ?? this.maximum,
      temporary: temporary ?? this.temporary,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (characterId.present) {
      map['character_id'] = Variable<String>(characterId.value);
    }
    if (current.present) {
      map['current_hit_points'] = Variable<int>(current.value);
    }
    if (maximum.present) {
      map['maximum_hit_points'] = Variable<int>(maximum.value);
    }
    if (temporary.present) {
      map['temporary_hit_points'] = Variable<int>(temporary.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CharacterHitPointsCompanion(')
          ..write('characterId: $characterId, ')
          ..write('current: $current, ')
          ..write('maximum: $maximum, ')
          ..write('temporary: $temporary, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CharacterFinishingDetailsTable extends CharacterFinishingDetails
    with TableInfo<$CharacterFinishingDetailsTable, CharacterFinishingDetail> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CharacterFinishingDetailsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _characterIdMeta = const VerificationMeta(
    'characterId',
  );
  @override
  late final GeneratedColumn<String> characterId = GeneratedColumn<String>(
    'character_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES characters (id)',
    ),
  );
  static const VerificationMeta _portraitAssetPathMeta = const VerificationMeta(
    'portraitAssetPath',
  );
  @override
  late final GeneratedColumn<String> portraitAssetPath =
      GeneratedColumn<String>(
        'portrait_asset_path',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _alignmentMeta = const VerificationMeta(
    'alignment',
  );
  @override
  late final GeneratedColumn<String> alignment = GeneratedColumn<String>(
    'alignment',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _appearanceDetailsMeta = const VerificationMeta(
    'appearanceDetails',
  );
  @override
  late final GeneratedColumn<String> appearanceDetails =
      GeneratedColumn<String>(
        'appearance_details',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _narrativeDetailsMeta = const VerificationMeta(
    'narrativeDetails',
  );
  @override
  late final GeneratedColumn<String> narrativeDetails = GeneratedColumn<String>(
    'narrative_details',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    characterId,
    portraitAssetPath,
    alignment,
    appearanceDetails,
    narrativeDetails,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'character_finishing_details';
  @override
  VerificationContext validateIntegrity(
    Insertable<CharacterFinishingDetail> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('character_id')) {
      context.handle(
        _characterIdMeta,
        characterId.isAcceptableOrUnknown(
          data['character_id']!,
          _characterIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_characterIdMeta);
    }
    if (data.containsKey('portrait_asset_path')) {
      context.handle(
        _portraitAssetPathMeta,
        portraitAssetPath.isAcceptableOrUnknown(
          data['portrait_asset_path']!,
          _portraitAssetPathMeta,
        ),
      );
    }
    if (data.containsKey('alignment')) {
      context.handle(
        _alignmentMeta,
        alignment.isAcceptableOrUnknown(data['alignment']!, _alignmentMeta),
      );
    }
    if (data.containsKey('appearance_details')) {
      context.handle(
        _appearanceDetailsMeta,
        appearanceDetails.isAcceptableOrUnknown(
          data['appearance_details']!,
          _appearanceDetailsMeta,
        ),
      );
    }
    if (data.containsKey('narrative_details')) {
      context.handle(
        _narrativeDetailsMeta,
        narrativeDetails.isAcceptableOrUnknown(
          data['narrative_details']!,
          _narrativeDetailsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {characterId};
  @override
  CharacterFinishingDetail map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CharacterFinishingDetail(
      characterId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}character_id'],
      )!,
      portraitAssetPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}portrait_asset_path'],
      ),
      alignment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alignment'],
      ),
      appearanceDetails: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}appearance_details'],
      ),
      narrativeDetails: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}narrative_details'],
      ),
    );
  }

  @override
  $CharacterFinishingDetailsTable createAlias(String alias) {
    return $CharacterFinishingDetailsTable(attachedDatabase, alias);
  }
}

class CharacterFinishingDetail extends DataClass
    implements Insertable<CharacterFinishingDetail> {
  final String characterId;
  final String? portraitAssetPath;
  final String? alignment;
  final String? appearanceDetails;
  final String? narrativeDetails;
  const CharacterFinishingDetail({
    required this.characterId,
    this.portraitAssetPath,
    this.alignment,
    this.appearanceDetails,
    this.narrativeDetails,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['character_id'] = Variable<String>(characterId);
    if (!nullToAbsent || portraitAssetPath != null) {
      map['portrait_asset_path'] = Variable<String>(portraitAssetPath);
    }
    if (!nullToAbsent || alignment != null) {
      map['alignment'] = Variable<String>(alignment);
    }
    if (!nullToAbsent || appearanceDetails != null) {
      map['appearance_details'] = Variable<String>(appearanceDetails);
    }
    if (!nullToAbsent || narrativeDetails != null) {
      map['narrative_details'] = Variable<String>(narrativeDetails);
    }
    return map;
  }

  CharacterFinishingDetailsCompanion toCompanion(bool nullToAbsent) {
    return CharacterFinishingDetailsCompanion(
      characterId: Value(characterId),
      portraitAssetPath: portraitAssetPath == null && nullToAbsent
          ? const Value.absent()
          : Value(portraitAssetPath),
      alignment: alignment == null && nullToAbsent
          ? const Value.absent()
          : Value(alignment),
      appearanceDetails: appearanceDetails == null && nullToAbsent
          ? const Value.absent()
          : Value(appearanceDetails),
      narrativeDetails: narrativeDetails == null && nullToAbsent
          ? const Value.absent()
          : Value(narrativeDetails),
    );
  }

  factory CharacterFinishingDetail.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CharacterFinishingDetail(
      characterId: serializer.fromJson<String>(json['characterId']),
      portraitAssetPath: serializer.fromJson<String?>(
        json['portraitAssetPath'],
      ),
      alignment: serializer.fromJson<String?>(json['alignment']),
      appearanceDetails: serializer.fromJson<String?>(
        json['appearanceDetails'],
      ),
      narrativeDetails: serializer.fromJson<String?>(json['narrativeDetails']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'characterId': serializer.toJson<String>(characterId),
      'portraitAssetPath': serializer.toJson<String?>(portraitAssetPath),
      'alignment': serializer.toJson<String?>(alignment),
      'appearanceDetails': serializer.toJson<String?>(appearanceDetails),
      'narrativeDetails': serializer.toJson<String?>(narrativeDetails),
    };
  }

  CharacterFinishingDetail copyWith({
    String? characterId,
    Value<String?> portraitAssetPath = const Value.absent(),
    Value<String?> alignment = const Value.absent(),
    Value<String?> appearanceDetails = const Value.absent(),
    Value<String?> narrativeDetails = const Value.absent(),
  }) => CharacterFinishingDetail(
    characterId: characterId ?? this.characterId,
    portraitAssetPath: portraitAssetPath.present
        ? portraitAssetPath.value
        : this.portraitAssetPath,
    alignment: alignment.present ? alignment.value : this.alignment,
    appearanceDetails: appearanceDetails.present
        ? appearanceDetails.value
        : this.appearanceDetails,
    narrativeDetails: narrativeDetails.present
        ? narrativeDetails.value
        : this.narrativeDetails,
  );
  CharacterFinishingDetail copyWithCompanion(
    CharacterFinishingDetailsCompanion data,
  ) {
    return CharacterFinishingDetail(
      characterId: data.characterId.present
          ? data.characterId.value
          : this.characterId,
      portraitAssetPath: data.portraitAssetPath.present
          ? data.portraitAssetPath.value
          : this.portraitAssetPath,
      alignment: data.alignment.present ? data.alignment.value : this.alignment,
      appearanceDetails: data.appearanceDetails.present
          ? data.appearanceDetails.value
          : this.appearanceDetails,
      narrativeDetails: data.narrativeDetails.present
          ? data.narrativeDetails.value
          : this.narrativeDetails,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CharacterFinishingDetail(')
          ..write('characterId: $characterId, ')
          ..write('portraitAssetPath: $portraitAssetPath, ')
          ..write('alignment: $alignment, ')
          ..write('appearanceDetails: $appearanceDetails, ')
          ..write('narrativeDetails: $narrativeDetails')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    characterId,
    portraitAssetPath,
    alignment,
    appearanceDetails,
    narrativeDetails,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CharacterFinishingDetail &&
          other.characterId == this.characterId &&
          other.portraitAssetPath == this.portraitAssetPath &&
          other.alignment == this.alignment &&
          other.appearanceDetails == this.appearanceDetails &&
          other.narrativeDetails == this.narrativeDetails);
}

class CharacterFinishingDetailsCompanion
    extends UpdateCompanion<CharacterFinishingDetail> {
  final Value<String> characterId;
  final Value<String?> portraitAssetPath;
  final Value<String?> alignment;
  final Value<String?> appearanceDetails;
  final Value<String?> narrativeDetails;
  final Value<int> rowid;
  const CharacterFinishingDetailsCompanion({
    this.characterId = const Value.absent(),
    this.portraitAssetPath = const Value.absent(),
    this.alignment = const Value.absent(),
    this.appearanceDetails = const Value.absent(),
    this.narrativeDetails = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CharacterFinishingDetailsCompanion.insert({
    required String characterId,
    this.portraitAssetPath = const Value.absent(),
    this.alignment = const Value.absent(),
    this.appearanceDetails = const Value.absent(),
    this.narrativeDetails = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : characterId = Value(characterId);
  static Insertable<CharacterFinishingDetail> custom({
    Expression<String>? characterId,
    Expression<String>? portraitAssetPath,
    Expression<String>? alignment,
    Expression<String>? appearanceDetails,
    Expression<String>? narrativeDetails,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (characterId != null) 'character_id': characterId,
      if (portraitAssetPath != null) 'portrait_asset_path': portraitAssetPath,
      if (alignment != null) 'alignment': alignment,
      if (appearanceDetails != null) 'appearance_details': appearanceDetails,
      if (narrativeDetails != null) 'narrative_details': narrativeDetails,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CharacterFinishingDetailsCompanion copyWith({
    Value<String>? characterId,
    Value<String?>? portraitAssetPath,
    Value<String?>? alignment,
    Value<String?>? appearanceDetails,
    Value<String?>? narrativeDetails,
    Value<int>? rowid,
  }) {
    return CharacterFinishingDetailsCompanion(
      characterId: characterId ?? this.characterId,
      portraitAssetPath: portraitAssetPath ?? this.portraitAssetPath,
      alignment: alignment ?? this.alignment,
      appearanceDetails: appearanceDetails ?? this.appearanceDetails,
      narrativeDetails: narrativeDetails ?? this.narrativeDetails,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (characterId.present) {
      map['character_id'] = Variable<String>(characterId.value);
    }
    if (portraitAssetPath.present) {
      map['portrait_asset_path'] = Variable<String>(portraitAssetPath.value);
    }
    if (alignment.present) {
      map['alignment'] = Variable<String>(alignment.value);
    }
    if (appearanceDetails.present) {
      map['appearance_details'] = Variable<String>(appearanceDetails.value);
    }
    if (narrativeDetails.present) {
      map['narrative_details'] = Variable<String>(narrativeDetails.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CharacterFinishingDetailsCompanion(')
          ..write('characterId: $characterId, ')
          ..write('portraitAssetPath: $portraitAssetPath, ')
          ..write('alignment: $alignment, ')
          ..write('appearanceDetails: $appearanceDetails, ')
          ..write('narrativeDetails: $narrativeDetails, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CharacterNarrativeSelectionsTable extends CharacterNarrativeSelections
    with
        TableInfo<
          $CharacterNarrativeSelectionsTable,
          CharacterNarrativeSelection
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CharacterNarrativeSelectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _characterIdMeta = const VerificationMeta(
    'characterId',
  );
  @override
  late final GeneratedColumn<String> characterId = GeneratedColumn<String>(
    'character_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES characters (id)',
    ),
  );
  static const VerificationMeta _fieldKeyMeta = const VerificationMeta(
    'fieldKey',
  );
  @override
  late final GeneratedColumn<String> fieldKey = GeneratedColumn<String>(
    'field_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _selectionModeMeta = const VerificationMeta(
    'selectionMode',
  );
  @override
  late final GeneratedColumn<String> selectionMode = GeneratedColumn<String>(
    'selection_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _groupIdMeta = const VerificationMeta(
    'groupId',
  );
  @override
  late final GeneratedColumn<String> groupId = GeneratedColumn<String>(
    'group_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _optionIdMeta = const VerificationMeta(
    'optionId',
  );
  @override
  late final GeneratedColumn<String> optionId = GeneratedColumn<String>(
    'option_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _valueTextMeta = const VerificationMeta(
    'valueText',
  );
  @override
  late final GeneratedColumn<String> valueText = GeneratedColumn<String>(
    'value_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rollValueMeta = const VerificationMeta(
    'rollValue',
  );
  @override
  late final GeneratedColumn<int> rollValue = GeneratedColumn<int>(
    'roll_value',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    characterId,
    fieldKey,
    selectionMode,
    groupId,
    optionId,
    valueText,
    rollValue,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'character_narrative_selections';
  @override
  VerificationContext validateIntegrity(
    Insertable<CharacterNarrativeSelection> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('character_id')) {
      context.handle(
        _characterIdMeta,
        characterId.isAcceptableOrUnknown(
          data['character_id']!,
          _characterIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_characterIdMeta);
    }
    if (data.containsKey('field_key')) {
      context.handle(
        _fieldKeyMeta,
        fieldKey.isAcceptableOrUnknown(data['field_key']!, _fieldKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_fieldKeyMeta);
    }
    if (data.containsKey('selection_mode')) {
      context.handle(
        _selectionModeMeta,
        selectionMode.isAcceptableOrUnknown(
          data['selection_mode']!,
          _selectionModeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_selectionModeMeta);
    }
    if (data.containsKey('group_id')) {
      context.handle(
        _groupIdMeta,
        groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta),
      );
    }
    if (data.containsKey('option_id')) {
      context.handle(
        _optionIdMeta,
        optionId.isAcceptableOrUnknown(data['option_id']!, _optionIdMeta),
      );
    }
    if (data.containsKey('value_text')) {
      context.handle(
        _valueTextMeta,
        valueText.isAcceptableOrUnknown(data['value_text']!, _valueTextMeta),
      );
    }
    if (data.containsKey('roll_value')) {
      context.handle(
        _rollValueMeta,
        rollValue.isAcceptableOrUnknown(data['roll_value']!, _rollValueMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {characterId, fieldKey};
  @override
  CharacterNarrativeSelection map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CharacterNarrativeSelection(
      characterId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}character_id'],
      )!,
      fieldKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_key'],
      )!,
      selectionMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}selection_mode'],
      )!,
      groupId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_id'],
      ),
      optionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}option_id'],
      ),
      valueText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value_text'],
      ),
      rollValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}roll_value'],
      ),
    );
  }

  @override
  $CharacterNarrativeSelectionsTable createAlias(String alias) {
    return $CharacterNarrativeSelectionsTable(attachedDatabase, alias);
  }
}

class CharacterNarrativeSelection extends DataClass
    implements Insertable<CharacterNarrativeSelection> {
  final String characterId;
  final String fieldKey;
  final String selectionMode;
  final String? groupId;
  final String? optionId;
  final String? valueText;
  final int? rollValue;
  const CharacterNarrativeSelection({
    required this.characterId,
    required this.fieldKey,
    required this.selectionMode,
    this.groupId,
    this.optionId,
    this.valueText,
    this.rollValue,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['character_id'] = Variable<String>(characterId);
    map['field_key'] = Variable<String>(fieldKey);
    map['selection_mode'] = Variable<String>(selectionMode);
    if (!nullToAbsent || groupId != null) {
      map['group_id'] = Variable<String>(groupId);
    }
    if (!nullToAbsent || optionId != null) {
      map['option_id'] = Variable<String>(optionId);
    }
    if (!nullToAbsent || valueText != null) {
      map['value_text'] = Variable<String>(valueText);
    }
    if (!nullToAbsent || rollValue != null) {
      map['roll_value'] = Variable<int>(rollValue);
    }
    return map;
  }

  CharacterNarrativeSelectionsCompanion toCompanion(bool nullToAbsent) {
    return CharacterNarrativeSelectionsCompanion(
      characterId: Value(characterId),
      fieldKey: Value(fieldKey),
      selectionMode: Value(selectionMode),
      groupId: groupId == null && nullToAbsent
          ? const Value.absent()
          : Value(groupId),
      optionId: optionId == null && nullToAbsent
          ? const Value.absent()
          : Value(optionId),
      valueText: valueText == null && nullToAbsent
          ? const Value.absent()
          : Value(valueText),
      rollValue: rollValue == null && nullToAbsent
          ? const Value.absent()
          : Value(rollValue),
    );
  }

  factory CharacterNarrativeSelection.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CharacterNarrativeSelection(
      characterId: serializer.fromJson<String>(json['characterId']),
      fieldKey: serializer.fromJson<String>(json['fieldKey']),
      selectionMode: serializer.fromJson<String>(json['selectionMode']),
      groupId: serializer.fromJson<String?>(json['groupId']),
      optionId: serializer.fromJson<String?>(json['optionId']),
      valueText: serializer.fromJson<String?>(json['valueText']),
      rollValue: serializer.fromJson<int?>(json['rollValue']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'characterId': serializer.toJson<String>(characterId),
      'fieldKey': serializer.toJson<String>(fieldKey),
      'selectionMode': serializer.toJson<String>(selectionMode),
      'groupId': serializer.toJson<String?>(groupId),
      'optionId': serializer.toJson<String?>(optionId),
      'valueText': serializer.toJson<String?>(valueText),
      'rollValue': serializer.toJson<int?>(rollValue),
    };
  }

  CharacterNarrativeSelection copyWith({
    String? characterId,
    String? fieldKey,
    String? selectionMode,
    Value<String?> groupId = const Value.absent(),
    Value<String?> optionId = const Value.absent(),
    Value<String?> valueText = const Value.absent(),
    Value<int?> rollValue = const Value.absent(),
  }) => CharacterNarrativeSelection(
    characterId: characterId ?? this.characterId,
    fieldKey: fieldKey ?? this.fieldKey,
    selectionMode: selectionMode ?? this.selectionMode,
    groupId: groupId.present ? groupId.value : this.groupId,
    optionId: optionId.present ? optionId.value : this.optionId,
    valueText: valueText.present ? valueText.value : this.valueText,
    rollValue: rollValue.present ? rollValue.value : this.rollValue,
  );
  CharacterNarrativeSelection copyWithCompanion(
    CharacterNarrativeSelectionsCompanion data,
  ) {
    return CharacterNarrativeSelection(
      characterId: data.characterId.present
          ? data.characterId.value
          : this.characterId,
      fieldKey: data.fieldKey.present ? data.fieldKey.value : this.fieldKey,
      selectionMode: data.selectionMode.present
          ? data.selectionMode.value
          : this.selectionMode,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      optionId: data.optionId.present ? data.optionId.value : this.optionId,
      valueText: data.valueText.present ? data.valueText.value : this.valueText,
      rollValue: data.rollValue.present ? data.rollValue.value : this.rollValue,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CharacterNarrativeSelection(')
          ..write('characterId: $characterId, ')
          ..write('fieldKey: $fieldKey, ')
          ..write('selectionMode: $selectionMode, ')
          ..write('groupId: $groupId, ')
          ..write('optionId: $optionId, ')
          ..write('valueText: $valueText, ')
          ..write('rollValue: $rollValue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    characterId,
    fieldKey,
    selectionMode,
    groupId,
    optionId,
    valueText,
    rollValue,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CharacterNarrativeSelection &&
          other.characterId == this.characterId &&
          other.fieldKey == this.fieldKey &&
          other.selectionMode == this.selectionMode &&
          other.groupId == this.groupId &&
          other.optionId == this.optionId &&
          other.valueText == this.valueText &&
          other.rollValue == this.rollValue);
}

class CharacterNarrativeSelectionsCompanion
    extends UpdateCompanion<CharacterNarrativeSelection> {
  final Value<String> characterId;
  final Value<String> fieldKey;
  final Value<String> selectionMode;
  final Value<String?> groupId;
  final Value<String?> optionId;
  final Value<String?> valueText;
  final Value<int?> rollValue;
  final Value<int> rowid;
  const CharacterNarrativeSelectionsCompanion({
    this.characterId = const Value.absent(),
    this.fieldKey = const Value.absent(),
    this.selectionMode = const Value.absent(),
    this.groupId = const Value.absent(),
    this.optionId = const Value.absent(),
    this.valueText = const Value.absent(),
    this.rollValue = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CharacterNarrativeSelectionsCompanion.insert({
    required String characterId,
    required String fieldKey,
    required String selectionMode,
    this.groupId = const Value.absent(),
    this.optionId = const Value.absent(),
    this.valueText = const Value.absent(),
    this.rollValue = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : characterId = Value(characterId),
       fieldKey = Value(fieldKey),
       selectionMode = Value(selectionMode);
  static Insertable<CharacterNarrativeSelection> custom({
    Expression<String>? characterId,
    Expression<String>? fieldKey,
    Expression<String>? selectionMode,
    Expression<String>? groupId,
    Expression<String>? optionId,
    Expression<String>? valueText,
    Expression<int>? rollValue,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (characterId != null) 'character_id': characterId,
      if (fieldKey != null) 'field_key': fieldKey,
      if (selectionMode != null) 'selection_mode': selectionMode,
      if (groupId != null) 'group_id': groupId,
      if (optionId != null) 'option_id': optionId,
      if (valueText != null) 'value_text': valueText,
      if (rollValue != null) 'roll_value': rollValue,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CharacterNarrativeSelectionsCompanion copyWith({
    Value<String>? characterId,
    Value<String>? fieldKey,
    Value<String>? selectionMode,
    Value<String?>? groupId,
    Value<String?>? optionId,
    Value<String?>? valueText,
    Value<int?>? rollValue,
    Value<int>? rowid,
  }) {
    return CharacterNarrativeSelectionsCompanion(
      characterId: characterId ?? this.characterId,
      fieldKey: fieldKey ?? this.fieldKey,
      selectionMode: selectionMode ?? this.selectionMode,
      groupId: groupId ?? this.groupId,
      optionId: optionId ?? this.optionId,
      valueText: valueText ?? this.valueText,
      rollValue: rollValue ?? this.rollValue,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (characterId.present) {
      map['character_id'] = Variable<String>(characterId.value);
    }
    if (fieldKey.present) {
      map['field_key'] = Variable<String>(fieldKey.value);
    }
    if (selectionMode.present) {
      map['selection_mode'] = Variable<String>(selectionMode.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<String>(groupId.value);
    }
    if (optionId.present) {
      map['option_id'] = Variable<String>(optionId.value);
    }
    if (valueText.present) {
      map['value_text'] = Variable<String>(valueText.value);
    }
    if (rollValue.present) {
      map['roll_value'] = Variable<int>(rollValue.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CharacterNarrativeSelectionsCompanion(')
          ..write('characterId: $characterId, ')
          ..write('fieldKey: $fieldKey, ')
          ..write('selectionMode: $selectionMode, ')
          ..write('groupId: $groupId, ')
          ..write('optionId: $optionId, ')
          ..write('valueText: $valueText, ')
          ..write('rollValue: $rollValue, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CharacterEquipmentLoadoutsTable extends CharacterEquipmentLoadouts
    with
        TableInfo<$CharacterEquipmentLoadoutsTable, CharacterEquipmentLoadout> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CharacterEquipmentLoadoutsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _characterIdMeta = const VerificationMeta(
    'characterId',
  );
  @override
  late final GeneratedColumn<String> characterId = GeneratedColumn<String>(
    'character_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES characters (id)',
    ),
  );
  static const VerificationMeta _loadoutIdMeta = const VerificationMeta(
    'loadoutId',
  );
  @override
  late final GeneratedColumn<String> loadoutId = GeneratedColumn<String>(
    'loadout_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _loadoutLabelMeta = const VerificationMeta(
    'loadoutLabel',
  );
  @override
  late final GeneratedColumn<String> loadoutLabel = GeneratedColumn<String>(
    'loadout_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [characterId, loadoutId, loadoutLabel];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'character_equipment_loadouts';
  @override
  VerificationContext validateIntegrity(
    Insertable<CharacterEquipmentLoadout> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('character_id')) {
      context.handle(
        _characterIdMeta,
        characterId.isAcceptableOrUnknown(
          data['character_id']!,
          _characterIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_characterIdMeta);
    }
    if (data.containsKey('loadout_id')) {
      context.handle(
        _loadoutIdMeta,
        loadoutId.isAcceptableOrUnknown(data['loadout_id']!, _loadoutIdMeta),
      );
    }
    if (data.containsKey('loadout_label')) {
      context.handle(
        _loadoutLabelMeta,
        loadoutLabel.isAcceptableOrUnknown(
          data['loadout_label']!,
          _loadoutLabelMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {characterId};
  @override
  CharacterEquipmentLoadout map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CharacterEquipmentLoadout(
      characterId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}character_id'],
      )!,
      loadoutId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}loadout_id'],
      ),
      loadoutLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}loadout_label'],
      ),
    );
  }

  @override
  $CharacterEquipmentLoadoutsTable createAlias(String alias) {
    return $CharacterEquipmentLoadoutsTable(attachedDatabase, alias);
  }
}

class CharacterEquipmentLoadout extends DataClass
    implements Insertable<CharacterEquipmentLoadout> {
  final String characterId;
  final String? loadoutId;
  final String? loadoutLabel;
  const CharacterEquipmentLoadout({
    required this.characterId,
    this.loadoutId,
    this.loadoutLabel,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['character_id'] = Variable<String>(characterId);
    if (!nullToAbsent || loadoutId != null) {
      map['loadout_id'] = Variable<String>(loadoutId);
    }
    if (!nullToAbsent || loadoutLabel != null) {
      map['loadout_label'] = Variable<String>(loadoutLabel);
    }
    return map;
  }

  CharacterEquipmentLoadoutsCompanion toCompanion(bool nullToAbsent) {
    return CharacterEquipmentLoadoutsCompanion(
      characterId: Value(characterId),
      loadoutId: loadoutId == null && nullToAbsent
          ? const Value.absent()
          : Value(loadoutId),
      loadoutLabel: loadoutLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(loadoutLabel),
    );
  }

  factory CharacterEquipmentLoadout.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CharacterEquipmentLoadout(
      characterId: serializer.fromJson<String>(json['characterId']),
      loadoutId: serializer.fromJson<String?>(json['loadoutId']),
      loadoutLabel: serializer.fromJson<String?>(json['loadoutLabel']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'characterId': serializer.toJson<String>(characterId),
      'loadoutId': serializer.toJson<String?>(loadoutId),
      'loadoutLabel': serializer.toJson<String?>(loadoutLabel),
    };
  }

  CharacterEquipmentLoadout copyWith({
    String? characterId,
    Value<String?> loadoutId = const Value.absent(),
    Value<String?> loadoutLabel = const Value.absent(),
  }) => CharacterEquipmentLoadout(
    characterId: characterId ?? this.characterId,
    loadoutId: loadoutId.present ? loadoutId.value : this.loadoutId,
    loadoutLabel: loadoutLabel.present ? loadoutLabel.value : this.loadoutLabel,
  );
  CharacterEquipmentLoadout copyWithCompanion(
    CharacterEquipmentLoadoutsCompanion data,
  ) {
    return CharacterEquipmentLoadout(
      characterId: data.characterId.present
          ? data.characterId.value
          : this.characterId,
      loadoutId: data.loadoutId.present ? data.loadoutId.value : this.loadoutId,
      loadoutLabel: data.loadoutLabel.present
          ? data.loadoutLabel.value
          : this.loadoutLabel,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CharacterEquipmentLoadout(')
          ..write('characterId: $characterId, ')
          ..write('loadoutId: $loadoutId, ')
          ..write('loadoutLabel: $loadoutLabel')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(characterId, loadoutId, loadoutLabel);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CharacterEquipmentLoadout &&
          other.characterId == this.characterId &&
          other.loadoutId == this.loadoutId &&
          other.loadoutLabel == this.loadoutLabel);
}

class CharacterEquipmentLoadoutsCompanion
    extends UpdateCompanion<CharacterEquipmentLoadout> {
  final Value<String> characterId;
  final Value<String?> loadoutId;
  final Value<String?> loadoutLabel;
  final Value<int> rowid;
  const CharacterEquipmentLoadoutsCompanion({
    this.characterId = const Value.absent(),
    this.loadoutId = const Value.absent(),
    this.loadoutLabel = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CharacterEquipmentLoadoutsCompanion.insert({
    required String characterId,
    this.loadoutId = const Value.absent(),
    this.loadoutLabel = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : characterId = Value(characterId);
  static Insertable<CharacterEquipmentLoadout> custom({
    Expression<String>? characterId,
    Expression<String>? loadoutId,
    Expression<String>? loadoutLabel,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (characterId != null) 'character_id': characterId,
      if (loadoutId != null) 'loadout_id': loadoutId,
      if (loadoutLabel != null) 'loadout_label': loadoutLabel,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CharacterEquipmentLoadoutsCompanion copyWith({
    Value<String>? characterId,
    Value<String?>? loadoutId,
    Value<String?>? loadoutLabel,
    Value<int>? rowid,
  }) {
    return CharacterEquipmentLoadoutsCompanion(
      characterId: characterId ?? this.characterId,
      loadoutId: loadoutId ?? this.loadoutId,
      loadoutLabel: loadoutLabel ?? this.loadoutLabel,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (characterId.present) {
      map['character_id'] = Variable<String>(characterId.value);
    }
    if (loadoutId.present) {
      map['loadout_id'] = Variable<String>(loadoutId.value);
    }
    if (loadoutLabel.present) {
      map['loadout_label'] = Variable<String>(loadoutLabel.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CharacterEquipmentLoadoutsCompanion(')
          ..write('characterId: $characterId, ')
          ..write('loadoutId: $loadoutId, ')
          ..write('loadoutLabel: $loadoutLabel, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CharacterSpellSelectionsTable extends CharacterSpellSelections
    with TableInfo<$CharacterSpellSelectionsTable, CharacterSpellSelection> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CharacterSpellSelectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _characterIdMeta = const VerificationMeta(
    'characterId',
  );
  @override
  late final GeneratedColumn<String> characterId = GeneratedColumn<String>(
    'character_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES characters (id)',
    ),
  );
  static const VerificationMeta _spellDefinitionIdMeta = const VerificationMeta(
    'spellDefinitionId',
  );
  @override
  late final GeneratedColumn<String> spellDefinitionId =
      GeneratedColumn<String>(
        'spell_definition_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _selectionKindMeta = const VerificationMeta(
    'selectionKind',
  );
  @override
  late final GeneratedColumn<String> selectionKind = GeneratedColumn<String>(
    'selection_kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _selectedAtOrderMeta = const VerificationMeta(
    'selectedAtOrder',
  );
  @override
  late final GeneratedColumn<int> selectedAtOrder = GeneratedColumn<int>(
    'selected_at_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    characterId,
    spellDefinitionId,
    selectionKind,
    selectedAtOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'character_spell_selections';
  @override
  VerificationContext validateIntegrity(
    Insertable<CharacterSpellSelection> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('character_id')) {
      context.handle(
        _characterIdMeta,
        characterId.isAcceptableOrUnknown(
          data['character_id']!,
          _characterIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_characterIdMeta);
    }
    if (data.containsKey('spell_definition_id')) {
      context.handle(
        _spellDefinitionIdMeta,
        spellDefinitionId.isAcceptableOrUnknown(
          data['spell_definition_id']!,
          _spellDefinitionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_spellDefinitionIdMeta);
    }
    if (data.containsKey('selection_kind')) {
      context.handle(
        _selectionKindMeta,
        selectionKind.isAcceptableOrUnknown(
          data['selection_kind']!,
          _selectionKindMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_selectionKindMeta);
    }
    if (data.containsKey('selected_at_order')) {
      context.handle(
        _selectedAtOrderMeta,
        selectedAtOrder.isAcceptableOrUnknown(
          data['selected_at_order']!,
          _selectedAtOrderMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {characterId, spellDefinitionId};
  @override
  CharacterSpellSelection map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CharacterSpellSelection(
      characterId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}character_id'],
      )!,
      spellDefinitionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}spell_definition_id'],
      )!,
      selectionKind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}selection_kind'],
      )!,
      selectedAtOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}selected_at_order'],
      )!,
    );
  }

  @override
  $CharacterSpellSelectionsTable createAlias(String alias) {
    return $CharacterSpellSelectionsTable(attachedDatabase, alias);
  }
}

class CharacterSpellSelection extends DataClass
    implements Insertable<CharacterSpellSelection> {
  final String characterId;
  final String spellDefinitionId;
  final String selectionKind;
  final int selectedAtOrder;
  const CharacterSpellSelection({
    required this.characterId,
    required this.spellDefinitionId,
    required this.selectionKind,
    required this.selectedAtOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['character_id'] = Variable<String>(characterId);
    map['spell_definition_id'] = Variable<String>(spellDefinitionId);
    map['selection_kind'] = Variable<String>(selectionKind);
    map['selected_at_order'] = Variable<int>(selectedAtOrder);
    return map;
  }

  CharacterSpellSelectionsCompanion toCompanion(bool nullToAbsent) {
    return CharacterSpellSelectionsCompanion(
      characterId: Value(characterId),
      spellDefinitionId: Value(spellDefinitionId),
      selectionKind: Value(selectionKind),
      selectedAtOrder: Value(selectedAtOrder),
    );
  }

  factory CharacterSpellSelection.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CharacterSpellSelection(
      characterId: serializer.fromJson<String>(json['characterId']),
      spellDefinitionId: serializer.fromJson<String>(json['spellDefinitionId']),
      selectionKind: serializer.fromJson<String>(json['selectionKind']),
      selectedAtOrder: serializer.fromJson<int>(json['selectedAtOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'characterId': serializer.toJson<String>(characterId),
      'spellDefinitionId': serializer.toJson<String>(spellDefinitionId),
      'selectionKind': serializer.toJson<String>(selectionKind),
      'selectedAtOrder': serializer.toJson<int>(selectedAtOrder),
    };
  }

  CharacterSpellSelection copyWith({
    String? characterId,
    String? spellDefinitionId,
    String? selectionKind,
    int? selectedAtOrder,
  }) => CharacterSpellSelection(
    characterId: characterId ?? this.characterId,
    spellDefinitionId: spellDefinitionId ?? this.spellDefinitionId,
    selectionKind: selectionKind ?? this.selectionKind,
    selectedAtOrder: selectedAtOrder ?? this.selectedAtOrder,
  );
  CharacterSpellSelection copyWithCompanion(
    CharacterSpellSelectionsCompanion data,
  ) {
    return CharacterSpellSelection(
      characterId: data.characterId.present
          ? data.characterId.value
          : this.characterId,
      spellDefinitionId: data.spellDefinitionId.present
          ? data.spellDefinitionId.value
          : this.spellDefinitionId,
      selectionKind: data.selectionKind.present
          ? data.selectionKind.value
          : this.selectionKind,
      selectedAtOrder: data.selectedAtOrder.present
          ? data.selectedAtOrder.value
          : this.selectedAtOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CharacterSpellSelection(')
          ..write('characterId: $characterId, ')
          ..write('spellDefinitionId: $spellDefinitionId, ')
          ..write('selectionKind: $selectionKind, ')
          ..write('selectedAtOrder: $selectedAtOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    characterId,
    spellDefinitionId,
    selectionKind,
    selectedAtOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CharacterSpellSelection &&
          other.characterId == this.characterId &&
          other.spellDefinitionId == this.spellDefinitionId &&
          other.selectionKind == this.selectionKind &&
          other.selectedAtOrder == this.selectedAtOrder);
}

class CharacterSpellSelectionsCompanion
    extends UpdateCompanion<CharacterSpellSelection> {
  final Value<String> characterId;
  final Value<String> spellDefinitionId;
  final Value<String> selectionKind;
  final Value<int> selectedAtOrder;
  final Value<int> rowid;
  const CharacterSpellSelectionsCompanion({
    this.characterId = const Value.absent(),
    this.spellDefinitionId = const Value.absent(),
    this.selectionKind = const Value.absent(),
    this.selectedAtOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CharacterSpellSelectionsCompanion.insert({
    required String characterId,
    required String spellDefinitionId,
    required String selectionKind,
    this.selectedAtOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : characterId = Value(characterId),
       spellDefinitionId = Value(spellDefinitionId),
       selectionKind = Value(selectionKind);
  static Insertable<CharacterSpellSelection> custom({
    Expression<String>? characterId,
    Expression<String>? spellDefinitionId,
    Expression<String>? selectionKind,
    Expression<int>? selectedAtOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (characterId != null) 'character_id': characterId,
      if (spellDefinitionId != null) 'spell_definition_id': spellDefinitionId,
      if (selectionKind != null) 'selection_kind': selectionKind,
      if (selectedAtOrder != null) 'selected_at_order': selectedAtOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CharacterSpellSelectionsCompanion copyWith({
    Value<String>? characterId,
    Value<String>? spellDefinitionId,
    Value<String>? selectionKind,
    Value<int>? selectedAtOrder,
    Value<int>? rowid,
  }) {
    return CharacterSpellSelectionsCompanion(
      characterId: characterId ?? this.characterId,
      spellDefinitionId: spellDefinitionId ?? this.spellDefinitionId,
      selectionKind: selectionKind ?? this.selectionKind,
      selectedAtOrder: selectedAtOrder ?? this.selectedAtOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (characterId.present) {
      map['character_id'] = Variable<String>(characterId.value);
    }
    if (spellDefinitionId.present) {
      map['spell_definition_id'] = Variable<String>(spellDefinitionId.value);
    }
    if (selectionKind.present) {
      map['selection_kind'] = Variable<String>(selectionKind.value);
    }
    if (selectedAtOrder.present) {
      map['selected_at_order'] = Variable<int>(selectedAtOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CharacterSpellSelectionsCompanion(')
          ..write('characterId: $characterId, ')
          ..write('spellDefinitionId: $spellDefinitionId, ')
          ..write('selectionKind: $selectionKind, ')
          ..write('selectedAtOrder: $selectedAtOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CharacterSpellSlotUsagesTable extends CharacterSpellSlotUsages
    with TableInfo<$CharacterSpellSlotUsagesTable, CharacterSpellSlotUsage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CharacterSpellSlotUsagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _characterIdMeta = const VerificationMeta(
    'characterId',
  );
  @override
  late final GeneratedColumn<String> characterId = GeneratedColumn<String>(
    'character_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES characters (id)',
    ),
  );
  static const VerificationMeta _spellLevelMeta = const VerificationMeta(
    'spellLevel',
  );
  @override
  late final GeneratedColumn<int> spellLevel = GeneratedColumn<int>(
    'spell_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _slotsExpendedMeta = const VerificationMeta(
    'slotsExpended',
  );
  @override
  late final GeneratedColumn<int> slotsExpended = GeneratedColumn<int>(
    'slots_expended',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    characterId,
    spellLevel,
    slotsExpended,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'character_spell_slot_usages';
  @override
  VerificationContext validateIntegrity(
    Insertable<CharacterSpellSlotUsage> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('character_id')) {
      context.handle(
        _characterIdMeta,
        characterId.isAcceptableOrUnknown(
          data['character_id']!,
          _characterIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_characterIdMeta);
    }
    if (data.containsKey('spell_level')) {
      context.handle(
        _spellLevelMeta,
        spellLevel.isAcceptableOrUnknown(data['spell_level']!, _spellLevelMeta),
      );
    } else if (isInserting) {
      context.missing(_spellLevelMeta);
    }
    if (data.containsKey('slots_expended')) {
      context.handle(
        _slotsExpendedMeta,
        slotsExpended.isAcceptableOrUnknown(
          data['slots_expended']!,
          _slotsExpendedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {characterId, spellLevel};
  @override
  CharacterSpellSlotUsage map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CharacterSpellSlotUsage(
      characterId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}character_id'],
      )!,
      spellLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}spell_level'],
      )!,
      slotsExpended: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}slots_expended'],
      )!,
    );
  }

  @override
  $CharacterSpellSlotUsagesTable createAlias(String alias) {
    return $CharacterSpellSlotUsagesTable(attachedDatabase, alias);
  }
}

class CharacterSpellSlotUsage extends DataClass
    implements Insertable<CharacterSpellSlotUsage> {
  final String characterId;
  final int spellLevel;
  final int slotsExpended;
  const CharacterSpellSlotUsage({
    required this.characterId,
    required this.spellLevel,
    required this.slotsExpended,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['character_id'] = Variable<String>(characterId);
    map['spell_level'] = Variable<int>(spellLevel);
    map['slots_expended'] = Variable<int>(slotsExpended);
    return map;
  }

  CharacterSpellSlotUsagesCompanion toCompanion(bool nullToAbsent) {
    return CharacterSpellSlotUsagesCompanion(
      characterId: Value(characterId),
      spellLevel: Value(spellLevel),
      slotsExpended: Value(slotsExpended),
    );
  }

  factory CharacterSpellSlotUsage.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CharacterSpellSlotUsage(
      characterId: serializer.fromJson<String>(json['characterId']),
      spellLevel: serializer.fromJson<int>(json['spellLevel']),
      slotsExpended: serializer.fromJson<int>(json['slotsExpended']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'characterId': serializer.toJson<String>(characterId),
      'spellLevel': serializer.toJson<int>(spellLevel),
      'slotsExpended': serializer.toJson<int>(slotsExpended),
    };
  }

  CharacterSpellSlotUsage copyWith({
    String? characterId,
    int? spellLevel,
    int? slotsExpended,
  }) => CharacterSpellSlotUsage(
    characterId: characterId ?? this.characterId,
    spellLevel: spellLevel ?? this.spellLevel,
    slotsExpended: slotsExpended ?? this.slotsExpended,
  );
  CharacterSpellSlotUsage copyWithCompanion(
    CharacterSpellSlotUsagesCompanion data,
  ) {
    return CharacterSpellSlotUsage(
      characterId: data.characterId.present
          ? data.characterId.value
          : this.characterId,
      spellLevel: data.spellLevel.present
          ? data.spellLevel.value
          : this.spellLevel,
      slotsExpended: data.slotsExpended.present
          ? data.slotsExpended.value
          : this.slotsExpended,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CharacterSpellSlotUsage(')
          ..write('characterId: $characterId, ')
          ..write('spellLevel: $spellLevel, ')
          ..write('slotsExpended: $slotsExpended')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(characterId, spellLevel, slotsExpended);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CharacterSpellSlotUsage &&
          other.characterId == this.characterId &&
          other.spellLevel == this.spellLevel &&
          other.slotsExpended == this.slotsExpended);
}

class CharacterSpellSlotUsagesCompanion
    extends UpdateCompanion<CharacterSpellSlotUsage> {
  final Value<String> characterId;
  final Value<int> spellLevel;
  final Value<int> slotsExpended;
  final Value<int> rowid;
  const CharacterSpellSlotUsagesCompanion({
    this.characterId = const Value.absent(),
    this.spellLevel = const Value.absent(),
    this.slotsExpended = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CharacterSpellSlotUsagesCompanion.insert({
    required String characterId,
    required int spellLevel,
    this.slotsExpended = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : characterId = Value(characterId),
       spellLevel = Value(spellLevel);
  static Insertable<CharacterSpellSlotUsage> custom({
    Expression<String>? characterId,
    Expression<int>? spellLevel,
    Expression<int>? slotsExpended,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (characterId != null) 'character_id': characterId,
      if (spellLevel != null) 'spell_level': spellLevel,
      if (slotsExpended != null) 'slots_expended': slotsExpended,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CharacterSpellSlotUsagesCompanion copyWith({
    Value<String>? characterId,
    Value<int>? spellLevel,
    Value<int>? slotsExpended,
    Value<int>? rowid,
  }) {
    return CharacterSpellSlotUsagesCompanion(
      characterId: characterId ?? this.characterId,
      spellLevel: spellLevel ?? this.spellLevel,
      slotsExpended: slotsExpended ?? this.slotsExpended,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (characterId.present) {
      map['character_id'] = Variable<String>(characterId.value);
    }
    if (spellLevel.present) {
      map['spell_level'] = Variable<int>(spellLevel.value);
    }
    if (slotsExpended.present) {
      map['slots_expended'] = Variable<int>(slotsExpended.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CharacterSpellSlotUsagesCompanion(')
          ..write('characterId: $characterId, ')
          ..write('spellLevel: $spellLevel, ')
          ..write('slotsExpended: $slotsExpended, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SkillDefinitionsTable extends SkillDefinitions
    with TableInfo<$SkillDefinitionsTable, SkillDefinition> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SkillDefinitionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _governingAbilityMeta = const VerificationMeta(
    'governingAbility',
  );
  @override
  late final GeneratedColumn<String> governingAbility = GeneratedColumn<String>(
    'governing_ability',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    key,
    name,
    governingAbility,
    description,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'skill_definitions';
  @override
  VerificationContext validateIntegrity(
    Insertable<SkillDefinition> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('governing_ability')) {
      context.handle(
        _governingAbilityMeta,
        governingAbility.isAcceptableOrUnknown(
          data['governing_ability']!,
          _governingAbilityMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_governingAbilityMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {key},
  ];
  @override
  SkillDefinition map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SkillDefinition(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      governingAbility: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}governing_ability'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
    );
  }

  @override
  $SkillDefinitionsTable createAlias(String alias) {
    return $SkillDefinitionsTable(attachedDatabase, alias);
  }
}

class SkillDefinition extends DataClass implements Insertable<SkillDefinition> {
  final String id;
  final String key;
  final String name;
  final String governingAbility;
  final String? description;
  const SkillDefinition({
    required this.id,
    required this.key,
    required this.name,
    required this.governingAbility,
    this.description,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['key'] = Variable<String>(key);
    map['name'] = Variable<String>(name);
    map['governing_ability'] = Variable<String>(governingAbility);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  SkillDefinitionsCompanion toCompanion(bool nullToAbsent) {
    return SkillDefinitionsCompanion(
      id: Value(id),
      key: Value(key),
      name: Value(name),
      governingAbility: Value(governingAbility),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory SkillDefinition.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SkillDefinition(
      id: serializer.fromJson<String>(json['id']),
      key: serializer.fromJson<String>(json['key']),
      name: serializer.fromJson<String>(json['name']),
      governingAbility: serializer.fromJson<String>(json['governingAbility']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'key': serializer.toJson<String>(key),
      'name': serializer.toJson<String>(name),
      'governingAbility': serializer.toJson<String>(governingAbility),
      'description': serializer.toJson<String?>(description),
    };
  }

  SkillDefinition copyWith({
    String? id,
    String? key,
    String? name,
    String? governingAbility,
    Value<String?> description = const Value.absent(),
  }) => SkillDefinition(
    id: id ?? this.id,
    key: key ?? this.key,
    name: name ?? this.name,
    governingAbility: governingAbility ?? this.governingAbility,
    description: description.present ? description.value : this.description,
  );
  SkillDefinition copyWithCompanion(SkillDefinitionsCompanion data) {
    return SkillDefinition(
      id: data.id.present ? data.id.value : this.id,
      key: data.key.present ? data.key.value : this.key,
      name: data.name.present ? data.name.value : this.name,
      governingAbility: data.governingAbility.present
          ? data.governingAbility.value
          : this.governingAbility,
      description: data.description.present
          ? data.description.value
          : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SkillDefinition(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('name: $name, ')
          ..write('governingAbility: $governingAbility, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, key, name, governingAbility, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SkillDefinition &&
          other.id == this.id &&
          other.key == this.key &&
          other.name == this.name &&
          other.governingAbility == this.governingAbility &&
          other.description == this.description);
}

class SkillDefinitionsCompanion extends UpdateCompanion<SkillDefinition> {
  final Value<String> id;
  final Value<String> key;
  final Value<String> name;
  final Value<String> governingAbility;
  final Value<String?> description;
  final Value<int> rowid;
  const SkillDefinitionsCompanion({
    this.id = const Value.absent(),
    this.key = const Value.absent(),
    this.name = const Value.absent(),
    this.governingAbility = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SkillDefinitionsCompanion.insert({
    required String id,
    required String key,
    required String name,
    required String governingAbility,
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       key = Value(key),
       name = Value(name),
       governingAbility = Value(governingAbility);
  static Insertable<SkillDefinition> custom({
    Expression<String>? id,
    Expression<String>? key,
    Expression<String>? name,
    Expression<String>? governingAbility,
    Expression<String>? description,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (key != null) 'key': key,
      if (name != null) 'name': name,
      if (governingAbility != null) 'governing_ability': governingAbility,
      if (description != null) 'description': description,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SkillDefinitionsCompanion copyWith({
    Value<String>? id,
    Value<String>? key,
    Value<String>? name,
    Value<String>? governingAbility,
    Value<String?>? description,
    Value<int>? rowid,
  }) {
    return SkillDefinitionsCompanion(
      id: id ?? this.id,
      key: key ?? this.key,
      name: name ?? this.name,
      governingAbility: governingAbility ?? this.governingAbility,
      description: description ?? this.description,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (governingAbility.present) {
      map['governing_ability'] = Variable<String>(governingAbility.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SkillDefinitionsCompanion(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('name: $name, ')
          ..write('governingAbility: $governingAbility, ')
          ..write('description: $description, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CharacterSkillsTable extends CharacterSkills
    with TableInfo<$CharacterSkillsTable, CharacterSkill> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CharacterSkillsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _characterIdMeta = const VerificationMeta(
    'characterId',
  );
  @override
  late final GeneratedColumn<String> characterId = GeneratedColumn<String>(
    'character_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES characters (id)',
    ),
  );
  static const VerificationMeta _skillDefinitionIdMeta = const VerificationMeta(
    'skillDefinitionId',
  );
  @override
  late final GeneratedColumn<String> skillDefinitionId =
      GeneratedColumn<String>(
        'skill_definition_id',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES skill_definitions (id)',
        ),
      );
  static const VerificationMeta _isProficientMeta = const VerificationMeta(
    'isProficient',
  );
  @override
  late final GeneratedColumn<bool> isProficient = GeneratedColumn<bool>(
    'is_proficient',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_proficient" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _hasExpertiseMeta = const VerificationMeta(
    'hasExpertise',
  );
  @override
  late final GeneratedColumn<bool> hasExpertise = GeneratedColumn<bool>(
    'has_expertise',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_expertise" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _miscBonusMeta = const VerificationMeta(
    'miscBonus',
  );
  @override
  late final GeneratedColumn<int> miscBonus = GeneratedColumn<int>(
    'misc_bonus',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalBonusMeta = const VerificationMeta(
    'totalBonus',
  );
  @override
  late final GeneratedColumn<int> totalBonus = GeneratedColumn<int>(
    'total_bonus',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    characterId,
    skillDefinitionId,
    isProficient,
    hasExpertise,
    miscBonus,
    totalBonus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'character_skills';
  @override
  VerificationContext validateIntegrity(
    Insertable<CharacterSkill> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('character_id')) {
      context.handle(
        _characterIdMeta,
        characterId.isAcceptableOrUnknown(
          data['character_id']!,
          _characterIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_characterIdMeta);
    }
    if (data.containsKey('skill_definition_id')) {
      context.handle(
        _skillDefinitionIdMeta,
        skillDefinitionId.isAcceptableOrUnknown(
          data['skill_definition_id']!,
          _skillDefinitionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_skillDefinitionIdMeta);
    }
    if (data.containsKey('is_proficient')) {
      context.handle(
        _isProficientMeta,
        isProficient.isAcceptableOrUnknown(
          data['is_proficient']!,
          _isProficientMeta,
        ),
      );
    }
    if (data.containsKey('has_expertise')) {
      context.handle(
        _hasExpertiseMeta,
        hasExpertise.isAcceptableOrUnknown(
          data['has_expertise']!,
          _hasExpertiseMeta,
        ),
      );
    }
    if (data.containsKey('misc_bonus')) {
      context.handle(
        _miscBonusMeta,
        miscBonus.isAcceptableOrUnknown(data['misc_bonus']!, _miscBonusMeta),
      );
    }
    if (data.containsKey('total_bonus')) {
      context.handle(
        _totalBonusMeta,
        totalBonus.isAcceptableOrUnknown(data['total_bonus']!, _totalBonusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {characterId, skillDefinitionId};
  @override
  CharacterSkill map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CharacterSkill(
      characterId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}character_id'],
      )!,
      skillDefinitionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}skill_definition_id'],
      )!,
      isProficient: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_proficient'],
      )!,
      hasExpertise: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_expertise'],
      )!,
      miscBonus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}misc_bonus'],
      )!,
      totalBonus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_bonus'],
      ),
    );
  }

  @override
  $CharacterSkillsTable createAlias(String alias) {
    return $CharacterSkillsTable(attachedDatabase, alias);
  }
}

class CharacterSkill extends DataClass implements Insertable<CharacterSkill> {
  final String characterId;
  final String skillDefinitionId;
  final bool isProficient;
  final bool hasExpertise;
  final int miscBonus;
  final int? totalBonus;
  const CharacterSkill({
    required this.characterId,
    required this.skillDefinitionId,
    required this.isProficient,
    required this.hasExpertise,
    required this.miscBonus,
    this.totalBonus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['character_id'] = Variable<String>(characterId);
    map['skill_definition_id'] = Variable<String>(skillDefinitionId);
    map['is_proficient'] = Variable<bool>(isProficient);
    map['has_expertise'] = Variable<bool>(hasExpertise);
    map['misc_bonus'] = Variable<int>(miscBonus);
    if (!nullToAbsent || totalBonus != null) {
      map['total_bonus'] = Variable<int>(totalBonus);
    }
    return map;
  }

  CharacterSkillsCompanion toCompanion(bool nullToAbsent) {
    return CharacterSkillsCompanion(
      characterId: Value(characterId),
      skillDefinitionId: Value(skillDefinitionId),
      isProficient: Value(isProficient),
      hasExpertise: Value(hasExpertise),
      miscBonus: Value(miscBonus),
      totalBonus: totalBonus == null && nullToAbsent
          ? const Value.absent()
          : Value(totalBonus),
    );
  }

  factory CharacterSkill.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CharacterSkill(
      characterId: serializer.fromJson<String>(json['characterId']),
      skillDefinitionId: serializer.fromJson<String>(json['skillDefinitionId']),
      isProficient: serializer.fromJson<bool>(json['isProficient']),
      hasExpertise: serializer.fromJson<bool>(json['hasExpertise']),
      miscBonus: serializer.fromJson<int>(json['miscBonus']),
      totalBonus: serializer.fromJson<int?>(json['totalBonus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'characterId': serializer.toJson<String>(characterId),
      'skillDefinitionId': serializer.toJson<String>(skillDefinitionId),
      'isProficient': serializer.toJson<bool>(isProficient),
      'hasExpertise': serializer.toJson<bool>(hasExpertise),
      'miscBonus': serializer.toJson<int>(miscBonus),
      'totalBonus': serializer.toJson<int?>(totalBonus),
    };
  }

  CharacterSkill copyWith({
    String? characterId,
    String? skillDefinitionId,
    bool? isProficient,
    bool? hasExpertise,
    int? miscBonus,
    Value<int?> totalBonus = const Value.absent(),
  }) => CharacterSkill(
    characterId: characterId ?? this.characterId,
    skillDefinitionId: skillDefinitionId ?? this.skillDefinitionId,
    isProficient: isProficient ?? this.isProficient,
    hasExpertise: hasExpertise ?? this.hasExpertise,
    miscBonus: miscBonus ?? this.miscBonus,
    totalBonus: totalBonus.present ? totalBonus.value : this.totalBonus,
  );
  CharacterSkill copyWithCompanion(CharacterSkillsCompanion data) {
    return CharacterSkill(
      characterId: data.characterId.present
          ? data.characterId.value
          : this.characterId,
      skillDefinitionId: data.skillDefinitionId.present
          ? data.skillDefinitionId.value
          : this.skillDefinitionId,
      isProficient: data.isProficient.present
          ? data.isProficient.value
          : this.isProficient,
      hasExpertise: data.hasExpertise.present
          ? data.hasExpertise.value
          : this.hasExpertise,
      miscBonus: data.miscBonus.present ? data.miscBonus.value : this.miscBonus,
      totalBonus: data.totalBonus.present
          ? data.totalBonus.value
          : this.totalBonus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CharacterSkill(')
          ..write('characterId: $characterId, ')
          ..write('skillDefinitionId: $skillDefinitionId, ')
          ..write('isProficient: $isProficient, ')
          ..write('hasExpertise: $hasExpertise, ')
          ..write('miscBonus: $miscBonus, ')
          ..write('totalBonus: $totalBonus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    characterId,
    skillDefinitionId,
    isProficient,
    hasExpertise,
    miscBonus,
    totalBonus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CharacterSkill &&
          other.characterId == this.characterId &&
          other.skillDefinitionId == this.skillDefinitionId &&
          other.isProficient == this.isProficient &&
          other.hasExpertise == this.hasExpertise &&
          other.miscBonus == this.miscBonus &&
          other.totalBonus == this.totalBonus);
}

class CharacterSkillsCompanion extends UpdateCompanion<CharacterSkill> {
  final Value<String> characterId;
  final Value<String> skillDefinitionId;
  final Value<bool> isProficient;
  final Value<bool> hasExpertise;
  final Value<int> miscBonus;
  final Value<int?> totalBonus;
  final Value<int> rowid;
  const CharacterSkillsCompanion({
    this.characterId = const Value.absent(),
    this.skillDefinitionId = const Value.absent(),
    this.isProficient = const Value.absent(),
    this.hasExpertise = const Value.absent(),
    this.miscBonus = const Value.absent(),
    this.totalBonus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CharacterSkillsCompanion.insert({
    required String characterId,
    required String skillDefinitionId,
    this.isProficient = const Value.absent(),
    this.hasExpertise = const Value.absent(),
    this.miscBonus = const Value.absent(),
    this.totalBonus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : characterId = Value(characterId),
       skillDefinitionId = Value(skillDefinitionId);
  static Insertable<CharacterSkill> custom({
    Expression<String>? characterId,
    Expression<String>? skillDefinitionId,
    Expression<bool>? isProficient,
    Expression<bool>? hasExpertise,
    Expression<int>? miscBonus,
    Expression<int>? totalBonus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (characterId != null) 'character_id': characterId,
      if (skillDefinitionId != null) 'skill_definition_id': skillDefinitionId,
      if (isProficient != null) 'is_proficient': isProficient,
      if (hasExpertise != null) 'has_expertise': hasExpertise,
      if (miscBonus != null) 'misc_bonus': miscBonus,
      if (totalBonus != null) 'total_bonus': totalBonus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CharacterSkillsCompanion copyWith({
    Value<String>? characterId,
    Value<String>? skillDefinitionId,
    Value<bool>? isProficient,
    Value<bool>? hasExpertise,
    Value<int>? miscBonus,
    Value<int?>? totalBonus,
    Value<int>? rowid,
  }) {
    return CharacterSkillsCompanion(
      characterId: characterId ?? this.characterId,
      skillDefinitionId: skillDefinitionId ?? this.skillDefinitionId,
      isProficient: isProficient ?? this.isProficient,
      hasExpertise: hasExpertise ?? this.hasExpertise,
      miscBonus: miscBonus ?? this.miscBonus,
      totalBonus: totalBonus ?? this.totalBonus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (characterId.present) {
      map['character_id'] = Variable<String>(characterId.value);
    }
    if (skillDefinitionId.present) {
      map['skill_definition_id'] = Variable<String>(skillDefinitionId.value);
    }
    if (isProficient.present) {
      map['is_proficient'] = Variable<bool>(isProficient.value);
    }
    if (hasExpertise.present) {
      map['has_expertise'] = Variable<bool>(hasExpertise.value);
    }
    if (miscBonus.present) {
      map['misc_bonus'] = Variable<int>(miscBonus.value);
    }
    if (totalBonus.present) {
      map['total_bonus'] = Variable<int>(totalBonus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CharacterSkillsCompanion(')
          ..write('characterId: $characterId, ')
          ..write('skillDefinitionId: $skillDefinitionId, ')
          ..write('isProficient: $isProficient, ')
          ..write('hasExpertise: $hasExpertise, ')
          ..write('miscBonus: $miscBonus, ')
          ..write('totalBonus: $totalBonus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CharacterSavingThrowsTable extends CharacterSavingThrows
    with TableInfo<$CharacterSavingThrowsTable, CharacterSavingThrow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CharacterSavingThrowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _characterIdMeta = const VerificationMeta(
    'characterId',
  );
  @override
  late final GeneratedColumn<String> characterId = GeneratedColumn<String>(
    'character_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES characters (id)',
    ),
  );
  static const VerificationMeta _abilityKeyMeta = const VerificationMeta(
    'abilityKey',
  );
  @override
  late final GeneratedColumn<String> abilityKey = GeneratedColumn<String>(
    'ability_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isProficientMeta = const VerificationMeta(
    'isProficient',
  );
  @override
  late final GeneratedColumn<bool> isProficient = GeneratedColumn<bool>(
    'is_proficient',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_proficient" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _miscBonusMeta = const VerificationMeta(
    'miscBonus',
  );
  @override
  late final GeneratedColumn<int> miscBonus = GeneratedColumn<int>(
    'misc_bonus',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalBonusMeta = const VerificationMeta(
    'totalBonus',
  );
  @override
  late final GeneratedColumn<int> totalBonus = GeneratedColumn<int>(
    'total_bonus',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    characterId,
    abilityKey,
    isProficient,
    miscBonus,
    totalBonus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'character_saving_throws';
  @override
  VerificationContext validateIntegrity(
    Insertable<CharacterSavingThrow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('character_id')) {
      context.handle(
        _characterIdMeta,
        characterId.isAcceptableOrUnknown(
          data['character_id']!,
          _characterIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_characterIdMeta);
    }
    if (data.containsKey('ability_key')) {
      context.handle(
        _abilityKeyMeta,
        abilityKey.isAcceptableOrUnknown(data['ability_key']!, _abilityKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_abilityKeyMeta);
    }
    if (data.containsKey('is_proficient')) {
      context.handle(
        _isProficientMeta,
        isProficient.isAcceptableOrUnknown(
          data['is_proficient']!,
          _isProficientMeta,
        ),
      );
    }
    if (data.containsKey('misc_bonus')) {
      context.handle(
        _miscBonusMeta,
        miscBonus.isAcceptableOrUnknown(data['misc_bonus']!, _miscBonusMeta),
      );
    }
    if (data.containsKey('total_bonus')) {
      context.handle(
        _totalBonusMeta,
        totalBonus.isAcceptableOrUnknown(data['total_bonus']!, _totalBonusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {characterId, abilityKey};
  @override
  CharacterSavingThrow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CharacterSavingThrow(
      characterId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}character_id'],
      )!,
      abilityKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ability_key'],
      )!,
      isProficient: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_proficient'],
      )!,
      miscBonus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}misc_bonus'],
      )!,
      totalBonus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_bonus'],
      ),
    );
  }

  @override
  $CharacterSavingThrowsTable createAlias(String alias) {
    return $CharacterSavingThrowsTable(attachedDatabase, alias);
  }
}

class CharacterSavingThrow extends DataClass
    implements Insertable<CharacterSavingThrow> {
  final String characterId;
  final String abilityKey;
  final bool isProficient;
  final int miscBonus;
  final int? totalBonus;
  const CharacterSavingThrow({
    required this.characterId,
    required this.abilityKey,
    required this.isProficient,
    required this.miscBonus,
    this.totalBonus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['character_id'] = Variable<String>(characterId);
    map['ability_key'] = Variable<String>(abilityKey);
    map['is_proficient'] = Variable<bool>(isProficient);
    map['misc_bonus'] = Variable<int>(miscBonus);
    if (!nullToAbsent || totalBonus != null) {
      map['total_bonus'] = Variable<int>(totalBonus);
    }
    return map;
  }

  CharacterSavingThrowsCompanion toCompanion(bool nullToAbsent) {
    return CharacterSavingThrowsCompanion(
      characterId: Value(characterId),
      abilityKey: Value(abilityKey),
      isProficient: Value(isProficient),
      miscBonus: Value(miscBonus),
      totalBonus: totalBonus == null && nullToAbsent
          ? const Value.absent()
          : Value(totalBonus),
    );
  }

  factory CharacterSavingThrow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CharacterSavingThrow(
      characterId: serializer.fromJson<String>(json['characterId']),
      abilityKey: serializer.fromJson<String>(json['abilityKey']),
      isProficient: serializer.fromJson<bool>(json['isProficient']),
      miscBonus: serializer.fromJson<int>(json['miscBonus']),
      totalBonus: serializer.fromJson<int?>(json['totalBonus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'characterId': serializer.toJson<String>(characterId),
      'abilityKey': serializer.toJson<String>(abilityKey),
      'isProficient': serializer.toJson<bool>(isProficient),
      'miscBonus': serializer.toJson<int>(miscBonus),
      'totalBonus': serializer.toJson<int?>(totalBonus),
    };
  }

  CharacterSavingThrow copyWith({
    String? characterId,
    String? abilityKey,
    bool? isProficient,
    int? miscBonus,
    Value<int?> totalBonus = const Value.absent(),
  }) => CharacterSavingThrow(
    characterId: characterId ?? this.characterId,
    abilityKey: abilityKey ?? this.abilityKey,
    isProficient: isProficient ?? this.isProficient,
    miscBonus: miscBonus ?? this.miscBonus,
    totalBonus: totalBonus.present ? totalBonus.value : this.totalBonus,
  );
  CharacterSavingThrow copyWithCompanion(CharacterSavingThrowsCompanion data) {
    return CharacterSavingThrow(
      characterId: data.characterId.present
          ? data.characterId.value
          : this.characterId,
      abilityKey: data.abilityKey.present
          ? data.abilityKey.value
          : this.abilityKey,
      isProficient: data.isProficient.present
          ? data.isProficient.value
          : this.isProficient,
      miscBonus: data.miscBonus.present ? data.miscBonus.value : this.miscBonus,
      totalBonus: data.totalBonus.present
          ? data.totalBonus.value
          : this.totalBonus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CharacterSavingThrow(')
          ..write('characterId: $characterId, ')
          ..write('abilityKey: $abilityKey, ')
          ..write('isProficient: $isProficient, ')
          ..write('miscBonus: $miscBonus, ')
          ..write('totalBonus: $totalBonus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(characterId, abilityKey, isProficient, miscBonus, totalBonus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CharacterSavingThrow &&
          other.characterId == this.characterId &&
          other.abilityKey == this.abilityKey &&
          other.isProficient == this.isProficient &&
          other.miscBonus == this.miscBonus &&
          other.totalBonus == this.totalBonus);
}

class CharacterSavingThrowsCompanion
    extends UpdateCompanion<CharacterSavingThrow> {
  final Value<String> characterId;
  final Value<String> abilityKey;
  final Value<bool> isProficient;
  final Value<int> miscBonus;
  final Value<int?> totalBonus;
  final Value<int> rowid;
  const CharacterSavingThrowsCompanion({
    this.characterId = const Value.absent(),
    this.abilityKey = const Value.absent(),
    this.isProficient = const Value.absent(),
    this.miscBonus = const Value.absent(),
    this.totalBonus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CharacterSavingThrowsCompanion.insert({
    required String characterId,
    required String abilityKey,
    this.isProficient = const Value.absent(),
    this.miscBonus = const Value.absent(),
    this.totalBonus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : characterId = Value(characterId),
       abilityKey = Value(abilityKey);
  static Insertable<CharacterSavingThrow> custom({
    Expression<String>? characterId,
    Expression<String>? abilityKey,
    Expression<bool>? isProficient,
    Expression<int>? miscBonus,
    Expression<int>? totalBonus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (characterId != null) 'character_id': characterId,
      if (abilityKey != null) 'ability_key': abilityKey,
      if (isProficient != null) 'is_proficient': isProficient,
      if (miscBonus != null) 'misc_bonus': miscBonus,
      if (totalBonus != null) 'total_bonus': totalBonus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CharacterSavingThrowsCompanion copyWith({
    Value<String>? characterId,
    Value<String>? abilityKey,
    Value<bool>? isProficient,
    Value<int>? miscBonus,
    Value<int?>? totalBonus,
    Value<int>? rowid,
  }) {
    return CharacterSavingThrowsCompanion(
      characterId: characterId ?? this.characterId,
      abilityKey: abilityKey ?? this.abilityKey,
      isProficient: isProficient ?? this.isProficient,
      miscBonus: miscBonus ?? this.miscBonus,
      totalBonus: totalBonus ?? this.totalBonus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (characterId.present) {
      map['character_id'] = Variable<String>(characterId.value);
    }
    if (abilityKey.present) {
      map['ability_key'] = Variable<String>(abilityKey.value);
    }
    if (isProficient.present) {
      map['is_proficient'] = Variable<bool>(isProficient.value);
    }
    if (miscBonus.present) {
      map['misc_bonus'] = Variable<int>(miscBonus.value);
    }
    if (totalBonus.present) {
      map['total_bonus'] = Variable<int>(totalBonus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CharacterSavingThrowsCompanion(')
          ..write('characterId: $characterId, ')
          ..write('abilityKey: $abilityKey, ')
          ..write('isProficient: $isProficient, ')
          ..write('miscBonus: $miscBonus, ')
          ..write('totalBonus: $totalBonus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EquipmentDefinitionsTable extends EquipmentDefinitions
    with TableInfo<$EquipmentDefinitionsTable, EquipmentDefinition> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EquipmentDefinitionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subcategoryMeta = const VerificationMeta(
    'subcategory',
  );
  @override
  late final GeneratedColumn<String> subcategory = GeneratedColumn<String>(
    'subcategory',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<int> weight = GeneratedColumn<int>(
    'weight',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _costValueMeta = const VerificationMeta(
    'costValue',
  );
  @override
  late final GeneratedColumn<int> costValue = GeneratedColumn<int>(
    'cost_value',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _costUnitMeta = const VerificationMeta(
    'costUnit',
  );
  @override
  late final GeneratedColumn<String> costUnit = GeneratedColumn<String>(
    'cost_unit',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isContainerMeta = const VerificationMeta(
    'isContainer',
  );
  @override
  late final GeneratedColumn<bool> isContainer = GeneratedColumn<bool>(
    'is_container',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_container" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isStackableMeta = const VerificationMeta(
    'isStackable',
  );
  @override
  late final GeneratedColumn<bool> isStackable = GeneratedColumn<bool>(
    'is_stackable',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_stackable" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weaponPropertiesJsonMeta =
      const VerificationMeta('weaponPropertiesJson');
  @override
  late final GeneratedColumn<String> weaponPropertiesJson =
      GeneratedColumn<String>(
        'weapon_properties_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _armorPropertiesJsonMeta =
      const VerificationMeta('armorPropertiesJson');
  @override
  late final GeneratedColumn<String> armorPropertiesJson =
      GeneratedColumn<String>(
        'armor_properties_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    key,
    name,
    category,
    subcategory,
    weight,
    costValue,
    costUnit,
    isContainer,
    isStackable,
    description,
    weaponPropertiesJson,
    armorPropertiesJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'equipment_definitions';
  @override
  VerificationContext validateIntegrity(
    Insertable<EquipmentDefinition> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('subcategory')) {
      context.handle(
        _subcategoryMeta,
        subcategory.isAcceptableOrUnknown(
          data['subcategory']!,
          _subcategoryMeta,
        ),
      );
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    }
    if (data.containsKey('cost_value')) {
      context.handle(
        _costValueMeta,
        costValue.isAcceptableOrUnknown(data['cost_value']!, _costValueMeta),
      );
    }
    if (data.containsKey('cost_unit')) {
      context.handle(
        _costUnitMeta,
        costUnit.isAcceptableOrUnknown(data['cost_unit']!, _costUnitMeta),
      );
    }
    if (data.containsKey('is_container')) {
      context.handle(
        _isContainerMeta,
        isContainer.isAcceptableOrUnknown(
          data['is_container']!,
          _isContainerMeta,
        ),
      );
    }
    if (data.containsKey('is_stackable')) {
      context.handle(
        _isStackableMeta,
        isStackable.isAcceptableOrUnknown(
          data['is_stackable']!,
          _isStackableMeta,
        ),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('weapon_properties_json')) {
      context.handle(
        _weaponPropertiesJsonMeta,
        weaponPropertiesJson.isAcceptableOrUnknown(
          data['weapon_properties_json']!,
          _weaponPropertiesJsonMeta,
        ),
      );
    }
    if (data.containsKey('armor_properties_json')) {
      context.handle(
        _armorPropertiesJsonMeta,
        armorPropertiesJson.isAcceptableOrUnknown(
          data['armor_properties_json']!,
          _armorPropertiesJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {key},
  ];
  @override
  EquipmentDefinition map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EquipmentDefinition(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      subcategory: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subcategory'],
      ),
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weight'],
      ),
      costValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cost_value'],
      ),
      costUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cost_unit'],
      ),
      isContainer: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_container'],
      )!,
      isStackable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_stackable'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      weaponPropertiesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}weapon_properties_json'],
      ),
      armorPropertiesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}armor_properties_json'],
      ),
    );
  }

  @override
  $EquipmentDefinitionsTable createAlias(String alias) {
    return $EquipmentDefinitionsTable(attachedDatabase, alias);
  }
}

class EquipmentDefinition extends DataClass
    implements Insertable<EquipmentDefinition> {
  final String id;
  final String key;
  final String name;
  final String category;
  final String? subcategory;
  final int? weight;
  final int? costValue;
  final String? costUnit;
  final bool isContainer;
  final bool isStackable;
  final String? description;
  final String? weaponPropertiesJson;
  final String? armorPropertiesJson;
  const EquipmentDefinition({
    required this.id,
    required this.key,
    required this.name,
    required this.category,
    this.subcategory,
    this.weight,
    this.costValue,
    this.costUnit,
    required this.isContainer,
    required this.isStackable,
    this.description,
    this.weaponPropertiesJson,
    this.armorPropertiesJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['key'] = Variable<String>(key);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || subcategory != null) {
      map['subcategory'] = Variable<String>(subcategory);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<int>(weight);
    }
    if (!nullToAbsent || costValue != null) {
      map['cost_value'] = Variable<int>(costValue);
    }
    if (!nullToAbsent || costUnit != null) {
      map['cost_unit'] = Variable<String>(costUnit);
    }
    map['is_container'] = Variable<bool>(isContainer);
    map['is_stackable'] = Variable<bool>(isStackable);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || weaponPropertiesJson != null) {
      map['weapon_properties_json'] = Variable<String>(weaponPropertiesJson);
    }
    if (!nullToAbsent || armorPropertiesJson != null) {
      map['armor_properties_json'] = Variable<String>(armorPropertiesJson);
    }
    return map;
  }

  EquipmentDefinitionsCompanion toCompanion(bool nullToAbsent) {
    return EquipmentDefinitionsCompanion(
      id: Value(id),
      key: Value(key),
      name: Value(name),
      category: Value(category),
      subcategory: subcategory == null && nullToAbsent
          ? const Value.absent()
          : Value(subcategory),
      weight: weight == null && nullToAbsent
          ? const Value.absent()
          : Value(weight),
      costValue: costValue == null && nullToAbsent
          ? const Value.absent()
          : Value(costValue),
      costUnit: costUnit == null && nullToAbsent
          ? const Value.absent()
          : Value(costUnit),
      isContainer: Value(isContainer),
      isStackable: Value(isStackable),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      weaponPropertiesJson: weaponPropertiesJson == null && nullToAbsent
          ? const Value.absent()
          : Value(weaponPropertiesJson),
      armorPropertiesJson: armorPropertiesJson == null && nullToAbsent
          ? const Value.absent()
          : Value(armorPropertiesJson),
    );
  }

  factory EquipmentDefinition.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EquipmentDefinition(
      id: serializer.fromJson<String>(json['id']),
      key: serializer.fromJson<String>(json['key']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      subcategory: serializer.fromJson<String?>(json['subcategory']),
      weight: serializer.fromJson<int?>(json['weight']),
      costValue: serializer.fromJson<int?>(json['costValue']),
      costUnit: serializer.fromJson<String?>(json['costUnit']),
      isContainer: serializer.fromJson<bool>(json['isContainer']),
      isStackable: serializer.fromJson<bool>(json['isStackable']),
      description: serializer.fromJson<String?>(json['description']),
      weaponPropertiesJson: serializer.fromJson<String?>(
        json['weaponPropertiesJson'],
      ),
      armorPropertiesJson: serializer.fromJson<String?>(
        json['armorPropertiesJson'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'key': serializer.toJson<String>(key),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'subcategory': serializer.toJson<String?>(subcategory),
      'weight': serializer.toJson<int?>(weight),
      'costValue': serializer.toJson<int?>(costValue),
      'costUnit': serializer.toJson<String?>(costUnit),
      'isContainer': serializer.toJson<bool>(isContainer),
      'isStackable': serializer.toJson<bool>(isStackable),
      'description': serializer.toJson<String?>(description),
      'weaponPropertiesJson': serializer.toJson<String?>(weaponPropertiesJson),
      'armorPropertiesJson': serializer.toJson<String?>(armorPropertiesJson),
    };
  }

  EquipmentDefinition copyWith({
    String? id,
    String? key,
    String? name,
    String? category,
    Value<String?> subcategory = const Value.absent(),
    Value<int?> weight = const Value.absent(),
    Value<int?> costValue = const Value.absent(),
    Value<String?> costUnit = const Value.absent(),
    bool? isContainer,
    bool? isStackable,
    Value<String?> description = const Value.absent(),
    Value<String?> weaponPropertiesJson = const Value.absent(),
    Value<String?> armorPropertiesJson = const Value.absent(),
  }) => EquipmentDefinition(
    id: id ?? this.id,
    key: key ?? this.key,
    name: name ?? this.name,
    category: category ?? this.category,
    subcategory: subcategory.present ? subcategory.value : this.subcategory,
    weight: weight.present ? weight.value : this.weight,
    costValue: costValue.present ? costValue.value : this.costValue,
    costUnit: costUnit.present ? costUnit.value : this.costUnit,
    isContainer: isContainer ?? this.isContainer,
    isStackable: isStackable ?? this.isStackable,
    description: description.present ? description.value : this.description,
    weaponPropertiesJson: weaponPropertiesJson.present
        ? weaponPropertiesJson.value
        : this.weaponPropertiesJson,
    armorPropertiesJson: armorPropertiesJson.present
        ? armorPropertiesJson.value
        : this.armorPropertiesJson,
  );
  EquipmentDefinition copyWithCompanion(EquipmentDefinitionsCompanion data) {
    return EquipmentDefinition(
      id: data.id.present ? data.id.value : this.id,
      key: data.key.present ? data.key.value : this.key,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      subcategory: data.subcategory.present
          ? data.subcategory.value
          : this.subcategory,
      weight: data.weight.present ? data.weight.value : this.weight,
      costValue: data.costValue.present ? data.costValue.value : this.costValue,
      costUnit: data.costUnit.present ? data.costUnit.value : this.costUnit,
      isContainer: data.isContainer.present
          ? data.isContainer.value
          : this.isContainer,
      isStackable: data.isStackable.present
          ? data.isStackable.value
          : this.isStackable,
      description: data.description.present
          ? data.description.value
          : this.description,
      weaponPropertiesJson: data.weaponPropertiesJson.present
          ? data.weaponPropertiesJson.value
          : this.weaponPropertiesJson,
      armorPropertiesJson: data.armorPropertiesJson.present
          ? data.armorPropertiesJson.value
          : this.armorPropertiesJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EquipmentDefinition(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('subcategory: $subcategory, ')
          ..write('weight: $weight, ')
          ..write('costValue: $costValue, ')
          ..write('costUnit: $costUnit, ')
          ..write('isContainer: $isContainer, ')
          ..write('isStackable: $isStackable, ')
          ..write('description: $description, ')
          ..write('weaponPropertiesJson: $weaponPropertiesJson, ')
          ..write('armorPropertiesJson: $armorPropertiesJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    key,
    name,
    category,
    subcategory,
    weight,
    costValue,
    costUnit,
    isContainer,
    isStackable,
    description,
    weaponPropertiesJson,
    armorPropertiesJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EquipmentDefinition &&
          other.id == this.id &&
          other.key == this.key &&
          other.name == this.name &&
          other.category == this.category &&
          other.subcategory == this.subcategory &&
          other.weight == this.weight &&
          other.costValue == this.costValue &&
          other.costUnit == this.costUnit &&
          other.isContainer == this.isContainer &&
          other.isStackable == this.isStackable &&
          other.description == this.description &&
          other.weaponPropertiesJson == this.weaponPropertiesJson &&
          other.armorPropertiesJson == this.armorPropertiesJson);
}

class EquipmentDefinitionsCompanion
    extends UpdateCompanion<EquipmentDefinition> {
  final Value<String> id;
  final Value<String> key;
  final Value<String> name;
  final Value<String> category;
  final Value<String?> subcategory;
  final Value<int?> weight;
  final Value<int?> costValue;
  final Value<String?> costUnit;
  final Value<bool> isContainer;
  final Value<bool> isStackable;
  final Value<String?> description;
  final Value<String?> weaponPropertiesJson;
  final Value<String?> armorPropertiesJson;
  final Value<int> rowid;
  const EquipmentDefinitionsCompanion({
    this.id = const Value.absent(),
    this.key = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.subcategory = const Value.absent(),
    this.weight = const Value.absent(),
    this.costValue = const Value.absent(),
    this.costUnit = const Value.absent(),
    this.isContainer = const Value.absent(),
    this.isStackable = const Value.absent(),
    this.description = const Value.absent(),
    this.weaponPropertiesJson = const Value.absent(),
    this.armorPropertiesJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EquipmentDefinitionsCompanion.insert({
    required String id,
    required String key,
    required String name,
    required String category,
    this.subcategory = const Value.absent(),
    this.weight = const Value.absent(),
    this.costValue = const Value.absent(),
    this.costUnit = const Value.absent(),
    this.isContainer = const Value.absent(),
    this.isStackable = const Value.absent(),
    this.description = const Value.absent(),
    this.weaponPropertiesJson = const Value.absent(),
    this.armorPropertiesJson = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       key = Value(key),
       name = Value(name),
       category = Value(category);
  static Insertable<EquipmentDefinition> custom({
    Expression<String>? id,
    Expression<String>? key,
    Expression<String>? name,
    Expression<String>? category,
    Expression<String>? subcategory,
    Expression<int>? weight,
    Expression<int>? costValue,
    Expression<String>? costUnit,
    Expression<bool>? isContainer,
    Expression<bool>? isStackable,
    Expression<String>? description,
    Expression<String>? weaponPropertiesJson,
    Expression<String>? armorPropertiesJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (key != null) 'key': key,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (subcategory != null) 'subcategory': subcategory,
      if (weight != null) 'weight': weight,
      if (costValue != null) 'cost_value': costValue,
      if (costUnit != null) 'cost_unit': costUnit,
      if (isContainer != null) 'is_container': isContainer,
      if (isStackable != null) 'is_stackable': isStackable,
      if (description != null) 'description': description,
      if (weaponPropertiesJson != null)
        'weapon_properties_json': weaponPropertiesJson,
      if (armorPropertiesJson != null)
        'armor_properties_json': armorPropertiesJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EquipmentDefinitionsCompanion copyWith({
    Value<String>? id,
    Value<String>? key,
    Value<String>? name,
    Value<String>? category,
    Value<String?>? subcategory,
    Value<int?>? weight,
    Value<int?>? costValue,
    Value<String?>? costUnit,
    Value<bool>? isContainer,
    Value<bool>? isStackable,
    Value<String?>? description,
    Value<String?>? weaponPropertiesJson,
    Value<String?>? armorPropertiesJson,
    Value<int>? rowid,
  }) {
    return EquipmentDefinitionsCompanion(
      id: id ?? this.id,
      key: key ?? this.key,
      name: name ?? this.name,
      category: category ?? this.category,
      subcategory: subcategory ?? this.subcategory,
      weight: weight ?? this.weight,
      costValue: costValue ?? this.costValue,
      costUnit: costUnit ?? this.costUnit,
      isContainer: isContainer ?? this.isContainer,
      isStackable: isStackable ?? this.isStackable,
      description: description ?? this.description,
      weaponPropertiesJson: weaponPropertiesJson ?? this.weaponPropertiesJson,
      armorPropertiesJson: armorPropertiesJson ?? this.armorPropertiesJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (subcategory.present) {
      map['subcategory'] = Variable<String>(subcategory.value);
    }
    if (weight.present) {
      map['weight'] = Variable<int>(weight.value);
    }
    if (costValue.present) {
      map['cost_value'] = Variable<int>(costValue.value);
    }
    if (costUnit.present) {
      map['cost_unit'] = Variable<String>(costUnit.value);
    }
    if (isContainer.present) {
      map['is_container'] = Variable<bool>(isContainer.value);
    }
    if (isStackable.present) {
      map['is_stackable'] = Variable<bool>(isStackable.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (weaponPropertiesJson.present) {
      map['weapon_properties_json'] = Variable<String>(
        weaponPropertiesJson.value,
      );
    }
    if (armorPropertiesJson.present) {
      map['armor_properties_json'] = Variable<String>(
        armorPropertiesJson.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EquipmentDefinitionsCompanion(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('subcategory: $subcategory, ')
          ..write('weight: $weight, ')
          ..write('costValue: $costValue, ')
          ..write('costUnit: $costUnit, ')
          ..write('isContainer: $isContainer, ')
          ..write('isStackable: $isStackable, ')
          ..write('description: $description, ')
          ..write('weaponPropertiesJson: $weaponPropertiesJson, ')
          ..write('armorPropertiesJson: $armorPropertiesJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TrinketDefinitionsTable extends TrinketDefinitions
    with TableInfo<$TrinketDefinitionsTable, TrinketDefinition> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrinketDefinitionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, key, name, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trinket_definitions';
  @override
  VerificationContext validateIntegrity(
    Insertable<TrinketDefinition> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {key},
  ];
  @override
  TrinketDefinition map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrinketDefinition(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
    );
  }

  @override
  $TrinketDefinitionsTable createAlias(String alias) {
    return $TrinketDefinitionsTable(attachedDatabase, alias);
  }
}

class TrinketDefinition extends DataClass
    implements Insertable<TrinketDefinition> {
  final String id;
  final String key;
  final String name;
  final String? description;
  const TrinketDefinition({
    required this.id,
    required this.key,
    required this.name,
    this.description,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['key'] = Variable<String>(key);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  TrinketDefinitionsCompanion toCompanion(bool nullToAbsent) {
    return TrinketDefinitionsCompanion(
      id: Value(id),
      key: Value(key),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory TrinketDefinition.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrinketDefinition(
      id: serializer.fromJson<String>(json['id']),
      key: serializer.fromJson<String>(json['key']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'key': serializer.toJson<String>(key),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
    };
  }

  TrinketDefinition copyWith({
    String? id,
    String? key,
    String? name,
    Value<String?> description = const Value.absent(),
  }) => TrinketDefinition(
    id: id ?? this.id,
    key: key ?? this.key,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
  );
  TrinketDefinition copyWithCompanion(TrinketDefinitionsCompanion data) {
    return TrinketDefinition(
      id: data.id.present ? data.id.value : this.id,
      key: data.key.present ? data.key.value : this.key,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TrinketDefinition(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('name: $name, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, key, name, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrinketDefinition &&
          other.id == this.id &&
          other.key == this.key &&
          other.name == this.name &&
          other.description == this.description);
}

class TrinketDefinitionsCompanion extends UpdateCompanion<TrinketDefinition> {
  final Value<String> id;
  final Value<String> key;
  final Value<String> name;
  final Value<String?> description;
  final Value<int> rowid;
  const TrinketDefinitionsCompanion({
    this.id = const Value.absent(),
    this.key = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TrinketDefinitionsCompanion.insert({
    required String id,
    required String key,
    required String name,
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       key = Value(key),
       name = Value(name);
  static Insertable<TrinketDefinition> custom({
    Expression<String>? id,
    Expression<String>? key,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (key != null) 'key': key,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TrinketDefinitionsCompanion copyWith({
    Value<String>? id,
    Value<String>? key,
    Value<String>? name,
    Value<String?>? description,
    Value<int>? rowid,
  }) {
    return TrinketDefinitionsCompanion(
      id: id ?? this.id,
      key: key ?? this.key,
      name: name ?? this.name,
      description: description ?? this.description,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrinketDefinitionsCompanion(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CharacterInventoryTable extends CharacterInventory
    with TableInfo<$CharacterInventoryTable, CharacterInventoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CharacterInventoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _characterIdMeta = const VerificationMeta(
    'characterId',
  );
  @override
  late final GeneratedColumn<String> characterId = GeneratedColumn<String>(
    'character_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES characters (id)',
    ),
  );
  static const VerificationMeta _equipmentDefinitionIdMeta =
      const VerificationMeta('equipmentDefinitionId');
  @override
  late final GeneratedColumn<String> equipmentDefinitionId =
      GeneratedColumn<String>(
        'equipment_definition_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES equipment_definitions (id)',
        ),
      );
  static const VerificationMeta _trinketDefinitionIdMeta =
      const VerificationMeta('trinketDefinitionId');
  @override
  late final GeneratedColumn<String> trinketDefinitionId =
      GeneratedColumn<String>(
        'trinket_definition_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES trinket_definitions (id)',
        ),
      );
  static const VerificationMeta _displayNameSnapshotMeta =
      const VerificationMeta('displayNameSnapshot');
  @override
  late final GeneratedColumn<String> displayNameSnapshot =
      GeneratedColumn<String>(
        'display_name_snapshot',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _isEquippedMeta = const VerificationMeta(
    'isEquipped',
  );
  @override
  late final GeneratedColumn<bool> isEquipped = GeneratedColumn<bool>(
    'is_equipped',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_equipped" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isCarriedMeta = const VerificationMeta(
    'isCarried',
  );
  @override
  late final GeneratedColumn<bool> isCarried = GeneratedColumn<bool>(
    'is_carried',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_carried" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _chargesCurrentMeta = const VerificationMeta(
    'chargesCurrent',
  );
  @override
  late final GeneratedColumn<int> chargesCurrent = GeneratedColumn<int>(
    'charges_current',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _chargesMaxMeta = const VerificationMeta(
    'chargesMax',
  );
  @override
  late final GeneratedColumn<int> chargesMax = GeneratedColumn<int>(
    'charges_max',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _containerInventoryItemIdMeta =
      const VerificationMeta('containerInventoryItemId');
  @override
  late final GeneratedColumn<String> containerInventoryItemId =
      GeneratedColumn<String>(
        'container_inventory_item_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    characterId,
    equipmentDefinitionId,
    trinketDefinitionId,
    displayNameSnapshot,
    quantity,
    isEquipped,
    isCarried,
    isFavorite,
    chargesCurrent,
    chargesMax,
    containerInventoryItemId,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'character_inventory';
  @override
  VerificationContext validateIntegrity(
    Insertable<CharacterInventoryData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('character_id')) {
      context.handle(
        _characterIdMeta,
        characterId.isAcceptableOrUnknown(
          data['character_id']!,
          _characterIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_characterIdMeta);
    }
    if (data.containsKey('equipment_definition_id')) {
      context.handle(
        _equipmentDefinitionIdMeta,
        equipmentDefinitionId.isAcceptableOrUnknown(
          data['equipment_definition_id']!,
          _equipmentDefinitionIdMeta,
        ),
      );
    }
    if (data.containsKey('trinket_definition_id')) {
      context.handle(
        _trinketDefinitionIdMeta,
        trinketDefinitionId.isAcceptableOrUnknown(
          data['trinket_definition_id']!,
          _trinketDefinitionIdMeta,
        ),
      );
    }
    if (data.containsKey('display_name_snapshot')) {
      context.handle(
        _displayNameSnapshotMeta,
        displayNameSnapshot.isAcceptableOrUnknown(
          data['display_name_snapshot']!,
          _displayNameSnapshotMeta,
        ),
      );
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('is_equipped')) {
      context.handle(
        _isEquippedMeta,
        isEquipped.isAcceptableOrUnknown(data['is_equipped']!, _isEquippedMeta),
      );
    }
    if (data.containsKey('is_carried')) {
      context.handle(
        _isCarriedMeta,
        isCarried.isAcceptableOrUnknown(data['is_carried']!, _isCarriedMeta),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('charges_current')) {
      context.handle(
        _chargesCurrentMeta,
        chargesCurrent.isAcceptableOrUnknown(
          data['charges_current']!,
          _chargesCurrentMeta,
        ),
      );
    }
    if (data.containsKey('charges_max')) {
      context.handle(
        _chargesMaxMeta,
        chargesMax.isAcceptableOrUnknown(data['charges_max']!, _chargesMaxMeta),
      );
    }
    if (data.containsKey('container_inventory_item_id')) {
      context.handle(
        _containerInventoryItemIdMeta,
        containerInventoryItemId.isAcceptableOrUnknown(
          data['container_inventory_item_id']!,
          _containerInventoryItemIdMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CharacterInventoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CharacterInventoryData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      characterId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}character_id'],
      )!,
      equipmentDefinitionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}equipment_definition_id'],
      ),
      trinketDefinitionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trinket_definition_id'],
      ),
      displayNameSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name_snapshot'],
      ),
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      isEquipped: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_equipped'],
      )!,
      isCarried: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_carried'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      chargesCurrent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}charges_current'],
      ),
      chargesMax: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}charges_max'],
      ),
      containerInventoryItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}container_inventory_item_id'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $CharacterInventoryTable createAlias(String alias) {
    return $CharacterInventoryTable(attachedDatabase, alias);
  }
}

class CharacterInventoryData extends DataClass
    implements Insertable<CharacterInventoryData> {
  final String id;
  final String characterId;
  final String? equipmentDefinitionId;
  final String? trinketDefinitionId;
  final String? displayNameSnapshot;
  final int quantity;
  final bool isEquipped;
  final bool isCarried;
  final bool isFavorite;
  final int? chargesCurrent;
  final int? chargesMax;
  final String? containerInventoryItemId;
  final String? notes;
  const CharacterInventoryData({
    required this.id,
    required this.characterId,
    this.equipmentDefinitionId,
    this.trinketDefinitionId,
    this.displayNameSnapshot,
    required this.quantity,
    required this.isEquipped,
    required this.isCarried,
    required this.isFavorite,
    this.chargesCurrent,
    this.chargesMax,
    this.containerInventoryItemId,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['character_id'] = Variable<String>(characterId);
    if (!nullToAbsent || equipmentDefinitionId != null) {
      map['equipment_definition_id'] = Variable<String>(equipmentDefinitionId);
    }
    if (!nullToAbsent || trinketDefinitionId != null) {
      map['trinket_definition_id'] = Variable<String>(trinketDefinitionId);
    }
    if (!nullToAbsent || displayNameSnapshot != null) {
      map['display_name_snapshot'] = Variable<String>(displayNameSnapshot);
    }
    map['quantity'] = Variable<int>(quantity);
    map['is_equipped'] = Variable<bool>(isEquipped);
    map['is_carried'] = Variable<bool>(isCarried);
    map['is_favorite'] = Variable<bool>(isFavorite);
    if (!nullToAbsent || chargesCurrent != null) {
      map['charges_current'] = Variable<int>(chargesCurrent);
    }
    if (!nullToAbsent || chargesMax != null) {
      map['charges_max'] = Variable<int>(chargesMax);
    }
    if (!nullToAbsent || containerInventoryItemId != null) {
      map['container_inventory_item_id'] = Variable<String>(
        containerInventoryItemId,
      );
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  CharacterInventoryCompanion toCompanion(bool nullToAbsent) {
    return CharacterInventoryCompanion(
      id: Value(id),
      characterId: Value(characterId),
      equipmentDefinitionId: equipmentDefinitionId == null && nullToAbsent
          ? const Value.absent()
          : Value(equipmentDefinitionId),
      trinketDefinitionId: trinketDefinitionId == null && nullToAbsent
          ? const Value.absent()
          : Value(trinketDefinitionId),
      displayNameSnapshot: displayNameSnapshot == null && nullToAbsent
          ? const Value.absent()
          : Value(displayNameSnapshot),
      quantity: Value(quantity),
      isEquipped: Value(isEquipped),
      isCarried: Value(isCarried),
      isFavorite: Value(isFavorite),
      chargesCurrent: chargesCurrent == null && nullToAbsent
          ? const Value.absent()
          : Value(chargesCurrent),
      chargesMax: chargesMax == null && nullToAbsent
          ? const Value.absent()
          : Value(chargesMax),
      containerInventoryItemId: containerInventoryItemId == null && nullToAbsent
          ? const Value.absent()
          : Value(containerInventoryItemId),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory CharacterInventoryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CharacterInventoryData(
      id: serializer.fromJson<String>(json['id']),
      characterId: serializer.fromJson<String>(json['characterId']),
      equipmentDefinitionId: serializer.fromJson<String?>(
        json['equipmentDefinitionId'],
      ),
      trinketDefinitionId: serializer.fromJson<String?>(
        json['trinketDefinitionId'],
      ),
      displayNameSnapshot: serializer.fromJson<String?>(
        json['displayNameSnapshot'],
      ),
      quantity: serializer.fromJson<int>(json['quantity']),
      isEquipped: serializer.fromJson<bool>(json['isEquipped']),
      isCarried: serializer.fromJson<bool>(json['isCarried']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      chargesCurrent: serializer.fromJson<int?>(json['chargesCurrent']),
      chargesMax: serializer.fromJson<int?>(json['chargesMax']),
      containerInventoryItemId: serializer.fromJson<String?>(
        json['containerInventoryItemId'],
      ),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'characterId': serializer.toJson<String>(characterId),
      'equipmentDefinitionId': serializer.toJson<String?>(
        equipmentDefinitionId,
      ),
      'trinketDefinitionId': serializer.toJson<String?>(trinketDefinitionId),
      'displayNameSnapshot': serializer.toJson<String?>(displayNameSnapshot),
      'quantity': serializer.toJson<int>(quantity),
      'isEquipped': serializer.toJson<bool>(isEquipped),
      'isCarried': serializer.toJson<bool>(isCarried),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'chargesCurrent': serializer.toJson<int?>(chargesCurrent),
      'chargesMax': serializer.toJson<int?>(chargesMax),
      'containerInventoryItemId': serializer.toJson<String?>(
        containerInventoryItemId,
      ),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  CharacterInventoryData copyWith({
    String? id,
    String? characterId,
    Value<String?> equipmentDefinitionId = const Value.absent(),
    Value<String?> trinketDefinitionId = const Value.absent(),
    Value<String?> displayNameSnapshot = const Value.absent(),
    int? quantity,
    bool? isEquipped,
    bool? isCarried,
    bool? isFavorite,
    Value<int?> chargesCurrent = const Value.absent(),
    Value<int?> chargesMax = const Value.absent(),
    Value<String?> containerInventoryItemId = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => CharacterInventoryData(
    id: id ?? this.id,
    characterId: characterId ?? this.characterId,
    equipmentDefinitionId: equipmentDefinitionId.present
        ? equipmentDefinitionId.value
        : this.equipmentDefinitionId,
    trinketDefinitionId: trinketDefinitionId.present
        ? trinketDefinitionId.value
        : this.trinketDefinitionId,
    displayNameSnapshot: displayNameSnapshot.present
        ? displayNameSnapshot.value
        : this.displayNameSnapshot,
    quantity: quantity ?? this.quantity,
    isEquipped: isEquipped ?? this.isEquipped,
    isCarried: isCarried ?? this.isCarried,
    isFavorite: isFavorite ?? this.isFavorite,
    chargesCurrent: chargesCurrent.present
        ? chargesCurrent.value
        : this.chargesCurrent,
    chargesMax: chargesMax.present ? chargesMax.value : this.chargesMax,
    containerInventoryItemId: containerInventoryItemId.present
        ? containerInventoryItemId.value
        : this.containerInventoryItemId,
    notes: notes.present ? notes.value : this.notes,
  );
  CharacterInventoryData copyWithCompanion(CharacterInventoryCompanion data) {
    return CharacterInventoryData(
      id: data.id.present ? data.id.value : this.id,
      characterId: data.characterId.present
          ? data.characterId.value
          : this.characterId,
      equipmentDefinitionId: data.equipmentDefinitionId.present
          ? data.equipmentDefinitionId.value
          : this.equipmentDefinitionId,
      trinketDefinitionId: data.trinketDefinitionId.present
          ? data.trinketDefinitionId.value
          : this.trinketDefinitionId,
      displayNameSnapshot: data.displayNameSnapshot.present
          ? data.displayNameSnapshot.value
          : this.displayNameSnapshot,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      isEquipped: data.isEquipped.present
          ? data.isEquipped.value
          : this.isEquipped,
      isCarried: data.isCarried.present ? data.isCarried.value : this.isCarried,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      chargesCurrent: data.chargesCurrent.present
          ? data.chargesCurrent.value
          : this.chargesCurrent,
      chargesMax: data.chargesMax.present
          ? data.chargesMax.value
          : this.chargesMax,
      containerInventoryItemId: data.containerInventoryItemId.present
          ? data.containerInventoryItemId.value
          : this.containerInventoryItemId,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CharacterInventoryData(')
          ..write('id: $id, ')
          ..write('characterId: $characterId, ')
          ..write('equipmentDefinitionId: $equipmentDefinitionId, ')
          ..write('trinketDefinitionId: $trinketDefinitionId, ')
          ..write('displayNameSnapshot: $displayNameSnapshot, ')
          ..write('quantity: $quantity, ')
          ..write('isEquipped: $isEquipped, ')
          ..write('isCarried: $isCarried, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('chargesCurrent: $chargesCurrent, ')
          ..write('chargesMax: $chargesMax, ')
          ..write('containerInventoryItemId: $containerInventoryItemId, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    characterId,
    equipmentDefinitionId,
    trinketDefinitionId,
    displayNameSnapshot,
    quantity,
    isEquipped,
    isCarried,
    isFavorite,
    chargesCurrent,
    chargesMax,
    containerInventoryItemId,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CharacterInventoryData &&
          other.id == this.id &&
          other.characterId == this.characterId &&
          other.equipmentDefinitionId == this.equipmentDefinitionId &&
          other.trinketDefinitionId == this.trinketDefinitionId &&
          other.displayNameSnapshot == this.displayNameSnapshot &&
          other.quantity == this.quantity &&
          other.isEquipped == this.isEquipped &&
          other.isCarried == this.isCarried &&
          other.isFavorite == this.isFavorite &&
          other.chargesCurrent == this.chargesCurrent &&
          other.chargesMax == this.chargesMax &&
          other.containerInventoryItemId == this.containerInventoryItemId &&
          other.notes == this.notes);
}

class CharacterInventoryCompanion
    extends UpdateCompanion<CharacterInventoryData> {
  final Value<String> id;
  final Value<String> characterId;
  final Value<String?> equipmentDefinitionId;
  final Value<String?> trinketDefinitionId;
  final Value<String?> displayNameSnapshot;
  final Value<int> quantity;
  final Value<bool> isEquipped;
  final Value<bool> isCarried;
  final Value<bool> isFavorite;
  final Value<int?> chargesCurrent;
  final Value<int?> chargesMax;
  final Value<String?> containerInventoryItemId;
  final Value<String?> notes;
  final Value<int> rowid;
  const CharacterInventoryCompanion({
    this.id = const Value.absent(),
    this.characterId = const Value.absent(),
    this.equipmentDefinitionId = const Value.absent(),
    this.trinketDefinitionId = const Value.absent(),
    this.displayNameSnapshot = const Value.absent(),
    this.quantity = const Value.absent(),
    this.isEquipped = const Value.absent(),
    this.isCarried = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.chargesCurrent = const Value.absent(),
    this.chargesMax = const Value.absent(),
    this.containerInventoryItemId = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CharacterInventoryCompanion.insert({
    required String id,
    required String characterId,
    this.equipmentDefinitionId = const Value.absent(),
    this.trinketDefinitionId = const Value.absent(),
    this.displayNameSnapshot = const Value.absent(),
    this.quantity = const Value.absent(),
    this.isEquipped = const Value.absent(),
    this.isCarried = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.chargesCurrent = const Value.absent(),
    this.chargesMax = const Value.absent(),
    this.containerInventoryItemId = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       characterId = Value(characterId);
  static Insertable<CharacterInventoryData> custom({
    Expression<String>? id,
    Expression<String>? characterId,
    Expression<String>? equipmentDefinitionId,
    Expression<String>? trinketDefinitionId,
    Expression<String>? displayNameSnapshot,
    Expression<int>? quantity,
    Expression<bool>? isEquipped,
    Expression<bool>? isCarried,
    Expression<bool>? isFavorite,
    Expression<int>? chargesCurrent,
    Expression<int>? chargesMax,
    Expression<String>? containerInventoryItemId,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (characterId != null) 'character_id': characterId,
      if (equipmentDefinitionId != null)
        'equipment_definition_id': equipmentDefinitionId,
      if (trinketDefinitionId != null)
        'trinket_definition_id': trinketDefinitionId,
      if (displayNameSnapshot != null)
        'display_name_snapshot': displayNameSnapshot,
      if (quantity != null) 'quantity': quantity,
      if (isEquipped != null) 'is_equipped': isEquipped,
      if (isCarried != null) 'is_carried': isCarried,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (chargesCurrent != null) 'charges_current': chargesCurrent,
      if (chargesMax != null) 'charges_max': chargesMax,
      if (containerInventoryItemId != null)
        'container_inventory_item_id': containerInventoryItemId,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CharacterInventoryCompanion copyWith({
    Value<String>? id,
    Value<String>? characterId,
    Value<String?>? equipmentDefinitionId,
    Value<String?>? trinketDefinitionId,
    Value<String?>? displayNameSnapshot,
    Value<int>? quantity,
    Value<bool>? isEquipped,
    Value<bool>? isCarried,
    Value<bool>? isFavorite,
    Value<int?>? chargesCurrent,
    Value<int?>? chargesMax,
    Value<String?>? containerInventoryItemId,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return CharacterInventoryCompanion(
      id: id ?? this.id,
      characterId: characterId ?? this.characterId,
      equipmentDefinitionId:
          equipmentDefinitionId ?? this.equipmentDefinitionId,
      trinketDefinitionId: trinketDefinitionId ?? this.trinketDefinitionId,
      displayNameSnapshot: displayNameSnapshot ?? this.displayNameSnapshot,
      quantity: quantity ?? this.quantity,
      isEquipped: isEquipped ?? this.isEquipped,
      isCarried: isCarried ?? this.isCarried,
      isFavorite: isFavorite ?? this.isFavorite,
      chargesCurrent: chargesCurrent ?? this.chargesCurrent,
      chargesMax: chargesMax ?? this.chargesMax,
      containerInventoryItemId:
          containerInventoryItemId ?? this.containerInventoryItemId,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (characterId.present) {
      map['character_id'] = Variable<String>(characterId.value);
    }
    if (equipmentDefinitionId.present) {
      map['equipment_definition_id'] = Variable<String>(
        equipmentDefinitionId.value,
      );
    }
    if (trinketDefinitionId.present) {
      map['trinket_definition_id'] = Variable<String>(
        trinketDefinitionId.value,
      );
    }
    if (displayNameSnapshot.present) {
      map['display_name_snapshot'] = Variable<String>(
        displayNameSnapshot.value,
      );
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (isEquipped.present) {
      map['is_equipped'] = Variable<bool>(isEquipped.value);
    }
    if (isCarried.present) {
      map['is_carried'] = Variable<bool>(isCarried.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (chargesCurrent.present) {
      map['charges_current'] = Variable<int>(chargesCurrent.value);
    }
    if (chargesMax.present) {
      map['charges_max'] = Variable<int>(chargesMax.value);
    }
    if (containerInventoryItemId.present) {
      map['container_inventory_item_id'] = Variable<String>(
        containerInventoryItemId.value,
      );
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CharacterInventoryCompanion(')
          ..write('id: $id, ')
          ..write('characterId: $characterId, ')
          ..write('equipmentDefinitionId: $equipmentDefinitionId, ')
          ..write('trinketDefinitionId: $trinketDefinitionId, ')
          ..write('displayNameSnapshot: $displayNameSnapshot, ')
          ..write('quantity: $quantity, ')
          ..write('isEquipped: $isEquipped, ')
          ..write('isCarried: $isCarried, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('chargesCurrent: $chargesCurrent, ')
          ..write('chargesMax: $chargesMax, ')
          ..write('containerInventoryItemId: $containerInventoryItemId, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CharacterProficienciesTable extends CharacterProficiencies
    with TableInfo<$CharacterProficienciesTable, CharacterProficiency> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CharacterProficienciesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _characterIdMeta = const VerificationMeta(
    'characterId',
  );
  @override
  late final GeneratedColumn<String> characterId = GeneratedColumn<String>(
    'character_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES characters (id)',
    ),
  );
  static const VerificationMeta _proficiencyTypeMeta = const VerificationMeta(
    'proficiencyType',
  );
  @override
  late final GeneratedColumn<String> proficiencyType = GeneratedColumn<String>(
    'proficiency_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenceKeyMeta = const VerificationMeta(
    'referenceKey',
  );
  @override
  late final GeneratedColumn<String> referenceKey = GeneratedColumn<String>(
    'reference_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceTypeMeta = const VerificationMeta(
    'sourceType',
  );
  @override
  late final GeneratedColumn<String> sourceType = GeneratedColumn<String>(
    'source_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceIdMeta = const VerificationMeta(
    'sourceId',
  );
  @override
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
    'source_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isExpertiseMeta = const VerificationMeta(
    'isExpertise',
  );
  @override
  late final GeneratedColumn<bool> isExpertise = GeneratedColumn<bool>(
    'is_expertise',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_expertise" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    characterId,
    proficiencyType,
    referenceKey,
    sourceType,
    sourceId,
    isExpertise,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'character_proficiencies';
  @override
  VerificationContext validateIntegrity(
    Insertable<CharacterProficiency> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('character_id')) {
      context.handle(
        _characterIdMeta,
        characterId.isAcceptableOrUnknown(
          data['character_id']!,
          _characterIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_characterIdMeta);
    }
    if (data.containsKey('proficiency_type')) {
      context.handle(
        _proficiencyTypeMeta,
        proficiencyType.isAcceptableOrUnknown(
          data['proficiency_type']!,
          _proficiencyTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_proficiencyTypeMeta);
    }
    if (data.containsKey('reference_key')) {
      context.handle(
        _referenceKeyMeta,
        referenceKey.isAcceptableOrUnknown(
          data['reference_key']!,
          _referenceKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_referenceKeyMeta);
    }
    if (data.containsKey('source_type')) {
      context.handle(
        _sourceTypeMeta,
        sourceType.isAcceptableOrUnknown(data['source_type']!, _sourceTypeMeta),
      );
    }
    if (data.containsKey('source_id')) {
      context.handle(
        _sourceIdMeta,
        sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta),
      );
    }
    if (data.containsKey('is_expertise')) {
      context.handle(
        _isExpertiseMeta,
        isExpertise.isAcceptableOrUnknown(
          data['is_expertise']!,
          _isExpertiseMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {characterId, proficiencyType, referenceKey},
  ];
  @override
  CharacterProficiency map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CharacterProficiency(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      characterId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}character_id'],
      )!,
      proficiencyType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}proficiency_type'],
      )!,
      referenceKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference_key'],
      )!,
      sourceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_type'],
      ),
      sourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_id'],
      ),
      isExpertise: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_expertise'],
      )!,
    );
  }

  @override
  $CharacterProficienciesTable createAlias(String alias) {
    return $CharacterProficienciesTable(attachedDatabase, alias);
  }
}

class CharacterProficiency extends DataClass
    implements Insertable<CharacterProficiency> {
  final String id;
  final String characterId;
  final String proficiencyType;
  final String referenceKey;
  final String? sourceType;
  final String? sourceId;
  final bool isExpertise;
  const CharacterProficiency({
    required this.id,
    required this.characterId,
    required this.proficiencyType,
    required this.referenceKey,
    this.sourceType,
    this.sourceId,
    required this.isExpertise,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['character_id'] = Variable<String>(characterId);
    map['proficiency_type'] = Variable<String>(proficiencyType);
    map['reference_key'] = Variable<String>(referenceKey);
    if (!nullToAbsent || sourceType != null) {
      map['source_type'] = Variable<String>(sourceType);
    }
    if (!nullToAbsent || sourceId != null) {
      map['source_id'] = Variable<String>(sourceId);
    }
    map['is_expertise'] = Variable<bool>(isExpertise);
    return map;
  }

  CharacterProficienciesCompanion toCompanion(bool nullToAbsent) {
    return CharacterProficienciesCompanion(
      id: Value(id),
      characterId: Value(characterId),
      proficiencyType: Value(proficiencyType),
      referenceKey: Value(referenceKey),
      sourceType: sourceType == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceType),
      sourceId: sourceId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceId),
      isExpertise: Value(isExpertise),
    );
  }

  factory CharacterProficiency.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CharacterProficiency(
      id: serializer.fromJson<String>(json['id']),
      characterId: serializer.fromJson<String>(json['characterId']),
      proficiencyType: serializer.fromJson<String>(json['proficiencyType']),
      referenceKey: serializer.fromJson<String>(json['referenceKey']),
      sourceType: serializer.fromJson<String?>(json['sourceType']),
      sourceId: serializer.fromJson<String?>(json['sourceId']),
      isExpertise: serializer.fromJson<bool>(json['isExpertise']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'characterId': serializer.toJson<String>(characterId),
      'proficiencyType': serializer.toJson<String>(proficiencyType),
      'referenceKey': serializer.toJson<String>(referenceKey),
      'sourceType': serializer.toJson<String?>(sourceType),
      'sourceId': serializer.toJson<String?>(sourceId),
      'isExpertise': serializer.toJson<bool>(isExpertise),
    };
  }

  CharacterProficiency copyWith({
    String? id,
    String? characterId,
    String? proficiencyType,
    String? referenceKey,
    Value<String?> sourceType = const Value.absent(),
    Value<String?> sourceId = const Value.absent(),
    bool? isExpertise,
  }) => CharacterProficiency(
    id: id ?? this.id,
    characterId: characterId ?? this.characterId,
    proficiencyType: proficiencyType ?? this.proficiencyType,
    referenceKey: referenceKey ?? this.referenceKey,
    sourceType: sourceType.present ? sourceType.value : this.sourceType,
    sourceId: sourceId.present ? sourceId.value : this.sourceId,
    isExpertise: isExpertise ?? this.isExpertise,
  );
  CharacterProficiency copyWithCompanion(CharacterProficienciesCompanion data) {
    return CharacterProficiency(
      id: data.id.present ? data.id.value : this.id,
      characterId: data.characterId.present
          ? data.characterId.value
          : this.characterId,
      proficiencyType: data.proficiencyType.present
          ? data.proficiencyType.value
          : this.proficiencyType,
      referenceKey: data.referenceKey.present
          ? data.referenceKey.value
          : this.referenceKey,
      sourceType: data.sourceType.present
          ? data.sourceType.value
          : this.sourceType,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      isExpertise: data.isExpertise.present
          ? data.isExpertise.value
          : this.isExpertise,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CharacterProficiency(')
          ..write('id: $id, ')
          ..write('characterId: $characterId, ')
          ..write('proficiencyType: $proficiencyType, ')
          ..write('referenceKey: $referenceKey, ')
          ..write('sourceType: $sourceType, ')
          ..write('sourceId: $sourceId, ')
          ..write('isExpertise: $isExpertise')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    characterId,
    proficiencyType,
    referenceKey,
    sourceType,
    sourceId,
    isExpertise,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CharacterProficiency &&
          other.id == this.id &&
          other.characterId == this.characterId &&
          other.proficiencyType == this.proficiencyType &&
          other.referenceKey == this.referenceKey &&
          other.sourceType == this.sourceType &&
          other.sourceId == this.sourceId &&
          other.isExpertise == this.isExpertise);
}

class CharacterProficienciesCompanion
    extends UpdateCompanion<CharacterProficiency> {
  final Value<String> id;
  final Value<String> characterId;
  final Value<String> proficiencyType;
  final Value<String> referenceKey;
  final Value<String?> sourceType;
  final Value<String?> sourceId;
  final Value<bool> isExpertise;
  final Value<int> rowid;
  const CharacterProficienciesCompanion({
    this.id = const Value.absent(),
    this.characterId = const Value.absent(),
    this.proficiencyType = const Value.absent(),
    this.referenceKey = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.isExpertise = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CharacterProficienciesCompanion.insert({
    required String id,
    required String characterId,
    required String proficiencyType,
    required String referenceKey,
    this.sourceType = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.isExpertise = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       characterId = Value(characterId),
       proficiencyType = Value(proficiencyType),
       referenceKey = Value(referenceKey);
  static Insertable<CharacterProficiency> custom({
    Expression<String>? id,
    Expression<String>? characterId,
    Expression<String>? proficiencyType,
    Expression<String>? referenceKey,
    Expression<String>? sourceType,
    Expression<String>? sourceId,
    Expression<bool>? isExpertise,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (characterId != null) 'character_id': characterId,
      if (proficiencyType != null) 'proficiency_type': proficiencyType,
      if (referenceKey != null) 'reference_key': referenceKey,
      if (sourceType != null) 'source_type': sourceType,
      if (sourceId != null) 'source_id': sourceId,
      if (isExpertise != null) 'is_expertise': isExpertise,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CharacterProficienciesCompanion copyWith({
    Value<String>? id,
    Value<String>? characterId,
    Value<String>? proficiencyType,
    Value<String>? referenceKey,
    Value<String?>? sourceType,
    Value<String?>? sourceId,
    Value<bool>? isExpertise,
    Value<int>? rowid,
  }) {
    return CharacterProficienciesCompanion(
      id: id ?? this.id,
      characterId: characterId ?? this.characterId,
      proficiencyType: proficiencyType ?? this.proficiencyType,
      referenceKey: referenceKey ?? this.referenceKey,
      sourceType: sourceType ?? this.sourceType,
      sourceId: sourceId ?? this.sourceId,
      isExpertise: isExpertise ?? this.isExpertise,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (characterId.present) {
      map['character_id'] = Variable<String>(characterId.value);
    }
    if (proficiencyType.present) {
      map['proficiency_type'] = Variable<String>(proficiencyType.value);
    }
    if (referenceKey.present) {
      map['reference_key'] = Variable<String>(referenceKey.value);
    }
    if (sourceType.present) {
      map['source_type'] = Variable<String>(sourceType.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (isExpertise.present) {
      map['is_expertise'] = Variable<bool>(isExpertise.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CharacterProficienciesCompanion(')
          ..write('id: $id, ')
          ..write('characterId: $characterId, ')
          ..write('proficiencyType: $proficiencyType, ')
          ..write('referenceKey: $referenceKey, ')
          ..write('sourceType: $sourceType, ')
          ..write('sourceId: $sourceId, ')
          ..write('isExpertise: $isExpertise, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CharacterCurrencyTable extends CharacterCurrency
    with TableInfo<$CharacterCurrencyTable, CharacterCurrencyData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CharacterCurrencyTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _characterIdMeta = const VerificationMeta(
    'characterId',
  );
  @override
  late final GeneratedColumn<String> characterId = GeneratedColumn<String>(
    'character_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES characters (id)',
    ),
  );
  static const VerificationMeta _copperMeta = const VerificationMeta('copper');
  @override
  late final GeneratedColumn<int> copper = GeneratedColumn<int>(
    'copper',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _silverMeta = const VerificationMeta('silver');
  @override
  late final GeneratedColumn<int> silver = GeneratedColumn<int>(
    'silver',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _electrumMeta = const VerificationMeta(
    'electrum',
  );
  @override
  late final GeneratedColumn<int> electrum = GeneratedColumn<int>(
    'electrum',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _goldMeta = const VerificationMeta('gold');
  @override
  late final GeneratedColumn<int> gold = GeneratedColumn<int>(
    'gold',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _platinumMeta = const VerificationMeta(
    'platinum',
  );
  @override
  late final GeneratedColumn<int> platinum = GeneratedColumn<int>(
    'platinum',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _summarySnapshotMeta = const VerificationMeta(
    'summarySnapshot',
  );
  @override
  late final GeneratedColumn<String> summarySnapshot = GeneratedColumn<String>(
    'summary_snapshot',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    characterId,
    copper,
    silver,
    electrum,
    gold,
    platinum,
    summarySnapshot,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'character_currency';
  @override
  VerificationContext validateIntegrity(
    Insertable<CharacterCurrencyData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('character_id')) {
      context.handle(
        _characterIdMeta,
        characterId.isAcceptableOrUnknown(
          data['character_id']!,
          _characterIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_characterIdMeta);
    }
    if (data.containsKey('copper')) {
      context.handle(
        _copperMeta,
        copper.isAcceptableOrUnknown(data['copper']!, _copperMeta),
      );
    }
    if (data.containsKey('silver')) {
      context.handle(
        _silverMeta,
        silver.isAcceptableOrUnknown(data['silver']!, _silverMeta),
      );
    }
    if (data.containsKey('electrum')) {
      context.handle(
        _electrumMeta,
        electrum.isAcceptableOrUnknown(data['electrum']!, _electrumMeta),
      );
    }
    if (data.containsKey('gold')) {
      context.handle(
        _goldMeta,
        gold.isAcceptableOrUnknown(data['gold']!, _goldMeta),
      );
    }
    if (data.containsKey('platinum')) {
      context.handle(
        _platinumMeta,
        platinum.isAcceptableOrUnknown(data['platinum']!, _platinumMeta),
      );
    }
    if (data.containsKey('summary_snapshot')) {
      context.handle(
        _summarySnapshotMeta,
        summarySnapshot.isAcceptableOrUnknown(
          data['summary_snapshot']!,
          _summarySnapshotMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {characterId};
  @override
  CharacterCurrencyData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CharacterCurrencyData(
      characterId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}character_id'],
      )!,
      copper: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}copper'],
      )!,
      silver: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}silver'],
      )!,
      electrum: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}electrum'],
      )!,
      gold: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}gold'],
      )!,
      platinum: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}platinum'],
      )!,
      summarySnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}summary_snapshot'],
      ),
    );
  }

  @override
  $CharacterCurrencyTable createAlias(String alias) {
    return $CharacterCurrencyTable(attachedDatabase, alias);
  }
}

class CharacterCurrencyData extends DataClass
    implements Insertable<CharacterCurrencyData> {
  final String characterId;
  final int copper;
  final int silver;
  final int electrum;
  final int gold;
  final int platinum;
  final String? summarySnapshot;
  const CharacterCurrencyData({
    required this.characterId,
    required this.copper,
    required this.silver,
    required this.electrum,
    required this.gold,
    required this.platinum,
    this.summarySnapshot,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['character_id'] = Variable<String>(characterId);
    map['copper'] = Variable<int>(copper);
    map['silver'] = Variable<int>(silver);
    map['electrum'] = Variable<int>(electrum);
    map['gold'] = Variable<int>(gold);
    map['platinum'] = Variable<int>(platinum);
    if (!nullToAbsent || summarySnapshot != null) {
      map['summary_snapshot'] = Variable<String>(summarySnapshot);
    }
    return map;
  }

  CharacterCurrencyCompanion toCompanion(bool nullToAbsent) {
    return CharacterCurrencyCompanion(
      characterId: Value(characterId),
      copper: Value(copper),
      silver: Value(silver),
      electrum: Value(electrum),
      gold: Value(gold),
      platinum: Value(platinum),
      summarySnapshot: summarySnapshot == null && nullToAbsent
          ? const Value.absent()
          : Value(summarySnapshot),
    );
  }

  factory CharacterCurrencyData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CharacterCurrencyData(
      characterId: serializer.fromJson<String>(json['characterId']),
      copper: serializer.fromJson<int>(json['copper']),
      silver: serializer.fromJson<int>(json['silver']),
      electrum: serializer.fromJson<int>(json['electrum']),
      gold: serializer.fromJson<int>(json['gold']),
      platinum: serializer.fromJson<int>(json['platinum']),
      summarySnapshot: serializer.fromJson<String?>(json['summarySnapshot']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'characterId': serializer.toJson<String>(characterId),
      'copper': serializer.toJson<int>(copper),
      'silver': serializer.toJson<int>(silver),
      'electrum': serializer.toJson<int>(electrum),
      'gold': serializer.toJson<int>(gold),
      'platinum': serializer.toJson<int>(platinum),
      'summarySnapshot': serializer.toJson<String?>(summarySnapshot),
    };
  }

  CharacterCurrencyData copyWith({
    String? characterId,
    int? copper,
    int? silver,
    int? electrum,
    int? gold,
    int? platinum,
    Value<String?> summarySnapshot = const Value.absent(),
  }) => CharacterCurrencyData(
    characterId: characterId ?? this.characterId,
    copper: copper ?? this.copper,
    silver: silver ?? this.silver,
    electrum: electrum ?? this.electrum,
    gold: gold ?? this.gold,
    platinum: platinum ?? this.platinum,
    summarySnapshot: summarySnapshot.present
        ? summarySnapshot.value
        : this.summarySnapshot,
  );
  CharacterCurrencyData copyWithCompanion(CharacterCurrencyCompanion data) {
    return CharacterCurrencyData(
      characterId: data.characterId.present
          ? data.characterId.value
          : this.characterId,
      copper: data.copper.present ? data.copper.value : this.copper,
      silver: data.silver.present ? data.silver.value : this.silver,
      electrum: data.electrum.present ? data.electrum.value : this.electrum,
      gold: data.gold.present ? data.gold.value : this.gold,
      platinum: data.platinum.present ? data.platinum.value : this.platinum,
      summarySnapshot: data.summarySnapshot.present
          ? data.summarySnapshot.value
          : this.summarySnapshot,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CharacterCurrencyData(')
          ..write('characterId: $characterId, ')
          ..write('copper: $copper, ')
          ..write('silver: $silver, ')
          ..write('electrum: $electrum, ')
          ..write('gold: $gold, ')
          ..write('platinum: $platinum, ')
          ..write('summarySnapshot: $summarySnapshot')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    characterId,
    copper,
    silver,
    electrum,
    gold,
    platinum,
    summarySnapshot,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CharacterCurrencyData &&
          other.characterId == this.characterId &&
          other.copper == this.copper &&
          other.silver == this.silver &&
          other.electrum == this.electrum &&
          other.gold == this.gold &&
          other.platinum == this.platinum &&
          other.summarySnapshot == this.summarySnapshot);
}

class CharacterCurrencyCompanion
    extends UpdateCompanion<CharacterCurrencyData> {
  final Value<String> characterId;
  final Value<int> copper;
  final Value<int> silver;
  final Value<int> electrum;
  final Value<int> gold;
  final Value<int> platinum;
  final Value<String?> summarySnapshot;
  final Value<int> rowid;
  const CharacterCurrencyCompanion({
    this.characterId = const Value.absent(),
    this.copper = const Value.absent(),
    this.silver = const Value.absent(),
    this.electrum = const Value.absent(),
    this.gold = const Value.absent(),
    this.platinum = const Value.absent(),
    this.summarySnapshot = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CharacterCurrencyCompanion.insert({
    required String characterId,
    this.copper = const Value.absent(),
    this.silver = const Value.absent(),
    this.electrum = const Value.absent(),
    this.gold = const Value.absent(),
    this.platinum = const Value.absent(),
    this.summarySnapshot = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : characterId = Value(characterId);
  static Insertable<CharacterCurrencyData> custom({
    Expression<String>? characterId,
    Expression<int>? copper,
    Expression<int>? silver,
    Expression<int>? electrum,
    Expression<int>? gold,
    Expression<int>? platinum,
    Expression<String>? summarySnapshot,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (characterId != null) 'character_id': characterId,
      if (copper != null) 'copper': copper,
      if (silver != null) 'silver': silver,
      if (electrum != null) 'electrum': electrum,
      if (gold != null) 'gold': gold,
      if (platinum != null) 'platinum': platinum,
      if (summarySnapshot != null) 'summary_snapshot': summarySnapshot,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CharacterCurrencyCompanion copyWith({
    Value<String>? characterId,
    Value<int>? copper,
    Value<int>? silver,
    Value<int>? electrum,
    Value<int>? gold,
    Value<int>? platinum,
    Value<String?>? summarySnapshot,
    Value<int>? rowid,
  }) {
    return CharacterCurrencyCompanion(
      characterId: characterId ?? this.characterId,
      copper: copper ?? this.copper,
      silver: silver ?? this.silver,
      electrum: electrum ?? this.electrum,
      gold: gold ?? this.gold,
      platinum: platinum ?? this.platinum,
      summarySnapshot: summarySnapshot ?? this.summarySnapshot,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (characterId.present) {
      map['character_id'] = Variable<String>(characterId.value);
    }
    if (copper.present) {
      map['copper'] = Variable<int>(copper.value);
    }
    if (silver.present) {
      map['silver'] = Variable<int>(silver.value);
    }
    if (electrum.present) {
      map['electrum'] = Variable<int>(electrum.value);
    }
    if (gold.present) {
      map['gold'] = Variable<int>(gold.value);
    }
    if (platinum.present) {
      map['platinum'] = Variable<int>(platinum.value);
    }
    if (summarySnapshot.present) {
      map['summary_snapshot'] = Variable<String>(summarySnapshot.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CharacterCurrencyCompanion(')
          ..write('characterId: $characterId, ')
          ..write('copper: $copper, ')
          ..write('silver: $silver, ')
          ..write('electrum: $electrum, ')
          ..write('gold: $gold, ')
          ..write('platinum: $platinum, ')
          ..write('summarySnapshot: $summarySnapshot, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ClassDefinitionsTable extends ClassDefinitions
    with TableInfo<$ClassDefinitionsTable, ClassDefinition> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClassDefinitionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hitDieMeta = const VerificationMeta('hitDie');
  @override
  late final GeneratedColumn<int> hitDie = GeneratedColumn<int>(
    'hit_die',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isSpellcasterMeta = const VerificationMeta(
    'isSpellcaster',
  );
  @override
  late final GeneratedColumn<bool> isSpellcaster = GeneratedColumn<bool>(
    'is_spellcaster',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_spellcaster" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _spellcastingAbilityMeta =
      const VerificationMeta('spellcastingAbility');
  @override
  late final GeneratedColumn<String> spellcastingAbility =
      GeneratedColumn<String>(
        'spellcasting_ability',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    key,
    name,
    hitDie,
    isSpellcaster,
    spellcastingAbility,
    description,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'class_definitions';
  @override
  VerificationContext validateIntegrity(
    Insertable<ClassDefinition> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('hit_die')) {
      context.handle(
        _hitDieMeta,
        hitDie.isAcceptableOrUnknown(data['hit_die']!, _hitDieMeta),
      );
    }
    if (data.containsKey('is_spellcaster')) {
      context.handle(
        _isSpellcasterMeta,
        isSpellcaster.isAcceptableOrUnknown(
          data['is_spellcaster']!,
          _isSpellcasterMeta,
        ),
      );
    }
    if (data.containsKey('spellcasting_ability')) {
      context.handle(
        _spellcastingAbilityMeta,
        spellcastingAbility.isAcceptableOrUnknown(
          data['spellcasting_ability']!,
          _spellcastingAbilityMeta,
        ),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {key},
  ];
  @override
  ClassDefinition map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClassDefinition(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      hitDie: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hit_die'],
      ),
      isSpellcaster: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_spellcaster'],
      )!,
      spellcastingAbility: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}spellcasting_ability'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
    );
  }

  @override
  $ClassDefinitionsTable createAlias(String alias) {
    return $ClassDefinitionsTable(attachedDatabase, alias);
  }
}

class ClassDefinition extends DataClass implements Insertable<ClassDefinition> {
  final String id;
  final String key;
  final String name;
  final int? hitDie;
  final bool isSpellcaster;
  final String? spellcastingAbility;
  final String? description;
  const ClassDefinition({
    required this.id,
    required this.key,
    required this.name,
    this.hitDie,
    required this.isSpellcaster,
    this.spellcastingAbility,
    this.description,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['key'] = Variable<String>(key);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || hitDie != null) {
      map['hit_die'] = Variable<int>(hitDie);
    }
    map['is_spellcaster'] = Variable<bool>(isSpellcaster);
    if (!nullToAbsent || spellcastingAbility != null) {
      map['spellcasting_ability'] = Variable<String>(spellcastingAbility);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  ClassDefinitionsCompanion toCompanion(bool nullToAbsent) {
    return ClassDefinitionsCompanion(
      id: Value(id),
      key: Value(key),
      name: Value(name),
      hitDie: hitDie == null && nullToAbsent
          ? const Value.absent()
          : Value(hitDie),
      isSpellcaster: Value(isSpellcaster),
      spellcastingAbility: spellcastingAbility == null && nullToAbsent
          ? const Value.absent()
          : Value(spellcastingAbility),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory ClassDefinition.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClassDefinition(
      id: serializer.fromJson<String>(json['id']),
      key: serializer.fromJson<String>(json['key']),
      name: serializer.fromJson<String>(json['name']),
      hitDie: serializer.fromJson<int?>(json['hitDie']),
      isSpellcaster: serializer.fromJson<bool>(json['isSpellcaster']),
      spellcastingAbility: serializer.fromJson<String?>(
        json['spellcastingAbility'],
      ),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'key': serializer.toJson<String>(key),
      'name': serializer.toJson<String>(name),
      'hitDie': serializer.toJson<int?>(hitDie),
      'isSpellcaster': serializer.toJson<bool>(isSpellcaster),
      'spellcastingAbility': serializer.toJson<String?>(spellcastingAbility),
      'description': serializer.toJson<String?>(description),
    };
  }

  ClassDefinition copyWith({
    String? id,
    String? key,
    String? name,
    Value<int?> hitDie = const Value.absent(),
    bool? isSpellcaster,
    Value<String?> spellcastingAbility = const Value.absent(),
    Value<String?> description = const Value.absent(),
  }) => ClassDefinition(
    id: id ?? this.id,
    key: key ?? this.key,
    name: name ?? this.name,
    hitDie: hitDie.present ? hitDie.value : this.hitDie,
    isSpellcaster: isSpellcaster ?? this.isSpellcaster,
    spellcastingAbility: spellcastingAbility.present
        ? spellcastingAbility.value
        : this.spellcastingAbility,
    description: description.present ? description.value : this.description,
  );
  ClassDefinition copyWithCompanion(ClassDefinitionsCompanion data) {
    return ClassDefinition(
      id: data.id.present ? data.id.value : this.id,
      key: data.key.present ? data.key.value : this.key,
      name: data.name.present ? data.name.value : this.name,
      hitDie: data.hitDie.present ? data.hitDie.value : this.hitDie,
      isSpellcaster: data.isSpellcaster.present
          ? data.isSpellcaster.value
          : this.isSpellcaster,
      spellcastingAbility: data.spellcastingAbility.present
          ? data.spellcastingAbility.value
          : this.spellcastingAbility,
      description: data.description.present
          ? data.description.value
          : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClassDefinition(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('name: $name, ')
          ..write('hitDie: $hitDie, ')
          ..write('isSpellcaster: $isSpellcaster, ')
          ..write('spellcastingAbility: $spellcastingAbility, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    key,
    name,
    hitDie,
    isSpellcaster,
    spellcastingAbility,
    description,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClassDefinition &&
          other.id == this.id &&
          other.key == this.key &&
          other.name == this.name &&
          other.hitDie == this.hitDie &&
          other.isSpellcaster == this.isSpellcaster &&
          other.spellcastingAbility == this.spellcastingAbility &&
          other.description == this.description);
}

class ClassDefinitionsCompanion extends UpdateCompanion<ClassDefinition> {
  final Value<String> id;
  final Value<String> key;
  final Value<String> name;
  final Value<int?> hitDie;
  final Value<bool> isSpellcaster;
  final Value<String?> spellcastingAbility;
  final Value<String?> description;
  final Value<int> rowid;
  const ClassDefinitionsCompanion({
    this.id = const Value.absent(),
    this.key = const Value.absent(),
    this.name = const Value.absent(),
    this.hitDie = const Value.absent(),
    this.isSpellcaster = const Value.absent(),
    this.spellcastingAbility = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClassDefinitionsCompanion.insert({
    required String id,
    required String key,
    required String name,
    this.hitDie = const Value.absent(),
    this.isSpellcaster = const Value.absent(),
    this.spellcastingAbility = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       key = Value(key),
       name = Value(name);
  static Insertable<ClassDefinition> custom({
    Expression<String>? id,
    Expression<String>? key,
    Expression<String>? name,
    Expression<int>? hitDie,
    Expression<bool>? isSpellcaster,
    Expression<String>? spellcastingAbility,
    Expression<String>? description,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (key != null) 'key': key,
      if (name != null) 'name': name,
      if (hitDie != null) 'hit_die': hitDie,
      if (isSpellcaster != null) 'is_spellcaster': isSpellcaster,
      if (spellcastingAbility != null)
        'spellcasting_ability': spellcastingAbility,
      if (description != null) 'description': description,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClassDefinitionsCompanion copyWith({
    Value<String>? id,
    Value<String>? key,
    Value<String>? name,
    Value<int?>? hitDie,
    Value<bool>? isSpellcaster,
    Value<String?>? spellcastingAbility,
    Value<String?>? description,
    Value<int>? rowid,
  }) {
    return ClassDefinitionsCompanion(
      id: id ?? this.id,
      key: key ?? this.key,
      name: name ?? this.name,
      hitDie: hitDie ?? this.hitDie,
      isSpellcaster: isSpellcaster ?? this.isSpellcaster,
      spellcastingAbility: spellcastingAbility ?? this.spellcastingAbility,
      description: description ?? this.description,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (hitDie.present) {
      map['hit_die'] = Variable<int>(hitDie.value);
    }
    if (isSpellcaster.present) {
      map['is_spellcaster'] = Variable<bool>(isSpellcaster.value);
    }
    if (spellcastingAbility.present) {
      map['spellcasting_ability'] = Variable<String>(spellcastingAbility.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClassDefinitionsCompanion(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('name: $name, ')
          ..write('hitDie: $hitDie, ')
          ..write('isSpellcaster: $isSpellcaster, ')
          ..write('spellcastingAbility: $spellcastingAbility, ')
          ..write('description: $description, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CharacterAdvancementDefinitionsTable
    extends CharacterAdvancementDefinitions
    with
        TableInfo<
          $CharacterAdvancementDefinitionsTable,
          CharacterAdvancementDefinition
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CharacterAdvancementDefinitionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _experienceMeta = const VerificationMeta(
    'experience',
  );
  @override
  late final GeneratedColumn<int> experience = GeneratedColumn<int>(
    'experience',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proficiencyBonusMeta = const VerificationMeta(
    'proficiencyBonus',
  );
  @override
  late final GeneratedColumn<int> proficiencyBonus = GeneratedColumn<int>(
    'proficiency_bonus',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [level, experience, proficiencyBonus];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'character_advancement_definitions';
  @override
  VerificationContext validateIntegrity(
    Insertable<CharacterAdvancementDefinition> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    }
    if (data.containsKey('experience')) {
      context.handle(
        _experienceMeta,
        experience.isAcceptableOrUnknown(data['experience']!, _experienceMeta),
      );
    } else if (isInserting) {
      context.missing(_experienceMeta);
    }
    if (data.containsKey('proficiency_bonus')) {
      context.handle(
        _proficiencyBonusMeta,
        proficiencyBonus.isAcceptableOrUnknown(
          data['proficiency_bonus']!,
          _proficiencyBonusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_proficiencyBonusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {level};
  @override
  CharacterAdvancementDefinition map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CharacterAdvancementDefinition(
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}level'],
      )!,
      experience: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}experience'],
      )!,
      proficiencyBonus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}proficiency_bonus'],
      )!,
    );
  }

  @override
  $CharacterAdvancementDefinitionsTable createAlias(String alias) {
    return $CharacterAdvancementDefinitionsTable(attachedDatabase, alias);
  }
}

class CharacterAdvancementDefinition extends DataClass
    implements Insertable<CharacterAdvancementDefinition> {
  final int level;
  final int experience;
  final int proficiencyBonus;
  const CharacterAdvancementDefinition({
    required this.level,
    required this.experience,
    required this.proficiencyBonus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['level'] = Variable<int>(level);
    map['experience'] = Variable<int>(experience);
    map['proficiency_bonus'] = Variable<int>(proficiencyBonus);
    return map;
  }

  CharacterAdvancementDefinitionsCompanion toCompanion(bool nullToAbsent) {
    return CharacterAdvancementDefinitionsCompanion(
      level: Value(level),
      experience: Value(experience),
      proficiencyBonus: Value(proficiencyBonus),
    );
  }

  factory CharacterAdvancementDefinition.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CharacterAdvancementDefinition(
      level: serializer.fromJson<int>(json['level']),
      experience: serializer.fromJson<int>(json['experience']),
      proficiencyBonus: serializer.fromJson<int>(json['proficiencyBonus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'level': serializer.toJson<int>(level),
      'experience': serializer.toJson<int>(experience),
      'proficiencyBonus': serializer.toJson<int>(proficiencyBonus),
    };
  }

  CharacterAdvancementDefinition copyWith({
    int? level,
    int? experience,
    int? proficiencyBonus,
  }) => CharacterAdvancementDefinition(
    level: level ?? this.level,
    experience: experience ?? this.experience,
    proficiencyBonus: proficiencyBonus ?? this.proficiencyBonus,
  );
  CharacterAdvancementDefinition copyWithCompanion(
    CharacterAdvancementDefinitionsCompanion data,
  ) {
    return CharacterAdvancementDefinition(
      level: data.level.present ? data.level.value : this.level,
      experience: data.experience.present
          ? data.experience.value
          : this.experience,
      proficiencyBonus: data.proficiencyBonus.present
          ? data.proficiencyBonus.value
          : this.proficiencyBonus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CharacterAdvancementDefinition(')
          ..write('level: $level, ')
          ..write('experience: $experience, ')
          ..write('proficiencyBonus: $proficiencyBonus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(level, experience, proficiencyBonus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CharacterAdvancementDefinition &&
          other.level == this.level &&
          other.experience == this.experience &&
          other.proficiencyBonus == this.proficiencyBonus);
}

class CharacterAdvancementDefinitionsCompanion
    extends UpdateCompanion<CharacterAdvancementDefinition> {
  final Value<int> level;
  final Value<int> experience;
  final Value<int> proficiencyBonus;
  const CharacterAdvancementDefinitionsCompanion({
    this.level = const Value.absent(),
    this.experience = const Value.absent(),
    this.proficiencyBonus = const Value.absent(),
  });
  CharacterAdvancementDefinitionsCompanion.insert({
    this.level = const Value.absent(),
    required int experience,
    required int proficiencyBonus,
  }) : experience = Value(experience),
       proficiencyBonus = Value(proficiencyBonus);
  static Insertable<CharacterAdvancementDefinition> custom({
    Expression<int>? level,
    Expression<int>? experience,
    Expression<int>? proficiencyBonus,
  }) {
    return RawValuesInsertable({
      if (level != null) 'level': level,
      if (experience != null) 'experience': experience,
      if (proficiencyBonus != null) 'proficiency_bonus': proficiencyBonus,
    });
  }

  CharacterAdvancementDefinitionsCompanion copyWith({
    Value<int>? level,
    Value<int>? experience,
    Value<int>? proficiencyBonus,
  }) {
    return CharacterAdvancementDefinitionsCompanion(
      level: level ?? this.level,
      experience: experience ?? this.experience,
      proficiencyBonus: proficiencyBonus ?? this.proficiencyBonus,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (experience.present) {
      map['experience'] = Variable<int>(experience.value);
    }
    if (proficiencyBonus.present) {
      map['proficiency_bonus'] = Variable<int>(proficiencyBonus.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CharacterAdvancementDefinitionsCompanion(')
          ..write('level: $level, ')
          ..write('experience: $experience, ')
          ..write('proficiencyBonus: $proficiencyBonus')
          ..write(')'))
        .toString();
  }
}

class $ClassStandardArrayRecommendationsTable
    extends ClassStandardArrayRecommendations
    with
        TableInfo<
          $ClassStandardArrayRecommendationsTable,
          ClassStandardArrayRecommendation
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClassStandardArrayRecommendationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _classIdMeta = const VerificationMeta(
    'classId',
  );
  @override
  late final GeneratedColumn<String> classId = GeneratedColumn<String>(
    'class_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _classNameMeta = const VerificationMeta(
    'className',
  );
  @override
  late final GeneratedColumn<String> className = GeneratedColumn<String>(
    'class_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _strengthMeta = const VerificationMeta(
    'strength',
  );
  @override
  late final GeneratedColumn<int> strength = GeneratedColumn<int>(
    'strength',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dexterityMeta = const VerificationMeta(
    'dexterity',
  );
  @override
  late final GeneratedColumn<int> dexterity = GeneratedColumn<int>(
    'dexterity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _constitutionMeta = const VerificationMeta(
    'constitution',
  );
  @override
  late final GeneratedColumn<int> constitution = GeneratedColumn<int>(
    'constitution',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _intelligenceMeta = const VerificationMeta(
    'intelligence',
  );
  @override
  late final GeneratedColumn<int> intelligence = GeneratedColumn<int>(
    'intelligence',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wisdomMeta = const VerificationMeta('wisdom');
  @override
  late final GeneratedColumn<int> wisdom = GeneratedColumn<int>(
    'wisdom',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _charismaMeta = const VerificationMeta(
    'charisma',
  );
  @override
  late final GeneratedColumn<int> charisma = GeneratedColumn<int>(
    'charisma',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    classId,
    className,
    strength,
    dexterity,
    constitution,
    intelligence,
    wisdom,
    charisma,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'class_standard_array_recommendations';
  @override
  VerificationContext validateIntegrity(
    Insertable<ClassStandardArrayRecommendation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('class_id')) {
      context.handle(
        _classIdMeta,
        classId.isAcceptableOrUnknown(data['class_id']!, _classIdMeta),
      );
    } else if (isInserting) {
      context.missing(_classIdMeta);
    }
    if (data.containsKey('class_name')) {
      context.handle(
        _classNameMeta,
        className.isAcceptableOrUnknown(data['class_name']!, _classNameMeta),
      );
    } else if (isInserting) {
      context.missing(_classNameMeta);
    }
    if (data.containsKey('strength')) {
      context.handle(
        _strengthMeta,
        strength.isAcceptableOrUnknown(data['strength']!, _strengthMeta),
      );
    } else if (isInserting) {
      context.missing(_strengthMeta);
    }
    if (data.containsKey('dexterity')) {
      context.handle(
        _dexterityMeta,
        dexterity.isAcceptableOrUnknown(data['dexterity']!, _dexterityMeta),
      );
    } else if (isInserting) {
      context.missing(_dexterityMeta);
    }
    if (data.containsKey('constitution')) {
      context.handle(
        _constitutionMeta,
        constitution.isAcceptableOrUnknown(
          data['constitution']!,
          _constitutionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_constitutionMeta);
    }
    if (data.containsKey('intelligence')) {
      context.handle(
        _intelligenceMeta,
        intelligence.isAcceptableOrUnknown(
          data['intelligence']!,
          _intelligenceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_intelligenceMeta);
    }
    if (data.containsKey('wisdom')) {
      context.handle(
        _wisdomMeta,
        wisdom.isAcceptableOrUnknown(data['wisdom']!, _wisdomMeta),
      );
    } else if (isInserting) {
      context.missing(_wisdomMeta);
    }
    if (data.containsKey('charisma')) {
      context.handle(
        _charismaMeta,
        charisma.isAcceptableOrUnknown(data['charisma']!, _charismaMeta),
      );
    } else if (isInserting) {
      context.missing(_charismaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {classId};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {className},
  ];
  @override
  ClassStandardArrayRecommendation map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClassStandardArrayRecommendation(
      classId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}class_id'],
      )!,
      className: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}class_name'],
      )!,
      strength: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}strength'],
      )!,
      dexterity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dexterity'],
      )!,
      constitution: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}constitution'],
      )!,
      intelligence: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}intelligence'],
      )!,
      wisdom: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wisdom'],
      )!,
      charisma: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}charisma'],
      )!,
    );
  }

  @override
  $ClassStandardArrayRecommendationsTable createAlias(String alias) {
    return $ClassStandardArrayRecommendationsTable(attachedDatabase, alias);
  }
}

class ClassStandardArrayRecommendation extends DataClass
    implements Insertable<ClassStandardArrayRecommendation> {
  final String classId;
  final String className;
  final int strength;
  final int dexterity;
  final int constitution;
  final int intelligence;
  final int wisdom;
  final int charisma;
  const ClassStandardArrayRecommendation({
    required this.classId,
    required this.className,
    required this.strength,
    required this.dexterity,
    required this.constitution,
    required this.intelligence,
    required this.wisdom,
    required this.charisma,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['class_id'] = Variable<String>(classId);
    map['class_name'] = Variable<String>(className);
    map['strength'] = Variable<int>(strength);
    map['dexterity'] = Variable<int>(dexterity);
    map['constitution'] = Variable<int>(constitution);
    map['intelligence'] = Variable<int>(intelligence);
    map['wisdom'] = Variable<int>(wisdom);
    map['charisma'] = Variable<int>(charisma);
    return map;
  }

  ClassStandardArrayRecommendationsCompanion toCompanion(bool nullToAbsent) {
    return ClassStandardArrayRecommendationsCompanion(
      classId: Value(classId),
      className: Value(className),
      strength: Value(strength),
      dexterity: Value(dexterity),
      constitution: Value(constitution),
      intelligence: Value(intelligence),
      wisdom: Value(wisdom),
      charisma: Value(charisma),
    );
  }

  factory ClassStandardArrayRecommendation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClassStandardArrayRecommendation(
      classId: serializer.fromJson<String>(json['classId']),
      className: serializer.fromJson<String>(json['className']),
      strength: serializer.fromJson<int>(json['strength']),
      dexterity: serializer.fromJson<int>(json['dexterity']),
      constitution: serializer.fromJson<int>(json['constitution']),
      intelligence: serializer.fromJson<int>(json['intelligence']),
      wisdom: serializer.fromJson<int>(json['wisdom']),
      charisma: serializer.fromJson<int>(json['charisma']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'classId': serializer.toJson<String>(classId),
      'className': serializer.toJson<String>(className),
      'strength': serializer.toJson<int>(strength),
      'dexterity': serializer.toJson<int>(dexterity),
      'constitution': serializer.toJson<int>(constitution),
      'intelligence': serializer.toJson<int>(intelligence),
      'wisdom': serializer.toJson<int>(wisdom),
      'charisma': serializer.toJson<int>(charisma),
    };
  }

  ClassStandardArrayRecommendation copyWith({
    String? classId,
    String? className,
    int? strength,
    int? dexterity,
    int? constitution,
    int? intelligence,
    int? wisdom,
    int? charisma,
  }) => ClassStandardArrayRecommendation(
    classId: classId ?? this.classId,
    className: className ?? this.className,
    strength: strength ?? this.strength,
    dexterity: dexterity ?? this.dexterity,
    constitution: constitution ?? this.constitution,
    intelligence: intelligence ?? this.intelligence,
    wisdom: wisdom ?? this.wisdom,
    charisma: charisma ?? this.charisma,
  );
  ClassStandardArrayRecommendation copyWithCompanion(
    ClassStandardArrayRecommendationsCompanion data,
  ) {
    return ClassStandardArrayRecommendation(
      classId: data.classId.present ? data.classId.value : this.classId,
      className: data.className.present ? data.className.value : this.className,
      strength: data.strength.present ? data.strength.value : this.strength,
      dexterity: data.dexterity.present ? data.dexterity.value : this.dexterity,
      constitution: data.constitution.present
          ? data.constitution.value
          : this.constitution,
      intelligence: data.intelligence.present
          ? data.intelligence.value
          : this.intelligence,
      wisdom: data.wisdom.present ? data.wisdom.value : this.wisdom,
      charisma: data.charisma.present ? data.charisma.value : this.charisma,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClassStandardArrayRecommendation(')
          ..write('classId: $classId, ')
          ..write('className: $className, ')
          ..write('strength: $strength, ')
          ..write('dexterity: $dexterity, ')
          ..write('constitution: $constitution, ')
          ..write('intelligence: $intelligence, ')
          ..write('wisdom: $wisdom, ')
          ..write('charisma: $charisma')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    classId,
    className,
    strength,
    dexterity,
    constitution,
    intelligence,
    wisdom,
    charisma,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClassStandardArrayRecommendation &&
          other.classId == this.classId &&
          other.className == this.className &&
          other.strength == this.strength &&
          other.dexterity == this.dexterity &&
          other.constitution == this.constitution &&
          other.intelligence == this.intelligence &&
          other.wisdom == this.wisdom &&
          other.charisma == this.charisma);
}

class ClassStandardArrayRecommendationsCompanion
    extends UpdateCompanion<ClassStandardArrayRecommendation> {
  final Value<String> classId;
  final Value<String> className;
  final Value<int> strength;
  final Value<int> dexterity;
  final Value<int> constitution;
  final Value<int> intelligence;
  final Value<int> wisdom;
  final Value<int> charisma;
  final Value<int> rowid;
  const ClassStandardArrayRecommendationsCompanion({
    this.classId = const Value.absent(),
    this.className = const Value.absent(),
    this.strength = const Value.absent(),
    this.dexterity = const Value.absent(),
    this.constitution = const Value.absent(),
    this.intelligence = const Value.absent(),
    this.wisdom = const Value.absent(),
    this.charisma = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClassStandardArrayRecommendationsCompanion.insert({
    required String classId,
    required String className,
    required int strength,
    required int dexterity,
    required int constitution,
    required int intelligence,
    required int wisdom,
    required int charisma,
    this.rowid = const Value.absent(),
  }) : classId = Value(classId),
       className = Value(className),
       strength = Value(strength),
       dexterity = Value(dexterity),
       constitution = Value(constitution),
       intelligence = Value(intelligence),
       wisdom = Value(wisdom),
       charisma = Value(charisma);
  static Insertable<ClassStandardArrayRecommendation> custom({
    Expression<String>? classId,
    Expression<String>? className,
    Expression<int>? strength,
    Expression<int>? dexterity,
    Expression<int>? constitution,
    Expression<int>? intelligence,
    Expression<int>? wisdom,
    Expression<int>? charisma,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (classId != null) 'class_id': classId,
      if (className != null) 'class_name': className,
      if (strength != null) 'strength': strength,
      if (dexterity != null) 'dexterity': dexterity,
      if (constitution != null) 'constitution': constitution,
      if (intelligence != null) 'intelligence': intelligence,
      if (wisdom != null) 'wisdom': wisdom,
      if (charisma != null) 'charisma': charisma,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClassStandardArrayRecommendationsCompanion copyWith({
    Value<String>? classId,
    Value<String>? className,
    Value<int>? strength,
    Value<int>? dexterity,
    Value<int>? constitution,
    Value<int>? intelligence,
    Value<int>? wisdom,
    Value<int>? charisma,
    Value<int>? rowid,
  }) {
    return ClassStandardArrayRecommendationsCompanion(
      classId: classId ?? this.classId,
      className: className ?? this.className,
      strength: strength ?? this.strength,
      dexterity: dexterity ?? this.dexterity,
      constitution: constitution ?? this.constitution,
      intelligence: intelligence ?? this.intelligence,
      wisdom: wisdom ?? this.wisdom,
      charisma: charisma ?? this.charisma,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (classId.present) {
      map['class_id'] = Variable<String>(classId.value);
    }
    if (className.present) {
      map['class_name'] = Variable<String>(className.value);
    }
    if (strength.present) {
      map['strength'] = Variable<int>(strength.value);
    }
    if (dexterity.present) {
      map['dexterity'] = Variable<int>(dexterity.value);
    }
    if (constitution.present) {
      map['constitution'] = Variable<int>(constitution.value);
    }
    if (intelligence.present) {
      map['intelligence'] = Variable<int>(intelligence.value);
    }
    if (wisdom.present) {
      map['wisdom'] = Variable<int>(wisdom.value);
    }
    if (charisma.present) {
      map['charisma'] = Variable<int>(charisma.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClassStandardArrayRecommendationsCompanion(')
          ..write('classId: $classId, ')
          ..write('className: $className, ')
          ..write('strength: $strength, ')
          ..write('dexterity: $dexterity, ')
          ..write('constitution: $constitution, ')
          ..write('intelligence: $intelligence, ')
          ..write('wisdom: $wisdom, ')
          ..write('charisma: $charisma, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NarrativeOptionGroupsTable extends NarrativeOptionGroups
    with TableInfo<$NarrativeOptionGroupsTable, NarrativeOptionGroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NarrativeOptionGroupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fieldKeyMeta = const VerificationMeta(
    'fieldKey',
  );
  @override
  late final GeneratedColumn<String> fieldKey = GeneratedColumn<String>(
    'field_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceTypeMeta = const VerificationMeta(
    'sourceType',
  );
  @override
  late final GeneratedColumn<String> sourceType = GeneratedColumn<String>(
    'source_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _packIdMeta = const VerificationMeta('packId');
  @override
  late final GeneratedColumn<String> packId = GeneratedColumn<String>(
    'pack_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceIdMeta = const VerificationMeta(
    'sourceId',
  );
  @override
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
    'source_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sourceNameMeta = const VerificationMeta(
    'sourceName',
  );
  @override
  late final GeneratedColumn<String> sourceName = GeneratedColumn<String>(
    'source_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _backgroundIdMeta = const VerificationMeta(
    'backgroundId',
  );
  @override
  late final GeneratedColumn<String> backgroundId = GeneratedColumn<String>(
    'background_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _backgroundNameMeta = const VerificationMeta(
    'backgroundName',
  );
  @override
  late final GeneratedColumn<String> backgroundName = GeneratedColumn<String>(
    'background_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _diceFormulaMeta = const VerificationMeta(
    'diceFormula',
  );
  @override
  late final GeneratedColumn<String> diceFormula = GeneratedColumn<String>(
    'dice_formula',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _optionCountMeta = const VerificationMeta(
    'optionCount',
  );
  @override
  late final GeneratedColumn<int> optionCount = GeneratedColumn<int>(
    'option_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _sourceBookMeta = const VerificationMeta(
    'sourceBook',
  );
  @override
  late final GeneratedColumn<String> sourceBook = GeneratedColumn<String>(
    'source_book',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fieldKey,
    sourceType,
    packId,
    sourceId,
    sourceName,
    backgroundId,
    backgroundName,
    title,
    diceFormula,
    optionCount,
    sourceBook,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'narrative_option_groups';
  @override
  VerificationContext validateIntegrity(
    Insertable<NarrativeOptionGroup> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('field_key')) {
      context.handle(
        _fieldKeyMeta,
        fieldKey.isAcceptableOrUnknown(data['field_key']!, _fieldKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_fieldKeyMeta);
    }
    if (data.containsKey('source_type')) {
      context.handle(
        _sourceTypeMeta,
        sourceType.isAcceptableOrUnknown(data['source_type']!, _sourceTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceTypeMeta);
    }
    if (data.containsKey('pack_id')) {
      context.handle(
        _packIdMeta,
        packId.isAcceptableOrUnknown(data['pack_id']!, _packIdMeta),
      );
    }
    if (data.containsKey('source_id')) {
      context.handle(
        _sourceIdMeta,
        sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta),
      );
    }
    if (data.containsKey('source_name')) {
      context.handle(
        _sourceNameMeta,
        sourceName.isAcceptableOrUnknown(data['source_name']!, _sourceNameMeta),
      );
    }
    if (data.containsKey('background_id')) {
      context.handle(
        _backgroundIdMeta,
        backgroundId.isAcceptableOrUnknown(
          data['background_id']!,
          _backgroundIdMeta,
        ),
      );
    }
    if (data.containsKey('background_name')) {
      context.handle(
        _backgroundNameMeta,
        backgroundName.isAcceptableOrUnknown(
          data['background_name']!,
          _backgroundNameMeta,
        ),
      );
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('dice_formula')) {
      context.handle(
        _diceFormulaMeta,
        diceFormula.isAcceptableOrUnknown(
          data['dice_formula']!,
          _diceFormulaMeta,
        ),
      );
    }
    if (data.containsKey('option_count')) {
      context.handle(
        _optionCountMeta,
        optionCount.isAcceptableOrUnknown(
          data['option_count']!,
          _optionCountMeta,
        ),
      );
    }
    if (data.containsKey('source_book')) {
      context.handle(
        _sourceBookMeta,
        sourceBook.isAcceptableOrUnknown(data['source_book']!, _sourceBookMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NarrativeOptionGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NarrativeOptionGroup(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      fieldKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}field_key'],
      )!,
      sourceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_type'],
      )!,
      packId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pack_id'],
      ),
      sourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_id'],
      ),
      sourceName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_name'],
      ),
      backgroundId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}background_id'],
      ),
      backgroundName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}background_name'],
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      diceFormula: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dice_formula'],
      ),
      optionCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}option_count'],
      )!,
      sourceBook: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_book'],
      ),
    );
  }

  @override
  $NarrativeOptionGroupsTable createAlias(String alias) {
    return $NarrativeOptionGroupsTable(attachedDatabase, alias);
  }
}

class NarrativeOptionGroup extends DataClass
    implements Insertable<NarrativeOptionGroup> {
  final String id;
  final String fieldKey;
  final String sourceType;
  final String? packId;
  final String? sourceId;
  final String? sourceName;
  final String? backgroundId;
  final String? backgroundName;
  final String title;
  final String? diceFormula;
  final int optionCount;
  final String? sourceBook;
  const NarrativeOptionGroup({
    required this.id,
    required this.fieldKey,
    required this.sourceType,
    this.packId,
    this.sourceId,
    this.sourceName,
    this.backgroundId,
    this.backgroundName,
    required this.title,
    this.diceFormula,
    required this.optionCount,
    this.sourceBook,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['field_key'] = Variable<String>(fieldKey);
    map['source_type'] = Variable<String>(sourceType);
    if (!nullToAbsent || packId != null) {
      map['pack_id'] = Variable<String>(packId);
    }
    if (!nullToAbsent || sourceId != null) {
      map['source_id'] = Variable<String>(sourceId);
    }
    if (!nullToAbsent || sourceName != null) {
      map['source_name'] = Variable<String>(sourceName);
    }
    if (!nullToAbsent || backgroundId != null) {
      map['background_id'] = Variable<String>(backgroundId);
    }
    if (!nullToAbsent || backgroundName != null) {
      map['background_name'] = Variable<String>(backgroundName);
    }
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || diceFormula != null) {
      map['dice_formula'] = Variable<String>(diceFormula);
    }
    map['option_count'] = Variable<int>(optionCount);
    if (!nullToAbsent || sourceBook != null) {
      map['source_book'] = Variable<String>(sourceBook);
    }
    return map;
  }

  NarrativeOptionGroupsCompanion toCompanion(bool nullToAbsent) {
    return NarrativeOptionGroupsCompanion(
      id: Value(id),
      fieldKey: Value(fieldKey),
      sourceType: Value(sourceType),
      packId: packId == null && nullToAbsent
          ? const Value.absent()
          : Value(packId),
      sourceId: sourceId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceId),
      sourceName: sourceName == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceName),
      backgroundId: backgroundId == null && nullToAbsent
          ? const Value.absent()
          : Value(backgroundId),
      backgroundName: backgroundName == null && nullToAbsent
          ? const Value.absent()
          : Value(backgroundName),
      title: Value(title),
      diceFormula: diceFormula == null && nullToAbsent
          ? const Value.absent()
          : Value(diceFormula),
      optionCount: Value(optionCount),
      sourceBook: sourceBook == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceBook),
    );
  }

  factory NarrativeOptionGroup.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NarrativeOptionGroup(
      id: serializer.fromJson<String>(json['id']),
      fieldKey: serializer.fromJson<String>(json['fieldKey']),
      sourceType: serializer.fromJson<String>(json['sourceType']),
      packId: serializer.fromJson<String?>(json['packId']),
      sourceId: serializer.fromJson<String?>(json['sourceId']),
      sourceName: serializer.fromJson<String?>(json['sourceName']),
      backgroundId: serializer.fromJson<String?>(json['backgroundId']),
      backgroundName: serializer.fromJson<String?>(json['backgroundName']),
      title: serializer.fromJson<String>(json['title']),
      diceFormula: serializer.fromJson<String?>(json['diceFormula']),
      optionCount: serializer.fromJson<int>(json['optionCount']),
      sourceBook: serializer.fromJson<String?>(json['sourceBook']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fieldKey': serializer.toJson<String>(fieldKey),
      'sourceType': serializer.toJson<String>(sourceType),
      'packId': serializer.toJson<String?>(packId),
      'sourceId': serializer.toJson<String?>(sourceId),
      'sourceName': serializer.toJson<String?>(sourceName),
      'backgroundId': serializer.toJson<String?>(backgroundId),
      'backgroundName': serializer.toJson<String?>(backgroundName),
      'title': serializer.toJson<String>(title),
      'diceFormula': serializer.toJson<String?>(diceFormula),
      'optionCount': serializer.toJson<int>(optionCount),
      'sourceBook': serializer.toJson<String?>(sourceBook),
    };
  }

  NarrativeOptionGroup copyWith({
    String? id,
    String? fieldKey,
    String? sourceType,
    Value<String?> packId = const Value.absent(),
    Value<String?> sourceId = const Value.absent(),
    Value<String?> sourceName = const Value.absent(),
    Value<String?> backgroundId = const Value.absent(),
    Value<String?> backgroundName = const Value.absent(),
    String? title,
    Value<String?> diceFormula = const Value.absent(),
    int? optionCount,
    Value<String?> sourceBook = const Value.absent(),
  }) => NarrativeOptionGroup(
    id: id ?? this.id,
    fieldKey: fieldKey ?? this.fieldKey,
    sourceType: sourceType ?? this.sourceType,
    packId: packId.present ? packId.value : this.packId,
    sourceId: sourceId.present ? sourceId.value : this.sourceId,
    sourceName: sourceName.present ? sourceName.value : this.sourceName,
    backgroundId: backgroundId.present ? backgroundId.value : this.backgroundId,
    backgroundName: backgroundName.present
        ? backgroundName.value
        : this.backgroundName,
    title: title ?? this.title,
    diceFormula: diceFormula.present ? diceFormula.value : this.diceFormula,
    optionCount: optionCount ?? this.optionCount,
    sourceBook: sourceBook.present ? sourceBook.value : this.sourceBook,
  );
  NarrativeOptionGroup copyWithCompanion(NarrativeOptionGroupsCompanion data) {
    return NarrativeOptionGroup(
      id: data.id.present ? data.id.value : this.id,
      fieldKey: data.fieldKey.present ? data.fieldKey.value : this.fieldKey,
      sourceType: data.sourceType.present
          ? data.sourceType.value
          : this.sourceType,
      packId: data.packId.present ? data.packId.value : this.packId,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      sourceName: data.sourceName.present
          ? data.sourceName.value
          : this.sourceName,
      backgroundId: data.backgroundId.present
          ? data.backgroundId.value
          : this.backgroundId,
      backgroundName: data.backgroundName.present
          ? data.backgroundName.value
          : this.backgroundName,
      title: data.title.present ? data.title.value : this.title,
      diceFormula: data.diceFormula.present
          ? data.diceFormula.value
          : this.diceFormula,
      optionCount: data.optionCount.present
          ? data.optionCount.value
          : this.optionCount,
      sourceBook: data.sourceBook.present
          ? data.sourceBook.value
          : this.sourceBook,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NarrativeOptionGroup(')
          ..write('id: $id, ')
          ..write('fieldKey: $fieldKey, ')
          ..write('sourceType: $sourceType, ')
          ..write('packId: $packId, ')
          ..write('sourceId: $sourceId, ')
          ..write('sourceName: $sourceName, ')
          ..write('backgroundId: $backgroundId, ')
          ..write('backgroundName: $backgroundName, ')
          ..write('title: $title, ')
          ..write('diceFormula: $diceFormula, ')
          ..write('optionCount: $optionCount, ')
          ..write('sourceBook: $sourceBook')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fieldKey,
    sourceType,
    packId,
    sourceId,
    sourceName,
    backgroundId,
    backgroundName,
    title,
    diceFormula,
    optionCount,
    sourceBook,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NarrativeOptionGroup &&
          other.id == this.id &&
          other.fieldKey == this.fieldKey &&
          other.sourceType == this.sourceType &&
          other.packId == this.packId &&
          other.sourceId == this.sourceId &&
          other.sourceName == this.sourceName &&
          other.backgroundId == this.backgroundId &&
          other.backgroundName == this.backgroundName &&
          other.title == this.title &&
          other.diceFormula == this.diceFormula &&
          other.optionCount == this.optionCount &&
          other.sourceBook == this.sourceBook);
}

class NarrativeOptionGroupsCompanion
    extends UpdateCompanion<NarrativeOptionGroup> {
  final Value<String> id;
  final Value<String> fieldKey;
  final Value<String> sourceType;
  final Value<String?> packId;
  final Value<String?> sourceId;
  final Value<String?> sourceName;
  final Value<String?> backgroundId;
  final Value<String?> backgroundName;
  final Value<String> title;
  final Value<String?> diceFormula;
  final Value<int> optionCount;
  final Value<String?> sourceBook;
  final Value<int> rowid;
  const NarrativeOptionGroupsCompanion({
    this.id = const Value.absent(),
    this.fieldKey = const Value.absent(),
    this.sourceType = const Value.absent(),
    this.packId = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.sourceName = const Value.absent(),
    this.backgroundId = const Value.absent(),
    this.backgroundName = const Value.absent(),
    this.title = const Value.absent(),
    this.diceFormula = const Value.absent(),
    this.optionCount = const Value.absent(),
    this.sourceBook = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NarrativeOptionGroupsCompanion.insert({
    required String id,
    required String fieldKey,
    required String sourceType,
    this.packId = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.sourceName = const Value.absent(),
    this.backgroundId = const Value.absent(),
    this.backgroundName = const Value.absent(),
    required String title,
    this.diceFormula = const Value.absent(),
    this.optionCount = const Value.absent(),
    this.sourceBook = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       fieldKey = Value(fieldKey),
       sourceType = Value(sourceType),
       title = Value(title);
  static Insertable<NarrativeOptionGroup> custom({
    Expression<String>? id,
    Expression<String>? fieldKey,
    Expression<String>? sourceType,
    Expression<String>? packId,
    Expression<String>? sourceId,
    Expression<String>? sourceName,
    Expression<String>? backgroundId,
    Expression<String>? backgroundName,
    Expression<String>? title,
    Expression<String>? diceFormula,
    Expression<int>? optionCount,
    Expression<String>? sourceBook,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fieldKey != null) 'field_key': fieldKey,
      if (sourceType != null) 'source_type': sourceType,
      if (packId != null) 'pack_id': packId,
      if (sourceId != null) 'source_id': sourceId,
      if (sourceName != null) 'source_name': sourceName,
      if (backgroundId != null) 'background_id': backgroundId,
      if (backgroundName != null) 'background_name': backgroundName,
      if (title != null) 'title': title,
      if (diceFormula != null) 'dice_formula': diceFormula,
      if (optionCount != null) 'option_count': optionCount,
      if (sourceBook != null) 'source_book': sourceBook,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NarrativeOptionGroupsCompanion copyWith({
    Value<String>? id,
    Value<String>? fieldKey,
    Value<String>? sourceType,
    Value<String?>? packId,
    Value<String?>? sourceId,
    Value<String?>? sourceName,
    Value<String?>? backgroundId,
    Value<String?>? backgroundName,
    Value<String>? title,
    Value<String?>? diceFormula,
    Value<int>? optionCount,
    Value<String?>? sourceBook,
    Value<int>? rowid,
  }) {
    return NarrativeOptionGroupsCompanion(
      id: id ?? this.id,
      fieldKey: fieldKey ?? this.fieldKey,
      sourceType: sourceType ?? this.sourceType,
      packId: packId ?? this.packId,
      sourceId: sourceId ?? this.sourceId,
      sourceName: sourceName ?? this.sourceName,
      backgroundId: backgroundId ?? this.backgroundId,
      backgroundName: backgroundName ?? this.backgroundName,
      title: title ?? this.title,
      diceFormula: diceFormula ?? this.diceFormula,
      optionCount: optionCount ?? this.optionCount,
      sourceBook: sourceBook ?? this.sourceBook,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fieldKey.present) {
      map['field_key'] = Variable<String>(fieldKey.value);
    }
    if (sourceType.present) {
      map['source_type'] = Variable<String>(sourceType.value);
    }
    if (packId.present) {
      map['pack_id'] = Variable<String>(packId.value);
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (sourceName.present) {
      map['source_name'] = Variable<String>(sourceName.value);
    }
    if (backgroundId.present) {
      map['background_id'] = Variable<String>(backgroundId.value);
    }
    if (backgroundName.present) {
      map['background_name'] = Variable<String>(backgroundName.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (diceFormula.present) {
      map['dice_formula'] = Variable<String>(diceFormula.value);
    }
    if (optionCount.present) {
      map['option_count'] = Variable<int>(optionCount.value);
    }
    if (sourceBook.present) {
      map['source_book'] = Variable<String>(sourceBook.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NarrativeOptionGroupsCompanion(')
          ..write('id: $id, ')
          ..write('fieldKey: $fieldKey, ')
          ..write('sourceType: $sourceType, ')
          ..write('packId: $packId, ')
          ..write('sourceId: $sourceId, ')
          ..write('sourceName: $sourceName, ')
          ..write('backgroundId: $backgroundId, ')
          ..write('backgroundName: $backgroundName, ')
          ..write('title: $title, ')
          ..write('diceFormula: $diceFormula, ')
          ..write('optionCount: $optionCount, ')
          ..write('sourceBook: $sourceBook, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NarrativeOptionsTable extends NarrativeOptions
    with TableInfo<$NarrativeOptionsTable, NarrativeOption> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NarrativeOptionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _groupIdMeta = const VerificationMeta(
    'groupId',
  );
  @override
  late final GeneratedColumn<String> groupId = GeneratedColumn<String>(
    'group_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES narrative_option_groups (id)',
    ),
  );
  static const VerificationMeta _optionIndexMeta = const VerificationMeta(
    'optionIndex',
  );
  @override
  late final GeneratedColumn<int> optionIndex = GeneratedColumn<int>(
    'option_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rollMinMeta = const VerificationMeta(
    'rollMin',
  );
  @override
  late final GeneratedColumn<int> rollMin = GeneratedColumn<int>(
    'roll_min',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rollMaxMeta = const VerificationMeta(
    'rollMax',
  );
  @override
  late final GeneratedColumn<int> rollMax = GeneratedColumn<int>(
    'roll_max',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    groupId,
    optionIndex,
    rollMin,
    rollMax,
    label,
    content,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'narrative_options';
  @override
  VerificationContext validateIntegrity(
    Insertable<NarrativeOption> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('group_id')) {
      context.handle(
        _groupIdMeta,
        groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta),
      );
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    if (data.containsKey('option_index')) {
      context.handle(
        _optionIndexMeta,
        optionIndex.isAcceptableOrUnknown(
          data['option_index']!,
          _optionIndexMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_optionIndexMeta);
    }
    if (data.containsKey('roll_min')) {
      context.handle(
        _rollMinMeta,
        rollMin.isAcceptableOrUnknown(data['roll_min']!, _rollMinMeta),
      );
    }
    if (data.containsKey('roll_max')) {
      context.handle(
        _rollMaxMeta,
        rollMax.isAcceptableOrUnknown(data['roll_max']!, _rollMaxMeta),
      );
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {groupId, optionIndex},
  ];
  @override
  NarrativeOption map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NarrativeOption(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      groupId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_id'],
      )!,
      optionIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}option_index'],
      )!,
      rollMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}roll_min'],
      ),
      rollMax: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}roll_max'],
      ),
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      ),
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
    );
  }

  @override
  $NarrativeOptionsTable createAlias(String alias) {
    return $NarrativeOptionsTable(attachedDatabase, alias);
  }
}

class NarrativeOption extends DataClass implements Insertable<NarrativeOption> {
  final String id;
  final String groupId;
  final int optionIndex;
  final int? rollMin;
  final int? rollMax;
  final String? label;
  final String content;
  const NarrativeOption({
    required this.id,
    required this.groupId,
    required this.optionIndex,
    this.rollMin,
    this.rollMax,
    this.label,
    required this.content,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['group_id'] = Variable<String>(groupId);
    map['option_index'] = Variable<int>(optionIndex);
    if (!nullToAbsent || rollMin != null) {
      map['roll_min'] = Variable<int>(rollMin);
    }
    if (!nullToAbsent || rollMax != null) {
      map['roll_max'] = Variable<int>(rollMax);
    }
    if (!nullToAbsent || label != null) {
      map['label'] = Variable<String>(label);
    }
    map['content'] = Variable<String>(content);
    return map;
  }

  NarrativeOptionsCompanion toCompanion(bool nullToAbsent) {
    return NarrativeOptionsCompanion(
      id: Value(id),
      groupId: Value(groupId),
      optionIndex: Value(optionIndex),
      rollMin: rollMin == null && nullToAbsent
          ? const Value.absent()
          : Value(rollMin),
      rollMax: rollMax == null && nullToAbsent
          ? const Value.absent()
          : Value(rollMax),
      label: label == null && nullToAbsent
          ? const Value.absent()
          : Value(label),
      content: Value(content),
    );
  }

  factory NarrativeOption.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NarrativeOption(
      id: serializer.fromJson<String>(json['id']),
      groupId: serializer.fromJson<String>(json['groupId']),
      optionIndex: serializer.fromJson<int>(json['optionIndex']),
      rollMin: serializer.fromJson<int?>(json['rollMin']),
      rollMax: serializer.fromJson<int?>(json['rollMax']),
      label: serializer.fromJson<String?>(json['label']),
      content: serializer.fromJson<String>(json['content']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'groupId': serializer.toJson<String>(groupId),
      'optionIndex': serializer.toJson<int>(optionIndex),
      'rollMin': serializer.toJson<int?>(rollMin),
      'rollMax': serializer.toJson<int?>(rollMax),
      'label': serializer.toJson<String?>(label),
      'content': serializer.toJson<String>(content),
    };
  }

  NarrativeOption copyWith({
    String? id,
    String? groupId,
    int? optionIndex,
    Value<int?> rollMin = const Value.absent(),
    Value<int?> rollMax = const Value.absent(),
    Value<String?> label = const Value.absent(),
    String? content,
  }) => NarrativeOption(
    id: id ?? this.id,
    groupId: groupId ?? this.groupId,
    optionIndex: optionIndex ?? this.optionIndex,
    rollMin: rollMin.present ? rollMin.value : this.rollMin,
    rollMax: rollMax.present ? rollMax.value : this.rollMax,
    label: label.present ? label.value : this.label,
    content: content ?? this.content,
  );
  NarrativeOption copyWithCompanion(NarrativeOptionsCompanion data) {
    return NarrativeOption(
      id: data.id.present ? data.id.value : this.id,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
      optionIndex: data.optionIndex.present
          ? data.optionIndex.value
          : this.optionIndex,
      rollMin: data.rollMin.present ? data.rollMin.value : this.rollMin,
      rollMax: data.rollMax.present ? data.rollMax.value : this.rollMax,
      label: data.label.present ? data.label.value : this.label,
      content: data.content.present ? data.content.value : this.content,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NarrativeOption(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('optionIndex: $optionIndex, ')
          ..write('rollMin: $rollMin, ')
          ..write('rollMax: $rollMax, ')
          ..write('label: $label, ')
          ..write('content: $content')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, groupId, optionIndex, rollMin, rollMax, label, content);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NarrativeOption &&
          other.id == this.id &&
          other.groupId == this.groupId &&
          other.optionIndex == this.optionIndex &&
          other.rollMin == this.rollMin &&
          other.rollMax == this.rollMax &&
          other.label == this.label &&
          other.content == this.content);
}

class NarrativeOptionsCompanion extends UpdateCompanion<NarrativeOption> {
  final Value<String> id;
  final Value<String> groupId;
  final Value<int> optionIndex;
  final Value<int?> rollMin;
  final Value<int?> rollMax;
  final Value<String?> label;
  final Value<String> content;
  final Value<int> rowid;
  const NarrativeOptionsCompanion({
    this.id = const Value.absent(),
    this.groupId = const Value.absent(),
    this.optionIndex = const Value.absent(),
    this.rollMin = const Value.absent(),
    this.rollMax = const Value.absent(),
    this.label = const Value.absent(),
    this.content = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NarrativeOptionsCompanion.insert({
    required String id,
    required String groupId,
    required int optionIndex,
    this.rollMin = const Value.absent(),
    this.rollMax = const Value.absent(),
    this.label = const Value.absent(),
    required String content,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       groupId = Value(groupId),
       optionIndex = Value(optionIndex),
       content = Value(content);
  static Insertable<NarrativeOption> custom({
    Expression<String>? id,
    Expression<String>? groupId,
    Expression<int>? optionIndex,
    Expression<int>? rollMin,
    Expression<int>? rollMax,
    Expression<String>? label,
    Expression<String>? content,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (groupId != null) 'group_id': groupId,
      if (optionIndex != null) 'option_index': optionIndex,
      if (rollMin != null) 'roll_min': rollMin,
      if (rollMax != null) 'roll_max': rollMax,
      if (label != null) 'label': label,
      if (content != null) 'content': content,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NarrativeOptionsCompanion copyWith({
    Value<String>? id,
    Value<String>? groupId,
    Value<int>? optionIndex,
    Value<int?>? rollMin,
    Value<int?>? rollMax,
    Value<String?>? label,
    Value<String>? content,
    Value<int>? rowid,
  }) {
    return NarrativeOptionsCompanion(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      optionIndex: optionIndex ?? this.optionIndex,
      rollMin: rollMin ?? this.rollMin,
      rollMax: rollMax ?? this.rollMax,
      label: label ?? this.label,
      content: content ?? this.content,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<String>(groupId.value);
    }
    if (optionIndex.present) {
      map['option_index'] = Variable<int>(optionIndex.value);
    }
    if (rollMin.present) {
      map['roll_min'] = Variable<int>(rollMin.value);
    }
    if (rollMax.present) {
      map['roll_max'] = Variable<int>(rollMax.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NarrativeOptionsCompanion(')
          ..write('id: $id, ')
          ..write('groupId: $groupId, ')
          ..write('optionIndex: $optionIndex, ')
          ..write('rollMin: $rollMin, ')
          ..write('rollMax: $rollMax, ')
          ..write('label: $label, ')
          ..write('content: $content, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CompendiumPackStatesTable extends CompendiumPackStates
    with TableInfo<$CompendiumPackStatesTable, CompendiumPackState> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CompendiumPackStatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isFixedMeta = const VerificationMeta(
    'isFixed',
  );
  @override
  late final GeneratedColumn<bool> isFixed = GeneratedColumn<bool>(
    'is_fixed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_fixed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    kind,
    isFixed,
    isActive,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'compendium_pack_states';
  @override
  VerificationContext validateIntegrity(
    Insertable<CompendiumPackState> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('is_fixed')) {
      context.handle(
        _isFixedMeta,
        isFixed.isAcceptableOrUnknown(data['is_fixed']!, _isFixedMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CompendiumPackState map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CompendiumPackState(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      isFixed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_fixed'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CompendiumPackStatesTable createAlias(String alias) {
    return $CompendiumPackStatesTable(attachedDatabase, alias);
  }
}

class CompendiumPackState extends DataClass
    implements Insertable<CompendiumPackState> {
  final String id;
  final String title;
  final String description;
  final String kind;
  final bool isFixed;
  final bool isActive;
  final DateTime updatedAt;
  const CompendiumPackState({
    required this.id,
    required this.title,
    required this.description,
    required this.kind,
    required this.isFixed,
    required this.isActive,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['kind'] = Variable<String>(kind);
    map['is_fixed'] = Variable<bool>(isFixed);
    map['is_active'] = Variable<bool>(isActive);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CompendiumPackStatesCompanion toCompanion(bool nullToAbsent) {
    return CompendiumPackStatesCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      kind: Value(kind),
      isFixed: Value(isFixed),
      isActive: Value(isActive),
      updatedAt: Value(updatedAt),
    );
  }

  factory CompendiumPackState.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CompendiumPackState(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      kind: serializer.fromJson<String>(json['kind']),
      isFixed: serializer.fromJson<bool>(json['isFixed']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'kind': serializer.toJson<String>(kind),
      'isFixed': serializer.toJson<bool>(isFixed),
      'isActive': serializer.toJson<bool>(isActive),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CompendiumPackState copyWith({
    String? id,
    String? title,
    String? description,
    String? kind,
    bool? isFixed,
    bool? isActive,
    DateTime? updatedAt,
  }) => CompendiumPackState(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    kind: kind ?? this.kind,
    isFixed: isFixed ?? this.isFixed,
    isActive: isActive ?? this.isActive,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CompendiumPackState copyWithCompanion(CompendiumPackStatesCompanion data) {
    return CompendiumPackState(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      kind: data.kind.present ? data.kind.value : this.kind,
      isFixed: data.isFixed.present ? data.isFixed.value : this.isFixed,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CompendiumPackState(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('kind: $kind, ')
          ..write('isFixed: $isFixed, ')
          ..write('isActive: $isActive, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, description, kind, isFixed, isActive, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CompendiumPackState &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.kind == this.kind &&
          other.isFixed == this.isFixed &&
          other.isActive == this.isActive &&
          other.updatedAt == this.updatedAt);
}

class CompendiumPackStatesCompanion
    extends UpdateCompanion<CompendiumPackState> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> description;
  final Value<String> kind;
  final Value<bool> isFixed;
  final Value<bool> isActive;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CompendiumPackStatesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.kind = const Value.absent(),
    this.isFixed = const Value.absent(),
    this.isActive = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CompendiumPackStatesCompanion.insert({
    required String id,
    required String title,
    required String description,
    required String kind,
    this.isFixed = const Value.absent(),
    this.isActive = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       description = Value(description),
       kind = Value(kind),
       updatedAt = Value(updatedAt);
  static Insertable<CompendiumPackState> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? kind,
    Expression<bool>? isFixed,
    Expression<bool>? isActive,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (kind != null) 'kind': kind,
      if (isFixed != null) 'is_fixed': isFixed,
      if (isActive != null) 'is_active': isActive,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CompendiumPackStatesCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? description,
    Value<String>? kind,
    Value<bool>? isFixed,
    Value<bool>? isActive,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return CompendiumPackStatesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      kind: kind ?? this.kind,
      isFixed: isFixed ?? this.isFixed,
      isActive: isActive ?? this.isActive,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (isFixed.present) {
      map['is_fixed'] = Variable<bool>(isFixed.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CompendiumPackStatesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('kind: $kind, ')
          ..write('isFixed: $isFixed, ')
          ..write('isActive: $isActive, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ImportedCompendiumPacksTable extends ImportedCompendiumPacks
    with TableInfo<$ImportedCompendiumPacksTable, ImportedCompendiumPack> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ImportedCompendiumPacksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rawXmlMeta = const VerificationMeta('rawXml');
  @override
  late final GeneratedColumn<String> rawXml = GeneratedColumn<String>(
    'raw_xml',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _importedAtMeta = const VerificationMeta(
    'importedAt',
  );
  @override
  late final GeneratedColumn<DateTime> importedAt = GeneratedColumn<DateTime>(
    'imported_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, rawXml, importedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'imported_compendium_packs';
  @override
  VerificationContext validateIntegrity(
    Insertable<ImportedCompendiumPack> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('raw_xml')) {
      context.handle(
        _rawXmlMeta,
        rawXml.isAcceptableOrUnknown(data['raw_xml']!, _rawXmlMeta),
      );
    } else if (isInserting) {
      context.missing(_rawXmlMeta);
    }
    if (data.containsKey('imported_at')) {
      context.handle(
        _importedAtMeta,
        importedAt.isAcceptableOrUnknown(data['imported_at']!, _importedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_importedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ImportedCompendiumPack map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ImportedCompendiumPack(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      rawXml: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raw_xml'],
      )!,
      importedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}imported_at'],
      )!,
    );
  }

  @override
  $ImportedCompendiumPacksTable createAlias(String alias) {
    return $ImportedCompendiumPacksTable(attachedDatabase, alias);
  }
}

class ImportedCompendiumPack extends DataClass
    implements Insertable<ImportedCompendiumPack> {
  final String id;
  final String rawXml;
  final DateTime importedAt;
  const ImportedCompendiumPack({
    required this.id,
    required this.rawXml,
    required this.importedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['raw_xml'] = Variable<String>(rawXml);
    map['imported_at'] = Variable<DateTime>(importedAt);
    return map;
  }

  ImportedCompendiumPacksCompanion toCompanion(bool nullToAbsent) {
    return ImportedCompendiumPacksCompanion(
      id: Value(id),
      rawXml: Value(rawXml),
      importedAt: Value(importedAt),
    );
  }

  factory ImportedCompendiumPack.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ImportedCompendiumPack(
      id: serializer.fromJson<String>(json['id']),
      rawXml: serializer.fromJson<String>(json['rawXml']),
      importedAt: serializer.fromJson<DateTime>(json['importedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'rawXml': serializer.toJson<String>(rawXml),
      'importedAt': serializer.toJson<DateTime>(importedAt),
    };
  }

  ImportedCompendiumPack copyWith({
    String? id,
    String? rawXml,
    DateTime? importedAt,
  }) => ImportedCompendiumPack(
    id: id ?? this.id,
    rawXml: rawXml ?? this.rawXml,
    importedAt: importedAt ?? this.importedAt,
  );
  ImportedCompendiumPack copyWithCompanion(
    ImportedCompendiumPacksCompanion data,
  ) {
    return ImportedCompendiumPack(
      id: data.id.present ? data.id.value : this.id,
      rawXml: data.rawXml.present ? data.rawXml.value : this.rawXml,
      importedAt: data.importedAt.present
          ? data.importedAt.value
          : this.importedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ImportedCompendiumPack(')
          ..write('id: $id, ')
          ..write('rawXml: $rawXml, ')
          ..write('importedAt: $importedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, rawXml, importedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ImportedCompendiumPack &&
          other.id == this.id &&
          other.rawXml == this.rawXml &&
          other.importedAt == this.importedAt);
}

class ImportedCompendiumPacksCompanion
    extends UpdateCompanion<ImportedCompendiumPack> {
  final Value<String> id;
  final Value<String> rawXml;
  final Value<DateTime> importedAt;
  final Value<int> rowid;
  const ImportedCompendiumPacksCompanion({
    this.id = const Value.absent(),
    this.rawXml = const Value.absent(),
    this.importedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ImportedCompendiumPacksCompanion.insert({
    required String id,
    required String rawXml,
    required DateTime importedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       rawXml = Value(rawXml),
       importedAt = Value(importedAt);
  static Insertable<ImportedCompendiumPack> custom({
    Expression<String>? id,
    Expression<String>? rawXml,
    Expression<DateTime>? importedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (rawXml != null) 'raw_xml': rawXml,
      if (importedAt != null) 'imported_at': importedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ImportedCompendiumPacksCompanion copyWith({
    Value<String>? id,
    Value<String>? rawXml,
    Value<DateTime>? importedAt,
    Value<int>? rowid,
  }) {
    return ImportedCompendiumPacksCompanion(
      id: id ?? this.id,
      rawXml: rawXml ?? this.rawXml,
      importedAt: importedAt ?? this.importedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (rawXml.present) {
      map['raw_xml'] = Variable<String>(rawXml.value);
    }
    if (importedAt.present) {
      map['imported_at'] = Variable<DateTime>(importedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ImportedCompendiumPacksCompanion(')
          ..write('id: $id, ')
          ..write('rawXml: $rawXml, ')
          ..write('importedAt: $importedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BackgroundDefinitionsTable extends BackgroundDefinitions
    with TableInfo<$BackgroundDefinitionsTable, BackgroundDefinition> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BackgroundDefinitionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _summaryMeta = const VerificationMeta(
    'summary',
  );
  @override
  late final GeneratedColumn<String> summary = GeneratedColumn<String>(
    'summary',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _featureNameMeta = const VerificationMeta(
    'featureName',
  );
  @override
  late final GeneratedColumn<String> featureName = GeneratedColumn<String>(
    'feature_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _featureDescriptionMeta =
      const VerificationMeta('featureDescription');
  @override
  late final GeneratedColumn<String> featureDescription =
      GeneratedColumn<String>(
        'feature_description',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _grantedSkillKeysJsonMeta =
      const VerificationMeta('grantedSkillKeysJson');
  @override
  late final GeneratedColumn<String> grantedSkillKeysJson =
      GeneratedColumn<String>(
        'granted_skill_keys_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _grantedToolKeysJsonMeta =
      const VerificationMeta('grantedToolKeysJson');
  @override
  late final GeneratedColumn<String> grantedToolKeysJson =
      GeneratedColumn<String>(
        'granted_tool_keys_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _grantedLanguageKeysJsonMeta =
      const VerificationMeta('grantedLanguageKeysJson');
  @override
  late final GeneratedColumn<String> grantedLanguageKeysJson =
      GeneratedColumn<String>(
        'granted_language_keys_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _startingEquipmentJsonMeta =
      const VerificationMeta('startingEquipmentJson');
  @override
  late final GeneratedColumn<String> startingEquipmentJson =
      GeneratedColumn<String>(
        'starting_equipment_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    key,
    name,
    summary,
    featureName,
    featureDescription,
    grantedSkillKeysJson,
    grantedToolKeysJson,
    grantedLanguageKeysJson,
    startingEquipmentJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'background_definitions';
  @override
  VerificationContext validateIntegrity(
    Insertable<BackgroundDefinition> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('summary')) {
      context.handle(
        _summaryMeta,
        summary.isAcceptableOrUnknown(data['summary']!, _summaryMeta),
      );
    }
    if (data.containsKey('feature_name')) {
      context.handle(
        _featureNameMeta,
        featureName.isAcceptableOrUnknown(
          data['feature_name']!,
          _featureNameMeta,
        ),
      );
    }
    if (data.containsKey('feature_description')) {
      context.handle(
        _featureDescriptionMeta,
        featureDescription.isAcceptableOrUnknown(
          data['feature_description']!,
          _featureDescriptionMeta,
        ),
      );
    }
    if (data.containsKey('granted_skill_keys_json')) {
      context.handle(
        _grantedSkillKeysJsonMeta,
        grantedSkillKeysJson.isAcceptableOrUnknown(
          data['granted_skill_keys_json']!,
          _grantedSkillKeysJsonMeta,
        ),
      );
    }
    if (data.containsKey('granted_tool_keys_json')) {
      context.handle(
        _grantedToolKeysJsonMeta,
        grantedToolKeysJson.isAcceptableOrUnknown(
          data['granted_tool_keys_json']!,
          _grantedToolKeysJsonMeta,
        ),
      );
    }
    if (data.containsKey('granted_language_keys_json')) {
      context.handle(
        _grantedLanguageKeysJsonMeta,
        grantedLanguageKeysJson.isAcceptableOrUnknown(
          data['granted_language_keys_json']!,
          _grantedLanguageKeysJsonMeta,
        ),
      );
    }
    if (data.containsKey('starting_equipment_json')) {
      context.handle(
        _startingEquipmentJsonMeta,
        startingEquipmentJson.isAcceptableOrUnknown(
          data['starting_equipment_json']!,
          _startingEquipmentJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {key},
  ];
  @override
  BackgroundDefinition map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BackgroundDefinition(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      summary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}summary'],
      ),
      featureName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}feature_name'],
      ),
      featureDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}feature_description'],
      ),
      grantedSkillKeysJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}granted_skill_keys_json'],
      ),
      grantedToolKeysJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}granted_tool_keys_json'],
      ),
      grantedLanguageKeysJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}granted_language_keys_json'],
      ),
      startingEquipmentJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}starting_equipment_json'],
      ),
    );
  }

  @override
  $BackgroundDefinitionsTable createAlias(String alias) {
    return $BackgroundDefinitionsTable(attachedDatabase, alias);
  }
}

class BackgroundDefinition extends DataClass
    implements Insertable<BackgroundDefinition> {
  final String id;
  final String key;
  final String name;
  final String? summary;
  final String? featureName;
  final String? featureDescription;
  final String? grantedSkillKeysJson;
  final String? grantedToolKeysJson;
  final String? grantedLanguageKeysJson;
  final String? startingEquipmentJson;
  const BackgroundDefinition({
    required this.id,
    required this.key,
    required this.name,
    this.summary,
    this.featureName,
    this.featureDescription,
    this.grantedSkillKeysJson,
    this.grantedToolKeysJson,
    this.grantedLanguageKeysJson,
    this.startingEquipmentJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['key'] = Variable<String>(key);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || summary != null) {
      map['summary'] = Variable<String>(summary);
    }
    if (!nullToAbsent || featureName != null) {
      map['feature_name'] = Variable<String>(featureName);
    }
    if (!nullToAbsent || featureDescription != null) {
      map['feature_description'] = Variable<String>(featureDescription);
    }
    if (!nullToAbsent || grantedSkillKeysJson != null) {
      map['granted_skill_keys_json'] = Variable<String>(grantedSkillKeysJson);
    }
    if (!nullToAbsent || grantedToolKeysJson != null) {
      map['granted_tool_keys_json'] = Variable<String>(grantedToolKeysJson);
    }
    if (!nullToAbsent || grantedLanguageKeysJson != null) {
      map['granted_language_keys_json'] = Variable<String>(
        grantedLanguageKeysJson,
      );
    }
    if (!nullToAbsent || startingEquipmentJson != null) {
      map['starting_equipment_json'] = Variable<String>(startingEquipmentJson);
    }
    return map;
  }

  BackgroundDefinitionsCompanion toCompanion(bool nullToAbsent) {
    return BackgroundDefinitionsCompanion(
      id: Value(id),
      key: Value(key),
      name: Value(name),
      summary: summary == null && nullToAbsent
          ? const Value.absent()
          : Value(summary),
      featureName: featureName == null && nullToAbsent
          ? const Value.absent()
          : Value(featureName),
      featureDescription: featureDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(featureDescription),
      grantedSkillKeysJson: grantedSkillKeysJson == null && nullToAbsent
          ? const Value.absent()
          : Value(grantedSkillKeysJson),
      grantedToolKeysJson: grantedToolKeysJson == null && nullToAbsent
          ? const Value.absent()
          : Value(grantedToolKeysJson),
      grantedLanguageKeysJson: grantedLanguageKeysJson == null && nullToAbsent
          ? const Value.absent()
          : Value(grantedLanguageKeysJson),
      startingEquipmentJson: startingEquipmentJson == null && nullToAbsent
          ? const Value.absent()
          : Value(startingEquipmentJson),
    );
  }

  factory BackgroundDefinition.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BackgroundDefinition(
      id: serializer.fromJson<String>(json['id']),
      key: serializer.fromJson<String>(json['key']),
      name: serializer.fromJson<String>(json['name']),
      summary: serializer.fromJson<String?>(json['summary']),
      featureName: serializer.fromJson<String?>(json['featureName']),
      featureDescription: serializer.fromJson<String?>(
        json['featureDescription'],
      ),
      grantedSkillKeysJson: serializer.fromJson<String?>(
        json['grantedSkillKeysJson'],
      ),
      grantedToolKeysJson: serializer.fromJson<String?>(
        json['grantedToolKeysJson'],
      ),
      grantedLanguageKeysJson: serializer.fromJson<String?>(
        json['grantedLanguageKeysJson'],
      ),
      startingEquipmentJson: serializer.fromJson<String?>(
        json['startingEquipmentJson'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'key': serializer.toJson<String>(key),
      'name': serializer.toJson<String>(name),
      'summary': serializer.toJson<String?>(summary),
      'featureName': serializer.toJson<String?>(featureName),
      'featureDescription': serializer.toJson<String?>(featureDescription),
      'grantedSkillKeysJson': serializer.toJson<String?>(grantedSkillKeysJson),
      'grantedToolKeysJson': serializer.toJson<String?>(grantedToolKeysJson),
      'grantedLanguageKeysJson': serializer.toJson<String?>(
        grantedLanguageKeysJson,
      ),
      'startingEquipmentJson': serializer.toJson<String?>(
        startingEquipmentJson,
      ),
    };
  }

  BackgroundDefinition copyWith({
    String? id,
    String? key,
    String? name,
    Value<String?> summary = const Value.absent(),
    Value<String?> featureName = const Value.absent(),
    Value<String?> featureDescription = const Value.absent(),
    Value<String?> grantedSkillKeysJson = const Value.absent(),
    Value<String?> grantedToolKeysJson = const Value.absent(),
    Value<String?> grantedLanguageKeysJson = const Value.absent(),
    Value<String?> startingEquipmentJson = const Value.absent(),
  }) => BackgroundDefinition(
    id: id ?? this.id,
    key: key ?? this.key,
    name: name ?? this.name,
    summary: summary.present ? summary.value : this.summary,
    featureName: featureName.present ? featureName.value : this.featureName,
    featureDescription: featureDescription.present
        ? featureDescription.value
        : this.featureDescription,
    grantedSkillKeysJson: grantedSkillKeysJson.present
        ? grantedSkillKeysJson.value
        : this.grantedSkillKeysJson,
    grantedToolKeysJson: grantedToolKeysJson.present
        ? grantedToolKeysJson.value
        : this.grantedToolKeysJson,
    grantedLanguageKeysJson: grantedLanguageKeysJson.present
        ? grantedLanguageKeysJson.value
        : this.grantedLanguageKeysJson,
    startingEquipmentJson: startingEquipmentJson.present
        ? startingEquipmentJson.value
        : this.startingEquipmentJson,
  );
  BackgroundDefinition copyWithCompanion(BackgroundDefinitionsCompanion data) {
    return BackgroundDefinition(
      id: data.id.present ? data.id.value : this.id,
      key: data.key.present ? data.key.value : this.key,
      name: data.name.present ? data.name.value : this.name,
      summary: data.summary.present ? data.summary.value : this.summary,
      featureName: data.featureName.present
          ? data.featureName.value
          : this.featureName,
      featureDescription: data.featureDescription.present
          ? data.featureDescription.value
          : this.featureDescription,
      grantedSkillKeysJson: data.grantedSkillKeysJson.present
          ? data.grantedSkillKeysJson.value
          : this.grantedSkillKeysJson,
      grantedToolKeysJson: data.grantedToolKeysJson.present
          ? data.grantedToolKeysJson.value
          : this.grantedToolKeysJson,
      grantedLanguageKeysJson: data.grantedLanguageKeysJson.present
          ? data.grantedLanguageKeysJson.value
          : this.grantedLanguageKeysJson,
      startingEquipmentJson: data.startingEquipmentJson.present
          ? data.startingEquipmentJson.value
          : this.startingEquipmentJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BackgroundDefinition(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('name: $name, ')
          ..write('summary: $summary, ')
          ..write('featureName: $featureName, ')
          ..write('featureDescription: $featureDescription, ')
          ..write('grantedSkillKeysJson: $grantedSkillKeysJson, ')
          ..write('grantedToolKeysJson: $grantedToolKeysJson, ')
          ..write('grantedLanguageKeysJson: $grantedLanguageKeysJson, ')
          ..write('startingEquipmentJson: $startingEquipmentJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    key,
    name,
    summary,
    featureName,
    featureDescription,
    grantedSkillKeysJson,
    grantedToolKeysJson,
    grantedLanguageKeysJson,
    startingEquipmentJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BackgroundDefinition &&
          other.id == this.id &&
          other.key == this.key &&
          other.name == this.name &&
          other.summary == this.summary &&
          other.featureName == this.featureName &&
          other.featureDescription == this.featureDescription &&
          other.grantedSkillKeysJson == this.grantedSkillKeysJson &&
          other.grantedToolKeysJson == this.grantedToolKeysJson &&
          other.grantedLanguageKeysJson == this.grantedLanguageKeysJson &&
          other.startingEquipmentJson == this.startingEquipmentJson);
}

class BackgroundDefinitionsCompanion
    extends UpdateCompanion<BackgroundDefinition> {
  final Value<String> id;
  final Value<String> key;
  final Value<String> name;
  final Value<String?> summary;
  final Value<String?> featureName;
  final Value<String?> featureDescription;
  final Value<String?> grantedSkillKeysJson;
  final Value<String?> grantedToolKeysJson;
  final Value<String?> grantedLanguageKeysJson;
  final Value<String?> startingEquipmentJson;
  final Value<int> rowid;
  const BackgroundDefinitionsCompanion({
    this.id = const Value.absent(),
    this.key = const Value.absent(),
    this.name = const Value.absent(),
    this.summary = const Value.absent(),
    this.featureName = const Value.absent(),
    this.featureDescription = const Value.absent(),
    this.grantedSkillKeysJson = const Value.absent(),
    this.grantedToolKeysJson = const Value.absent(),
    this.grantedLanguageKeysJson = const Value.absent(),
    this.startingEquipmentJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BackgroundDefinitionsCompanion.insert({
    required String id,
    required String key,
    required String name,
    this.summary = const Value.absent(),
    this.featureName = const Value.absent(),
    this.featureDescription = const Value.absent(),
    this.grantedSkillKeysJson = const Value.absent(),
    this.grantedToolKeysJson = const Value.absent(),
    this.grantedLanguageKeysJson = const Value.absent(),
    this.startingEquipmentJson = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       key = Value(key),
       name = Value(name);
  static Insertable<BackgroundDefinition> custom({
    Expression<String>? id,
    Expression<String>? key,
    Expression<String>? name,
    Expression<String>? summary,
    Expression<String>? featureName,
    Expression<String>? featureDescription,
    Expression<String>? grantedSkillKeysJson,
    Expression<String>? grantedToolKeysJson,
    Expression<String>? grantedLanguageKeysJson,
    Expression<String>? startingEquipmentJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (key != null) 'key': key,
      if (name != null) 'name': name,
      if (summary != null) 'summary': summary,
      if (featureName != null) 'feature_name': featureName,
      if (featureDescription != null) 'feature_description': featureDescription,
      if (grantedSkillKeysJson != null)
        'granted_skill_keys_json': grantedSkillKeysJson,
      if (grantedToolKeysJson != null)
        'granted_tool_keys_json': grantedToolKeysJson,
      if (grantedLanguageKeysJson != null)
        'granted_language_keys_json': grantedLanguageKeysJson,
      if (startingEquipmentJson != null)
        'starting_equipment_json': startingEquipmentJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BackgroundDefinitionsCompanion copyWith({
    Value<String>? id,
    Value<String>? key,
    Value<String>? name,
    Value<String?>? summary,
    Value<String?>? featureName,
    Value<String?>? featureDescription,
    Value<String?>? grantedSkillKeysJson,
    Value<String?>? grantedToolKeysJson,
    Value<String?>? grantedLanguageKeysJson,
    Value<String?>? startingEquipmentJson,
    Value<int>? rowid,
  }) {
    return BackgroundDefinitionsCompanion(
      id: id ?? this.id,
      key: key ?? this.key,
      name: name ?? this.name,
      summary: summary ?? this.summary,
      featureName: featureName ?? this.featureName,
      featureDescription: featureDescription ?? this.featureDescription,
      grantedSkillKeysJson: grantedSkillKeysJson ?? this.grantedSkillKeysJson,
      grantedToolKeysJson: grantedToolKeysJson ?? this.grantedToolKeysJson,
      grantedLanguageKeysJson:
          grantedLanguageKeysJson ?? this.grantedLanguageKeysJson,
      startingEquipmentJson:
          startingEquipmentJson ?? this.startingEquipmentJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (summary.present) {
      map['summary'] = Variable<String>(summary.value);
    }
    if (featureName.present) {
      map['feature_name'] = Variable<String>(featureName.value);
    }
    if (featureDescription.present) {
      map['feature_description'] = Variable<String>(featureDescription.value);
    }
    if (grantedSkillKeysJson.present) {
      map['granted_skill_keys_json'] = Variable<String>(
        grantedSkillKeysJson.value,
      );
    }
    if (grantedToolKeysJson.present) {
      map['granted_tool_keys_json'] = Variable<String>(
        grantedToolKeysJson.value,
      );
    }
    if (grantedLanguageKeysJson.present) {
      map['granted_language_keys_json'] = Variable<String>(
        grantedLanguageKeysJson.value,
      );
    }
    if (startingEquipmentJson.present) {
      map['starting_equipment_json'] = Variable<String>(
        startingEquipmentJson.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BackgroundDefinitionsCompanion(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('name: $name, ')
          ..write('summary: $summary, ')
          ..write('featureName: $featureName, ')
          ..write('featureDescription: $featureDescription, ')
          ..write('grantedSkillKeysJson: $grantedSkillKeysJson, ')
          ..write('grantedToolKeysJson: $grantedToolKeysJson, ')
          ..write('grantedLanguageKeysJson: $grantedLanguageKeysJson, ')
          ..write('startingEquipmentJson: $startingEquipmentJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SpellDefinitionsTable extends SpellDefinitions
    with TableInfo<$SpellDefinitionsTable, SpellDefinition> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SpellDefinitionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
    'level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _schoolMeta = const VerificationMeta('school');
  @override
  late final GeneratedColumn<String> school = GeneratedColumn<String>(
    'school',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _castingTimeMeta = const VerificationMeta(
    'castingTime',
  );
  @override
  late final GeneratedColumn<String> castingTime = GeneratedColumn<String>(
    'casting_time',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rangeTextMeta = const VerificationMeta(
    'rangeText',
  );
  @override
  late final GeneratedColumn<String> rangeText = GeneratedColumn<String>(
    'range_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationTextMeta = const VerificationMeta(
    'durationText',
  );
  @override
  late final GeneratedColumn<String> durationText = GeneratedColumn<String>(
    'duration_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _requiresConcentrationMeta =
      const VerificationMeta('requiresConcentration');
  @override
  late final GeneratedColumn<bool> requiresConcentration =
      GeneratedColumn<bool>(
        'requires_concentration',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("requires_concentration" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _isRitualMeta = const VerificationMeta(
    'isRitual',
  );
  @override
  late final GeneratedColumn<bool> isRitual = GeneratedColumn<bool>(
    'is_ritual',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_ritual" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _componentsJsonMeta = const VerificationMeta(
    'componentsJson',
  );
  @override
  late final GeneratedColumn<String> componentsJson = GeneratedColumn<String>(
    'components_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _higherLevelsDescriptionMeta =
      const VerificationMeta('higherLevelsDescription');
  @override
  late final GeneratedColumn<String> higherLevelsDescription =
      GeneratedColumn<String>(
        'higher_levels_description',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    key,
    name,
    level,
    school,
    castingTime,
    rangeText,
    durationText,
    requiresConcentration,
    isRitual,
    componentsJson,
    description,
    higherLevelsDescription,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'spell_definitions';
  @override
  VerificationContext validateIntegrity(
    Insertable<SpellDefinition> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('level')) {
      context.handle(
        _levelMeta,
        level.isAcceptableOrUnknown(data['level']!, _levelMeta),
      );
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('school')) {
      context.handle(
        _schoolMeta,
        school.isAcceptableOrUnknown(data['school']!, _schoolMeta),
      );
    } else if (isInserting) {
      context.missing(_schoolMeta);
    }
    if (data.containsKey('casting_time')) {
      context.handle(
        _castingTimeMeta,
        castingTime.isAcceptableOrUnknown(
          data['casting_time']!,
          _castingTimeMeta,
        ),
      );
    }
    if (data.containsKey('range_text')) {
      context.handle(
        _rangeTextMeta,
        rangeText.isAcceptableOrUnknown(data['range_text']!, _rangeTextMeta),
      );
    }
    if (data.containsKey('duration_text')) {
      context.handle(
        _durationTextMeta,
        durationText.isAcceptableOrUnknown(
          data['duration_text']!,
          _durationTextMeta,
        ),
      );
    }
    if (data.containsKey('requires_concentration')) {
      context.handle(
        _requiresConcentrationMeta,
        requiresConcentration.isAcceptableOrUnknown(
          data['requires_concentration']!,
          _requiresConcentrationMeta,
        ),
      );
    }
    if (data.containsKey('is_ritual')) {
      context.handle(
        _isRitualMeta,
        isRitual.isAcceptableOrUnknown(data['is_ritual']!, _isRitualMeta),
      );
    }
    if (data.containsKey('components_json')) {
      context.handle(
        _componentsJsonMeta,
        componentsJson.isAcceptableOrUnknown(
          data['components_json']!,
          _componentsJsonMeta,
        ),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('higher_levels_description')) {
      context.handle(
        _higherLevelsDescriptionMeta,
        higherLevelsDescription.isAcceptableOrUnknown(
          data['higher_levels_description']!,
          _higherLevelsDescriptionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {key},
  ];
  @override
  SpellDefinition map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SpellDefinition(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      level: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}level'],
      )!,
      school: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}school'],
      )!,
      castingTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}casting_time'],
      ),
      rangeText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}range_text'],
      ),
      durationText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}duration_text'],
      ),
      requiresConcentration: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}requires_concentration'],
      )!,
      isRitual: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_ritual'],
      )!,
      componentsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}components_json'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      higherLevelsDescription: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}higher_levels_description'],
      ),
    );
  }

  @override
  $SpellDefinitionsTable createAlias(String alias) {
    return $SpellDefinitionsTable(attachedDatabase, alias);
  }
}

class SpellDefinition extends DataClass implements Insertable<SpellDefinition> {
  final String id;
  final String key;
  final String name;
  final int level;
  final String school;
  final String? castingTime;
  final String? rangeText;
  final String? durationText;
  final bool requiresConcentration;
  final bool isRitual;
  final String? componentsJson;
  final String? description;
  final String? higherLevelsDescription;
  const SpellDefinition({
    required this.id,
    required this.key,
    required this.name,
    required this.level,
    required this.school,
    this.castingTime,
    this.rangeText,
    this.durationText,
    required this.requiresConcentration,
    required this.isRitual,
    this.componentsJson,
    this.description,
    this.higherLevelsDescription,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['key'] = Variable<String>(key);
    map['name'] = Variable<String>(name);
    map['level'] = Variable<int>(level);
    map['school'] = Variable<String>(school);
    if (!nullToAbsent || castingTime != null) {
      map['casting_time'] = Variable<String>(castingTime);
    }
    if (!nullToAbsent || rangeText != null) {
      map['range_text'] = Variable<String>(rangeText);
    }
    if (!nullToAbsent || durationText != null) {
      map['duration_text'] = Variable<String>(durationText);
    }
    map['requires_concentration'] = Variable<bool>(requiresConcentration);
    map['is_ritual'] = Variable<bool>(isRitual);
    if (!nullToAbsent || componentsJson != null) {
      map['components_json'] = Variable<String>(componentsJson);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || higherLevelsDescription != null) {
      map['higher_levels_description'] = Variable<String>(
        higherLevelsDescription,
      );
    }
    return map;
  }

  SpellDefinitionsCompanion toCompanion(bool nullToAbsent) {
    return SpellDefinitionsCompanion(
      id: Value(id),
      key: Value(key),
      name: Value(name),
      level: Value(level),
      school: Value(school),
      castingTime: castingTime == null && nullToAbsent
          ? const Value.absent()
          : Value(castingTime),
      rangeText: rangeText == null && nullToAbsent
          ? const Value.absent()
          : Value(rangeText),
      durationText: durationText == null && nullToAbsent
          ? const Value.absent()
          : Value(durationText),
      requiresConcentration: Value(requiresConcentration),
      isRitual: Value(isRitual),
      componentsJson: componentsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(componentsJson),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      higherLevelsDescription: higherLevelsDescription == null && nullToAbsent
          ? const Value.absent()
          : Value(higherLevelsDescription),
    );
  }

  factory SpellDefinition.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SpellDefinition(
      id: serializer.fromJson<String>(json['id']),
      key: serializer.fromJson<String>(json['key']),
      name: serializer.fromJson<String>(json['name']),
      level: serializer.fromJson<int>(json['level']),
      school: serializer.fromJson<String>(json['school']),
      castingTime: serializer.fromJson<String?>(json['castingTime']),
      rangeText: serializer.fromJson<String?>(json['rangeText']),
      durationText: serializer.fromJson<String?>(json['durationText']),
      requiresConcentration: serializer.fromJson<bool>(
        json['requiresConcentration'],
      ),
      isRitual: serializer.fromJson<bool>(json['isRitual']),
      componentsJson: serializer.fromJson<String?>(json['componentsJson']),
      description: serializer.fromJson<String?>(json['description']),
      higherLevelsDescription: serializer.fromJson<String?>(
        json['higherLevelsDescription'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'key': serializer.toJson<String>(key),
      'name': serializer.toJson<String>(name),
      'level': serializer.toJson<int>(level),
      'school': serializer.toJson<String>(school),
      'castingTime': serializer.toJson<String?>(castingTime),
      'rangeText': serializer.toJson<String?>(rangeText),
      'durationText': serializer.toJson<String?>(durationText),
      'requiresConcentration': serializer.toJson<bool>(requiresConcentration),
      'isRitual': serializer.toJson<bool>(isRitual),
      'componentsJson': serializer.toJson<String?>(componentsJson),
      'description': serializer.toJson<String?>(description),
      'higherLevelsDescription': serializer.toJson<String?>(
        higherLevelsDescription,
      ),
    };
  }

  SpellDefinition copyWith({
    String? id,
    String? key,
    String? name,
    int? level,
    String? school,
    Value<String?> castingTime = const Value.absent(),
    Value<String?> rangeText = const Value.absent(),
    Value<String?> durationText = const Value.absent(),
    bool? requiresConcentration,
    bool? isRitual,
    Value<String?> componentsJson = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<String?> higherLevelsDescription = const Value.absent(),
  }) => SpellDefinition(
    id: id ?? this.id,
    key: key ?? this.key,
    name: name ?? this.name,
    level: level ?? this.level,
    school: school ?? this.school,
    castingTime: castingTime.present ? castingTime.value : this.castingTime,
    rangeText: rangeText.present ? rangeText.value : this.rangeText,
    durationText: durationText.present ? durationText.value : this.durationText,
    requiresConcentration: requiresConcentration ?? this.requiresConcentration,
    isRitual: isRitual ?? this.isRitual,
    componentsJson: componentsJson.present
        ? componentsJson.value
        : this.componentsJson,
    description: description.present ? description.value : this.description,
    higherLevelsDescription: higherLevelsDescription.present
        ? higherLevelsDescription.value
        : this.higherLevelsDescription,
  );
  SpellDefinition copyWithCompanion(SpellDefinitionsCompanion data) {
    return SpellDefinition(
      id: data.id.present ? data.id.value : this.id,
      key: data.key.present ? data.key.value : this.key,
      name: data.name.present ? data.name.value : this.name,
      level: data.level.present ? data.level.value : this.level,
      school: data.school.present ? data.school.value : this.school,
      castingTime: data.castingTime.present
          ? data.castingTime.value
          : this.castingTime,
      rangeText: data.rangeText.present ? data.rangeText.value : this.rangeText,
      durationText: data.durationText.present
          ? data.durationText.value
          : this.durationText,
      requiresConcentration: data.requiresConcentration.present
          ? data.requiresConcentration.value
          : this.requiresConcentration,
      isRitual: data.isRitual.present ? data.isRitual.value : this.isRitual,
      componentsJson: data.componentsJson.present
          ? data.componentsJson.value
          : this.componentsJson,
      description: data.description.present
          ? data.description.value
          : this.description,
      higherLevelsDescription: data.higherLevelsDescription.present
          ? data.higherLevelsDescription.value
          : this.higherLevelsDescription,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SpellDefinition(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('name: $name, ')
          ..write('level: $level, ')
          ..write('school: $school, ')
          ..write('castingTime: $castingTime, ')
          ..write('rangeText: $rangeText, ')
          ..write('durationText: $durationText, ')
          ..write('requiresConcentration: $requiresConcentration, ')
          ..write('isRitual: $isRitual, ')
          ..write('componentsJson: $componentsJson, ')
          ..write('description: $description, ')
          ..write('higherLevelsDescription: $higherLevelsDescription')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    key,
    name,
    level,
    school,
    castingTime,
    rangeText,
    durationText,
    requiresConcentration,
    isRitual,
    componentsJson,
    description,
    higherLevelsDescription,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SpellDefinition &&
          other.id == this.id &&
          other.key == this.key &&
          other.name == this.name &&
          other.level == this.level &&
          other.school == this.school &&
          other.castingTime == this.castingTime &&
          other.rangeText == this.rangeText &&
          other.durationText == this.durationText &&
          other.requiresConcentration == this.requiresConcentration &&
          other.isRitual == this.isRitual &&
          other.componentsJson == this.componentsJson &&
          other.description == this.description &&
          other.higherLevelsDescription == this.higherLevelsDescription);
}

class SpellDefinitionsCompanion extends UpdateCompanion<SpellDefinition> {
  final Value<String> id;
  final Value<String> key;
  final Value<String> name;
  final Value<int> level;
  final Value<String> school;
  final Value<String?> castingTime;
  final Value<String?> rangeText;
  final Value<String?> durationText;
  final Value<bool> requiresConcentration;
  final Value<bool> isRitual;
  final Value<String?> componentsJson;
  final Value<String?> description;
  final Value<String?> higherLevelsDescription;
  final Value<int> rowid;
  const SpellDefinitionsCompanion({
    this.id = const Value.absent(),
    this.key = const Value.absent(),
    this.name = const Value.absent(),
    this.level = const Value.absent(),
    this.school = const Value.absent(),
    this.castingTime = const Value.absent(),
    this.rangeText = const Value.absent(),
    this.durationText = const Value.absent(),
    this.requiresConcentration = const Value.absent(),
    this.isRitual = const Value.absent(),
    this.componentsJson = const Value.absent(),
    this.description = const Value.absent(),
    this.higherLevelsDescription = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SpellDefinitionsCompanion.insert({
    required String id,
    required String key,
    required String name,
    required int level,
    required String school,
    this.castingTime = const Value.absent(),
    this.rangeText = const Value.absent(),
    this.durationText = const Value.absent(),
    this.requiresConcentration = const Value.absent(),
    this.isRitual = const Value.absent(),
    this.componentsJson = const Value.absent(),
    this.description = const Value.absent(),
    this.higherLevelsDescription = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       key = Value(key),
       name = Value(name),
       level = Value(level),
       school = Value(school);
  static Insertable<SpellDefinition> custom({
    Expression<String>? id,
    Expression<String>? key,
    Expression<String>? name,
    Expression<int>? level,
    Expression<String>? school,
    Expression<String>? castingTime,
    Expression<String>? rangeText,
    Expression<String>? durationText,
    Expression<bool>? requiresConcentration,
    Expression<bool>? isRitual,
    Expression<String>? componentsJson,
    Expression<String>? description,
    Expression<String>? higherLevelsDescription,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (key != null) 'key': key,
      if (name != null) 'name': name,
      if (level != null) 'level': level,
      if (school != null) 'school': school,
      if (castingTime != null) 'casting_time': castingTime,
      if (rangeText != null) 'range_text': rangeText,
      if (durationText != null) 'duration_text': durationText,
      if (requiresConcentration != null)
        'requires_concentration': requiresConcentration,
      if (isRitual != null) 'is_ritual': isRitual,
      if (componentsJson != null) 'components_json': componentsJson,
      if (description != null) 'description': description,
      if (higherLevelsDescription != null)
        'higher_levels_description': higherLevelsDescription,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SpellDefinitionsCompanion copyWith({
    Value<String>? id,
    Value<String>? key,
    Value<String>? name,
    Value<int>? level,
    Value<String>? school,
    Value<String?>? castingTime,
    Value<String?>? rangeText,
    Value<String?>? durationText,
    Value<bool>? requiresConcentration,
    Value<bool>? isRitual,
    Value<String?>? componentsJson,
    Value<String?>? description,
    Value<String?>? higherLevelsDescription,
    Value<int>? rowid,
  }) {
    return SpellDefinitionsCompanion(
      id: id ?? this.id,
      key: key ?? this.key,
      name: name ?? this.name,
      level: level ?? this.level,
      school: school ?? this.school,
      castingTime: castingTime ?? this.castingTime,
      rangeText: rangeText ?? this.rangeText,
      durationText: durationText ?? this.durationText,
      requiresConcentration:
          requiresConcentration ?? this.requiresConcentration,
      isRitual: isRitual ?? this.isRitual,
      componentsJson: componentsJson ?? this.componentsJson,
      description: description ?? this.description,
      higherLevelsDescription:
          higherLevelsDescription ?? this.higherLevelsDescription,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (school.present) {
      map['school'] = Variable<String>(school.value);
    }
    if (castingTime.present) {
      map['casting_time'] = Variable<String>(castingTime.value);
    }
    if (rangeText.present) {
      map['range_text'] = Variable<String>(rangeText.value);
    }
    if (durationText.present) {
      map['duration_text'] = Variable<String>(durationText.value);
    }
    if (requiresConcentration.present) {
      map['requires_concentration'] = Variable<bool>(
        requiresConcentration.value,
      );
    }
    if (isRitual.present) {
      map['is_ritual'] = Variable<bool>(isRitual.value);
    }
    if (componentsJson.present) {
      map['components_json'] = Variable<String>(componentsJson.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (higherLevelsDescription.present) {
      map['higher_levels_description'] = Variable<String>(
        higherLevelsDescription.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SpellDefinitionsCompanion(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('name: $name, ')
          ..write('level: $level, ')
          ..write('school: $school, ')
          ..write('castingTime: $castingTime, ')
          ..write('rangeText: $rangeText, ')
          ..write('durationText: $durationText, ')
          ..write('requiresConcentration: $requiresConcentration, ')
          ..write('isRitual: $isRitual, ')
          ..write('componentsJson: $componentsJson, ')
          ..write('description: $description, ')
          ..write('higherLevelsDescription: $higherLevelsDescription, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CharactersTable characters = $CharactersTable(this);
  late final $CharacterAbilityScoresTable characterAbilityScores =
      $CharacterAbilityScoresTable(this);
  late final $CharacterAbilityScoreProvenancesTable
  characterAbilityScoreProvenances = $CharacterAbilityScoreProvenancesTable(
    this,
  );
  late final $CharacterHitPointsTable characterHitPoints =
      $CharacterHitPointsTable(this);
  late final $CharacterFinishingDetailsTable characterFinishingDetails =
      $CharacterFinishingDetailsTable(this);
  late final $CharacterNarrativeSelectionsTable characterNarrativeSelections =
      $CharacterNarrativeSelectionsTable(this);
  late final $CharacterEquipmentLoadoutsTable characterEquipmentLoadouts =
      $CharacterEquipmentLoadoutsTable(this);
  late final $CharacterSpellSelectionsTable characterSpellSelections =
      $CharacterSpellSelectionsTable(this);
  late final $CharacterSpellSlotUsagesTable characterSpellSlotUsages =
      $CharacterSpellSlotUsagesTable(this);
  late final $SkillDefinitionsTable skillDefinitions = $SkillDefinitionsTable(
    this,
  );
  late final $CharacterSkillsTable characterSkills = $CharacterSkillsTable(
    this,
  );
  late final $CharacterSavingThrowsTable characterSavingThrows =
      $CharacterSavingThrowsTable(this);
  late final $EquipmentDefinitionsTable equipmentDefinitions =
      $EquipmentDefinitionsTable(this);
  late final $TrinketDefinitionsTable trinketDefinitions =
      $TrinketDefinitionsTable(this);
  late final $CharacterInventoryTable characterInventory =
      $CharacterInventoryTable(this);
  late final $CharacterProficienciesTable characterProficiencies =
      $CharacterProficienciesTable(this);
  late final $CharacterCurrencyTable characterCurrency =
      $CharacterCurrencyTable(this);
  late final $ClassDefinitionsTable classDefinitions = $ClassDefinitionsTable(
    this,
  );
  late final $CharacterAdvancementDefinitionsTable
  characterAdvancementDefinitions = $CharacterAdvancementDefinitionsTable(this);
  late final $ClassStandardArrayRecommendationsTable
  classStandardArrayRecommendations = $ClassStandardArrayRecommendationsTable(
    this,
  );
  late final $NarrativeOptionGroupsTable narrativeOptionGroups =
      $NarrativeOptionGroupsTable(this);
  late final $NarrativeOptionsTable narrativeOptions = $NarrativeOptionsTable(
    this,
  );
  late final $CompendiumPackStatesTable compendiumPackStates =
      $CompendiumPackStatesTable(this);
  late final $ImportedCompendiumPacksTable importedCompendiumPacks =
      $ImportedCompendiumPacksTable(this);
  late final $BackgroundDefinitionsTable backgroundDefinitions =
      $BackgroundDefinitionsTable(this);
  late final $SpellDefinitionsTable spellDefinitions = $SpellDefinitionsTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    characters,
    characterAbilityScores,
    characterAbilityScoreProvenances,
    characterHitPoints,
    characterFinishingDetails,
    characterNarrativeSelections,
    characterEquipmentLoadouts,
    characterSpellSelections,
    characterSpellSlotUsages,
    skillDefinitions,
    characterSkills,
    characterSavingThrows,
    equipmentDefinitions,
    trinketDefinitions,
    characterInventory,
    characterProficiencies,
    characterCurrency,
    classDefinitions,
    characterAdvancementDefinitions,
    classStandardArrayRecommendations,
    narrativeOptionGroups,
    narrativeOptions,
    compendiumPackStates,
    importedCompendiumPacks,
    backgroundDefinitions,
    spellDefinitions,
  ];
}

typedef $$CharactersTableCreateCompanionBuilder =
    CharactersCompanion Function({
      required String id,
      required String name,
      required String raceName,
      Value<String?> classDefinitionId,
      Value<String?> backgroundDefinitionRefId,
      required String className,
      required int level,
      Value<int?> experience,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$CharactersTableUpdateCompanionBuilder =
    CharactersCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> raceName,
      Value<String?> classDefinitionId,
      Value<String?> backgroundDefinitionRefId,
      Value<String> className,
      Value<int> level,
      Value<int?> experience,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$CharactersTableReferences
    extends BaseReferences<_$AppDatabase, $CharactersTable, Character> {
  $$CharactersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $CharacterAbilityScoresTable,
    List<CharacterAbilityScore>
  >
  _characterAbilityScoresRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.characterAbilityScores,
        aliasName: $_aliasNameGenerator(
          db.characters.id,
          db.characterAbilityScores.characterId,
        ),
      );

  $$CharacterAbilityScoresTableProcessedTableManager
  get characterAbilityScoresRefs {
    final manager = $$CharacterAbilityScoresTableTableManager(
      $_db,
      $_db.characterAbilityScores,
    ).filter((f) => f.characterId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _characterAbilityScoresRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $CharacterAbilityScoreProvenancesTable,
    List<CharacterAbilityScoreProvenance>
  >
  _characterAbilityScoreProvenancesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.characterAbilityScoreProvenances,
        aliasName: $_aliasNameGenerator(
          db.characters.id,
          db.characterAbilityScoreProvenances.characterId,
        ),
      );

  $$CharacterAbilityScoreProvenancesTableProcessedTableManager
  get characterAbilityScoreProvenancesRefs {
    final manager = $$CharacterAbilityScoreProvenancesTableTableManager(
      $_db,
      $_db.characterAbilityScoreProvenances,
    ).filter((f) => f.characterId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _characterAbilityScoreProvenancesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CharacterHitPointsTable, List<CharacterHitPoint>>
  _characterHitPointsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.characterHitPoints,
        aliasName: $_aliasNameGenerator(
          db.characters.id,
          db.characterHitPoints.characterId,
        ),
      );

  $$CharacterHitPointsTableProcessedTableManager get characterHitPointsRefs {
    final manager = $$CharacterHitPointsTableTableManager(
      $_db,
      $_db.characterHitPoints,
    ).filter((f) => f.characterId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _characterHitPointsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $CharacterFinishingDetailsTable,
    List<CharacterFinishingDetail>
  >
  _characterFinishingDetailsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.characterFinishingDetails,
        aliasName: $_aliasNameGenerator(
          db.characters.id,
          db.characterFinishingDetails.characterId,
        ),
      );

  $$CharacterFinishingDetailsTableProcessedTableManager
  get characterFinishingDetailsRefs {
    final manager = $$CharacterFinishingDetailsTableTableManager(
      $_db,
      $_db.characterFinishingDetails,
    ).filter((f) => f.characterId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _characterFinishingDetailsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $CharacterNarrativeSelectionsTable,
    List<CharacterNarrativeSelection>
  >
  _characterNarrativeSelectionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.characterNarrativeSelections,
        aliasName: $_aliasNameGenerator(
          db.characters.id,
          db.characterNarrativeSelections.characterId,
        ),
      );

  $$CharacterNarrativeSelectionsTableProcessedTableManager
  get characterNarrativeSelectionsRefs {
    final manager = $$CharacterNarrativeSelectionsTableTableManager(
      $_db,
      $_db.characterNarrativeSelections,
    ).filter((f) => f.characterId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _characterNarrativeSelectionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $CharacterEquipmentLoadoutsTable,
    List<CharacterEquipmentLoadout>
  >
  _characterEquipmentLoadoutsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.characterEquipmentLoadouts,
        aliasName: $_aliasNameGenerator(
          db.characters.id,
          db.characterEquipmentLoadouts.characterId,
        ),
      );

  $$CharacterEquipmentLoadoutsTableProcessedTableManager
  get characterEquipmentLoadoutsRefs {
    final manager = $$CharacterEquipmentLoadoutsTableTableManager(
      $_db,
      $_db.characterEquipmentLoadouts,
    ).filter((f) => f.characterId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _characterEquipmentLoadoutsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $CharacterSpellSelectionsTable,
    List<CharacterSpellSelection>
  >
  _characterSpellSelectionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.characterSpellSelections,
        aliasName: $_aliasNameGenerator(
          db.characters.id,
          db.characterSpellSelections.characterId,
        ),
      );

  $$CharacterSpellSelectionsTableProcessedTableManager
  get characterSpellSelectionsRefs {
    final manager = $$CharacterSpellSelectionsTableTableManager(
      $_db,
      $_db.characterSpellSelections,
    ).filter((f) => f.characterId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _characterSpellSelectionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $CharacterSpellSlotUsagesTable,
    List<CharacterSpellSlotUsage>
  >
  _characterSpellSlotUsagesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.characterSpellSlotUsages,
        aliasName: $_aliasNameGenerator(
          db.characters.id,
          db.characterSpellSlotUsages.characterId,
        ),
      );

  $$CharacterSpellSlotUsagesTableProcessedTableManager
  get characterSpellSlotUsagesRefs {
    final manager = $$CharacterSpellSlotUsagesTableTableManager(
      $_db,
      $_db.characterSpellSlotUsages,
    ).filter((f) => f.characterId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _characterSpellSlotUsagesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CharacterSkillsTable, List<CharacterSkill>>
  _characterSkillsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.characterSkills,
    aliasName: $_aliasNameGenerator(
      db.characters.id,
      db.characterSkills.characterId,
    ),
  );

  $$CharacterSkillsTableProcessedTableManager get characterSkillsRefs {
    final manager = $$CharacterSkillsTableTableManager(
      $_db,
      $_db.characterSkills,
    ).filter((f) => f.characterId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _characterSkillsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $CharacterSavingThrowsTable,
    List<CharacterSavingThrow>
  >
  _characterSavingThrowsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.characterSavingThrows,
        aliasName: $_aliasNameGenerator(
          db.characters.id,
          db.characterSavingThrows.characterId,
        ),
      );

  $$CharacterSavingThrowsTableProcessedTableManager
  get characterSavingThrowsRefs {
    final manager = $$CharacterSavingThrowsTableTableManager(
      $_db,
      $_db.characterSavingThrows,
    ).filter((f) => f.characterId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _characterSavingThrowsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $CharacterInventoryTable,
    List<CharacterInventoryData>
  >
  _characterInventoryRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.characterInventory,
        aliasName: $_aliasNameGenerator(
          db.characters.id,
          db.characterInventory.characterId,
        ),
      );

  $$CharacterInventoryTableProcessedTableManager get characterInventoryRefs {
    final manager = $$CharacterInventoryTableTableManager(
      $_db,
      $_db.characterInventory,
    ).filter((f) => f.characterId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _characterInventoryRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $CharacterProficienciesTable,
    List<CharacterProficiency>
  >
  _characterProficienciesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.characterProficiencies,
        aliasName: $_aliasNameGenerator(
          db.characters.id,
          db.characterProficiencies.characterId,
        ),
      );

  $$CharacterProficienciesTableProcessedTableManager
  get characterProficienciesRefs {
    final manager = $$CharacterProficienciesTableTableManager(
      $_db,
      $_db.characterProficiencies,
    ).filter((f) => f.characterId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _characterProficienciesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $CharacterCurrencyTable,
    List<CharacterCurrencyData>
  >
  _characterCurrencyRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.characterCurrency,
        aliasName: $_aliasNameGenerator(
          db.characters.id,
          db.characterCurrency.characterId,
        ),
      );

  $$CharacterCurrencyTableProcessedTableManager get characterCurrencyRefs {
    final manager = $$CharacterCurrencyTableTableManager(
      $_db,
      $_db.characterCurrency,
    ).filter((f) => f.characterId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _characterCurrencyRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CharactersTableFilterComposer
    extends Composer<_$AppDatabase, $CharactersTable> {
  $$CharactersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get raceName => $composableBuilder(
    column: $table.raceName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get classDefinitionId => $composableBuilder(
    column: $table.classDefinitionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get backgroundDefinitionRefId => $composableBuilder(
    column: $table.backgroundDefinitionRefId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get className => $composableBuilder(
    column: $table.className,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get experience => $composableBuilder(
    column: $table.experience,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> characterAbilityScoresRefs(
    Expression<bool> Function($$CharacterAbilityScoresTableFilterComposer f) f,
  ) {
    final $$CharacterAbilityScoresTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.characterAbilityScores,
          getReferencedColumn: (t) => t.characterId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CharacterAbilityScoresTableFilterComposer(
                $db: $db,
                $table: $db.characterAbilityScores,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> characterAbilityScoreProvenancesRefs(
    Expression<bool> Function(
      $$CharacterAbilityScoreProvenancesTableFilterComposer f,
    )
    f,
  ) {
    final $$CharacterAbilityScoreProvenancesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.characterAbilityScoreProvenances,
          getReferencedColumn: (t) => t.characterId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CharacterAbilityScoreProvenancesTableFilterComposer(
                $db: $db,
                $table: $db.characterAbilityScoreProvenances,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> characterHitPointsRefs(
    Expression<bool> Function($$CharacterHitPointsTableFilterComposer f) f,
  ) {
    final $$CharacterHitPointsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.characterHitPoints,
      getReferencedColumn: (t) => t.characterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharacterHitPointsTableFilterComposer(
            $db: $db,
            $table: $db.characterHitPoints,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> characterFinishingDetailsRefs(
    Expression<bool> Function($$CharacterFinishingDetailsTableFilterComposer f)
    f,
  ) {
    final $$CharacterFinishingDetailsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.characterFinishingDetails,
          getReferencedColumn: (t) => t.characterId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CharacterFinishingDetailsTableFilterComposer(
                $db: $db,
                $table: $db.characterFinishingDetails,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> characterNarrativeSelectionsRefs(
    Expression<bool> Function(
      $$CharacterNarrativeSelectionsTableFilterComposer f,
    )
    f,
  ) {
    final $$CharacterNarrativeSelectionsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.characterNarrativeSelections,
          getReferencedColumn: (t) => t.characterId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CharacterNarrativeSelectionsTableFilterComposer(
                $db: $db,
                $table: $db.characterNarrativeSelections,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> characterEquipmentLoadoutsRefs(
    Expression<bool> Function($$CharacterEquipmentLoadoutsTableFilterComposer f)
    f,
  ) {
    final $$CharacterEquipmentLoadoutsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.characterEquipmentLoadouts,
          getReferencedColumn: (t) => t.characterId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CharacterEquipmentLoadoutsTableFilterComposer(
                $db: $db,
                $table: $db.characterEquipmentLoadouts,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> characterSpellSelectionsRefs(
    Expression<bool> Function($$CharacterSpellSelectionsTableFilterComposer f)
    f,
  ) {
    final $$CharacterSpellSelectionsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.characterSpellSelections,
          getReferencedColumn: (t) => t.characterId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CharacterSpellSelectionsTableFilterComposer(
                $db: $db,
                $table: $db.characterSpellSelections,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> characterSpellSlotUsagesRefs(
    Expression<bool> Function($$CharacterSpellSlotUsagesTableFilterComposer f)
    f,
  ) {
    final $$CharacterSpellSlotUsagesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.characterSpellSlotUsages,
          getReferencedColumn: (t) => t.characterId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CharacterSpellSlotUsagesTableFilterComposer(
                $db: $db,
                $table: $db.characterSpellSlotUsages,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> characterSkillsRefs(
    Expression<bool> Function($$CharacterSkillsTableFilterComposer f) f,
  ) {
    final $$CharacterSkillsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.characterSkills,
      getReferencedColumn: (t) => t.characterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharacterSkillsTableFilterComposer(
            $db: $db,
            $table: $db.characterSkills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> characterSavingThrowsRefs(
    Expression<bool> Function($$CharacterSavingThrowsTableFilterComposer f) f,
  ) {
    final $$CharacterSavingThrowsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.characterSavingThrows,
          getReferencedColumn: (t) => t.characterId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CharacterSavingThrowsTableFilterComposer(
                $db: $db,
                $table: $db.characterSavingThrows,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> characterInventoryRefs(
    Expression<bool> Function($$CharacterInventoryTableFilterComposer f) f,
  ) {
    final $$CharacterInventoryTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.characterInventory,
      getReferencedColumn: (t) => t.characterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharacterInventoryTableFilterComposer(
            $db: $db,
            $table: $db.characterInventory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> characterProficienciesRefs(
    Expression<bool> Function($$CharacterProficienciesTableFilterComposer f) f,
  ) {
    final $$CharacterProficienciesTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.characterProficiencies,
          getReferencedColumn: (t) => t.characterId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CharacterProficienciesTableFilterComposer(
                $db: $db,
                $table: $db.characterProficiencies,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> characterCurrencyRefs(
    Expression<bool> Function($$CharacterCurrencyTableFilterComposer f) f,
  ) {
    final $$CharacterCurrencyTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.characterCurrency,
      getReferencedColumn: (t) => t.characterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharacterCurrencyTableFilterComposer(
            $db: $db,
            $table: $db.characterCurrency,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CharactersTableOrderingComposer
    extends Composer<_$AppDatabase, $CharactersTable> {
  $$CharactersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get raceName => $composableBuilder(
    column: $table.raceName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get classDefinitionId => $composableBuilder(
    column: $table.classDefinitionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get backgroundDefinitionRefId => $composableBuilder(
    column: $table.backgroundDefinitionRefId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get className => $composableBuilder(
    column: $table.className,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get experience => $composableBuilder(
    column: $table.experience,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CharactersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CharactersTable> {
  $$CharactersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get raceName =>
      $composableBuilder(column: $table.raceName, builder: (column) => column);

  GeneratedColumn<String> get classDefinitionId => $composableBuilder(
    column: $table.classDefinitionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get backgroundDefinitionRefId => $composableBuilder(
    column: $table.backgroundDefinitionRefId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get className =>
      $composableBuilder(column: $table.className, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get experience => $composableBuilder(
    column: $table.experience,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> characterAbilityScoresRefs<T extends Object>(
    Expression<T> Function($$CharacterAbilityScoresTableAnnotationComposer a) f,
  ) {
    final $$CharacterAbilityScoresTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.characterAbilityScores,
          getReferencedColumn: (t) => t.characterId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CharacterAbilityScoresTableAnnotationComposer(
                $db: $db,
                $table: $db.characterAbilityScores,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> characterAbilityScoreProvenancesRefs<T extends Object>(
    Expression<T> Function(
      $$CharacterAbilityScoreProvenancesTableAnnotationComposer a,
    )
    f,
  ) {
    final $$CharacterAbilityScoreProvenancesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.characterAbilityScoreProvenances,
          getReferencedColumn: (t) => t.characterId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CharacterAbilityScoreProvenancesTableAnnotationComposer(
                $db: $db,
                $table: $db.characterAbilityScoreProvenances,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> characterHitPointsRefs<T extends Object>(
    Expression<T> Function($$CharacterHitPointsTableAnnotationComposer a) f,
  ) {
    final $$CharacterHitPointsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.characterHitPoints,
          getReferencedColumn: (t) => t.characterId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CharacterHitPointsTableAnnotationComposer(
                $db: $db,
                $table: $db.characterHitPoints,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> characterFinishingDetailsRefs<T extends Object>(
    Expression<T> Function($$CharacterFinishingDetailsTableAnnotationComposer a)
    f,
  ) {
    final $$CharacterFinishingDetailsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.characterFinishingDetails,
          getReferencedColumn: (t) => t.characterId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CharacterFinishingDetailsTableAnnotationComposer(
                $db: $db,
                $table: $db.characterFinishingDetails,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> characterNarrativeSelectionsRefs<T extends Object>(
    Expression<T> Function(
      $$CharacterNarrativeSelectionsTableAnnotationComposer a,
    )
    f,
  ) {
    final $$CharacterNarrativeSelectionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.characterNarrativeSelections,
          getReferencedColumn: (t) => t.characterId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CharacterNarrativeSelectionsTableAnnotationComposer(
                $db: $db,
                $table: $db.characterNarrativeSelections,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> characterEquipmentLoadoutsRefs<T extends Object>(
    Expression<T> Function(
      $$CharacterEquipmentLoadoutsTableAnnotationComposer a,
    )
    f,
  ) {
    final $$CharacterEquipmentLoadoutsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.characterEquipmentLoadouts,
          getReferencedColumn: (t) => t.characterId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CharacterEquipmentLoadoutsTableAnnotationComposer(
                $db: $db,
                $table: $db.characterEquipmentLoadouts,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> characterSpellSelectionsRefs<T extends Object>(
    Expression<T> Function($$CharacterSpellSelectionsTableAnnotationComposer a)
    f,
  ) {
    final $$CharacterSpellSelectionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.characterSpellSelections,
          getReferencedColumn: (t) => t.characterId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CharacterSpellSelectionsTableAnnotationComposer(
                $db: $db,
                $table: $db.characterSpellSelections,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> characterSpellSlotUsagesRefs<T extends Object>(
    Expression<T> Function($$CharacterSpellSlotUsagesTableAnnotationComposer a)
    f,
  ) {
    final $$CharacterSpellSlotUsagesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.characterSpellSlotUsages,
          getReferencedColumn: (t) => t.characterId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CharacterSpellSlotUsagesTableAnnotationComposer(
                $db: $db,
                $table: $db.characterSpellSlotUsages,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> characterSkillsRefs<T extends Object>(
    Expression<T> Function($$CharacterSkillsTableAnnotationComposer a) f,
  ) {
    final $$CharacterSkillsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.characterSkills,
      getReferencedColumn: (t) => t.characterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharacterSkillsTableAnnotationComposer(
            $db: $db,
            $table: $db.characterSkills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> characterSavingThrowsRefs<T extends Object>(
    Expression<T> Function($$CharacterSavingThrowsTableAnnotationComposer a) f,
  ) {
    final $$CharacterSavingThrowsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.characterSavingThrows,
          getReferencedColumn: (t) => t.characterId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CharacterSavingThrowsTableAnnotationComposer(
                $db: $db,
                $table: $db.characterSavingThrows,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> characterInventoryRefs<T extends Object>(
    Expression<T> Function($$CharacterInventoryTableAnnotationComposer a) f,
  ) {
    final $$CharacterInventoryTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.characterInventory,
          getReferencedColumn: (t) => t.characterId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CharacterInventoryTableAnnotationComposer(
                $db: $db,
                $table: $db.characterInventory,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> characterProficienciesRefs<T extends Object>(
    Expression<T> Function($$CharacterProficienciesTableAnnotationComposer a) f,
  ) {
    final $$CharacterProficienciesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.characterProficiencies,
          getReferencedColumn: (t) => t.characterId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CharacterProficienciesTableAnnotationComposer(
                $db: $db,
                $table: $db.characterProficiencies,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> characterCurrencyRefs<T extends Object>(
    Expression<T> Function($$CharacterCurrencyTableAnnotationComposer a) f,
  ) {
    final $$CharacterCurrencyTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.characterCurrency,
          getReferencedColumn: (t) => t.characterId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CharacterCurrencyTableAnnotationComposer(
                $db: $db,
                $table: $db.characterCurrency,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$CharactersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CharactersTable,
          Character,
          $$CharactersTableFilterComposer,
          $$CharactersTableOrderingComposer,
          $$CharactersTableAnnotationComposer,
          $$CharactersTableCreateCompanionBuilder,
          $$CharactersTableUpdateCompanionBuilder,
          (Character, $$CharactersTableReferences),
          Character,
          PrefetchHooks Function({
            bool characterAbilityScoresRefs,
            bool characterAbilityScoreProvenancesRefs,
            bool characterHitPointsRefs,
            bool characterFinishingDetailsRefs,
            bool characterNarrativeSelectionsRefs,
            bool characterEquipmentLoadoutsRefs,
            bool characterSpellSelectionsRefs,
            bool characterSpellSlotUsagesRefs,
            bool characterSkillsRefs,
            bool characterSavingThrowsRefs,
            bool characterInventoryRefs,
            bool characterProficienciesRefs,
            bool characterCurrencyRefs,
          })
        > {
  $$CharactersTableTableManager(_$AppDatabase db, $CharactersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CharactersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CharactersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CharactersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> raceName = const Value.absent(),
                Value<String?> classDefinitionId = const Value.absent(),
                Value<String?> backgroundDefinitionRefId = const Value.absent(),
                Value<String> className = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int?> experience = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CharactersCompanion(
                id: id,
                name: name,
                raceName: raceName,
                classDefinitionId: classDefinitionId,
                backgroundDefinitionRefId: backgroundDefinitionRefId,
                className: className,
                level: level,
                experience: experience,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String raceName,
                Value<String?> classDefinitionId = const Value.absent(),
                Value<String?> backgroundDefinitionRefId = const Value.absent(),
                required String className,
                required int level,
                Value<int?> experience = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => CharactersCompanion.insert(
                id: id,
                name: name,
                raceName: raceName,
                classDefinitionId: classDefinitionId,
                backgroundDefinitionRefId: backgroundDefinitionRefId,
                className: className,
                level: level,
                experience: experience,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CharactersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                characterAbilityScoresRefs = false,
                characterAbilityScoreProvenancesRefs = false,
                characterHitPointsRefs = false,
                characterFinishingDetailsRefs = false,
                characterNarrativeSelectionsRefs = false,
                characterEquipmentLoadoutsRefs = false,
                characterSpellSelectionsRefs = false,
                characterSpellSlotUsagesRefs = false,
                characterSkillsRefs = false,
                characterSavingThrowsRefs = false,
                characterInventoryRefs = false,
                characterProficienciesRefs = false,
                characterCurrencyRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (characterAbilityScoresRefs) db.characterAbilityScores,
                    if (characterAbilityScoreProvenancesRefs)
                      db.characterAbilityScoreProvenances,
                    if (characterHitPointsRefs) db.characterHitPoints,
                    if (characterFinishingDetailsRefs)
                      db.characterFinishingDetails,
                    if (characterNarrativeSelectionsRefs)
                      db.characterNarrativeSelections,
                    if (characterEquipmentLoadoutsRefs)
                      db.characterEquipmentLoadouts,
                    if (characterSpellSelectionsRefs)
                      db.characterSpellSelections,
                    if (characterSpellSlotUsagesRefs)
                      db.characterSpellSlotUsages,
                    if (characterSkillsRefs) db.characterSkills,
                    if (characterSavingThrowsRefs) db.characterSavingThrows,
                    if (characterInventoryRefs) db.characterInventory,
                    if (characterProficienciesRefs) db.characterProficiencies,
                    if (characterCurrencyRefs) db.characterCurrency,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (characterAbilityScoresRefs)
                        await $_getPrefetchedData<
                          Character,
                          $CharactersTable,
                          CharacterAbilityScore
                        >(
                          currentTable: table,
                          referencedTable: $$CharactersTableReferences
                              ._characterAbilityScoresRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CharactersTableReferences(
                                db,
                                table,
                                p0,
                              ).characterAbilityScoresRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.characterId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (characterAbilityScoreProvenancesRefs)
                        await $_getPrefetchedData<
                          Character,
                          $CharactersTable,
                          CharacterAbilityScoreProvenance
                        >(
                          currentTable: table,
                          referencedTable: $$CharactersTableReferences
                              ._characterAbilityScoreProvenancesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CharactersTableReferences(
                                db,
                                table,
                                p0,
                              ).characterAbilityScoreProvenancesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.characterId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (characterHitPointsRefs)
                        await $_getPrefetchedData<
                          Character,
                          $CharactersTable,
                          CharacterHitPoint
                        >(
                          currentTable: table,
                          referencedTable: $$CharactersTableReferences
                              ._characterHitPointsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CharactersTableReferences(
                                db,
                                table,
                                p0,
                              ).characterHitPointsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.characterId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (characterFinishingDetailsRefs)
                        await $_getPrefetchedData<
                          Character,
                          $CharactersTable,
                          CharacterFinishingDetail
                        >(
                          currentTable: table,
                          referencedTable: $$CharactersTableReferences
                              ._characterFinishingDetailsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CharactersTableReferences(
                                db,
                                table,
                                p0,
                              ).characterFinishingDetailsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.characterId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (characterNarrativeSelectionsRefs)
                        await $_getPrefetchedData<
                          Character,
                          $CharactersTable,
                          CharacterNarrativeSelection
                        >(
                          currentTable: table,
                          referencedTable: $$CharactersTableReferences
                              ._characterNarrativeSelectionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CharactersTableReferences(
                                db,
                                table,
                                p0,
                              ).characterNarrativeSelectionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.characterId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (characterEquipmentLoadoutsRefs)
                        await $_getPrefetchedData<
                          Character,
                          $CharactersTable,
                          CharacterEquipmentLoadout
                        >(
                          currentTable: table,
                          referencedTable: $$CharactersTableReferences
                              ._characterEquipmentLoadoutsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CharactersTableReferences(
                                db,
                                table,
                                p0,
                              ).characterEquipmentLoadoutsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.characterId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (characterSpellSelectionsRefs)
                        await $_getPrefetchedData<
                          Character,
                          $CharactersTable,
                          CharacterSpellSelection
                        >(
                          currentTable: table,
                          referencedTable: $$CharactersTableReferences
                              ._characterSpellSelectionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CharactersTableReferences(
                                db,
                                table,
                                p0,
                              ).characterSpellSelectionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.characterId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (characterSpellSlotUsagesRefs)
                        await $_getPrefetchedData<
                          Character,
                          $CharactersTable,
                          CharacterSpellSlotUsage
                        >(
                          currentTable: table,
                          referencedTable: $$CharactersTableReferences
                              ._characterSpellSlotUsagesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CharactersTableReferences(
                                db,
                                table,
                                p0,
                              ).characterSpellSlotUsagesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.characterId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (characterSkillsRefs)
                        await $_getPrefetchedData<
                          Character,
                          $CharactersTable,
                          CharacterSkill
                        >(
                          currentTable: table,
                          referencedTable: $$CharactersTableReferences
                              ._characterSkillsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CharactersTableReferences(
                                db,
                                table,
                                p0,
                              ).characterSkillsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.characterId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (characterSavingThrowsRefs)
                        await $_getPrefetchedData<
                          Character,
                          $CharactersTable,
                          CharacterSavingThrow
                        >(
                          currentTable: table,
                          referencedTable: $$CharactersTableReferences
                              ._characterSavingThrowsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CharactersTableReferences(
                                db,
                                table,
                                p0,
                              ).characterSavingThrowsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.characterId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (characterInventoryRefs)
                        await $_getPrefetchedData<
                          Character,
                          $CharactersTable,
                          CharacterInventoryData
                        >(
                          currentTable: table,
                          referencedTable: $$CharactersTableReferences
                              ._characterInventoryRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CharactersTableReferences(
                                db,
                                table,
                                p0,
                              ).characterInventoryRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.characterId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (characterProficienciesRefs)
                        await $_getPrefetchedData<
                          Character,
                          $CharactersTable,
                          CharacterProficiency
                        >(
                          currentTable: table,
                          referencedTable: $$CharactersTableReferences
                              ._characterProficienciesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CharactersTableReferences(
                                db,
                                table,
                                p0,
                              ).characterProficienciesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.characterId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (characterCurrencyRefs)
                        await $_getPrefetchedData<
                          Character,
                          $CharactersTable,
                          CharacterCurrencyData
                        >(
                          currentTable: table,
                          referencedTable: $$CharactersTableReferences
                              ._characterCurrencyRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CharactersTableReferences(
                                db,
                                table,
                                p0,
                              ).characterCurrencyRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.characterId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$CharactersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CharactersTable,
      Character,
      $$CharactersTableFilterComposer,
      $$CharactersTableOrderingComposer,
      $$CharactersTableAnnotationComposer,
      $$CharactersTableCreateCompanionBuilder,
      $$CharactersTableUpdateCompanionBuilder,
      (Character, $$CharactersTableReferences),
      Character,
      PrefetchHooks Function({
        bool characterAbilityScoresRefs,
        bool characterAbilityScoreProvenancesRefs,
        bool characterHitPointsRefs,
        bool characterFinishingDetailsRefs,
        bool characterNarrativeSelectionsRefs,
        bool characterEquipmentLoadoutsRefs,
        bool characterSpellSelectionsRefs,
        bool characterSpellSlotUsagesRefs,
        bool characterSkillsRefs,
        bool characterSavingThrowsRefs,
        bool characterInventoryRefs,
        bool characterProficienciesRefs,
        bool characterCurrencyRefs,
      })
    >;
typedef $$CharacterAbilityScoresTableCreateCompanionBuilder =
    CharacterAbilityScoresCompanion Function({
      required String characterId,
      required int strengthScore,
      required int dexterityScore,
      required int constitutionScore,
      required int intelligenceScore,
      required int wisdomScore,
      required int charismaScore,
      Value<int?> strengthModifier,
      Value<int?> dexterityModifier,
      Value<int?> constitutionModifier,
      Value<int?> intelligenceModifier,
      Value<int?> wisdomModifier,
      Value<int?> charismaModifier,
      Value<int> rowid,
    });
typedef $$CharacterAbilityScoresTableUpdateCompanionBuilder =
    CharacterAbilityScoresCompanion Function({
      Value<String> characterId,
      Value<int> strengthScore,
      Value<int> dexterityScore,
      Value<int> constitutionScore,
      Value<int> intelligenceScore,
      Value<int> wisdomScore,
      Value<int> charismaScore,
      Value<int?> strengthModifier,
      Value<int?> dexterityModifier,
      Value<int?> constitutionModifier,
      Value<int?> intelligenceModifier,
      Value<int?> wisdomModifier,
      Value<int?> charismaModifier,
      Value<int> rowid,
    });

final class $$CharacterAbilityScoresTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CharacterAbilityScoresTable,
          CharacterAbilityScore
        > {
  $$CharacterAbilityScoresTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CharactersTable _characterIdTable(_$AppDatabase db) =>
      db.characters.createAlias(
        $_aliasNameGenerator(
          db.characterAbilityScores.characterId,
          db.characters.id,
        ),
      );

  $$CharactersTableProcessedTableManager get characterId {
    final $_column = $_itemColumn<String>('character_id')!;

    final manager = $$CharactersTableTableManager(
      $_db,
      $_db.characters,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_characterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CharacterAbilityScoresTableFilterComposer
    extends Composer<_$AppDatabase, $CharacterAbilityScoresTable> {
  $$CharacterAbilityScoresTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get strengthScore => $composableBuilder(
    column: $table.strengthScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dexterityScore => $composableBuilder(
    column: $table.dexterityScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get constitutionScore => $composableBuilder(
    column: $table.constitutionScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intelligenceScore => $composableBuilder(
    column: $table.intelligenceScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wisdomScore => $composableBuilder(
    column: $table.wisdomScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get charismaScore => $composableBuilder(
    column: $table.charismaScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get strengthModifier => $composableBuilder(
    column: $table.strengthModifier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dexterityModifier => $composableBuilder(
    column: $table.dexterityModifier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get constitutionModifier => $composableBuilder(
    column: $table.constitutionModifier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intelligenceModifier => $composableBuilder(
    column: $table.intelligenceModifier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wisdomModifier => $composableBuilder(
    column: $table.wisdomModifier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get charismaModifier => $composableBuilder(
    column: $table.charismaModifier,
    builder: (column) => ColumnFilters(column),
  );

  $$CharactersTableFilterComposer get characterId {
    final $$CharactersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableFilterComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CharacterAbilityScoresTableOrderingComposer
    extends Composer<_$AppDatabase, $CharacterAbilityScoresTable> {
  $$CharacterAbilityScoresTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get strengthScore => $composableBuilder(
    column: $table.strengthScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dexterityScore => $composableBuilder(
    column: $table.dexterityScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get constitutionScore => $composableBuilder(
    column: $table.constitutionScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intelligenceScore => $composableBuilder(
    column: $table.intelligenceScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wisdomScore => $composableBuilder(
    column: $table.wisdomScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get charismaScore => $composableBuilder(
    column: $table.charismaScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get strengthModifier => $composableBuilder(
    column: $table.strengthModifier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dexterityModifier => $composableBuilder(
    column: $table.dexterityModifier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get constitutionModifier => $composableBuilder(
    column: $table.constitutionModifier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intelligenceModifier => $composableBuilder(
    column: $table.intelligenceModifier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wisdomModifier => $composableBuilder(
    column: $table.wisdomModifier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get charismaModifier => $composableBuilder(
    column: $table.charismaModifier,
    builder: (column) => ColumnOrderings(column),
  );

  $$CharactersTableOrderingComposer get characterId {
    final $$CharactersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableOrderingComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CharacterAbilityScoresTableAnnotationComposer
    extends Composer<_$AppDatabase, $CharacterAbilityScoresTable> {
  $$CharacterAbilityScoresTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get strengthScore => $composableBuilder(
    column: $table.strengthScore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dexterityScore => $composableBuilder(
    column: $table.dexterityScore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get constitutionScore => $composableBuilder(
    column: $table.constitutionScore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get intelligenceScore => $composableBuilder(
    column: $table.intelligenceScore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get wisdomScore => $composableBuilder(
    column: $table.wisdomScore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get charismaScore => $composableBuilder(
    column: $table.charismaScore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get strengthModifier => $composableBuilder(
    column: $table.strengthModifier,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dexterityModifier => $composableBuilder(
    column: $table.dexterityModifier,
    builder: (column) => column,
  );

  GeneratedColumn<int> get constitutionModifier => $composableBuilder(
    column: $table.constitutionModifier,
    builder: (column) => column,
  );

  GeneratedColumn<int> get intelligenceModifier => $composableBuilder(
    column: $table.intelligenceModifier,
    builder: (column) => column,
  );

  GeneratedColumn<int> get wisdomModifier => $composableBuilder(
    column: $table.wisdomModifier,
    builder: (column) => column,
  );

  GeneratedColumn<int> get charismaModifier => $composableBuilder(
    column: $table.charismaModifier,
    builder: (column) => column,
  );

  $$CharactersTableAnnotationComposer get characterId {
    final $$CharactersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableAnnotationComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CharacterAbilityScoresTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CharacterAbilityScoresTable,
          CharacterAbilityScore,
          $$CharacterAbilityScoresTableFilterComposer,
          $$CharacterAbilityScoresTableOrderingComposer,
          $$CharacterAbilityScoresTableAnnotationComposer,
          $$CharacterAbilityScoresTableCreateCompanionBuilder,
          $$CharacterAbilityScoresTableUpdateCompanionBuilder,
          (CharacterAbilityScore, $$CharacterAbilityScoresTableReferences),
          CharacterAbilityScore,
          PrefetchHooks Function({bool characterId})
        > {
  $$CharacterAbilityScoresTableTableManager(
    _$AppDatabase db,
    $CharacterAbilityScoresTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CharacterAbilityScoresTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$CharacterAbilityScoresTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CharacterAbilityScoresTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> characterId = const Value.absent(),
                Value<int> strengthScore = const Value.absent(),
                Value<int> dexterityScore = const Value.absent(),
                Value<int> constitutionScore = const Value.absent(),
                Value<int> intelligenceScore = const Value.absent(),
                Value<int> wisdomScore = const Value.absent(),
                Value<int> charismaScore = const Value.absent(),
                Value<int?> strengthModifier = const Value.absent(),
                Value<int?> dexterityModifier = const Value.absent(),
                Value<int?> constitutionModifier = const Value.absent(),
                Value<int?> intelligenceModifier = const Value.absent(),
                Value<int?> wisdomModifier = const Value.absent(),
                Value<int?> charismaModifier = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CharacterAbilityScoresCompanion(
                characterId: characterId,
                strengthScore: strengthScore,
                dexterityScore: dexterityScore,
                constitutionScore: constitutionScore,
                intelligenceScore: intelligenceScore,
                wisdomScore: wisdomScore,
                charismaScore: charismaScore,
                strengthModifier: strengthModifier,
                dexterityModifier: dexterityModifier,
                constitutionModifier: constitutionModifier,
                intelligenceModifier: intelligenceModifier,
                wisdomModifier: wisdomModifier,
                charismaModifier: charismaModifier,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String characterId,
                required int strengthScore,
                required int dexterityScore,
                required int constitutionScore,
                required int intelligenceScore,
                required int wisdomScore,
                required int charismaScore,
                Value<int?> strengthModifier = const Value.absent(),
                Value<int?> dexterityModifier = const Value.absent(),
                Value<int?> constitutionModifier = const Value.absent(),
                Value<int?> intelligenceModifier = const Value.absent(),
                Value<int?> wisdomModifier = const Value.absent(),
                Value<int?> charismaModifier = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CharacterAbilityScoresCompanion.insert(
                characterId: characterId,
                strengthScore: strengthScore,
                dexterityScore: dexterityScore,
                constitutionScore: constitutionScore,
                intelligenceScore: intelligenceScore,
                wisdomScore: wisdomScore,
                charismaScore: charismaScore,
                strengthModifier: strengthModifier,
                dexterityModifier: dexterityModifier,
                constitutionModifier: constitutionModifier,
                intelligenceModifier: intelligenceModifier,
                wisdomModifier: wisdomModifier,
                charismaModifier: charismaModifier,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CharacterAbilityScoresTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({characterId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (characterId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.characterId,
                                referencedTable:
                                    $$CharacterAbilityScoresTableReferences
                                        ._characterIdTable(db),
                                referencedColumn:
                                    $$CharacterAbilityScoresTableReferences
                                        ._characterIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CharacterAbilityScoresTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CharacterAbilityScoresTable,
      CharacterAbilityScore,
      $$CharacterAbilityScoresTableFilterComposer,
      $$CharacterAbilityScoresTableOrderingComposer,
      $$CharacterAbilityScoresTableAnnotationComposer,
      $$CharacterAbilityScoresTableCreateCompanionBuilder,
      $$CharacterAbilityScoresTableUpdateCompanionBuilder,
      (CharacterAbilityScore, $$CharacterAbilityScoresTableReferences),
      CharacterAbilityScore,
      PrefetchHooks Function({bool characterId})
    >;
typedef $$CharacterAbilityScoreProvenancesTableCreateCompanionBuilder =
    CharacterAbilityScoreProvenancesCompanion Function({
      required String characterId,
      Value<String?> methodKey,
      Value<int?> strengthAssignedScore,
      Value<int?> dexterityAssignedScore,
      Value<int?> constitutionAssignedScore,
      Value<int?> intelligenceAssignedScore,
      Value<int?> wisdomAssignedScore,
      Value<int?> charismaAssignedScore,
      Value<int> rowid,
    });
typedef $$CharacterAbilityScoreProvenancesTableUpdateCompanionBuilder =
    CharacterAbilityScoreProvenancesCompanion Function({
      Value<String> characterId,
      Value<String?> methodKey,
      Value<int?> strengthAssignedScore,
      Value<int?> dexterityAssignedScore,
      Value<int?> constitutionAssignedScore,
      Value<int?> intelligenceAssignedScore,
      Value<int?> wisdomAssignedScore,
      Value<int?> charismaAssignedScore,
      Value<int> rowid,
    });

final class $$CharacterAbilityScoreProvenancesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CharacterAbilityScoreProvenancesTable,
          CharacterAbilityScoreProvenance
        > {
  $$CharacterAbilityScoreProvenancesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CharactersTable _characterIdTable(_$AppDatabase db) =>
      db.characters.createAlias(
        $_aliasNameGenerator(
          db.characterAbilityScoreProvenances.characterId,
          db.characters.id,
        ),
      );

  $$CharactersTableProcessedTableManager get characterId {
    final $_column = $_itemColumn<String>('character_id')!;

    final manager = $$CharactersTableTableManager(
      $_db,
      $_db.characters,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_characterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CharacterAbilityScoreProvenancesTableFilterComposer
    extends Composer<_$AppDatabase, $CharacterAbilityScoreProvenancesTable> {
  $$CharacterAbilityScoreProvenancesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get methodKey => $composableBuilder(
    column: $table.methodKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get strengthAssignedScore => $composableBuilder(
    column: $table.strengthAssignedScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dexterityAssignedScore => $composableBuilder(
    column: $table.dexterityAssignedScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get constitutionAssignedScore => $composableBuilder(
    column: $table.constitutionAssignedScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intelligenceAssignedScore => $composableBuilder(
    column: $table.intelligenceAssignedScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wisdomAssignedScore => $composableBuilder(
    column: $table.wisdomAssignedScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get charismaAssignedScore => $composableBuilder(
    column: $table.charismaAssignedScore,
    builder: (column) => ColumnFilters(column),
  );

  $$CharactersTableFilterComposer get characterId {
    final $$CharactersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableFilterComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CharacterAbilityScoreProvenancesTableOrderingComposer
    extends Composer<_$AppDatabase, $CharacterAbilityScoreProvenancesTable> {
  $$CharacterAbilityScoreProvenancesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get methodKey => $composableBuilder(
    column: $table.methodKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get strengthAssignedScore => $composableBuilder(
    column: $table.strengthAssignedScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dexterityAssignedScore => $composableBuilder(
    column: $table.dexterityAssignedScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get constitutionAssignedScore => $composableBuilder(
    column: $table.constitutionAssignedScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intelligenceAssignedScore => $composableBuilder(
    column: $table.intelligenceAssignedScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wisdomAssignedScore => $composableBuilder(
    column: $table.wisdomAssignedScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get charismaAssignedScore => $composableBuilder(
    column: $table.charismaAssignedScore,
    builder: (column) => ColumnOrderings(column),
  );

  $$CharactersTableOrderingComposer get characterId {
    final $$CharactersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableOrderingComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CharacterAbilityScoreProvenancesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CharacterAbilityScoreProvenancesTable> {
  $$CharacterAbilityScoreProvenancesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get methodKey =>
      $composableBuilder(column: $table.methodKey, builder: (column) => column);

  GeneratedColumn<int> get strengthAssignedScore => $composableBuilder(
    column: $table.strengthAssignedScore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dexterityAssignedScore => $composableBuilder(
    column: $table.dexterityAssignedScore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get constitutionAssignedScore => $composableBuilder(
    column: $table.constitutionAssignedScore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get intelligenceAssignedScore => $composableBuilder(
    column: $table.intelligenceAssignedScore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get wisdomAssignedScore => $composableBuilder(
    column: $table.wisdomAssignedScore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get charismaAssignedScore => $composableBuilder(
    column: $table.charismaAssignedScore,
    builder: (column) => column,
  );

  $$CharactersTableAnnotationComposer get characterId {
    final $$CharactersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableAnnotationComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CharacterAbilityScoreProvenancesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CharacterAbilityScoreProvenancesTable,
          CharacterAbilityScoreProvenance,
          $$CharacterAbilityScoreProvenancesTableFilterComposer,
          $$CharacterAbilityScoreProvenancesTableOrderingComposer,
          $$CharacterAbilityScoreProvenancesTableAnnotationComposer,
          $$CharacterAbilityScoreProvenancesTableCreateCompanionBuilder,
          $$CharacterAbilityScoreProvenancesTableUpdateCompanionBuilder,
          (
            CharacterAbilityScoreProvenance,
            $$CharacterAbilityScoreProvenancesTableReferences,
          ),
          CharacterAbilityScoreProvenance,
          PrefetchHooks Function({bool characterId})
        > {
  $$CharacterAbilityScoreProvenancesTableTableManager(
    _$AppDatabase db,
    $CharacterAbilityScoreProvenancesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CharacterAbilityScoreProvenancesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$CharacterAbilityScoreProvenancesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CharacterAbilityScoreProvenancesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> characterId = const Value.absent(),
                Value<String?> methodKey = const Value.absent(),
                Value<int?> strengthAssignedScore = const Value.absent(),
                Value<int?> dexterityAssignedScore = const Value.absent(),
                Value<int?> constitutionAssignedScore = const Value.absent(),
                Value<int?> intelligenceAssignedScore = const Value.absent(),
                Value<int?> wisdomAssignedScore = const Value.absent(),
                Value<int?> charismaAssignedScore = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CharacterAbilityScoreProvenancesCompanion(
                characterId: characterId,
                methodKey: methodKey,
                strengthAssignedScore: strengthAssignedScore,
                dexterityAssignedScore: dexterityAssignedScore,
                constitutionAssignedScore: constitutionAssignedScore,
                intelligenceAssignedScore: intelligenceAssignedScore,
                wisdomAssignedScore: wisdomAssignedScore,
                charismaAssignedScore: charismaAssignedScore,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String characterId,
                Value<String?> methodKey = const Value.absent(),
                Value<int?> strengthAssignedScore = const Value.absent(),
                Value<int?> dexterityAssignedScore = const Value.absent(),
                Value<int?> constitutionAssignedScore = const Value.absent(),
                Value<int?> intelligenceAssignedScore = const Value.absent(),
                Value<int?> wisdomAssignedScore = const Value.absent(),
                Value<int?> charismaAssignedScore = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CharacterAbilityScoreProvenancesCompanion.insert(
                characterId: characterId,
                methodKey: methodKey,
                strengthAssignedScore: strengthAssignedScore,
                dexterityAssignedScore: dexterityAssignedScore,
                constitutionAssignedScore: constitutionAssignedScore,
                intelligenceAssignedScore: intelligenceAssignedScore,
                wisdomAssignedScore: wisdomAssignedScore,
                charismaAssignedScore: charismaAssignedScore,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CharacterAbilityScoreProvenancesTableReferences(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({characterId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (characterId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.characterId,
                                referencedTable:
                                    $$CharacterAbilityScoreProvenancesTableReferences
                                        ._characterIdTable(db),
                                referencedColumn:
                                    $$CharacterAbilityScoreProvenancesTableReferences
                                        ._characterIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CharacterAbilityScoreProvenancesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CharacterAbilityScoreProvenancesTable,
      CharacterAbilityScoreProvenance,
      $$CharacterAbilityScoreProvenancesTableFilterComposer,
      $$CharacterAbilityScoreProvenancesTableOrderingComposer,
      $$CharacterAbilityScoreProvenancesTableAnnotationComposer,
      $$CharacterAbilityScoreProvenancesTableCreateCompanionBuilder,
      $$CharacterAbilityScoreProvenancesTableUpdateCompanionBuilder,
      (
        CharacterAbilityScoreProvenance,
        $$CharacterAbilityScoreProvenancesTableReferences,
      ),
      CharacterAbilityScoreProvenance,
      PrefetchHooks Function({bool characterId})
    >;
typedef $$CharacterHitPointsTableCreateCompanionBuilder =
    CharacterHitPointsCompanion Function({
      required String characterId,
      required int current,
      required int maximum,
      required int temporary,
      Value<int> rowid,
    });
typedef $$CharacterHitPointsTableUpdateCompanionBuilder =
    CharacterHitPointsCompanion Function({
      Value<String> characterId,
      Value<int> current,
      Value<int> maximum,
      Value<int> temporary,
      Value<int> rowid,
    });

final class $$CharacterHitPointsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CharacterHitPointsTable,
          CharacterHitPoint
        > {
  $$CharacterHitPointsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CharactersTable _characterIdTable(_$AppDatabase db) =>
      db.characters.createAlias(
        $_aliasNameGenerator(
          db.characterHitPoints.characterId,
          db.characters.id,
        ),
      );

  $$CharactersTableProcessedTableManager get characterId {
    final $_column = $_itemColumn<String>('character_id')!;

    final manager = $$CharactersTableTableManager(
      $_db,
      $_db.characters,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_characterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CharacterHitPointsTableFilterComposer
    extends Composer<_$AppDatabase, $CharacterHitPointsTable> {
  $$CharacterHitPointsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get current => $composableBuilder(
    column: $table.current,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maximum => $composableBuilder(
    column: $table.maximum,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get temporary => $composableBuilder(
    column: $table.temporary,
    builder: (column) => ColumnFilters(column),
  );

  $$CharactersTableFilterComposer get characterId {
    final $$CharactersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableFilterComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CharacterHitPointsTableOrderingComposer
    extends Composer<_$AppDatabase, $CharacterHitPointsTable> {
  $$CharacterHitPointsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get current => $composableBuilder(
    column: $table.current,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maximum => $composableBuilder(
    column: $table.maximum,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get temporary => $composableBuilder(
    column: $table.temporary,
    builder: (column) => ColumnOrderings(column),
  );

  $$CharactersTableOrderingComposer get characterId {
    final $$CharactersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableOrderingComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CharacterHitPointsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CharacterHitPointsTable> {
  $$CharacterHitPointsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get current =>
      $composableBuilder(column: $table.current, builder: (column) => column);

  GeneratedColumn<int> get maximum =>
      $composableBuilder(column: $table.maximum, builder: (column) => column);

  GeneratedColumn<int> get temporary =>
      $composableBuilder(column: $table.temporary, builder: (column) => column);

  $$CharactersTableAnnotationComposer get characterId {
    final $$CharactersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableAnnotationComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CharacterHitPointsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CharacterHitPointsTable,
          CharacterHitPoint,
          $$CharacterHitPointsTableFilterComposer,
          $$CharacterHitPointsTableOrderingComposer,
          $$CharacterHitPointsTableAnnotationComposer,
          $$CharacterHitPointsTableCreateCompanionBuilder,
          $$CharacterHitPointsTableUpdateCompanionBuilder,
          (CharacterHitPoint, $$CharacterHitPointsTableReferences),
          CharacterHitPoint,
          PrefetchHooks Function({bool characterId})
        > {
  $$CharacterHitPointsTableTableManager(
    _$AppDatabase db,
    $CharacterHitPointsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CharacterHitPointsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CharacterHitPointsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CharacterHitPointsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> characterId = const Value.absent(),
                Value<int> current = const Value.absent(),
                Value<int> maximum = const Value.absent(),
                Value<int> temporary = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CharacterHitPointsCompanion(
                characterId: characterId,
                current: current,
                maximum: maximum,
                temporary: temporary,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String characterId,
                required int current,
                required int maximum,
                required int temporary,
                Value<int> rowid = const Value.absent(),
              }) => CharacterHitPointsCompanion.insert(
                characterId: characterId,
                current: current,
                maximum: maximum,
                temporary: temporary,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CharacterHitPointsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({characterId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (characterId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.characterId,
                                referencedTable:
                                    $$CharacterHitPointsTableReferences
                                        ._characterIdTable(db),
                                referencedColumn:
                                    $$CharacterHitPointsTableReferences
                                        ._characterIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CharacterHitPointsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CharacterHitPointsTable,
      CharacterHitPoint,
      $$CharacterHitPointsTableFilterComposer,
      $$CharacterHitPointsTableOrderingComposer,
      $$CharacterHitPointsTableAnnotationComposer,
      $$CharacterHitPointsTableCreateCompanionBuilder,
      $$CharacterHitPointsTableUpdateCompanionBuilder,
      (CharacterHitPoint, $$CharacterHitPointsTableReferences),
      CharacterHitPoint,
      PrefetchHooks Function({bool characterId})
    >;
typedef $$CharacterFinishingDetailsTableCreateCompanionBuilder =
    CharacterFinishingDetailsCompanion Function({
      required String characterId,
      Value<String?> portraitAssetPath,
      Value<String?> alignment,
      Value<String?> appearanceDetails,
      Value<String?> narrativeDetails,
      Value<int> rowid,
    });
typedef $$CharacterFinishingDetailsTableUpdateCompanionBuilder =
    CharacterFinishingDetailsCompanion Function({
      Value<String> characterId,
      Value<String?> portraitAssetPath,
      Value<String?> alignment,
      Value<String?> appearanceDetails,
      Value<String?> narrativeDetails,
      Value<int> rowid,
    });

final class $$CharacterFinishingDetailsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CharacterFinishingDetailsTable,
          CharacterFinishingDetail
        > {
  $$CharacterFinishingDetailsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CharactersTable _characterIdTable(_$AppDatabase db) =>
      db.characters.createAlias(
        $_aliasNameGenerator(
          db.characterFinishingDetails.characterId,
          db.characters.id,
        ),
      );

  $$CharactersTableProcessedTableManager get characterId {
    final $_column = $_itemColumn<String>('character_id')!;

    final manager = $$CharactersTableTableManager(
      $_db,
      $_db.characters,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_characterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CharacterFinishingDetailsTableFilterComposer
    extends Composer<_$AppDatabase, $CharacterFinishingDetailsTable> {
  $$CharacterFinishingDetailsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get portraitAssetPath => $composableBuilder(
    column: $table.portraitAssetPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get alignment => $composableBuilder(
    column: $table.alignment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get appearanceDetails => $composableBuilder(
    column: $table.appearanceDetails,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get narrativeDetails => $composableBuilder(
    column: $table.narrativeDetails,
    builder: (column) => ColumnFilters(column),
  );

  $$CharactersTableFilterComposer get characterId {
    final $$CharactersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableFilterComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CharacterFinishingDetailsTableOrderingComposer
    extends Composer<_$AppDatabase, $CharacterFinishingDetailsTable> {
  $$CharacterFinishingDetailsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get portraitAssetPath => $composableBuilder(
    column: $table.portraitAssetPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get alignment => $composableBuilder(
    column: $table.alignment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get appearanceDetails => $composableBuilder(
    column: $table.appearanceDetails,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get narrativeDetails => $composableBuilder(
    column: $table.narrativeDetails,
    builder: (column) => ColumnOrderings(column),
  );

  $$CharactersTableOrderingComposer get characterId {
    final $$CharactersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableOrderingComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CharacterFinishingDetailsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CharacterFinishingDetailsTable> {
  $$CharacterFinishingDetailsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get portraitAssetPath => $composableBuilder(
    column: $table.portraitAssetPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get alignment =>
      $composableBuilder(column: $table.alignment, builder: (column) => column);

  GeneratedColumn<String> get appearanceDetails => $composableBuilder(
    column: $table.appearanceDetails,
    builder: (column) => column,
  );

  GeneratedColumn<String> get narrativeDetails => $composableBuilder(
    column: $table.narrativeDetails,
    builder: (column) => column,
  );

  $$CharactersTableAnnotationComposer get characterId {
    final $$CharactersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableAnnotationComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CharacterFinishingDetailsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CharacterFinishingDetailsTable,
          CharacterFinishingDetail,
          $$CharacterFinishingDetailsTableFilterComposer,
          $$CharacterFinishingDetailsTableOrderingComposer,
          $$CharacterFinishingDetailsTableAnnotationComposer,
          $$CharacterFinishingDetailsTableCreateCompanionBuilder,
          $$CharacterFinishingDetailsTableUpdateCompanionBuilder,
          (
            CharacterFinishingDetail,
            $$CharacterFinishingDetailsTableReferences,
          ),
          CharacterFinishingDetail,
          PrefetchHooks Function({bool characterId})
        > {
  $$CharacterFinishingDetailsTableTableManager(
    _$AppDatabase db,
    $CharacterFinishingDetailsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CharacterFinishingDetailsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$CharacterFinishingDetailsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CharacterFinishingDetailsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> characterId = const Value.absent(),
                Value<String?> portraitAssetPath = const Value.absent(),
                Value<String?> alignment = const Value.absent(),
                Value<String?> appearanceDetails = const Value.absent(),
                Value<String?> narrativeDetails = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CharacterFinishingDetailsCompanion(
                characterId: characterId,
                portraitAssetPath: portraitAssetPath,
                alignment: alignment,
                appearanceDetails: appearanceDetails,
                narrativeDetails: narrativeDetails,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String characterId,
                Value<String?> portraitAssetPath = const Value.absent(),
                Value<String?> alignment = const Value.absent(),
                Value<String?> appearanceDetails = const Value.absent(),
                Value<String?> narrativeDetails = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CharacterFinishingDetailsCompanion.insert(
                characterId: characterId,
                portraitAssetPath: portraitAssetPath,
                alignment: alignment,
                appearanceDetails: appearanceDetails,
                narrativeDetails: narrativeDetails,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CharacterFinishingDetailsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({characterId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (characterId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.characterId,
                                referencedTable:
                                    $$CharacterFinishingDetailsTableReferences
                                        ._characterIdTable(db),
                                referencedColumn:
                                    $$CharacterFinishingDetailsTableReferences
                                        ._characterIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CharacterFinishingDetailsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CharacterFinishingDetailsTable,
      CharacterFinishingDetail,
      $$CharacterFinishingDetailsTableFilterComposer,
      $$CharacterFinishingDetailsTableOrderingComposer,
      $$CharacterFinishingDetailsTableAnnotationComposer,
      $$CharacterFinishingDetailsTableCreateCompanionBuilder,
      $$CharacterFinishingDetailsTableUpdateCompanionBuilder,
      (CharacterFinishingDetail, $$CharacterFinishingDetailsTableReferences),
      CharacterFinishingDetail,
      PrefetchHooks Function({bool characterId})
    >;
typedef $$CharacterNarrativeSelectionsTableCreateCompanionBuilder =
    CharacterNarrativeSelectionsCompanion Function({
      required String characterId,
      required String fieldKey,
      required String selectionMode,
      Value<String?> groupId,
      Value<String?> optionId,
      Value<String?> valueText,
      Value<int?> rollValue,
      Value<int> rowid,
    });
typedef $$CharacterNarrativeSelectionsTableUpdateCompanionBuilder =
    CharacterNarrativeSelectionsCompanion Function({
      Value<String> characterId,
      Value<String> fieldKey,
      Value<String> selectionMode,
      Value<String?> groupId,
      Value<String?> optionId,
      Value<String?> valueText,
      Value<int?> rollValue,
      Value<int> rowid,
    });

final class $$CharacterNarrativeSelectionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CharacterNarrativeSelectionsTable,
          CharacterNarrativeSelection
        > {
  $$CharacterNarrativeSelectionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CharactersTable _characterIdTable(_$AppDatabase db) =>
      db.characters.createAlias(
        $_aliasNameGenerator(
          db.characterNarrativeSelections.characterId,
          db.characters.id,
        ),
      );

  $$CharactersTableProcessedTableManager get characterId {
    final $_column = $_itemColumn<String>('character_id')!;

    final manager = $$CharactersTableTableManager(
      $_db,
      $_db.characters,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_characterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CharacterNarrativeSelectionsTableFilterComposer
    extends Composer<_$AppDatabase, $CharacterNarrativeSelectionsTable> {
  $$CharacterNarrativeSelectionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get fieldKey => $composableBuilder(
    column: $table.fieldKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get selectionMode => $composableBuilder(
    column: $table.selectionMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get groupId => $composableBuilder(
    column: $table.groupId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get optionId => $composableBuilder(
    column: $table.optionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get valueText => $composableBuilder(
    column: $table.valueText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rollValue => $composableBuilder(
    column: $table.rollValue,
    builder: (column) => ColumnFilters(column),
  );

  $$CharactersTableFilterComposer get characterId {
    final $$CharactersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableFilterComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CharacterNarrativeSelectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $CharacterNarrativeSelectionsTable> {
  $$CharacterNarrativeSelectionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get fieldKey => $composableBuilder(
    column: $table.fieldKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get selectionMode => $composableBuilder(
    column: $table.selectionMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get groupId => $composableBuilder(
    column: $table.groupId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get optionId => $composableBuilder(
    column: $table.optionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get valueText => $composableBuilder(
    column: $table.valueText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rollValue => $composableBuilder(
    column: $table.rollValue,
    builder: (column) => ColumnOrderings(column),
  );

  $$CharactersTableOrderingComposer get characterId {
    final $$CharactersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableOrderingComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CharacterNarrativeSelectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CharacterNarrativeSelectionsTable> {
  $$CharacterNarrativeSelectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get fieldKey =>
      $composableBuilder(column: $table.fieldKey, builder: (column) => column);

  GeneratedColumn<String> get selectionMode => $composableBuilder(
    column: $table.selectionMode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get groupId =>
      $composableBuilder(column: $table.groupId, builder: (column) => column);

  GeneratedColumn<String> get optionId =>
      $composableBuilder(column: $table.optionId, builder: (column) => column);

  GeneratedColumn<String> get valueText =>
      $composableBuilder(column: $table.valueText, builder: (column) => column);

  GeneratedColumn<int> get rollValue =>
      $composableBuilder(column: $table.rollValue, builder: (column) => column);

  $$CharactersTableAnnotationComposer get characterId {
    final $$CharactersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableAnnotationComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CharacterNarrativeSelectionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CharacterNarrativeSelectionsTable,
          CharacterNarrativeSelection,
          $$CharacterNarrativeSelectionsTableFilterComposer,
          $$CharacterNarrativeSelectionsTableOrderingComposer,
          $$CharacterNarrativeSelectionsTableAnnotationComposer,
          $$CharacterNarrativeSelectionsTableCreateCompanionBuilder,
          $$CharacterNarrativeSelectionsTableUpdateCompanionBuilder,
          (
            CharacterNarrativeSelection,
            $$CharacterNarrativeSelectionsTableReferences,
          ),
          CharacterNarrativeSelection,
          PrefetchHooks Function({bool characterId})
        > {
  $$CharacterNarrativeSelectionsTableTableManager(
    _$AppDatabase db,
    $CharacterNarrativeSelectionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CharacterNarrativeSelectionsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$CharacterNarrativeSelectionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CharacterNarrativeSelectionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> characterId = const Value.absent(),
                Value<String> fieldKey = const Value.absent(),
                Value<String> selectionMode = const Value.absent(),
                Value<String?> groupId = const Value.absent(),
                Value<String?> optionId = const Value.absent(),
                Value<String?> valueText = const Value.absent(),
                Value<int?> rollValue = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CharacterNarrativeSelectionsCompanion(
                characterId: characterId,
                fieldKey: fieldKey,
                selectionMode: selectionMode,
                groupId: groupId,
                optionId: optionId,
                valueText: valueText,
                rollValue: rollValue,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String characterId,
                required String fieldKey,
                required String selectionMode,
                Value<String?> groupId = const Value.absent(),
                Value<String?> optionId = const Value.absent(),
                Value<String?> valueText = const Value.absent(),
                Value<int?> rollValue = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CharacterNarrativeSelectionsCompanion.insert(
                characterId: characterId,
                fieldKey: fieldKey,
                selectionMode: selectionMode,
                groupId: groupId,
                optionId: optionId,
                valueText: valueText,
                rollValue: rollValue,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CharacterNarrativeSelectionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({characterId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (characterId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.characterId,
                                referencedTable:
                                    $$CharacterNarrativeSelectionsTableReferences
                                        ._characterIdTable(db),
                                referencedColumn:
                                    $$CharacterNarrativeSelectionsTableReferences
                                        ._characterIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CharacterNarrativeSelectionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CharacterNarrativeSelectionsTable,
      CharacterNarrativeSelection,
      $$CharacterNarrativeSelectionsTableFilterComposer,
      $$CharacterNarrativeSelectionsTableOrderingComposer,
      $$CharacterNarrativeSelectionsTableAnnotationComposer,
      $$CharacterNarrativeSelectionsTableCreateCompanionBuilder,
      $$CharacterNarrativeSelectionsTableUpdateCompanionBuilder,
      (
        CharacterNarrativeSelection,
        $$CharacterNarrativeSelectionsTableReferences,
      ),
      CharacterNarrativeSelection,
      PrefetchHooks Function({bool characterId})
    >;
typedef $$CharacterEquipmentLoadoutsTableCreateCompanionBuilder =
    CharacterEquipmentLoadoutsCompanion Function({
      required String characterId,
      Value<String?> loadoutId,
      Value<String?> loadoutLabel,
      Value<int> rowid,
    });
typedef $$CharacterEquipmentLoadoutsTableUpdateCompanionBuilder =
    CharacterEquipmentLoadoutsCompanion Function({
      Value<String> characterId,
      Value<String?> loadoutId,
      Value<String?> loadoutLabel,
      Value<int> rowid,
    });

final class $$CharacterEquipmentLoadoutsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CharacterEquipmentLoadoutsTable,
          CharacterEquipmentLoadout
        > {
  $$CharacterEquipmentLoadoutsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CharactersTable _characterIdTable(_$AppDatabase db) =>
      db.characters.createAlias(
        $_aliasNameGenerator(
          db.characterEquipmentLoadouts.characterId,
          db.characters.id,
        ),
      );

  $$CharactersTableProcessedTableManager get characterId {
    final $_column = $_itemColumn<String>('character_id')!;

    final manager = $$CharactersTableTableManager(
      $_db,
      $_db.characters,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_characterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CharacterEquipmentLoadoutsTableFilterComposer
    extends Composer<_$AppDatabase, $CharacterEquipmentLoadoutsTable> {
  $$CharacterEquipmentLoadoutsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get loadoutId => $composableBuilder(
    column: $table.loadoutId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get loadoutLabel => $composableBuilder(
    column: $table.loadoutLabel,
    builder: (column) => ColumnFilters(column),
  );

  $$CharactersTableFilterComposer get characterId {
    final $$CharactersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableFilterComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CharacterEquipmentLoadoutsTableOrderingComposer
    extends Composer<_$AppDatabase, $CharacterEquipmentLoadoutsTable> {
  $$CharacterEquipmentLoadoutsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get loadoutId => $composableBuilder(
    column: $table.loadoutId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get loadoutLabel => $composableBuilder(
    column: $table.loadoutLabel,
    builder: (column) => ColumnOrderings(column),
  );

  $$CharactersTableOrderingComposer get characterId {
    final $$CharactersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableOrderingComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CharacterEquipmentLoadoutsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CharacterEquipmentLoadoutsTable> {
  $$CharacterEquipmentLoadoutsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get loadoutId =>
      $composableBuilder(column: $table.loadoutId, builder: (column) => column);

  GeneratedColumn<String> get loadoutLabel => $composableBuilder(
    column: $table.loadoutLabel,
    builder: (column) => column,
  );

  $$CharactersTableAnnotationComposer get characterId {
    final $$CharactersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableAnnotationComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CharacterEquipmentLoadoutsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CharacterEquipmentLoadoutsTable,
          CharacterEquipmentLoadout,
          $$CharacterEquipmentLoadoutsTableFilterComposer,
          $$CharacterEquipmentLoadoutsTableOrderingComposer,
          $$CharacterEquipmentLoadoutsTableAnnotationComposer,
          $$CharacterEquipmentLoadoutsTableCreateCompanionBuilder,
          $$CharacterEquipmentLoadoutsTableUpdateCompanionBuilder,
          (
            CharacterEquipmentLoadout,
            $$CharacterEquipmentLoadoutsTableReferences,
          ),
          CharacterEquipmentLoadout,
          PrefetchHooks Function({bool characterId})
        > {
  $$CharacterEquipmentLoadoutsTableTableManager(
    _$AppDatabase db,
    $CharacterEquipmentLoadoutsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CharacterEquipmentLoadoutsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$CharacterEquipmentLoadoutsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CharacterEquipmentLoadoutsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> characterId = const Value.absent(),
                Value<String?> loadoutId = const Value.absent(),
                Value<String?> loadoutLabel = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CharacterEquipmentLoadoutsCompanion(
                characterId: characterId,
                loadoutId: loadoutId,
                loadoutLabel: loadoutLabel,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String characterId,
                Value<String?> loadoutId = const Value.absent(),
                Value<String?> loadoutLabel = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CharacterEquipmentLoadoutsCompanion.insert(
                characterId: characterId,
                loadoutId: loadoutId,
                loadoutLabel: loadoutLabel,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CharacterEquipmentLoadoutsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({characterId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (characterId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.characterId,
                                referencedTable:
                                    $$CharacterEquipmentLoadoutsTableReferences
                                        ._characterIdTable(db),
                                referencedColumn:
                                    $$CharacterEquipmentLoadoutsTableReferences
                                        ._characterIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CharacterEquipmentLoadoutsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CharacterEquipmentLoadoutsTable,
      CharacterEquipmentLoadout,
      $$CharacterEquipmentLoadoutsTableFilterComposer,
      $$CharacterEquipmentLoadoutsTableOrderingComposer,
      $$CharacterEquipmentLoadoutsTableAnnotationComposer,
      $$CharacterEquipmentLoadoutsTableCreateCompanionBuilder,
      $$CharacterEquipmentLoadoutsTableUpdateCompanionBuilder,
      (CharacterEquipmentLoadout, $$CharacterEquipmentLoadoutsTableReferences),
      CharacterEquipmentLoadout,
      PrefetchHooks Function({bool characterId})
    >;
typedef $$CharacterSpellSelectionsTableCreateCompanionBuilder =
    CharacterSpellSelectionsCompanion Function({
      required String characterId,
      required String spellDefinitionId,
      required String selectionKind,
      Value<int> selectedAtOrder,
      Value<int> rowid,
    });
typedef $$CharacterSpellSelectionsTableUpdateCompanionBuilder =
    CharacterSpellSelectionsCompanion Function({
      Value<String> characterId,
      Value<String> spellDefinitionId,
      Value<String> selectionKind,
      Value<int> selectedAtOrder,
      Value<int> rowid,
    });

final class $$CharacterSpellSelectionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CharacterSpellSelectionsTable,
          CharacterSpellSelection
        > {
  $$CharacterSpellSelectionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CharactersTable _characterIdTable(_$AppDatabase db) =>
      db.characters.createAlias(
        $_aliasNameGenerator(
          db.characterSpellSelections.characterId,
          db.characters.id,
        ),
      );

  $$CharactersTableProcessedTableManager get characterId {
    final $_column = $_itemColumn<String>('character_id')!;

    final manager = $$CharactersTableTableManager(
      $_db,
      $_db.characters,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_characterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CharacterSpellSelectionsTableFilterComposer
    extends Composer<_$AppDatabase, $CharacterSpellSelectionsTable> {
  $$CharacterSpellSelectionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get spellDefinitionId => $composableBuilder(
    column: $table.spellDefinitionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get selectionKind => $composableBuilder(
    column: $table.selectionKind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get selectedAtOrder => $composableBuilder(
    column: $table.selectedAtOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$CharactersTableFilterComposer get characterId {
    final $$CharactersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableFilterComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CharacterSpellSelectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $CharacterSpellSelectionsTable> {
  $$CharacterSpellSelectionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get spellDefinitionId => $composableBuilder(
    column: $table.spellDefinitionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get selectionKind => $composableBuilder(
    column: $table.selectionKind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get selectedAtOrder => $composableBuilder(
    column: $table.selectedAtOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$CharactersTableOrderingComposer get characterId {
    final $$CharactersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableOrderingComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CharacterSpellSelectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CharacterSpellSelectionsTable> {
  $$CharacterSpellSelectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get spellDefinitionId => $composableBuilder(
    column: $table.spellDefinitionId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get selectionKind => $composableBuilder(
    column: $table.selectionKind,
    builder: (column) => column,
  );

  GeneratedColumn<int> get selectedAtOrder => $composableBuilder(
    column: $table.selectedAtOrder,
    builder: (column) => column,
  );

  $$CharactersTableAnnotationComposer get characterId {
    final $$CharactersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableAnnotationComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CharacterSpellSelectionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CharacterSpellSelectionsTable,
          CharacterSpellSelection,
          $$CharacterSpellSelectionsTableFilterComposer,
          $$CharacterSpellSelectionsTableOrderingComposer,
          $$CharacterSpellSelectionsTableAnnotationComposer,
          $$CharacterSpellSelectionsTableCreateCompanionBuilder,
          $$CharacterSpellSelectionsTableUpdateCompanionBuilder,
          (CharacterSpellSelection, $$CharacterSpellSelectionsTableReferences),
          CharacterSpellSelection,
          PrefetchHooks Function({bool characterId})
        > {
  $$CharacterSpellSelectionsTableTableManager(
    _$AppDatabase db,
    $CharacterSpellSelectionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CharacterSpellSelectionsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$CharacterSpellSelectionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CharacterSpellSelectionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> characterId = const Value.absent(),
                Value<String> spellDefinitionId = const Value.absent(),
                Value<String> selectionKind = const Value.absent(),
                Value<int> selectedAtOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CharacterSpellSelectionsCompanion(
                characterId: characterId,
                spellDefinitionId: spellDefinitionId,
                selectionKind: selectionKind,
                selectedAtOrder: selectedAtOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String characterId,
                required String spellDefinitionId,
                required String selectionKind,
                Value<int> selectedAtOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CharacterSpellSelectionsCompanion.insert(
                characterId: characterId,
                spellDefinitionId: spellDefinitionId,
                selectionKind: selectionKind,
                selectedAtOrder: selectedAtOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CharacterSpellSelectionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({characterId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (characterId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.characterId,
                                referencedTable:
                                    $$CharacterSpellSelectionsTableReferences
                                        ._characterIdTable(db),
                                referencedColumn:
                                    $$CharacterSpellSelectionsTableReferences
                                        ._characterIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CharacterSpellSelectionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CharacterSpellSelectionsTable,
      CharacterSpellSelection,
      $$CharacterSpellSelectionsTableFilterComposer,
      $$CharacterSpellSelectionsTableOrderingComposer,
      $$CharacterSpellSelectionsTableAnnotationComposer,
      $$CharacterSpellSelectionsTableCreateCompanionBuilder,
      $$CharacterSpellSelectionsTableUpdateCompanionBuilder,
      (CharacterSpellSelection, $$CharacterSpellSelectionsTableReferences),
      CharacterSpellSelection,
      PrefetchHooks Function({bool characterId})
    >;
typedef $$CharacterSpellSlotUsagesTableCreateCompanionBuilder =
    CharacterSpellSlotUsagesCompanion Function({
      required String characterId,
      required int spellLevel,
      Value<int> slotsExpended,
      Value<int> rowid,
    });
typedef $$CharacterSpellSlotUsagesTableUpdateCompanionBuilder =
    CharacterSpellSlotUsagesCompanion Function({
      Value<String> characterId,
      Value<int> spellLevel,
      Value<int> slotsExpended,
      Value<int> rowid,
    });

final class $$CharacterSpellSlotUsagesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CharacterSpellSlotUsagesTable,
          CharacterSpellSlotUsage
        > {
  $$CharacterSpellSlotUsagesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CharactersTable _characterIdTable(_$AppDatabase db) =>
      db.characters.createAlias(
        $_aliasNameGenerator(
          db.characterSpellSlotUsages.characterId,
          db.characters.id,
        ),
      );

  $$CharactersTableProcessedTableManager get characterId {
    final $_column = $_itemColumn<String>('character_id')!;

    final manager = $$CharactersTableTableManager(
      $_db,
      $_db.characters,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_characterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CharacterSpellSlotUsagesTableFilterComposer
    extends Composer<_$AppDatabase, $CharacterSpellSlotUsagesTable> {
  $$CharacterSpellSlotUsagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get spellLevel => $composableBuilder(
    column: $table.spellLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get slotsExpended => $composableBuilder(
    column: $table.slotsExpended,
    builder: (column) => ColumnFilters(column),
  );

  $$CharactersTableFilterComposer get characterId {
    final $$CharactersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableFilterComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CharacterSpellSlotUsagesTableOrderingComposer
    extends Composer<_$AppDatabase, $CharacterSpellSlotUsagesTable> {
  $$CharacterSpellSlotUsagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get spellLevel => $composableBuilder(
    column: $table.spellLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get slotsExpended => $composableBuilder(
    column: $table.slotsExpended,
    builder: (column) => ColumnOrderings(column),
  );

  $$CharactersTableOrderingComposer get characterId {
    final $$CharactersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableOrderingComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CharacterSpellSlotUsagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CharacterSpellSlotUsagesTable> {
  $$CharacterSpellSlotUsagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get spellLevel => $composableBuilder(
    column: $table.spellLevel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get slotsExpended => $composableBuilder(
    column: $table.slotsExpended,
    builder: (column) => column,
  );

  $$CharactersTableAnnotationComposer get characterId {
    final $$CharactersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableAnnotationComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CharacterSpellSlotUsagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CharacterSpellSlotUsagesTable,
          CharacterSpellSlotUsage,
          $$CharacterSpellSlotUsagesTableFilterComposer,
          $$CharacterSpellSlotUsagesTableOrderingComposer,
          $$CharacterSpellSlotUsagesTableAnnotationComposer,
          $$CharacterSpellSlotUsagesTableCreateCompanionBuilder,
          $$CharacterSpellSlotUsagesTableUpdateCompanionBuilder,
          (CharacterSpellSlotUsage, $$CharacterSpellSlotUsagesTableReferences),
          CharacterSpellSlotUsage,
          PrefetchHooks Function({bool characterId})
        > {
  $$CharacterSpellSlotUsagesTableTableManager(
    _$AppDatabase db,
    $CharacterSpellSlotUsagesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CharacterSpellSlotUsagesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$CharacterSpellSlotUsagesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CharacterSpellSlotUsagesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> characterId = const Value.absent(),
                Value<int> spellLevel = const Value.absent(),
                Value<int> slotsExpended = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CharacterSpellSlotUsagesCompanion(
                characterId: characterId,
                spellLevel: spellLevel,
                slotsExpended: slotsExpended,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String characterId,
                required int spellLevel,
                Value<int> slotsExpended = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CharacterSpellSlotUsagesCompanion.insert(
                characterId: characterId,
                spellLevel: spellLevel,
                slotsExpended: slotsExpended,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CharacterSpellSlotUsagesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({characterId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (characterId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.characterId,
                                referencedTable:
                                    $$CharacterSpellSlotUsagesTableReferences
                                        ._characterIdTable(db),
                                referencedColumn:
                                    $$CharacterSpellSlotUsagesTableReferences
                                        ._characterIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CharacterSpellSlotUsagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CharacterSpellSlotUsagesTable,
      CharacterSpellSlotUsage,
      $$CharacterSpellSlotUsagesTableFilterComposer,
      $$CharacterSpellSlotUsagesTableOrderingComposer,
      $$CharacterSpellSlotUsagesTableAnnotationComposer,
      $$CharacterSpellSlotUsagesTableCreateCompanionBuilder,
      $$CharacterSpellSlotUsagesTableUpdateCompanionBuilder,
      (CharacterSpellSlotUsage, $$CharacterSpellSlotUsagesTableReferences),
      CharacterSpellSlotUsage,
      PrefetchHooks Function({bool characterId})
    >;
typedef $$SkillDefinitionsTableCreateCompanionBuilder =
    SkillDefinitionsCompanion Function({
      required String id,
      required String key,
      required String name,
      required String governingAbility,
      Value<String?> description,
      Value<int> rowid,
    });
typedef $$SkillDefinitionsTableUpdateCompanionBuilder =
    SkillDefinitionsCompanion Function({
      Value<String> id,
      Value<String> key,
      Value<String> name,
      Value<String> governingAbility,
      Value<String?> description,
      Value<int> rowid,
    });

final class $$SkillDefinitionsTableReferences
    extends
        BaseReferences<_$AppDatabase, $SkillDefinitionsTable, SkillDefinition> {
  $$SkillDefinitionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$CharacterSkillsTable, List<CharacterSkill>>
  _characterSkillsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.characterSkills,
    aliasName: $_aliasNameGenerator(
      db.skillDefinitions.id,
      db.characterSkills.skillDefinitionId,
    ),
  );

  $$CharacterSkillsTableProcessedTableManager get characterSkillsRefs {
    final manager =
        $$CharacterSkillsTableTableManager($_db, $_db.characterSkills).filter(
          (f) => f.skillDefinitionId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _characterSkillsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SkillDefinitionsTableFilterComposer
    extends Composer<_$AppDatabase, $SkillDefinitionsTable> {
  $$SkillDefinitionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get governingAbility => $composableBuilder(
    column: $table.governingAbility,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> characterSkillsRefs(
    Expression<bool> Function($$CharacterSkillsTableFilterComposer f) f,
  ) {
    final $$CharacterSkillsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.characterSkills,
      getReferencedColumn: (t) => t.skillDefinitionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharacterSkillsTableFilterComposer(
            $db: $db,
            $table: $db.characterSkills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SkillDefinitionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SkillDefinitionsTable> {
  $$SkillDefinitionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get governingAbility => $composableBuilder(
    column: $table.governingAbility,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SkillDefinitionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SkillDefinitionsTable> {
  $$SkillDefinitionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get governingAbility => $composableBuilder(
    column: $table.governingAbility,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  Expression<T> characterSkillsRefs<T extends Object>(
    Expression<T> Function($$CharacterSkillsTableAnnotationComposer a) f,
  ) {
    final $$CharacterSkillsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.characterSkills,
      getReferencedColumn: (t) => t.skillDefinitionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharacterSkillsTableAnnotationComposer(
            $db: $db,
            $table: $db.characterSkills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SkillDefinitionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SkillDefinitionsTable,
          SkillDefinition,
          $$SkillDefinitionsTableFilterComposer,
          $$SkillDefinitionsTableOrderingComposer,
          $$SkillDefinitionsTableAnnotationComposer,
          $$SkillDefinitionsTableCreateCompanionBuilder,
          $$SkillDefinitionsTableUpdateCompanionBuilder,
          (SkillDefinition, $$SkillDefinitionsTableReferences),
          SkillDefinition,
          PrefetchHooks Function({bool characterSkillsRefs})
        > {
  $$SkillDefinitionsTableTableManager(
    _$AppDatabase db,
    $SkillDefinitionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SkillDefinitionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SkillDefinitionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SkillDefinitionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> key = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> governingAbility = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SkillDefinitionsCompanion(
                id: id,
                key: key,
                name: name,
                governingAbility: governingAbility,
                description: description,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String key,
                required String name,
                required String governingAbility,
                Value<String?> description = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SkillDefinitionsCompanion.insert(
                id: id,
                key: key,
                name: name,
                governingAbility: governingAbility,
                description: description,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SkillDefinitionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({characterSkillsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (characterSkillsRefs) db.characterSkills,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (characterSkillsRefs)
                    await $_getPrefetchedData<
                      SkillDefinition,
                      $SkillDefinitionsTable,
                      CharacterSkill
                    >(
                      currentTable: table,
                      referencedTable: $$SkillDefinitionsTableReferences
                          ._characterSkillsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$SkillDefinitionsTableReferences(
                            db,
                            table,
                            p0,
                          ).characterSkillsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.skillDefinitionId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SkillDefinitionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SkillDefinitionsTable,
      SkillDefinition,
      $$SkillDefinitionsTableFilterComposer,
      $$SkillDefinitionsTableOrderingComposer,
      $$SkillDefinitionsTableAnnotationComposer,
      $$SkillDefinitionsTableCreateCompanionBuilder,
      $$SkillDefinitionsTableUpdateCompanionBuilder,
      (SkillDefinition, $$SkillDefinitionsTableReferences),
      SkillDefinition,
      PrefetchHooks Function({bool characterSkillsRefs})
    >;
typedef $$CharacterSkillsTableCreateCompanionBuilder =
    CharacterSkillsCompanion Function({
      required String characterId,
      required String skillDefinitionId,
      Value<bool> isProficient,
      Value<bool> hasExpertise,
      Value<int> miscBonus,
      Value<int?> totalBonus,
      Value<int> rowid,
    });
typedef $$CharacterSkillsTableUpdateCompanionBuilder =
    CharacterSkillsCompanion Function({
      Value<String> characterId,
      Value<String> skillDefinitionId,
      Value<bool> isProficient,
      Value<bool> hasExpertise,
      Value<int> miscBonus,
      Value<int?> totalBonus,
      Value<int> rowid,
    });

final class $$CharacterSkillsTableReferences
    extends
        BaseReferences<_$AppDatabase, $CharacterSkillsTable, CharacterSkill> {
  $$CharacterSkillsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CharactersTable _characterIdTable(_$AppDatabase db) =>
      db.characters.createAlias(
        $_aliasNameGenerator(db.characterSkills.characterId, db.characters.id),
      );

  $$CharactersTableProcessedTableManager get characterId {
    final $_column = $_itemColumn<String>('character_id')!;

    final manager = $$CharactersTableTableManager(
      $_db,
      $_db.characters,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_characterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $SkillDefinitionsTable _skillDefinitionIdTable(_$AppDatabase db) =>
      db.skillDefinitions.createAlias(
        $_aliasNameGenerator(
          db.characterSkills.skillDefinitionId,
          db.skillDefinitions.id,
        ),
      );

  $$SkillDefinitionsTableProcessedTableManager get skillDefinitionId {
    final $_column = $_itemColumn<String>('skill_definition_id')!;

    final manager = $$SkillDefinitionsTableTableManager(
      $_db,
      $_db.skillDefinitions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_skillDefinitionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CharacterSkillsTableFilterComposer
    extends Composer<_$AppDatabase, $CharacterSkillsTable> {
  $$CharacterSkillsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<bool> get isProficient => $composableBuilder(
    column: $table.isProficient,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasExpertise => $composableBuilder(
    column: $table.hasExpertise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get miscBonus => $composableBuilder(
    column: $table.miscBonus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalBonus => $composableBuilder(
    column: $table.totalBonus,
    builder: (column) => ColumnFilters(column),
  );

  $$CharactersTableFilterComposer get characterId {
    final $$CharactersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableFilterComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SkillDefinitionsTableFilterComposer get skillDefinitionId {
    final $$SkillDefinitionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.skillDefinitionId,
      referencedTable: $db.skillDefinitions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillDefinitionsTableFilterComposer(
            $db: $db,
            $table: $db.skillDefinitions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CharacterSkillsTableOrderingComposer
    extends Composer<_$AppDatabase, $CharacterSkillsTable> {
  $$CharacterSkillsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<bool> get isProficient => $composableBuilder(
    column: $table.isProficient,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasExpertise => $composableBuilder(
    column: $table.hasExpertise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get miscBonus => $composableBuilder(
    column: $table.miscBonus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalBonus => $composableBuilder(
    column: $table.totalBonus,
    builder: (column) => ColumnOrderings(column),
  );

  $$CharactersTableOrderingComposer get characterId {
    final $$CharactersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableOrderingComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SkillDefinitionsTableOrderingComposer get skillDefinitionId {
    final $$SkillDefinitionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.skillDefinitionId,
      referencedTable: $db.skillDefinitions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillDefinitionsTableOrderingComposer(
            $db: $db,
            $table: $db.skillDefinitions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CharacterSkillsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CharacterSkillsTable> {
  $$CharacterSkillsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<bool> get isProficient => $composableBuilder(
    column: $table.isProficient,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get hasExpertise => $composableBuilder(
    column: $table.hasExpertise,
    builder: (column) => column,
  );

  GeneratedColumn<int> get miscBonus =>
      $composableBuilder(column: $table.miscBonus, builder: (column) => column);

  GeneratedColumn<int> get totalBonus => $composableBuilder(
    column: $table.totalBonus,
    builder: (column) => column,
  );

  $$CharactersTableAnnotationComposer get characterId {
    final $$CharactersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableAnnotationComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SkillDefinitionsTableAnnotationComposer get skillDefinitionId {
    final $$SkillDefinitionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.skillDefinitionId,
      referencedTable: $db.skillDefinitions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SkillDefinitionsTableAnnotationComposer(
            $db: $db,
            $table: $db.skillDefinitions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CharacterSkillsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CharacterSkillsTable,
          CharacterSkill,
          $$CharacterSkillsTableFilterComposer,
          $$CharacterSkillsTableOrderingComposer,
          $$CharacterSkillsTableAnnotationComposer,
          $$CharacterSkillsTableCreateCompanionBuilder,
          $$CharacterSkillsTableUpdateCompanionBuilder,
          (CharacterSkill, $$CharacterSkillsTableReferences),
          CharacterSkill,
          PrefetchHooks Function({bool characterId, bool skillDefinitionId})
        > {
  $$CharacterSkillsTableTableManager(
    _$AppDatabase db,
    $CharacterSkillsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CharacterSkillsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CharacterSkillsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CharacterSkillsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> characterId = const Value.absent(),
                Value<String> skillDefinitionId = const Value.absent(),
                Value<bool> isProficient = const Value.absent(),
                Value<bool> hasExpertise = const Value.absent(),
                Value<int> miscBonus = const Value.absent(),
                Value<int?> totalBonus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CharacterSkillsCompanion(
                characterId: characterId,
                skillDefinitionId: skillDefinitionId,
                isProficient: isProficient,
                hasExpertise: hasExpertise,
                miscBonus: miscBonus,
                totalBonus: totalBonus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String characterId,
                required String skillDefinitionId,
                Value<bool> isProficient = const Value.absent(),
                Value<bool> hasExpertise = const Value.absent(),
                Value<int> miscBonus = const Value.absent(),
                Value<int?> totalBonus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CharacterSkillsCompanion.insert(
                characterId: characterId,
                skillDefinitionId: skillDefinitionId,
                isProficient: isProficient,
                hasExpertise: hasExpertise,
                miscBonus: miscBonus,
                totalBonus: totalBonus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CharacterSkillsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({characterId = false, skillDefinitionId = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (characterId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.characterId,
                                    referencedTable:
                                        $$CharacterSkillsTableReferences
                                            ._characterIdTable(db),
                                    referencedColumn:
                                        $$CharacterSkillsTableReferences
                                            ._characterIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (skillDefinitionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.skillDefinitionId,
                                    referencedTable:
                                        $$CharacterSkillsTableReferences
                                            ._skillDefinitionIdTable(db),
                                    referencedColumn:
                                        $$CharacterSkillsTableReferences
                                            ._skillDefinitionIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$CharacterSkillsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CharacterSkillsTable,
      CharacterSkill,
      $$CharacterSkillsTableFilterComposer,
      $$CharacterSkillsTableOrderingComposer,
      $$CharacterSkillsTableAnnotationComposer,
      $$CharacterSkillsTableCreateCompanionBuilder,
      $$CharacterSkillsTableUpdateCompanionBuilder,
      (CharacterSkill, $$CharacterSkillsTableReferences),
      CharacterSkill,
      PrefetchHooks Function({bool characterId, bool skillDefinitionId})
    >;
typedef $$CharacterSavingThrowsTableCreateCompanionBuilder =
    CharacterSavingThrowsCompanion Function({
      required String characterId,
      required String abilityKey,
      Value<bool> isProficient,
      Value<int> miscBonus,
      Value<int?> totalBonus,
      Value<int> rowid,
    });
typedef $$CharacterSavingThrowsTableUpdateCompanionBuilder =
    CharacterSavingThrowsCompanion Function({
      Value<String> characterId,
      Value<String> abilityKey,
      Value<bool> isProficient,
      Value<int> miscBonus,
      Value<int?> totalBonus,
      Value<int> rowid,
    });

final class $$CharacterSavingThrowsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CharacterSavingThrowsTable,
          CharacterSavingThrow
        > {
  $$CharacterSavingThrowsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CharactersTable _characterIdTable(_$AppDatabase db) =>
      db.characters.createAlias(
        $_aliasNameGenerator(
          db.characterSavingThrows.characterId,
          db.characters.id,
        ),
      );

  $$CharactersTableProcessedTableManager get characterId {
    final $_column = $_itemColumn<String>('character_id')!;

    final manager = $$CharactersTableTableManager(
      $_db,
      $_db.characters,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_characterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CharacterSavingThrowsTableFilterComposer
    extends Composer<_$AppDatabase, $CharacterSavingThrowsTable> {
  $$CharacterSavingThrowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get abilityKey => $composableBuilder(
    column: $table.abilityKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isProficient => $composableBuilder(
    column: $table.isProficient,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get miscBonus => $composableBuilder(
    column: $table.miscBonus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalBonus => $composableBuilder(
    column: $table.totalBonus,
    builder: (column) => ColumnFilters(column),
  );

  $$CharactersTableFilterComposer get characterId {
    final $$CharactersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableFilterComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CharacterSavingThrowsTableOrderingComposer
    extends Composer<_$AppDatabase, $CharacterSavingThrowsTable> {
  $$CharacterSavingThrowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get abilityKey => $composableBuilder(
    column: $table.abilityKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isProficient => $composableBuilder(
    column: $table.isProficient,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get miscBonus => $composableBuilder(
    column: $table.miscBonus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalBonus => $composableBuilder(
    column: $table.totalBonus,
    builder: (column) => ColumnOrderings(column),
  );

  $$CharactersTableOrderingComposer get characterId {
    final $$CharactersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableOrderingComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CharacterSavingThrowsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CharacterSavingThrowsTable> {
  $$CharacterSavingThrowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get abilityKey => $composableBuilder(
    column: $table.abilityKey,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isProficient => $composableBuilder(
    column: $table.isProficient,
    builder: (column) => column,
  );

  GeneratedColumn<int> get miscBonus =>
      $composableBuilder(column: $table.miscBonus, builder: (column) => column);

  GeneratedColumn<int> get totalBonus => $composableBuilder(
    column: $table.totalBonus,
    builder: (column) => column,
  );

  $$CharactersTableAnnotationComposer get characterId {
    final $$CharactersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableAnnotationComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CharacterSavingThrowsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CharacterSavingThrowsTable,
          CharacterSavingThrow,
          $$CharacterSavingThrowsTableFilterComposer,
          $$CharacterSavingThrowsTableOrderingComposer,
          $$CharacterSavingThrowsTableAnnotationComposer,
          $$CharacterSavingThrowsTableCreateCompanionBuilder,
          $$CharacterSavingThrowsTableUpdateCompanionBuilder,
          (CharacterSavingThrow, $$CharacterSavingThrowsTableReferences),
          CharacterSavingThrow,
          PrefetchHooks Function({bool characterId})
        > {
  $$CharacterSavingThrowsTableTableManager(
    _$AppDatabase db,
    $CharacterSavingThrowsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CharacterSavingThrowsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$CharacterSavingThrowsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CharacterSavingThrowsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> characterId = const Value.absent(),
                Value<String> abilityKey = const Value.absent(),
                Value<bool> isProficient = const Value.absent(),
                Value<int> miscBonus = const Value.absent(),
                Value<int?> totalBonus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CharacterSavingThrowsCompanion(
                characterId: characterId,
                abilityKey: abilityKey,
                isProficient: isProficient,
                miscBonus: miscBonus,
                totalBonus: totalBonus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String characterId,
                required String abilityKey,
                Value<bool> isProficient = const Value.absent(),
                Value<int> miscBonus = const Value.absent(),
                Value<int?> totalBonus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CharacterSavingThrowsCompanion.insert(
                characterId: characterId,
                abilityKey: abilityKey,
                isProficient: isProficient,
                miscBonus: miscBonus,
                totalBonus: totalBonus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CharacterSavingThrowsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({characterId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (characterId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.characterId,
                                referencedTable:
                                    $$CharacterSavingThrowsTableReferences
                                        ._characterIdTable(db),
                                referencedColumn:
                                    $$CharacterSavingThrowsTableReferences
                                        ._characterIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CharacterSavingThrowsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CharacterSavingThrowsTable,
      CharacterSavingThrow,
      $$CharacterSavingThrowsTableFilterComposer,
      $$CharacterSavingThrowsTableOrderingComposer,
      $$CharacterSavingThrowsTableAnnotationComposer,
      $$CharacterSavingThrowsTableCreateCompanionBuilder,
      $$CharacterSavingThrowsTableUpdateCompanionBuilder,
      (CharacterSavingThrow, $$CharacterSavingThrowsTableReferences),
      CharacterSavingThrow,
      PrefetchHooks Function({bool characterId})
    >;
typedef $$EquipmentDefinitionsTableCreateCompanionBuilder =
    EquipmentDefinitionsCompanion Function({
      required String id,
      required String key,
      required String name,
      required String category,
      Value<String?> subcategory,
      Value<int?> weight,
      Value<int?> costValue,
      Value<String?> costUnit,
      Value<bool> isContainer,
      Value<bool> isStackable,
      Value<String?> description,
      Value<String?> weaponPropertiesJson,
      Value<String?> armorPropertiesJson,
      Value<int> rowid,
    });
typedef $$EquipmentDefinitionsTableUpdateCompanionBuilder =
    EquipmentDefinitionsCompanion Function({
      Value<String> id,
      Value<String> key,
      Value<String> name,
      Value<String> category,
      Value<String?> subcategory,
      Value<int?> weight,
      Value<int?> costValue,
      Value<String?> costUnit,
      Value<bool> isContainer,
      Value<bool> isStackable,
      Value<String?> description,
      Value<String?> weaponPropertiesJson,
      Value<String?> armorPropertiesJson,
      Value<int> rowid,
    });

final class $$EquipmentDefinitionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $EquipmentDefinitionsTable,
          EquipmentDefinition
        > {
  $$EquipmentDefinitionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $CharacterInventoryTable,
    List<CharacterInventoryData>
  >
  _characterInventoryRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.characterInventory,
        aliasName: $_aliasNameGenerator(
          db.equipmentDefinitions.id,
          db.characterInventory.equipmentDefinitionId,
        ),
      );

  $$CharacterInventoryTableProcessedTableManager get characterInventoryRefs {
    final manager =
        $$CharacterInventoryTableTableManager(
          $_db,
          $_db.characterInventory,
        ).filter(
          (f) =>
              f.equipmentDefinitionId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _characterInventoryRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EquipmentDefinitionsTableFilterComposer
    extends Composer<_$AppDatabase, $EquipmentDefinitionsTable> {
  $$EquipmentDefinitionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subcategory => $composableBuilder(
    column: $table.subcategory,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get costValue => $composableBuilder(
    column: $table.costValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get costUnit => $composableBuilder(
    column: $table.costUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isContainer => $composableBuilder(
    column: $table.isContainer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isStackable => $composableBuilder(
    column: $table.isStackable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get weaponPropertiesJson => $composableBuilder(
    column: $table.weaponPropertiesJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get armorPropertiesJson => $composableBuilder(
    column: $table.armorPropertiesJson,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> characterInventoryRefs(
    Expression<bool> Function($$CharacterInventoryTableFilterComposer f) f,
  ) {
    final $$CharacterInventoryTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.characterInventory,
      getReferencedColumn: (t) => t.equipmentDefinitionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharacterInventoryTableFilterComposer(
            $db: $db,
            $table: $db.characterInventory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EquipmentDefinitionsTableOrderingComposer
    extends Composer<_$AppDatabase, $EquipmentDefinitionsTable> {
  $$EquipmentDefinitionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subcategory => $composableBuilder(
    column: $table.subcategory,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get costValue => $composableBuilder(
    column: $table.costValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get costUnit => $composableBuilder(
    column: $table.costUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isContainer => $composableBuilder(
    column: $table.isContainer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isStackable => $composableBuilder(
    column: $table.isStackable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weaponPropertiesJson => $composableBuilder(
    column: $table.weaponPropertiesJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get armorPropertiesJson => $composableBuilder(
    column: $table.armorPropertiesJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EquipmentDefinitionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EquipmentDefinitionsTable> {
  $$EquipmentDefinitionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get subcategory => $composableBuilder(
    column: $table.subcategory,
    builder: (column) => column,
  );

  GeneratedColumn<int> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<int> get costValue =>
      $composableBuilder(column: $table.costValue, builder: (column) => column);

  GeneratedColumn<String> get costUnit =>
      $composableBuilder(column: $table.costUnit, builder: (column) => column);

  GeneratedColumn<bool> get isContainer => $composableBuilder(
    column: $table.isContainer,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isStackable => $composableBuilder(
    column: $table.isStackable,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get weaponPropertiesJson => $composableBuilder(
    column: $table.weaponPropertiesJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get armorPropertiesJson => $composableBuilder(
    column: $table.armorPropertiesJson,
    builder: (column) => column,
  );

  Expression<T> characterInventoryRefs<T extends Object>(
    Expression<T> Function($$CharacterInventoryTableAnnotationComposer a) f,
  ) {
    final $$CharacterInventoryTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.characterInventory,
          getReferencedColumn: (t) => t.equipmentDefinitionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CharacterInventoryTableAnnotationComposer(
                $db: $db,
                $table: $db.characterInventory,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$EquipmentDefinitionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EquipmentDefinitionsTable,
          EquipmentDefinition,
          $$EquipmentDefinitionsTableFilterComposer,
          $$EquipmentDefinitionsTableOrderingComposer,
          $$EquipmentDefinitionsTableAnnotationComposer,
          $$EquipmentDefinitionsTableCreateCompanionBuilder,
          $$EquipmentDefinitionsTableUpdateCompanionBuilder,
          (EquipmentDefinition, $$EquipmentDefinitionsTableReferences),
          EquipmentDefinition,
          PrefetchHooks Function({bool characterInventoryRefs})
        > {
  $$EquipmentDefinitionsTableTableManager(
    _$AppDatabase db,
    $EquipmentDefinitionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EquipmentDefinitionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EquipmentDefinitionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$EquipmentDefinitionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> key = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String?> subcategory = const Value.absent(),
                Value<int?> weight = const Value.absent(),
                Value<int?> costValue = const Value.absent(),
                Value<String?> costUnit = const Value.absent(),
                Value<bool> isContainer = const Value.absent(),
                Value<bool> isStackable = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> weaponPropertiesJson = const Value.absent(),
                Value<String?> armorPropertiesJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EquipmentDefinitionsCompanion(
                id: id,
                key: key,
                name: name,
                category: category,
                subcategory: subcategory,
                weight: weight,
                costValue: costValue,
                costUnit: costUnit,
                isContainer: isContainer,
                isStackable: isStackable,
                description: description,
                weaponPropertiesJson: weaponPropertiesJson,
                armorPropertiesJson: armorPropertiesJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String key,
                required String name,
                required String category,
                Value<String?> subcategory = const Value.absent(),
                Value<int?> weight = const Value.absent(),
                Value<int?> costValue = const Value.absent(),
                Value<String?> costUnit = const Value.absent(),
                Value<bool> isContainer = const Value.absent(),
                Value<bool> isStackable = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> weaponPropertiesJson = const Value.absent(),
                Value<String?> armorPropertiesJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EquipmentDefinitionsCompanion.insert(
                id: id,
                key: key,
                name: name,
                category: category,
                subcategory: subcategory,
                weight: weight,
                costValue: costValue,
                costUnit: costUnit,
                isContainer: isContainer,
                isStackable: isStackable,
                description: description,
                weaponPropertiesJson: weaponPropertiesJson,
                armorPropertiesJson: armorPropertiesJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EquipmentDefinitionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({characterInventoryRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (characterInventoryRefs) db.characterInventory,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (characterInventoryRefs)
                    await $_getPrefetchedData<
                      EquipmentDefinition,
                      $EquipmentDefinitionsTable,
                      CharacterInventoryData
                    >(
                      currentTable: table,
                      referencedTable: $$EquipmentDefinitionsTableReferences
                          ._characterInventoryRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$EquipmentDefinitionsTableReferences(
                            db,
                            table,
                            p0,
                          ).characterInventoryRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.equipmentDefinitionId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$EquipmentDefinitionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EquipmentDefinitionsTable,
      EquipmentDefinition,
      $$EquipmentDefinitionsTableFilterComposer,
      $$EquipmentDefinitionsTableOrderingComposer,
      $$EquipmentDefinitionsTableAnnotationComposer,
      $$EquipmentDefinitionsTableCreateCompanionBuilder,
      $$EquipmentDefinitionsTableUpdateCompanionBuilder,
      (EquipmentDefinition, $$EquipmentDefinitionsTableReferences),
      EquipmentDefinition,
      PrefetchHooks Function({bool characterInventoryRefs})
    >;
typedef $$TrinketDefinitionsTableCreateCompanionBuilder =
    TrinketDefinitionsCompanion Function({
      required String id,
      required String key,
      required String name,
      Value<String?> description,
      Value<int> rowid,
    });
typedef $$TrinketDefinitionsTableUpdateCompanionBuilder =
    TrinketDefinitionsCompanion Function({
      Value<String> id,
      Value<String> key,
      Value<String> name,
      Value<String?> description,
      Value<int> rowid,
    });

final class $$TrinketDefinitionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $TrinketDefinitionsTable,
          TrinketDefinition
        > {
  $$TrinketDefinitionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $CharacterInventoryTable,
    List<CharacterInventoryData>
  >
  _characterInventoryRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.characterInventory,
        aliasName: $_aliasNameGenerator(
          db.trinketDefinitions.id,
          db.characterInventory.trinketDefinitionId,
        ),
      );

  $$CharacterInventoryTableProcessedTableManager get characterInventoryRefs {
    final manager =
        $$CharacterInventoryTableTableManager(
          $_db,
          $_db.characterInventory,
        ).filter(
          (f) =>
              f.trinketDefinitionId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _characterInventoryRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TrinketDefinitionsTableFilterComposer
    extends Composer<_$AppDatabase, $TrinketDefinitionsTable> {
  $$TrinketDefinitionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> characterInventoryRefs(
    Expression<bool> Function($$CharacterInventoryTableFilterComposer f) f,
  ) {
    final $$CharacterInventoryTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.characterInventory,
      getReferencedColumn: (t) => t.trinketDefinitionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharacterInventoryTableFilterComposer(
            $db: $db,
            $table: $db.characterInventory,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TrinketDefinitionsTableOrderingComposer
    extends Composer<_$AppDatabase, $TrinketDefinitionsTable> {
  $$TrinketDefinitionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TrinketDefinitionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrinketDefinitionsTable> {
  $$TrinketDefinitionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  Expression<T> characterInventoryRefs<T extends Object>(
    Expression<T> Function($$CharacterInventoryTableAnnotationComposer a) f,
  ) {
    final $$CharacterInventoryTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.characterInventory,
          getReferencedColumn: (t) => t.trinketDefinitionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CharacterInventoryTableAnnotationComposer(
                $db: $db,
                $table: $db.characterInventory,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$TrinketDefinitionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TrinketDefinitionsTable,
          TrinketDefinition,
          $$TrinketDefinitionsTableFilterComposer,
          $$TrinketDefinitionsTableOrderingComposer,
          $$TrinketDefinitionsTableAnnotationComposer,
          $$TrinketDefinitionsTableCreateCompanionBuilder,
          $$TrinketDefinitionsTableUpdateCompanionBuilder,
          (TrinketDefinition, $$TrinketDefinitionsTableReferences),
          TrinketDefinition,
          PrefetchHooks Function({bool characterInventoryRefs})
        > {
  $$TrinketDefinitionsTableTableManager(
    _$AppDatabase db,
    $TrinketDefinitionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrinketDefinitionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrinketDefinitionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrinketDefinitionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> key = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TrinketDefinitionsCompanion(
                id: id,
                key: key,
                name: name,
                description: description,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String key,
                required String name,
                Value<String?> description = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TrinketDefinitionsCompanion.insert(
                id: id,
                key: key,
                name: name,
                description: description,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TrinketDefinitionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({characterInventoryRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (characterInventoryRefs) db.characterInventory,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (characterInventoryRefs)
                    await $_getPrefetchedData<
                      TrinketDefinition,
                      $TrinketDefinitionsTable,
                      CharacterInventoryData
                    >(
                      currentTable: table,
                      referencedTable: $$TrinketDefinitionsTableReferences
                          ._characterInventoryRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$TrinketDefinitionsTableReferences(
                            db,
                            table,
                            p0,
                          ).characterInventoryRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.trinketDefinitionId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TrinketDefinitionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TrinketDefinitionsTable,
      TrinketDefinition,
      $$TrinketDefinitionsTableFilterComposer,
      $$TrinketDefinitionsTableOrderingComposer,
      $$TrinketDefinitionsTableAnnotationComposer,
      $$TrinketDefinitionsTableCreateCompanionBuilder,
      $$TrinketDefinitionsTableUpdateCompanionBuilder,
      (TrinketDefinition, $$TrinketDefinitionsTableReferences),
      TrinketDefinition,
      PrefetchHooks Function({bool characterInventoryRefs})
    >;
typedef $$CharacterInventoryTableCreateCompanionBuilder =
    CharacterInventoryCompanion Function({
      required String id,
      required String characterId,
      Value<String?> equipmentDefinitionId,
      Value<String?> trinketDefinitionId,
      Value<String?> displayNameSnapshot,
      Value<int> quantity,
      Value<bool> isEquipped,
      Value<bool> isCarried,
      Value<bool> isFavorite,
      Value<int?> chargesCurrent,
      Value<int?> chargesMax,
      Value<String?> containerInventoryItemId,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$CharacterInventoryTableUpdateCompanionBuilder =
    CharacterInventoryCompanion Function({
      Value<String> id,
      Value<String> characterId,
      Value<String?> equipmentDefinitionId,
      Value<String?> trinketDefinitionId,
      Value<String?> displayNameSnapshot,
      Value<int> quantity,
      Value<bool> isEquipped,
      Value<bool> isCarried,
      Value<bool> isFavorite,
      Value<int?> chargesCurrent,
      Value<int?> chargesMax,
      Value<String?> containerInventoryItemId,
      Value<String?> notes,
      Value<int> rowid,
    });

final class $$CharacterInventoryTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CharacterInventoryTable,
          CharacterInventoryData
        > {
  $$CharacterInventoryTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CharactersTable _characterIdTable(_$AppDatabase db) =>
      db.characters.createAlias(
        $_aliasNameGenerator(
          db.characterInventory.characterId,
          db.characters.id,
        ),
      );

  $$CharactersTableProcessedTableManager get characterId {
    final $_column = $_itemColumn<String>('character_id')!;

    final manager = $$CharactersTableTableManager(
      $_db,
      $_db.characters,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_characterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $EquipmentDefinitionsTable _equipmentDefinitionIdTable(
    _$AppDatabase db,
  ) => db.equipmentDefinitions.createAlias(
    $_aliasNameGenerator(
      db.characterInventory.equipmentDefinitionId,
      db.equipmentDefinitions.id,
    ),
  );

  $$EquipmentDefinitionsTableProcessedTableManager? get equipmentDefinitionId {
    final $_column = $_itemColumn<String>('equipment_definition_id');
    if ($_column == null) return null;
    final manager = $$EquipmentDefinitionsTableTableManager(
      $_db,
      $_db.equipmentDefinitions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(
      _equipmentDefinitionIdTable($_db),
    );
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TrinketDefinitionsTable _trinketDefinitionIdTable(_$AppDatabase db) =>
      db.trinketDefinitions.createAlias(
        $_aliasNameGenerator(
          db.characterInventory.trinketDefinitionId,
          db.trinketDefinitions.id,
        ),
      );

  $$TrinketDefinitionsTableProcessedTableManager? get trinketDefinitionId {
    final $_column = $_itemColumn<String>('trinket_definition_id');
    if ($_column == null) return null;
    final manager = $$TrinketDefinitionsTableTableManager(
      $_db,
      $_db.trinketDefinitions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_trinketDefinitionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CharacterInventoryTableFilterComposer
    extends Composer<_$AppDatabase, $CharacterInventoryTable> {
  $$CharacterInventoryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayNameSnapshot => $composableBuilder(
    column: $table.displayNameSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEquipped => $composableBuilder(
    column: $table.isEquipped,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCarried => $composableBuilder(
    column: $table.isCarried,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get chargesCurrent => $composableBuilder(
    column: $table.chargesCurrent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get chargesMax => $composableBuilder(
    column: $table.chargesMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get containerInventoryItemId => $composableBuilder(
    column: $table.containerInventoryItemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$CharactersTableFilterComposer get characterId {
    final $$CharactersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableFilterComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EquipmentDefinitionsTableFilterComposer get equipmentDefinitionId {
    final $$EquipmentDefinitionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.equipmentDefinitionId,
      referencedTable: $db.equipmentDefinitions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EquipmentDefinitionsTableFilterComposer(
            $db: $db,
            $table: $db.equipmentDefinitions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TrinketDefinitionsTableFilterComposer get trinketDefinitionId {
    final $$TrinketDefinitionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trinketDefinitionId,
      referencedTable: $db.trinketDefinitions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrinketDefinitionsTableFilterComposer(
            $db: $db,
            $table: $db.trinketDefinitions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CharacterInventoryTableOrderingComposer
    extends Composer<_$AppDatabase, $CharacterInventoryTable> {
  $$CharacterInventoryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayNameSnapshot => $composableBuilder(
    column: $table.displayNameSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEquipped => $composableBuilder(
    column: $table.isEquipped,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCarried => $composableBuilder(
    column: $table.isCarried,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get chargesCurrent => $composableBuilder(
    column: $table.chargesCurrent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get chargesMax => $composableBuilder(
    column: $table.chargesMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get containerInventoryItemId => $composableBuilder(
    column: $table.containerInventoryItemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$CharactersTableOrderingComposer get characterId {
    final $$CharactersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableOrderingComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EquipmentDefinitionsTableOrderingComposer get equipmentDefinitionId {
    final $$EquipmentDefinitionsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.equipmentDefinitionId,
          referencedTable: $db.equipmentDefinitions,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$EquipmentDefinitionsTableOrderingComposer(
                $db: $db,
                $table: $db.equipmentDefinitions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$TrinketDefinitionsTableOrderingComposer get trinketDefinitionId {
    final $$TrinketDefinitionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.trinketDefinitionId,
      referencedTable: $db.trinketDefinitions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrinketDefinitionsTableOrderingComposer(
            $db: $db,
            $table: $db.trinketDefinitions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CharacterInventoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $CharacterInventoryTable> {
  $$CharacterInventoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get displayNameSnapshot => $composableBuilder(
    column: $table.displayNameSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<bool> get isEquipped => $composableBuilder(
    column: $table.isEquipped,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCarried =>
      $composableBuilder(column: $table.isCarried, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<int> get chargesCurrent => $composableBuilder(
    column: $table.chargesCurrent,
    builder: (column) => column,
  );

  GeneratedColumn<int> get chargesMax => $composableBuilder(
    column: $table.chargesMax,
    builder: (column) => column,
  );

  GeneratedColumn<String> get containerInventoryItemId => $composableBuilder(
    column: $table.containerInventoryItemId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$CharactersTableAnnotationComposer get characterId {
    final $$CharactersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableAnnotationComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$EquipmentDefinitionsTableAnnotationComposer get equipmentDefinitionId {
    final $$EquipmentDefinitionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.equipmentDefinitionId,
          referencedTable: $db.equipmentDefinitions,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$EquipmentDefinitionsTableAnnotationComposer(
                $db: $db,
                $table: $db.equipmentDefinitions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$TrinketDefinitionsTableAnnotationComposer get trinketDefinitionId {
    final $$TrinketDefinitionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.trinketDefinitionId,
          referencedTable: $db.trinketDefinitions,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TrinketDefinitionsTableAnnotationComposer(
                $db: $db,
                $table: $db.trinketDefinitions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$CharacterInventoryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CharacterInventoryTable,
          CharacterInventoryData,
          $$CharacterInventoryTableFilterComposer,
          $$CharacterInventoryTableOrderingComposer,
          $$CharacterInventoryTableAnnotationComposer,
          $$CharacterInventoryTableCreateCompanionBuilder,
          $$CharacterInventoryTableUpdateCompanionBuilder,
          (CharacterInventoryData, $$CharacterInventoryTableReferences),
          CharacterInventoryData,
          PrefetchHooks Function({
            bool characterId,
            bool equipmentDefinitionId,
            bool trinketDefinitionId,
          })
        > {
  $$CharacterInventoryTableTableManager(
    _$AppDatabase db,
    $CharacterInventoryTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CharacterInventoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CharacterInventoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CharacterInventoryTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> characterId = const Value.absent(),
                Value<String?> equipmentDefinitionId = const Value.absent(),
                Value<String?> trinketDefinitionId = const Value.absent(),
                Value<String?> displayNameSnapshot = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<bool> isEquipped = const Value.absent(),
                Value<bool> isCarried = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<int?> chargesCurrent = const Value.absent(),
                Value<int?> chargesMax = const Value.absent(),
                Value<String?> containerInventoryItemId = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CharacterInventoryCompanion(
                id: id,
                characterId: characterId,
                equipmentDefinitionId: equipmentDefinitionId,
                trinketDefinitionId: trinketDefinitionId,
                displayNameSnapshot: displayNameSnapshot,
                quantity: quantity,
                isEquipped: isEquipped,
                isCarried: isCarried,
                isFavorite: isFavorite,
                chargesCurrent: chargesCurrent,
                chargesMax: chargesMax,
                containerInventoryItemId: containerInventoryItemId,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String characterId,
                Value<String?> equipmentDefinitionId = const Value.absent(),
                Value<String?> trinketDefinitionId = const Value.absent(),
                Value<String?> displayNameSnapshot = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<bool> isEquipped = const Value.absent(),
                Value<bool> isCarried = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<int?> chargesCurrent = const Value.absent(),
                Value<int?> chargesMax = const Value.absent(),
                Value<String?> containerInventoryItemId = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CharacterInventoryCompanion.insert(
                id: id,
                characterId: characterId,
                equipmentDefinitionId: equipmentDefinitionId,
                trinketDefinitionId: trinketDefinitionId,
                displayNameSnapshot: displayNameSnapshot,
                quantity: quantity,
                isEquipped: isEquipped,
                isCarried: isCarried,
                isFavorite: isFavorite,
                chargesCurrent: chargesCurrent,
                chargesMax: chargesMax,
                containerInventoryItemId: containerInventoryItemId,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CharacterInventoryTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                characterId = false,
                equipmentDefinitionId = false,
                trinketDefinitionId = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (characterId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.characterId,
                                    referencedTable:
                                        $$CharacterInventoryTableReferences
                                            ._characterIdTable(db),
                                    referencedColumn:
                                        $$CharacterInventoryTableReferences
                                            ._characterIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (equipmentDefinitionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.equipmentDefinitionId,
                                    referencedTable:
                                        $$CharacterInventoryTableReferences
                                            ._equipmentDefinitionIdTable(db),
                                    referencedColumn:
                                        $$CharacterInventoryTableReferences
                                            ._equipmentDefinitionIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (trinketDefinitionId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.trinketDefinitionId,
                                    referencedTable:
                                        $$CharacterInventoryTableReferences
                                            ._trinketDefinitionIdTable(db),
                                    referencedColumn:
                                        $$CharacterInventoryTableReferences
                                            ._trinketDefinitionIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [];
                  },
                );
              },
        ),
      );
}

typedef $$CharacterInventoryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CharacterInventoryTable,
      CharacterInventoryData,
      $$CharacterInventoryTableFilterComposer,
      $$CharacterInventoryTableOrderingComposer,
      $$CharacterInventoryTableAnnotationComposer,
      $$CharacterInventoryTableCreateCompanionBuilder,
      $$CharacterInventoryTableUpdateCompanionBuilder,
      (CharacterInventoryData, $$CharacterInventoryTableReferences),
      CharacterInventoryData,
      PrefetchHooks Function({
        bool characterId,
        bool equipmentDefinitionId,
        bool trinketDefinitionId,
      })
    >;
typedef $$CharacterProficienciesTableCreateCompanionBuilder =
    CharacterProficienciesCompanion Function({
      required String id,
      required String characterId,
      required String proficiencyType,
      required String referenceKey,
      Value<String?> sourceType,
      Value<String?> sourceId,
      Value<bool> isExpertise,
      Value<int> rowid,
    });
typedef $$CharacterProficienciesTableUpdateCompanionBuilder =
    CharacterProficienciesCompanion Function({
      Value<String> id,
      Value<String> characterId,
      Value<String> proficiencyType,
      Value<String> referenceKey,
      Value<String?> sourceType,
      Value<String?> sourceId,
      Value<bool> isExpertise,
      Value<int> rowid,
    });

final class $$CharacterProficienciesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CharacterProficienciesTable,
          CharacterProficiency
        > {
  $$CharacterProficienciesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CharactersTable _characterIdTable(_$AppDatabase db) =>
      db.characters.createAlias(
        $_aliasNameGenerator(
          db.characterProficiencies.characterId,
          db.characters.id,
        ),
      );

  $$CharactersTableProcessedTableManager get characterId {
    final $_column = $_itemColumn<String>('character_id')!;

    final manager = $$CharactersTableTableManager(
      $_db,
      $_db.characters,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_characterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CharacterProficienciesTableFilterComposer
    extends Composer<_$AppDatabase, $CharacterProficienciesTable> {
  $$CharacterProficienciesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get proficiencyType => $composableBuilder(
    column: $table.proficiencyType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referenceKey => $composableBuilder(
    column: $table.referenceKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isExpertise => $composableBuilder(
    column: $table.isExpertise,
    builder: (column) => ColumnFilters(column),
  );

  $$CharactersTableFilterComposer get characterId {
    final $$CharactersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableFilterComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CharacterProficienciesTableOrderingComposer
    extends Composer<_$AppDatabase, $CharacterProficienciesTable> {
  $$CharacterProficienciesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get proficiencyType => $composableBuilder(
    column: $table.proficiencyType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referenceKey => $composableBuilder(
    column: $table.referenceKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isExpertise => $composableBuilder(
    column: $table.isExpertise,
    builder: (column) => ColumnOrderings(column),
  );

  $$CharactersTableOrderingComposer get characterId {
    final $$CharactersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableOrderingComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CharacterProficienciesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CharacterProficienciesTable> {
  $$CharacterProficienciesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get proficiencyType => $composableBuilder(
    column: $table.proficiencyType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get referenceKey => $composableBuilder(
    column: $table.referenceKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceId =>
      $composableBuilder(column: $table.sourceId, builder: (column) => column);

  GeneratedColumn<bool> get isExpertise => $composableBuilder(
    column: $table.isExpertise,
    builder: (column) => column,
  );

  $$CharactersTableAnnotationComposer get characterId {
    final $$CharactersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableAnnotationComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CharacterProficienciesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CharacterProficienciesTable,
          CharacterProficiency,
          $$CharacterProficienciesTableFilterComposer,
          $$CharacterProficienciesTableOrderingComposer,
          $$CharacterProficienciesTableAnnotationComposer,
          $$CharacterProficienciesTableCreateCompanionBuilder,
          $$CharacterProficienciesTableUpdateCompanionBuilder,
          (CharacterProficiency, $$CharacterProficienciesTableReferences),
          CharacterProficiency,
          PrefetchHooks Function({bool characterId})
        > {
  $$CharacterProficienciesTableTableManager(
    _$AppDatabase db,
    $CharacterProficienciesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CharacterProficienciesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$CharacterProficienciesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CharacterProficienciesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> characterId = const Value.absent(),
                Value<String> proficiencyType = const Value.absent(),
                Value<String> referenceKey = const Value.absent(),
                Value<String?> sourceType = const Value.absent(),
                Value<String?> sourceId = const Value.absent(),
                Value<bool> isExpertise = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CharacterProficienciesCompanion(
                id: id,
                characterId: characterId,
                proficiencyType: proficiencyType,
                referenceKey: referenceKey,
                sourceType: sourceType,
                sourceId: sourceId,
                isExpertise: isExpertise,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String characterId,
                required String proficiencyType,
                required String referenceKey,
                Value<String?> sourceType = const Value.absent(),
                Value<String?> sourceId = const Value.absent(),
                Value<bool> isExpertise = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CharacterProficienciesCompanion.insert(
                id: id,
                characterId: characterId,
                proficiencyType: proficiencyType,
                referenceKey: referenceKey,
                sourceType: sourceType,
                sourceId: sourceId,
                isExpertise: isExpertise,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CharacterProficienciesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({characterId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (characterId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.characterId,
                                referencedTable:
                                    $$CharacterProficienciesTableReferences
                                        ._characterIdTable(db),
                                referencedColumn:
                                    $$CharacterProficienciesTableReferences
                                        ._characterIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CharacterProficienciesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CharacterProficienciesTable,
      CharacterProficiency,
      $$CharacterProficienciesTableFilterComposer,
      $$CharacterProficienciesTableOrderingComposer,
      $$CharacterProficienciesTableAnnotationComposer,
      $$CharacterProficienciesTableCreateCompanionBuilder,
      $$CharacterProficienciesTableUpdateCompanionBuilder,
      (CharacterProficiency, $$CharacterProficienciesTableReferences),
      CharacterProficiency,
      PrefetchHooks Function({bool characterId})
    >;
typedef $$CharacterCurrencyTableCreateCompanionBuilder =
    CharacterCurrencyCompanion Function({
      required String characterId,
      Value<int> copper,
      Value<int> silver,
      Value<int> electrum,
      Value<int> gold,
      Value<int> platinum,
      Value<String?> summarySnapshot,
      Value<int> rowid,
    });
typedef $$CharacterCurrencyTableUpdateCompanionBuilder =
    CharacterCurrencyCompanion Function({
      Value<String> characterId,
      Value<int> copper,
      Value<int> silver,
      Value<int> electrum,
      Value<int> gold,
      Value<int> platinum,
      Value<String?> summarySnapshot,
      Value<int> rowid,
    });

final class $$CharacterCurrencyTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CharacterCurrencyTable,
          CharacterCurrencyData
        > {
  $$CharacterCurrencyTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CharactersTable _characterIdTable(_$AppDatabase db) =>
      db.characters.createAlias(
        $_aliasNameGenerator(
          db.characterCurrency.characterId,
          db.characters.id,
        ),
      );

  $$CharactersTableProcessedTableManager get characterId {
    final $_column = $_itemColumn<String>('character_id')!;

    final manager = $$CharactersTableTableManager(
      $_db,
      $_db.characters,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_characterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CharacterCurrencyTableFilterComposer
    extends Composer<_$AppDatabase, $CharacterCurrencyTable> {
  $$CharacterCurrencyTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get copper => $composableBuilder(
    column: $table.copper,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get silver => $composableBuilder(
    column: $table.silver,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get electrum => $composableBuilder(
    column: $table.electrum,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get gold => $composableBuilder(
    column: $table.gold,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get platinum => $composableBuilder(
    column: $table.platinum,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get summarySnapshot => $composableBuilder(
    column: $table.summarySnapshot,
    builder: (column) => ColumnFilters(column),
  );

  $$CharactersTableFilterComposer get characterId {
    final $$CharactersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableFilterComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CharacterCurrencyTableOrderingComposer
    extends Composer<_$AppDatabase, $CharacterCurrencyTable> {
  $$CharacterCurrencyTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get copper => $composableBuilder(
    column: $table.copper,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get silver => $composableBuilder(
    column: $table.silver,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get electrum => $composableBuilder(
    column: $table.electrum,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get gold => $composableBuilder(
    column: $table.gold,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get platinum => $composableBuilder(
    column: $table.platinum,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get summarySnapshot => $composableBuilder(
    column: $table.summarySnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  $$CharactersTableOrderingComposer get characterId {
    final $$CharactersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableOrderingComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CharacterCurrencyTableAnnotationComposer
    extends Composer<_$AppDatabase, $CharacterCurrencyTable> {
  $$CharacterCurrencyTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get copper =>
      $composableBuilder(column: $table.copper, builder: (column) => column);

  GeneratedColumn<int> get silver =>
      $composableBuilder(column: $table.silver, builder: (column) => column);

  GeneratedColumn<int> get electrum =>
      $composableBuilder(column: $table.electrum, builder: (column) => column);

  GeneratedColumn<int> get gold =>
      $composableBuilder(column: $table.gold, builder: (column) => column);

  GeneratedColumn<int> get platinum =>
      $composableBuilder(column: $table.platinum, builder: (column) => column);

  GeneratedColumn<String> get summarySnapshot => $composableBuilder(
    column: $table.summarySnapshot,
    builder: (column) => column,
  );

  $$CharactersTableAnnotationComposer get characterId {
    final $$CharactersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.characterId,
      referencedTable: $db.characters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CharactersTableAnnotationComposer(
            $db: $db,
            $table: $db.characters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CharacterCurrencyTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CharacterCurrencyTable,
          CharacterCurrencyData,
          $$CharacterCurrencyTableFilterComposer,
          $$CharacterCurrencyTableOrderingComposer,
          $$CharacterCurrencyTableAnnotationComposer,
          $$CharacterCurrencyTableCreateCompanionBuilder,
          $$CharacterCurrencyTableUpdateCompanionBuilder,
          (CharacterCurrencyData, $$CharacterCurrencyTableReferences),
          CharacterCurrencyData,
          PrefetchHooks Function({bool characterId})
        > {
  $$CharacterCurrencyTableTableManager(
    _$AppDatabase db,
    $CharacterCurrencyTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CharacterCurrencyTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CharacterCurrencyTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CharacterCurrencyTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> characterId = const Value.absent(),
                Value<int> copper = const Value.absent(),
                Value<int> silver = const Value.absent(),
                Value<int> electrum = const Value.absent(),
                Value<int> gold = const Value.absent(),
                Value<int> platinum = const Value.absent(),
                Value<String?> summarySnapshot = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CharacterCurrencyCompanion(
                characterId: characterId,
                copper: copper,
                silver: silver,
                electrum: electrum,
                gold: gold,
                platinum: platinum,
                summarySnapshot: summarySnapshot,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String characterId,
                Value<int> copper = const Value.absent(),
                Value<int> silver = const Value.absent(),
                Value<int> electrum = const Value.absent(),
                Value<int> gold = const Value.absent(),
                Value<int> platinum = const Value.absent(),
                Value<String?> summarySnapshot = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CharacterCurrencyCompanion.insert(
                characterId: characterId,
                copper: copper,
                silver: silver,
                electrum: electrum,
                gold: gold,
                platinum: platinum,
                summarySnapshot: summarySnapshot,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CharacterCurrencyTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({characterId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (characterId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.characterId,
                                referencedTable:
                                    $$CharacterCurrencyTableReferences
                                        ._characterIdTable(db),
                                referencedColumn:
                                    $$CharacterCurrencyTableReferences
                                        ._characterIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CharacterCurrencyTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CharacterCurrencyTable,
      CharacterCurrencyData,
      $$CharacterCurrencyTableFilterComposer,
      $$CharacterCurrencyTableOrderingComposer,
      $$CharacterCurrencyTableAnnotationComposer,
      $$CharacterCurrencyTableCreateCompanionBuilder,
      $$CharacterCurrencyTableUpdateCompanionBuilder,
      (CharacterCurrencyData, $$CharacterCurrencyTableReferences),
      CharacterCurrencyData,
      PrefetchHooks Function({bool characterId})
    >;
typedef $$ClassDefinitionsTableCreateCompanionBuilder =
    ClassDefinitionsCompanion Function({
      required String id,
      required String key,
      required String name,
      Value<int?> hitDie,
      Value<bool> isSpellcaster,
      Value<String?> spellcastingAbility,
      Value<String?> description,
      Value<int> rowid,
    });
typedef $$ClassDefinitionsTableUpdateCompanionBuilder =
    ClassDefinitionsCompanion Function({
      Value<String> id,
      Value<String> key,
      Value<String> name,
      Value<int?> hitDie,
      Value<bool> isSpellcaster,
      Value<String?> spellcastingAbility,
      Value<String?> description,
      Value<int> rowid,
    });

class $$ClassDefinitionsTableFilterComposer
    extends Composer<_$AppDatabase, $ClassDefinitionsTable> {
  $$ClassDefinitionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hitDie => $composableBuilder(
    column: $table.hitDie,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSpellcaster => $composableBuilder(
    column: $table.isSpellcaster,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get spellcastingAbility => $composableBuilder(
    column: $table.spellcastingAbility,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ClassDefinitionsTableOrderingComposer
    extends Composer<_$AppDatabase, $ClassDefinitionsTable> {
  $$ClassDefinitionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hitDie => $composableBuilder(
    column: $table.hitDie,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSpellcaster => $composableBuilder(
    column: $table.isSpellcaster,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get spellcastingAbility => $composableBuilder(
    column: $table.spellcastingAbility,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ClassDefinitionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClassDefinitionsTable> {
  $$ClassDefinitionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get hitDie =>
      $composableBuilder(column: $table.hitDie, builder: (column) => column);

  GeneratedColumn<bool> get isSpellcaster => $composableBuilder(
    column: $table.isSpellcaster,
    builder: (column) => column,
  );

  GeneratedColumn<String> get spellcastingAbility => $composableBuilder(
    column: $table.spellcastingAbility,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );
}

class $$ClassDefinitionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClassDefinitionsTable,
          ClassDefinition,
          $$ClassDefinitionsTableFilterComposer,
          $$ClassDefinitionsTableOrderingComposer,
          $$ClassDefinitionsTableAnnotationComposer,
          $$ClassDefinitionsTableCreateCompanionBuilder,
          $$ClassDefinitionsTableUpdateCompanionBuilder,
          (
            ClassDefinition,
            BaseReferences<
              _$AppDatabase,
              $ClassDefinitionsTable,
              ClassDefinition
            >,
          ),
          ClassDefinition,
          PrefetchHooks Function()
        > {
  $$ClassDefinitionsTableTableManager(
    _$AppDatabase db,
    $ClassDefinitionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClassDefinitionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClassDefinitionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClassDefinitionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> key = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int?> hitDie = const Value.absent(),
                Value<bool> isSpellcaster = const Value.absent(),
                Value<String?> spellcastingAbility = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ClassDefinitionsCompanion(
                id: id,
                key: key,
                name: name,
                hitDie: hitDie,
                isSpellcaster: isSpellcaster,
                spellcastingAbility: spellcastingAbility,
                description: description,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String key,
                required String name,
                Value<int?> hitDie = const Value.absent(),
                Value<bool> isSpellcaster = const Value.absent(),
                Value<String?> spellcastingAbility = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ClassDefinitionsCompanion.insert(
                id: id,
                key: key,
                name: name,
                hitDie: hitDie,
                isSpellcaster: isSpellcaster,
                spellcastingAbility: spellcastingAbility,
                description: description,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ClassDefinitionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClassDefinitionsTable,
      ClassDefinition,
      $$ClassDefinitionsTableFilterComposer,
      $$ClassDefinitionsTableOrderingComposer,
      $$ClassDefinitionsTableAnnotationComposer,
      $$ClassDefinitionsTableCreateCompanionBuilder,
      $$ClassDefinitionsTableUpdateCompanionBuilder,
      (
        ClassDefinition,
        BaseReferences<_$AppDatabase, $ClassDefinitionsTable, ClassDefinition>,
      ),
      ClassDefinition,
      PrefetchHooks Function()
    >;
typedef $$CharacterAdvancementDefinitionsTableCreateCompanionBuilder =
    CharacterAdvancementDefinitionsCompanion Function({
      Value<int> level,
      required int experience,
      required int proficiencyBonus,
    });
typedef $$CharacterAdvancementDefinitionsTableUpdateCompanionBuilder =
    CharacterAdvancementDefinitionsCompanion Function({
      Value<int> level,
      Value<int> experience,
      Value<int> proficiencyBonus,
    });

class $$CharacterAdvancementDefinitionsTableFilterComposer
    extends Composer<_$AppDatabase, $CharacterAdvancementDefinitionsTable> {
  $$CharacterAdvancementDefinitionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get experience => $composableBuilder(
    column: $table.experience,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get proficiencyBonus => $composableBuilder(
    column: $table.proficiencyBonus,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CharacterAdvancementDefinitionsTableOrderingComposer
    extends Composer<_$AppDatabase, $CharacterAdvancementDefinitionsTable> {
  $$CharacterAdvancementDefinitionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get experience => $composableBuilder(
    column: $table.experience,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get proficiencyBonus => $composableBuilder(
    column: $table.proficiencyBonus,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CharacterAdvancementDefinitionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CharacterAdvancementDefinitionsTable> {
  $$CharacterAdvancementDefinitionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get experience => $composableBuilder(
    column: $table.experience,
    builder: (column) => column,
  );

  GeneratedColumn<int> get proficiencyBonus => $composableBuilder(
    column: $table.proficiencyBonus,
    builder: (column) => column,
  );
}

class $$CharacterAdvancementDefinitionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CharacterAdvancementDefinitionsTable,
          CharacterAdvancementDefinition,
          $$CharacterAdvancementDefinitionsTableFilterComposer,
          $$CharacterAdvancementDefinitionsTableOrderingComposer,
          $$CharacterAdvancementDefinitionsTableAnnotationComposer,
          $$CharacterAdvancementDefinitionsTableCreateCompanionBuilder,
          $$CharacterAdvancementDefinitionsTableUpdateCompanionBuilder,
          (
            CharacterAdvancementDefinition,
            BaseReferences<
              _$AppDatabase,
              $CharacterAdvancementDefinitionsTable,
              CharacterAdvancementDefinition
            >,
          ),
          CharacterAdvancementDefinition,
          PrefetchHooks Function()
        > {
  $$CharacterAdvancementDefinitionsTableTableManager(
    _$AppDatabase db,
    $CharacterAdvancementDefinitionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CharacterAdvancementDefinitionsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$CharacterAdvancementDefinitionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CharacterAdvancementDefinitionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> level = const Value.absent(),
                Value<int> experience = const Value.absent(),
                Value<int> proficiencyBonus = const Value.absent(),
              }) => CharacterAdvancementDefinitionsCompanion(
                level: level,
                experience: experience,
                proficiencyBonus: proficiencyBonus,
              ),
          createCompanionCallback:
              ({
                Value<int> level = const Value.absent(),
                required int experience,
                required int proficiencyBonus,
              }) => CharacterAdvancementDefinitionsCompanion.insert(
                level: level,
                experience: experience,
                proficiencyBonus: proficiencyBonus,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CharacterAdvancementDefinitionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CharacterAdvancementDefinitionsTable,
      CharacterAdvancementDefinition,
      $$CharacterAdvancementDefinitionsTableFilterComposer,
      $$CharacterAdvancementDefinitionsTableOrderingComposer,
      $$CharacterAdvancementDefinitionsTableAnnotationComposer,
      $$CharacterAdvancementDefinitionsTableCreateCompanionBuilder,
      $$CharacterAdvancementDefinitionsTableUpdateCompanionBuilder,
      (
        CharacterAdvancementDefinition,
        BaseReferences<
          _$AppDatabase,
          $CharacterAdvancementDefinitionsTable,
          CharacterAdvancementDefinition
        >,
      ),
      CharacterAdvancementDefinition,
      PrefetchHooks Function()
    >;
typedef $$ClassStandardArrayRecommendationsTableCreateCompanionBuilder =
    ClassStandardArrayRecommendationsCompanion Function({
      required String classId,
      required String className,
      required int strength,
      required int dexterity,
      required int constitution,
      required int intelligence,
      required int wisdom,
      required int charisma,
      Value<int> rowid,
    });
typedef $$ClassStandardArrayRecommendationsTableUpdateCompanionBuilder =
    ClassStandardArrayRecommendationsCompanion Function({
      Value<String> classId,
      Value<String> className,
      Value<int> strength,
      Value<int> dexterity,
      Value<int> constitution,
      Value<int> intelligence,
      Value<int> wisdom,
      Value<int> charisma,
      Value<int> rowid,
    });

class $$ClassStandardArrayRecommendationsTableFilterComposer
    extends Composer<_$AppDatabase, $ClassStandardArrayRecommendationsTable> {
  $$ClassStandardArrayRecommendationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get classId => $composableBuilder(
    column: $table.classId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get className => $composableBuilder(
    column: $table.className,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get strength => $composableBuilder(
    column: $table.strength,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dexterity => $composableBuilder(
    column: $table.dexterity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get constitution => $composableBuilder(
    column: $table.constitution,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intelligence => $composableBuilder(
    column: $table.intelligence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wisdom => $composableBuilder(
    column: $table.wisdom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get charisma => $composableBuilder(
    column: $table.charisma,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ClassStandardArrayRecommendationsTableOrderingComposer
    extends Composer<_$AppDatabase, $ClassStandardArrayRecommendationsTable> {
  $$ClassStandardArrayRecommendationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get classId => $composableBuilder(
    column: $table.classId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get className => $composableBuilder(
    column: $table.className,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get strength => $composableBuilder(
    column: $table.strength,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dexterity => $composableBuilder(
    column: $table.dexterity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get constitution => $composableBuilder(
    column: $table.constitution,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intelligence => $composableBuilder(
    column: $table.intelligence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wisdom => $composableBuilder(
    column: $table.wisdom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get charisma => $composableBuilder(
    column: $table.charisma,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ClassStandardArrayRecommendationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClassStandardArrayRecommendationsTable> {
  $$ClassStandardArrayRecommendationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get classId =>
      $composableBuilder(column: $table.classId, builder: (column) => column);

  GeneratedColumn<String> get className =>
      $composableBuilder(column: $table.className, builder: (column) => column);

  GeneratedColumn<int> get strength =>
      $composableBuilder(column: $table.strength, builder: (column) => column);

  GeneratedColumn<int> get dexterity =>
      $composableBuilder(column: $table.dexterity, builder: (column) => column);

  GeneratedColumn<int> get constitution => $composableBuilder(
    column: $table.constitution,
    builder: (column) => column,
  );

  GeneratedColumn<int> get intelligence => $composableBuilder(
    column: $table.intelligence,
    builder: (column) => column,
  );

  GeneratedColumn<int> get wisdom =>
      $composableBuilder(column: $table.wisdom, builder: (column) => column);

  GeneratedColumn<int> get charisma =>
      $composableBuilder(column: $table.charisma, builder: (column) => column);
}

class $$ClassStandardArrayRecommendationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClassStandardArrayRecommendationsTable,
          ClassStandardArrayRecommendation,
          $$ClassStandardArrayRecommendationsTableFilterComposer,
          $$ClassStandardArrayRecommendationsTableOrderingComposer,
          $$ClassStandardArrayRecommendationsTableAnnotationComposer,
          $$ClassStandardArrayRecommendationsTableCreateCompanionBuilder,
          $$ClassStandardArrayRecommendationsTableUpdateCompanionBuilder,
          (
            ClassStandardArrayRecommendation,
            BaseReferences<
              _$AppDatabase,
              $ClassStandardArrayRecommendationsTable,
              ClassStandardArrayRecommendation
            >,
          ),
          ClassStandardArrayRecommendation,
          PrefetchHooks Function()
        > {
  $$ClassStandardArrayRecommendationsTableTableManager(
    _$AppDatabase db,
    $ClassStandardArrayRecommendationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClassStandardArrayRecommendationsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ClassStandardArrayRecommendationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ClassStandardArrayRecommendationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> classId = const Value.absent(),
                Value<String> className = const Value.absent(),
                Value<int> strength = const Value.absent(),
                Value<int> dexterity = const Value.absent(),
                Value<int> constitution = const Value.absent(),
                Value<int> intelligence = const Value.absent(),
                Value<int> wisdom = const Value.absent(),
                Value<int> charisma = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ClassStandardArrayRecommendationsCompanion(
                classId: classId,
                className: className,
                strength: strength,
                dexterity: dexterity,
                constitution: constitution,
                intelligence: intelligence,
                wisdom: wisdom,
                charisma: charisma,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String classId,
                required String className,
                required int strength,
                required int dexterity,
                required int constitution,
                required int intelligence,
                required int wisdom,
                required int charisma,
                Value<int> rowid = const Value.absent(),
              }) => ClassStandardArrayRecommendationsCompanion.insert(
                classId: classId,
                className: className,
                strength: strength,
                dexterity: dexterity,
                constitution: constitution,
                intelligence: intelligence,
                wisdom: wisdom,
                charisma: charisma,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ClassStandardArrayRecommendationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClassStandardArrayRecommendationsTable,
      ClassStandardArrayRecommendation,
      $$ClassStandardArrayRecommendationsTableFilterComposer,
      $$ClassStandardArrayRecommendationsTableOrderingComposer,
      $$ClassStandardArrayRecommendationsTableAnnotationComposer,
      $$ClassStandardArrayRecommendationsTableCreateCompanionBuilder,
      $$ClassStandardArrayRecommendationsTableUpdateCompanionBuilder,
      (
        ClassStandardArrayRecommendation,
        BaseReferences<
          _$AppDatabase,
          $ClassStandardArrayRecommendationsTable,
          ClassStandardArrayRecommendation
        >,
      ),
      ClassStandardArrayRecommendation,
      PrefetchHooks Function()
    >;
typedef $$NarrativeOptionGroupsTableCreateCompanionBuilder =
    NarrativeOptionGroupsCompanion Function({
      required String id,
      required String fieldKey,
      required String sourceType,
      Value<String?> packId,
      Value<String?> sourceId,
      Value<String?> sourceName,
      Value<String?> backgroundId,
      Value<String?> backgroundName,
      required String title,
      Value<String?> diceFormula,
      Value<int> optionCount,
      Value<String?> sourceBook,
      Value<int> rowid,
    });
typedef $$NarrativeOptionGroupsTableUpdateCompanionBuilder =
    NarrativeOptionGroupsCompanion Function({
      Value<String> id,
      Value<String> fieldKey,
      Value<String> sourceType,
      Value<String?> packId,
      Value<String?> sourceId,
      Value<String?> sourceName,
      Value<String?> backgroundId,
      Value<String?> backgroundName,
      Value<String> title,
      Value<String?> diceFormula,
      Value<int> optionCount,
      Value<String?> sourceBook,
      Value<int> rowid,
    });

final class $$NarrativeOptionGroupsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $NarrativeOptionGroupsTable,
          NarrativeOptionGroup
        > {
  $$NarrativeOptionGroupsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$NarrativeOptionsTable, List<NarrativeOption>>
  _narrativeOptionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.narrativeOptions,
    aliasName: $_aliasNameGenerator(
      db.narrativeOptionGroups.id,
      db.narrativeOptions.groupId,
    ),
  );

  $$NarrativeOptionsTableProcessedTableManager get narrativeOptionsRefs {
    final manager = $$NarrativeOptionsTableTableManager(
      $_db,
      $_db.narrativeOptions,
    ).filter((f) => f.groupId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _narrativeOptionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$NarrativeOptionGroupsTableFilterComposer
    extends Composer<_$AppDatabase, $NarrativeOptionGroupsTable> {
  $$NarrativeOptionGroupsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fieldKey => $composableBuilder(
    column: $table.fieldKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get packId => $composableBuilder(
    column: $table.packId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceName => $composableBuilder(
    column: $table.sourceName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get backgroundId => $composableBuilder(
    column: $table.backgroundId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get backgroundName => $composableBuilder(
    column: $table.backgroundName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get diceFormula => $composableBuilder(
    column: $table.diceFormula,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get optionCount => $composableBuilder(
    column: $table.optionCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceBook => $composableBuilder(
    column: $table.sourceBook,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> narrativeOptionsRefs(
    Expression<bool> Function($$NarrativeOptionsTableFilterComposer f) f,
  ) {
    final $$NarrativeOptionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.narrativeOptions,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NarrativeOptionsTableFilterComposer(
            $db: $db,
            $table: $db.narrativeOptions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$NarrativeOptionGroupsTableOrderingComposer
    extends Composer<_$AppDatabase, $NarrativeOptionGroupsTable> {
  $$NarrativeOptionGroupsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fieldKey => $composableBuilder(
    column: $table.fieldKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get packId => $composableBuilder(
    column: $table.packId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceName => $composableBuilder(
    column: $table.sourceName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get backgroundId => $composableBuilder(
    column: $table.backgroundId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get backgroundName => $composableBuilder(
    column: $table.backgroundName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get diceFormula => $composableBuilder(
    column: $table.diceFormula,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get optionCount => $composableBuilder(
    column: $table.optionCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceBook => $composableBuilder(
    column: $table.sourceBook,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NarrativeOptionGroupsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NarrativeOptionGroupsTable> {
  $$NarrativeOptionGroupsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fieldKey =>
      $composableBuilder(column: $table.fieldKey, builder: (column) => column);

  GeneratedColumn<String> get sourceType => $composableBuilder(
    column: $table.sourceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get packId =>
      $composableBuilder(column: $table.packId, builder: (column) => column);

  GeneratedColumn<String> get sourceId =>
      $composableBuilder(column: $table.sourceId, builder: (column) => column);

  GeneratedColumn<String> get sourceName => $composableBuilder(
    column: $table.sourceName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get backgroundId => $composableBuilder(
    column: $table.backgroundId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get backgroundName => $composableBuilder(
    column: $table.backgroundName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get diceFormula => $composableBuilder(
    column: $table.diceFormula,
    builder: (column) => column,
  );

  GeneratedColumn<int> get optionCount => $composableBuilder(
    column: $table.optionCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceBook => $composableBuilder(
    column: $table.sourceBook,
    builder: (column) => column,
  );

  Expression<T> narrativeOptionsRefs<T extends Object>(
    Expression<T> Function($$NarrativeOptionsTableAnnotationComposer a) f,
  ) {
    final $$NarrativeOptionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.narrativeOptions,
      getReferencedColumn: (t) => t.groupId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NarrativeOptionsTableAnnotationComposer(
            $db: $db,
            $table: $db.narrativeOptions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$NarrativeOptionGroupsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NarrativeOptionGroupsTable,
          NarrativeOptionGroup,
          $$NarrativeOptionGroupsTableFilterComposer,
          $$NarrativeOptionGroupsTableOrderingComposer,
          $$NarrativeOptionGroupsTableAnnotationComposer,
          $$NarrativeOptionGroupsTableCreateCompanionBuilder,
          $$NarrativeOptionGroupsTableUpdateCompanionBuilder,
          (NarrativeOptionGroup, $$NarrativeOptionGroupsTableReferences),
          NarrativeOptionGroup,
          PrefetchHooks Function({bool narrativeOptionsRefs})
        > {
  $$NarrativeOptionGroupsTableTableManager(
    _$AppDatabase db,
    $NarrativeOptionGroupsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NarrativeOptionGroupsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$NarrativeOptionGroupsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$NarrativeOptionGroupsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> fieldKey = const Value.absent(),
                Value<String> sourceType = const Value.absent(),
                Value<String?> packId = const Value.absent(),
                Value<String?> sourceId = const Value.absent(),
                Value<String?> sourceName = const Value.absent(),
                Value<String?> backgroundId = const Value.absent(),
                Value<String?> backgroundName = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> diceFormula = const Value.absent(),
                Value<int> optionCount = const Value.absent(),
                Value<String?> sourceBook = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NarrativeOptionGroupsCompanion(
                id: id,
                fieldKey: fieldKey,
                sourceType: sourceType,
                packId: packId,
                sourceId: sourceId,
                sourceName: sourceName,
                backgroundId: backgroundId,
                backgroundName: backgroundName,
                title: title,
                diceFormula: diceFormula,
                optionCount: optionCount,
                sourceBook: sourceBook,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String fieldKey,
                required String sourceType,
                Value<String?> packId = const Value.absent(),
                Value<String?> sourceId = const Value.absent(),
                Value<String?> sourceName = const Value.absent(),
                Value<String?> backgroundId = const Value.absent(),
                Value<String?> backgroundName = const Value.absent(),
                required String title,
                Value<String?> diceFormula = const Value.absent(),
                Value<int> optionCount = const Value.absent(),
                Value<String?> sourceBook = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NarrativeOptionGroupsCompanion.insert(
                id: id,
                fieldKey: fieldKey,
                sourceType: sourceType,
                packId: packId,
                sourceId: sourceId,
                sourceName: sourceName,
                backgroundId: backgroundId,
                backgroundName: backgroundName,
                title: title,
                diceFormula: diceFormula,
                optionCount: optionCount,
                sourceBook: sourceBook,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$NarrativeOptionGroupsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({narrativeOptionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (narrativeOptionsRefs) db.narrativeOptions,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (narrativeOptionsRefs)
                    await $_getPrefetchedData<
                      NarrativeOptionGroup,
                      $NarrativeOptionGroupsTable,
                      NarrativeOption
                    >(
                      currentTable: table,
                      referencedTable: $$NarrativeOptionGroupsTableReferences
                          ._narrativeOptionsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$NarrativeOptionGroupsTableReferences(
                            db,
                            table,
                            p0,
                          ).narrativeOptionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.groupId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$NarrativeOptionGroupsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NarrativeOptionGroupsTable,
      NarrativeOptionGroup,
      $$NarrativeOptionGroupsTableFilterComposer,
      $$NarrativeOptionGroupsTableOrderingComposer,
      $$NarrativeOptionGroupsTableAnnotationComposer,
      $$NarrativeOptionGroupsTableCreateCompanionBuilder,
      $$NarrativeOptionGroupsTableUpdateCompanionBuilder,
      (NarrativeOptionGroup, $$NarrativeOptionGroupsTableReferences),
      NarrativeOptionGroup,
      PrefetchHooks Function({bool narrativeOptionsRefs})
    >;
typedef $$NarrativeOptionsTableCreateCompanionBuilder =
    NarrativeOptionsCompanion Function({
      required String id,
      required String groupId,
      required int optionIndex,
      Value<int?> rollMin,
      Value<int?> rollMax,
      Value<String?> label,
      required String content,
      Value<int> rowid,
    });
typedef $$NarrativeOptionsTableUpdateCompanionBuilder =
    NarrativeOptionsCompanion Function({
      Value<String> id,
      Value<String> groupId,
      Value<int> optionIndex,
      Value<int?> rollMin,
      Value<int?> rollMax,
      Value<String?> label,
      Value<String> content,
      Value<int> rowid,
    });

final class $$NarrativeOptionsTableReferences
    extends
        BaseReferences<_$AppDatabase, $NarrativeOptionsTable, NarrativeOption> {
  $$NarrativeOptionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $NarrativeOptionGroupsTable _groupIdTable(_$AppDatabase db) =>
      db.narrativeOptionGroups.createAlias(
        $_aliasNameGenerator(
          db.narrativeOptions.groupId,
          db.narrativeOptionGroups.id,
        ),
      );

  $$NarrativeOptionGroupsTableProcessedTableManager get groupId {
    final $_column = $_itemColumn<String>('group_id')!;

    final manager = $$NarrativeOptionGroupsTableTableManager(
      $_db,
      $_db.narrativeOptionGroups,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_groupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$NarrativeOptionsTableFilterComposer
    extends Composer<_$AppDatabase, $NarrativeOptionsTable> {
  $$NarrativeOptionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get optionIndex => $composableBuilder(
    column: $table.optionIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rollMin => $composableBuilder(
    column: $table.rollMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rollMax => $composableBuilder(
    column: $table.rollMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  $$NarrativeOptionGroupsTableFilterComposer get groupId {
    final $$NarrativeOptionGroupsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.groupId,
          referencedTable: $db.narrativeOptionGroups,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$NarrativeOptionGroupsTableFilterComposer(
                $db: $db,
                $table: $db.narrativeOptionGroups,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$NarrativeOptionsTableOrderingComposer
    extends Composer<_$AppDatabase, $NarrativeOptionsTable> {
  $$NarrativeOptionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get optionIndex => $composableBuilder(
    column: $table.optionIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rollMin => $composableBuilder(
    column: $table.rollMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rollMax => $composableBuilder(
    column: $table.rollMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  $$NarrativeOptionGroupsTableOrderingComposer get groupId {
    final $$NarrativeOptionGroupsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.groupId,
          referencedTable: $db.narrativeOptionGroups,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$NarrativeOptionGroupsTableOrderingComposer(
                $db: $db,
                $table: $db.narrativeOptionGroups,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$NarrativeOptionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NarrativeOptionsTable> {
  $$NarrativeOptionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get optionIndex => $composableBuilder(
    column: $table.optionIndex,
    builder: (column) => column,
  );

  GeneratedColumn<int> get rollMin =>
      $composableBuilder(column: $table.rollMin, builder: (column) => column);

  GeneratedColumn<int> get rollMax =>
      $composableBuilder(column: $table.rollMax, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  $$NarrativeOptionGroupsTableAnnotationComposer get groupId {
    final $$NarrativeOptionGroupsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.groupId,
          referencedTable: $db.narrativeOptionGroups,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$NarrativeOptionGroupsTableAnnotationComposer(
                $db: $db,
                $table: $db.narrativeOptionGroups,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$NarrativeOptionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NarrativeOptionsTable,
          NarrativeOption,
          $$NarrativeOptionsTableFilterComposer,
          $$NarrativeOptionsTableOrderingComposer,
          $$NarrativeOptionsTableAnnotationComposer,
          $$NarrativeOptionsTableCreateCompanionBuilder,
          $$NarrativeOptionsTableUpdateCompanionBuilder,
          (NarrativeOption, $$NarrativeOptionsTableReferences),
          NarrativeOption,
          PrefetchHooks Function({bool groupId})
        > {
  $$NarrativeOptionsTableTableManager(
    _$AppDatabase db,
    $NarrativeOptionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NarrativeOptionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NarrativeOptionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NarrativeOptionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> groupId = const Value.absent(),
                Value<int> optionIndex = const Value.absent(),
                Value<int?> rollMin = const Value.absent(),
                Value<int?> rollMax = const Value.absent(),
                Value<String?> label = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NarrativeOptionsCompanion(
                id: id,
                groupId: groupId,
                optionIndex: optionIndex,
                rollMin: rollMin,
                rollMax: rollMax,
                label: label,
                content: content,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String groupId,
                required int optionIndex,
                Value<int?> rollMin = const Value.absent(),
                Value<int?> rollMax = const Value.absent(),
                Value<String?> label = const Value.absent(),
                required String content,
                Value<int> rowid = const Value.absent(),
              }) => NarrativeOptionsCompanion.insert(
                id: id,
                groupId: groupId,
                optionIndex: optionIndex,
                rollMin: rollMin,
                rollMax: rollMax,
                label: label,
                content: content,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$NarrativeOptionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({groupId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (groupId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.groupId,
                                referencedTable:
                                    $$NarrativeOptionsTableReferences
                                        ._groupIdTable(db),
                                referencedColumn:
                                    $$NarrativeOptionsTableReferences
                                        ._groupIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$NarrativeOptionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NarrativeOptionsTable,
      NarrativeOption,
      $$NarrativeOptionsTableFilterComposer,
      $$NarrativeOptionsTableOrderingComposer,
      $$NarrativeOptionsTableAnnotationComposer,
      $$NarrativeOptionsTableCreateCompanionBuilder,
      $$NarrativeOptionsTableUpdateCompanionBuilder,
      (NarrativeOption, $$NarrativeOptionsTableReferences),
      NarrativeOption,
      PrefetchHooks Function({bool groupId})
    >;
typedef $$CompendiumPackStatesTableCreateCompanionBuilder =
    CompendiumPackStatesCompanion Function({
      required String id,
      required String title,
      required String description,
      required String kind,
      Value<bool> isFixed,
      Value<bool> isActive,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$CompendiumPackStatesTableUpdateCompanionBuilder =
    CompendiumPackStatesCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> description,
      Value<String> kind,
      Value<bool> isFixed,
      Value<bool> isActive,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$CompendiumPackStatesTableFilterComposer
    extends Composer<_$AppDatabase, $CompendiumPackStatesTable> {
  $$CompendiumPackStatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFixed => $composableBuilder(
    column: $table.isFixed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CompendiumPackStatesTableOrderingComposer
    extends Composer<_$AppDatabase, $CompendiumPackStatesTable> {
  $$CompendiumPackStatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFixed => $composableBuilder(
    column: $table.isFixed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CompendiumPackStatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CompendiumPackStatesTable> {
  $$CompendiumPackStatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<bool> get isFixed =>
      $composableBuilder(column: $table.isFixed, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CompendiumPackStatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CompendiumPackStatesTable,
          CompendiumPackState,
          $$CompendiumPackStatesTableFilterComposer,
          $$CompendiumPackStatesTableOrderingComposer,
          $$CompendiumPackStatesTableAnnotationComposer,
          $$CompendiumPackStatesTableCreateCompanionBuilder,
          $$CompendiumPackStatesTableUpdateCompanionBuilder,
          (
            CompendiumPackState,
            BaseReferences<
              _$AppDatabase,
              $CompendiumPackStatesTable,
              CompendiumPackState
            >,
          ),
          CompendiumPackState,
          PrefetchHooks Function()
        > {
  $$CompendiumPackStatesTableTableManager(
    _$AppDatabase db,
    $CompendiumPackStatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CompendiumPackStatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CompendiumPackStatesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CompendiumPackStatesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<bool> isFixed = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CompendiumPackStatesCompanion(
                id: id,
                title: title,
                description: description,
                kind: kind,
                isFixed: isFixed,
                isActive: isActive,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String description,
                required String kind,
                Value<bool> isFixed = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => CompendiumPackStatesCompanion.insert(
                id: id,
                title: title,
                description: description,
                kind: kind,
                isFixed: isFixed,
                isActive: isActive,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CompendiumPackStatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CompendiumPackStatesTable,
      CompendiumPackState,
      $$CompendiumPackStatesTableFilterComposer,
      $$CompendiumPackStatesTableOrderingComposer,
      $$CompendiumPackStatesTableAnnotationComposer,
      $$CompendiumPackStatesTableCreateCompanionBuilder,
      $$CompendiumPackStatesTableUpdateCompanionBuilder,
      (
        CompendiumPackState,
        BaseReferences<
          _$AppDatabase,
          $CompendiumPackStatesTable,
          CompendiumPackState
        >,
      ),
      CompendiumPackState,
      PrefetchHooks Function()
    >;
typedef $$ImportedCompendiumPacksTableCreateCompanionBuilder =
    ImportedCompendiumPacksCompanion Function({
      required String id,
      required String rawXml,
      required DateTime importedAt,
      Value<int> rowid,
    });
typedef $$ImportedCompendiumPacksTableUpdateCompanionBuilder =
    ImportedCompendiumPacksCompanion Function({
      Value<String> id,
      Value<String> rawXml,
      Value<DateTime> importedAt,
      Value<int> rowid,
    });

class $$ImportedCompendiumPacksTableFilterComposer
    extends Composer<_$AppDatabase, $ImportedCompendiumPacksTable> {
  $$ImportedCompendiumPacksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rawXml => $composableBuilder(
    column: $table.rawXml,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ImportedCompendiumPacksTableOrderingComposer
    extends Composer<_$AppDatabase, $ImportedCompendiumPacksTable> {
  $$ImportedCompendiumPacksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rawXml => $composableBuilder(
    column: $table.rawXml,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ImportedCompendiumPacksTableAnnotationComposer
    extends Composer<_$AppDatabase, $ImportedCompendiumPacksTable> {
  $$ImportedCompendiumPacksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get rawXml =>
      $composableBuilder(column: $table.rawXml, builder: (column) => column);

  GeneratedColumn<DateTime> get importedAt => $composableBuilder(
    column: $table.importedAt,
    builder: (column) => column,
  );
}

class $$ImportedCompendiumPacksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ImportedCompendiumPacksTable,
          ImportedCompendiumPack,
          $$ImportedCompendiumPacksTableFilterComposer,
          $$ImportedCompendiumPacksTableOrderingComposer,
          $$ImportedCompendiumPacksTableAnnotationComposer,
          $$ImportedCompendiumPacksTableCreateCompanionBuilder,
          $$ImportedCompendiumPacksTableUpdateCompanionBuilder,
          (
            ImportedCompendiumPack,
            BaseReferences<
              _$AppDatabase,
              $ImportedCompendiumPacksTable,
              ImportedCompendiumPack
            >,
          ),
          ImportedCompendiumPack,
          PrefetchHooks Function()
        > {
  $$ImportedCompendiumPacksTableTableManager(
    _$AppDatabase db,
    $ImportedCompendiumPacksTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ImportedCompendiumPacksTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ImportedCompendiumPacksTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ImportedCompendiumPacksTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> rawXml = const Value.absent(),
                Value<DateTime> importedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ImportedCompendiumPacksCompanion(
                id: id,
                rawXml: rawXml,
                importedAt: importedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String rawXml,
                required DateTime importedAt,
                Value<int> rowid = const Value.absent(),
              }) => ImportedCompendiumPacksCompanion.insert(
                id: id,
                rawXml: rawXml,
                importedAt: importedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ImportedCompendiumPacksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ImportedCompendiumPacksTable,
      ImportedCompendiumPack,
      $$ImportedCompendiumPacksTableFilterComposer,
      $$ImportedCompendiumPacksTableOrderingComposer,
      $$ImportedCompendiumPacksTableAnnotationComposer,
      $$ImportedCompendiumPacksTableCreateCompanionBuilder,
      $$ImportedCompendiumPacksTableUpdateCompanionBuilder,
      (
        ImportedCompendiumPack,
        BaseReferences<
          _$AppDatabase,
          $ImportedCompendiumPacksTable,
          ImportedCompendiumPack
        >,
      ),
      ImportedCompendiumPack,
      PrefetchHooks Function()
    >;
typedef $$BackgroundDefinitionsTableCreateCompanionBuilder =
    BackgroundDefinitionsCompanion Function({
      required String id,
      required String key,
      required String name,
      Value<String?> summary,
      Value<String?> featureName,
      Value<String?> featureDescription,
      Value<String?> grantedSkillKeysJson,
      Value<String?> grantedToolKeysJson,
      Value<String?> grantedLanguageKeysJson,
      Value<String?> startingEquipmentJson,
      Value<int> rowid,
    });
typedef $$BackgroundDefinitionsTableUpdateCompanionBuilder =
    BackgroundDefinitionsCompanion Function({
      Value<String> id,
      Value<String> key,
      Value<String> name,
      Value<String?> summary,
      Value<String?> featureName,
      Value<String?> featureDescription,
      Value<String?> grantedSkillKeysJson,
      Value<String?> grantedToolKeysJson,
      Value<String?> grantedLanguageKeysJson,
      Value<String?> startingEquipmentJson,
      Value<int> rowid,
    });

class $$BackgroundDefinitionsTableFilterComposer
    extends Composer<_$AppDatabase, $BackgroundDefinitionsTable> {
  $$BackgroundDefinitionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get featureName => $composableBuilder(
    column: $table.featureName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get featureDescription => $composableBuilder(
    column: $table.featureDescription,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grantedSkillKeysJson => $composableBuilder(
    column: $table.grantedSkillKeysJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grantedToolKeysJson => $composableBuilder(
    column: $table.grantedToolKeysJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grantedLanguageKeysJson => $composableBuilder(
    column: $table.grantedLanguageKeysJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startingEquipmentJson => $composableBuilder(
    column: $table.startingEquipmentJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BackgroundDefinitionsTableOrderingComposer
    extends Composer<_$AppDatabase, $BackgroundDefinitionsTable> {
  $$BackgroundDefinitionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get summary => $composableBuilder(
    column: $table.summary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get featureName => $composableBuilder(
    column: $table.featureName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get featureDescription => $composableBuilder(
    column: $table.featureDescription,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grantedSkillKeysJson => $composableBuilder(
    column: $table.grantedSkillKeysJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grantedToolKeysJson => $composableBuilder(
    column: $table.grantedToolKeysJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grantedLanguageKeysJson => $composableBuilder(
    column: $table.grantedLanguageKeysJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startingEquipmentJson => $composableBuilder(
    column: $table.startingEquipmentJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BackgroundDefinitionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BackgroundDefinitionsTable> {
  $$BackgroundDefinitionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get summary =>
      $composableBuilder(column: $table.summary, builder: (column) => column);

  GeneratedColumn<String> get featureName => $composableBuilder(
    column: $table.featureName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get featureDescription => $composableBuilder(
    column: $table.featureDescription,
    builder: (column) => column,
  );

  GeneratedColumn<String> get grantedSkillKeysJson => $composableBuilder(
    column: $table.grantedSkillKeysJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get grantedToolKeysJson => $composableBuilder(
    column: $table.grantedToolKeysJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get grantedLanguageKeysJson => $composableBuilder(
    column: $table.grantedLanguageKeysJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get startingEquipmentJson => $composableBuilder(
    column: $table.startingEquipmentJson,
    builder: (column) => column,
  );
}

class $$BackgroundDefinitionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BackgroundDefinitionsTable,
          BackgroundDefinition,
          $$BackgroundDefinitionsTableFilterComposer,
          $$BackgroundDefinitionsTableOrderingComposer,
          $$BackgroundDefinitionsTableAnnotationComposer,
          $$BackgroundDefinitionsTableCreateCompanionBuilder,
          $$BackgroundDefinitionsTableUpdateCompanionBuilder,
          (
            BackgroundDefinition,
            BaseReferences<
              _$AppDatabase,
              $BackgroundDefinitionsTable,
              BackgroundDefinition
            >,
          ),
          BackgroundDefinition,
          PrefetchHooks Function()
        > {
  $$BackgroundDefinitionsTableTableManager(
    _$AppDatabase db,
    $BackgroundDefinitionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BackgroundDefinitionsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$BackgroundDefinitionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$BackgroundDefinitionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> key = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> summary = const Value.absent(),
                Value<String?> featureName = const Value.absent(),
                Value<String?> featureDescription = const Value.absent(),
                Value<String?> grantedSkillKeysJson = const Value.absent(),
                Value<String?> grantedToolKeysJson = const Value.absent(),
                Value<String?> grantedLanguageKeysJson = const Value.absent(),
                Value<String?> startingEquipmentJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BackgroundDefinitionsCompanion(
                id: id,
                key: key,
                name: name,
                summary: summary,
                featureName: featureName,
                featureDescription: featureDescription,
                grantedSkillKeysJson: grantedSkillKeysJson,
                grantedToolKeysJson: grantedToolKeysJson,
                grantedLanguageKeysJson: grantedLanguageKeysJson,
                startingEquipmentJson: startingEquipmentJson,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String key,
                required String name,
                Value<String?> summary = const Value.absent(),
                Value<String?> featureName = const Value.absent(),
                Value<String?> featureDescription = const Value.absent(),
                Value<String?> grantedSkillKeysJson = const Value.absent(),
                Value<String?> grantedToolKeysJson = const Value.absent(),
                Value<String?> grantedLanguageKeysJson = const Value.absent(),
                Value<String?> startingEquipmentJson = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BackgroundDefinitionsCompanion.insert(
                id: id,
                key: key,
                name: name,
                summary: summary,
                featureName: featureName,
                featureDescription: featureDescription,
                grantedSkillKeysJson: grantedSkillKeysJson,
                grantedToolKeysJson: grantedToolKeysJson,
                grantedLanguageKeysJson: grantedLanguageKeysJson,
                startingEquipmentJson: startingEquipmentJson,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BackgroundDefinitionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BackgroundDefinitionsTable,
      BackgroundDefinition,
      $$BackgroundDefinitionsTableFilterComposer,
      $$BackgroundDefinitionsTableOrderingComposer,
      $$BackgroundDefinitionsTableAnnotationComposer,
      $$BackgroundDefinitionsTableCreateCompanionBuilder,
      $$BackgroundDefinitionsTableUpdateCompanionBuilder,
      (
        BackgroundDefinition,
        BaseReferences<
          _$AppDatabase,
          $BackgroundDefinitionsTable,
          BackgroundDefinition
        >,
      ),
      BackgroundDefinition,
      PrefetchHooks Function()
    >;
typedef $$SpellDefinitionsTableCreateCompanionBuilder =
    SpellDefinitionsCompanion Function({
      required String id,
      required String key,
      required String name,
      required int level,
      required String school,
      Value<String?> castingTime,
      Value<String?> rangeText,
      Value<String?> durationText,
      Value<bool> requiresConcentration,
      Value<bool> isRitual,
      Value<String?> componentsJson,
      Value<String?> description,
      Value<String?> higherLevelsDescription,
      Value<int> rowid,
    });
typedef $$SpellDefinitionsTableUpdateCompanionBuilder =
    SpellDefinitionsCompanion Function({
      Value<String> id,
      Value<String> key,
      Value<String> name,
      Value<int> level,
      Value<String> school,
      Value<String?> castingTime,
      Value<String?> rangeText,
      Value<String?> durationText,
      Value<bool> requiresConcentration,
      Value<bool> isRitual,
      Value<String?> componentsJson,
      Value<String?> description,
      Value<String?> higherLevelsDescription,
      Value<int> rowid,
    });

class $$SpellDefinitionsTableFilterComposer
    extends Composer<_$AppDatabase, $SpellDefinitionsTable> {
  $$SpellDefinitionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get school => $composableBuilder(
    column: $table.school,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get castingTime => $composableBuilder(
    column: $table.castingTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rangeText => $composableBuilder(
    column: $table.rangeText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get durationText => $composableBuilder(
    column: $table.durationText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get requiresConcentration => $composableBuilder(
    column: $table.requiresConcentration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRitual => $composableBuilder(
    column: $table.isRitual,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get componentsJson => $composableBuilder(
    column: $table.componentsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get higherLevelsDescription => $composableBuilder(
    column: $table.higherLevelsDescription,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SpellDefinitionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SpellDefinitionsTable> {
  $$SpellDefinitionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get level => $composableBuilder(
    column: $table.level,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get school => $composableBuilder(
    column: $table.school,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get castingTime => $composableBuilder(
    column: $table.castingTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rangeText => $composableBuilder(
    column: $table.rangeText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get durationText => $composableBuilder(
    column: $table.durationText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get requiresConcentration => $composableBuilder(
    column: $table.requiresConcentration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRitual => $composableBuilder(
    column: $table.isRitual,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get componentsJson => $composableBuilder(
    column: $table.componentsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get higherLevelsDescription => $composableBuilder(
    column: $table.higherLevelsDescription,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SpellDefinitionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SpellDefinitionsTable> {
  $$SpellDefinitionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<String> get school =>
      $composableBuilder(column: $table.school, builder: (column) => column);

  GeneratedColumn<String> get castingTime => $composableBuilder(
    column: $table.castingTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get rangeText =>
      $composableBuilder(column: $table.rangeText, builder: (column) => column);

  GeneratedColumn<String> get durationText => $composableBuilder(
    column: $table.durationText,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get requiresConcentration => $composableBuilder(
    column: $table.requiresConcentration,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isRitual =>
      $composableBuilder(column: $table.isRitual, builder: (column) => column);

  GeneratedColumn<String> get componentsJson => $composableBuilder(
    column: $table.componentsJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get higherLevelsDescription => $composableBuilder(
    column: $table.higherLevelsDescription,
    builder: (column) => column,
  );
}

class $$SpellDefinitionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SpellDefinitionsTable,
          SpellDefinition,
          $$SpellDefinitionsTableFilterComposer,
          $$SpellDefinitionsTableOrderingComposer,
          $$SpellDefinitionsTableAnnotationComposer,
          $$SpellDefinitionsTableCreateCompanionBuilder,
          $$SpellDefinitionsTableUpdateCompanionBuilder,
          (
            SpellDefinition,
            BaseReferences<
              _$AppDatabase,
              $SpellDefinitionsTable,
              SpellDefinition
            >,
          ),
          SpellDefinition,
          PrefetchHooks Function()
        > {
  $$SpellDefinitionsTableTableManager(
    _$AppDatabase db,
    $SpellDefinitionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SpellDefinitionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SpellDefinitionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SpellDefinitionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> key = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<String> school = const Value.absent(),
                Value<String?> castingTime = const Value.absent(),
                Value<String?> rangeText = const Value.absent(),
                Value<String?> durationText = const Value.absent(),
                Value<bool> requiresConcentration = const Value.absent(),
                Value<bool> isRitual = const Value.absent(),
                Value<String?> componentsJson = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> higherLevelsDescription = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SpellDefinitionsCompanion(
                id: id,
                key: key,
                name: name,
                level: level,
                school: school,
                castingTime: castingTime,
                rangeText: rangeText,
                durationText: durationText,
                requiresConcentration: requiresConcentration,
                isRitual: isRitual,
                componentsJson: componentsJson,
                description: description,
                higherLevelsDescription: higherLevelsDescription,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String key,
                required String name,
                required int level,
                required String school,
                Value<String?> castingTime = const Value.absent(),
                Value<String?> rangeText = const Value.absent(),
                Value<String?> durationText = const Value.absent(),
                Value<bool> requiresConcentration = const Value.absent(),
                Value<bool> isRitual = const Value.absent(),
                Value<String?> componentsJson = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> higherLevelsDescription = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SpellDefinitionsCompanion.insert(
                id: id,
                key: key,
                name: name,
                level: level,
                school: school,
                castingTime: castingTime,
                rangeText: rangeText,
                durationText: durationText,
                requiresConcentration: requiresConcentration,
                isRitual: isRitual,
                componentsJson: componentsJson,
                description: description,
                higherLevelsDescription: higherLevelsDescription,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SpellDefinitionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SpellDefinitionsTable,
      SpellDefinition,
      $$SpellDefinitionsTableFilterComposer,
      $$SpellDefinitionsTableOrderingComposer,
      $$SpellDefinitionsTableAnnotationComposer,
      $$SpellDefinitionsTableCreateCompanionBuilder,
      $$SpellDefinitionsTableUpdateCompanionBuilder,
      (
        SpellDefinition,
        BaseReferences<_$AppDatabase, $SpellDefinitionsTable, SpellDefinition>,
      ),
      SpellDefinition,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CharactersTableTableManager get characters =>
      $$CharactersTableTableManager(_db, _db.characters);
  $$CharacterAbilityScoresTableTableManager get characterAbilityScores =>
      $$CharacterAbilityScoresTableTableManager(
        _db,
        _db.characterAbilityScores,
      );
  $$CharacterAbilityScoreProvenancesTableTableManager
  get characterAbilityScoreProvenances =>
      $$CharacterAbilityScoreProvenancesTableTableManager(
        _db,
        _db.characterAbilityScoreProvenances,
      );
  $$CharacterHitPointsTableTableManager get characterHitPoints =>
      $$CharacterHitPointsTableTableManager(_db, _db.characterHitPoints);
  $$CharacterFinishingDetailsTableTableManager get characterFinishingDetails =>
      $$CharacterFinishingDetailsTableTableManager(
        _db,
        _db.characterFinishingDetails,
      );
  $$CharacterNarrativeSelectionsTableTableManager
  get characterNarrativeSelections =>
      $$CharacterNarrativeSelectionsTableTableManager(
        _db,
        _db.characterNarrativeSelections,
      );
  $$CharacterEquipmentLoadoutsTableTableManager
  get characterEquipmentLoadouts =>
      $$CharacterEquipmentLoadoutsTableTableManager(
        _db,
        _db.characterEquipmentLoadouts,
      );
  $$CharacterSpellSelectionsTableTableManager get characterSpellSelections =>
      $$CharacterSpellSelectionsTableTableManager(
        _db,
        _db.characterSpellSelections,
      );
  $$CharacterSpellSlotUsagesTableTableManager get characterSpellSlotUsages =>
      $$CharacterSpellSlotUsagesTableTableManager(
        _db,
        _db.characterSpellSlotUsages,
      );
  $$SkillDefinitionsTableTableManager get skillDefinitions =>
      $$SkillDefinitionsTableTableManager(_db, _db.skillDefinitions);
  $$CharacterSkillsTableTableManager get characterSkills =>
      $$CharacterSkillsTableTableManager(_db, _db.characterSkills);
  $$CharacterSavingThrowsTableTableManager get characterSavingThrows =>
      $$CharacterSavingThrowsTableTableManager(_db, _db.characterSavingThrows);
  $$EquipmentDefinitionsTableTableManager get equipmentDefinitions =>
      $$EquipmentDefinitionsTableTableManager(_db, _db.equipmentDefinitions);
  $$TrinketDefinitionsTableTableManager get trinketDefinitions =>
      $$TrinketDefinitionsTableTableManager(_db, _db.trinketDefinitions);
  $$CharacterInventoryTableTableManager get characterInventory =>
      $$CharacterInventoryTableTableManager(_db, _db.characterInventory);
  $$CharacterProficienciesTableTableManager get characterProficiencies =>
      $$CharacterProficienciesTableTableManager(
        _db,
        _db.characterProficiencies,
      );
  $$CharacterCurrencyTableTableManager get characterCurrency =>
      $$CharacterCurrencyTableTableManager(_db, _db.characterCurrency);
  $$ClassDefinitionsTableTableManager get classDefinitions =>
      $$ClassDefinitionsTableTableManager(_db, _db.classDefinitions);
  $$CharacterAdvancementDefinitionsTableTableManager
  get characterAdvancementDefinitions =>
      $$CharacterAdvancementDefinitionsTableTableManager(
        _db,
        _db.characterAdvancementDefinitions,
      );
  $$ClassStandardArrayRecommendationsTableTableManager
  get classStandardArrayRecommendations =>
      $$ClassStandardArrayRecommendationsTableTableManager(
        _db,
        _db.classStandardArrayRecommendations,
      );
  $$NarrativeOptionGroupsTableTableManager get narrativeOptionGroups =>
      $$NarrativeOptionGroupsTableTableManager(_db, _db.narrativeOptionGroups);
  $$NarrativeOptionsTableTableManager get narrativeOptions =>
      $$NarrativeOptionsTableTableManager(_db, _db.narrativeOptions);
  $$CompendiumPackStatesTableTableManager get compendiumPackStates =>
      $$CompendiumPackStatesTableTableManager(_db, _db.compendiumPackStates);
  $$ImportedCompendiumPacksTableTableManager get importedCompendiumPacks =>
      $$ImportedCompendiumPacksTableTableManager(
        _db,
        _db.importedCompendiumPacks,
      );
  $$BackgroundDefinitionsTableTableManager get backgroundDefinitions =>
      $$BackgroundDefinitionsTableTableManager(_db, _db.backgroundDefinitions);
  $$SpellDefinitionsTableTableManager get spellDefinitions =>
      $$SpellDefinitionsTableTableManager(_db, _db.spellDefinitions);
}
