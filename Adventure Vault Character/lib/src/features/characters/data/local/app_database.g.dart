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
  static const VerificationMeta _backgroundSummaryMeta = const VerificationMeta(
    'backgroundSummary',
  );
  @override
  late final GeneratedColumn<String> backgroundSummary =
      GeneratedColumn<String>(
        'background_summary',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _abilityScoreMethodMeta =
      const VerificationMeta('abilityScoreMethod');
  @override
  late final GeneratedColumn<String> abilityScoreMethod =
      GeneratedColumn<String>(
        'ability_score_method',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _abilityScoreProvenanceMeta =
      const VerificationMeta('abilityScoreProvenance');
  @override
  late final GeneratedColumn<String> abilityScoreProvenance =
      GeneratedColumn<String>(
        'ability_score_provenance',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _strengthMeta = const VerificationMeta(
    'strength',
  );
  @override
  late final GeneratedColumn<int> strength = GeneratedColumn<int>(
    'strength',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dexterityMeta = const VerificationMeta(
    'dexterity',
  );
  @override
  late final GeneratedColumn<int> dexterity = GeneratedColumn<int>(
    'dexterity',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _constitutionMeta = const VerificationMeta(
    'constitution',
  );
  @override
  late final GeneratedColumn<int> constitution = GeneratedColumn<int>(
    'constitution',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _intelligenceMeta = const VerificationMeta(
    'intelligence',
  );
  @override
  late final GeneratedColumn<int> intelligence = GeneratedColumn<int>(
    'intelligence',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _wisdomMeta = const VerificationMeta('wisdom');
  @override
  late final GeneratedColumn<int> wisdom = GeneratedColumn<int>(
    'wisdom',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _charismaMeta = const VerificationMeta(
    'charisma',
  );
  @override
  late final GeneratedColumn<int> charisma = GeneratedColumn<int>(
    'charisma',
    aliasedName,
    true,
    type: DriftSqlType.int,
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
  static const VerificationMeta _currentHitPointsMeta = const VerificationMeta(
    'currentHitPoints',
  );
  @override
  late final GeneratedColumn<int> currentHitPoints = GeneratedColumn<int>(
    'current_hit_points',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maximumHitPointsMeta = const VerificationMeta(
    'maximumHitPoints',
  );
  @override
  late final GeneratedColumn<int> maximumHitPoints = GeneratedColumn<int>(
    'maximum_hit_points',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _temporaryHitPointsMeta =
      const VerificationMeta('temporaryHitPoints');
  @override
  late final GeneratedColumn<int> temporaryHitPoints = GeneratedColumn<int>(
    'temporary_hit_points',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
    backgroundId,
    backgroundName,
    backgroundSummary,
    abilityScoreMethod,
    abilityScoreProvenance,
    strength,
    dexterity,
    constitution,
    intelligence,
    wisdom,
    charisma,
    className,
    level,
    experience,
    currentHitPoints,
    maximumHitPoints,
    temporaryHitPoints,
    portraitAssetPath,
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
    if (data.containsKey('background_summary')) {
      context.handle(
        _backgroundSummaryMeta,
        backgroundSummary.isAcceptableOrUnknown(
          data['background_summary']!,
          _backgroundSummaryMeta,
        ),
      );
    }
    if (data.containsKey('ability_score_method')) {
      context.handle(
        _abilityScoreMethodMeta,
        abilityScoreMethod.isAcceptableOrUnknown(
          data['ability_score_method']!,
          _abilityScoreMethodMeta,
        ),
      );
    }
    if (data.containsKey('ability_score_provenance')) {
      context.handle(
        _abilityScoreProvenanceMeta,
        abilityScoreProvenance.isAcceptableOrUnknown(
          data['ability_score_provenance']!,
          _abilityScoreProvenanceMeta,
        ),
      );
    }
    if (data.containsKey('strength')) {
      context.handle(
        _strengthMeta,
        strength.isAcceptableOrUnknown(data['strength']!, _strengthMeta),
      );
    }
    if (data.containsKey('dexterity')) {
      context.handle(
        _dexterityMeta,
        dexterity.isAcceptableOrUnknown(data['dexterity']!, _dexterityMeta),
      );
    }
    if (data.containsKey('constitution')) {
      context.handle(
        _constitutionMeta,
        constitution.isAcceptableOrUnknown(
          data['constitution']!,
          _constitutionMeta,
        ),
      );
    }
    if (data.containsKey('intelligence')) {
      context.handle(
        _intelligenceMeta,
        intelligence.isAcceptableOrUnknown(
          data['intelligence']!,
          _intelligenceMeta,
        ),
      );
    }
    if (data.containsKey('wisdom')) {
      context.handle(
        _wisdomMeta,
        wisdom.isAcceptableOrUnknown(data['wisdom']!, _wisdomMeta),
      );
    }
    if (data.containsKey('charisma')) {
      context.handle(
        _charismaMeta,
        charisma.isAcceptableOrUnknown(data['charisma']!, _charismaMeta),
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
    if (data.containsKey('current_hit_points')) {
      context.handle(
        _currentHitPointsMeta,
        currentHitPoints.isAcceptableOrUnknown(
          data['current_hit_points']!,
          _currentHitPointsMeta,
        ),
      );
    }
    if (data.containsKey('maximum_hit_points')) {
      context.handle(
        _maximumHitPointsMeta,
        maximumHitPoints.isAcceptableOrUnknown(
          data['maximum_hit_points']!,
          _maximumHitPointsMeta,
        ),
      );
    }
    if (data.containsKey('temporary_hit_points')) {
      context.handle(
        _temporaryHitPointsMeta,
        temporaryHitPoints.isAcceptableOrUnknown(
          data['temporary_hit_points']!,
          _temporaryHitPointsMeta,
        ),
      );
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
      backgroundId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}background_id'],
      ),
      backgroundName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}background_name'],
      ),
      backgroundSummary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}background_summary'],
      ),
      abilityScoreMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ability_score_method'],
      ),
      abilityScoreProvenance: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ability_score_provenance'],
      ),
      strength: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}strength'],
      ),
      dexterity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dexterity'],
      ),
      constitution: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}constitution'],
      ),
      intelligence: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}intelligence'],
      ),
      wisdom: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wisdom'],
      ),
      charisma: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}charisma'],
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
      currentHitPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_hit_points'],
      ),
      maximumHitPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}maximum_hit_points'],
      ),
      temporaryHitPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}temporary_hit_points'],
      ),
      portraitAssetPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}portrait_asset_path'],
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
  final String? backgroundId;
  final String? backgroundName;
  final String? backgroundSummary;
  final String? abilityScoreMethod;
  final String? abilityScoreProvenance;
  final int? strength;
  final int? dexterity;
  final int? constitution;
  final int? intelligence;
  final int? wisdom;
  final int? charisma;
  final String className;
  final int level;
  final int? experience;
  final int? currentHitPoints;
  final int? maximumHitPoints;
  final int? temporaryHitPoints;
  final String? portraitAssetPath;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Character({
    required this.id,
    required this.name,
    required this.raceName,
    this.backgroundId,
    this.backgroundName,
    this.backgroundSummary,
    this.abilityScoreMethod,
    this.abilityScoreProvenance,
    this.strength,
    this.dexterity,
    this.constitution,
    this.intelligence,
    this.wisdom,
    this.charisma,
    required this.className,
    required this.level,
    this.experience,
    this.currentHitPoints,
    this.maximumHitPoints,
    this.temporaryHitPoints,
    this.portraitAssetPath,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['race_name'] = Variable<String>(raceName);
    if (!nullToAbsent || backgroundId != null) {
      map['background_id'] = Variable<String>(backgroundId);
    }
    if (!nullToAbsent || backgroundName != null) {
      map['background_name'] = Variable<String>(backgroundName);
    }
    if (!nullToAbsent || backgroundSummary != null) {
      map['background_summary'] = Variable<String>(backgroundSummary);
    }
    if (!nullToAbsent || abilityScoreMethod != null) {
      map['ability_score_method'] = Variable<String>(abilityScoreMethod);
    }
    if (!nullToAbsent || abilityScoreProvenance != null) {
      map['ability_score_provenance'] = Variable<String>(
        abilityScoreProvenance,
      );
    }
    if (!nullToAbsent || strength != null) {
      map['strength'] = Variable<int>(strength);
    }
    if (!nullToAbsent || dexterity != null) {
      map['dexterity'] = Variable<int>(dexterity);
    }
    if (!nullToAbsent || constitution != null) {
      map['constitution'] = Variable<int>(constitution);
    }
    if (!nullToAbsent || intelligence != null) {
      map['intelligence'] = Variable<int>(intelligence);
    }
    if (!nullToAbsent || wisdom != null) {
      map['wisdom'] = Variable<int>(wisdom);
    }
    if (!nullToAbsent || charisma != null) {
      map['charisma'] = Variable<int>(charisma);
    }
    map['class_name'] = Variable<String>(className);
    map['level'] = Variable<int>(level);
    if (!nullToAbsent || experience != null) {
      map['experience'] = Variable<int>(experience);
    }
    if (!nullToAbsent || currentHitPoints != null) {
      map['current_hit_points'] = Variable<int>(currentHitPoints);
    }
    if (!nullToAbsent || maximumHitPoints != null) {
      map['maximum_hit_points'] = Variable<int>(maximumHitPoints);
    }
    if (!nullToAbsent || temporaryHitPoints != null) {
      map['temporary_hit_points'] = Variable<int>(temporaryHitPoints);
    }
    if (!nullToAbsent || portraitAssetPath != null) {
      map['portrait_asset_path'] = Variable<String>(portraitAssetPath);
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
      backgroundId: backgroundId == null && nullToAbsent
          ? const Value.absent()
          : Value(backgroundId),
      backgroundName: backgroundName == null && nullToAbsent
          ? const Value.absent()
          : Value(backgroundName),
      backgroundSummary: backgroundSummary == null && nullToAbsent
          ? const Value.absent()
          : Value(backgroundSummary),
      abilityScoreMethod: abilityScoreMethod == null && nullToAbsent
          ? const Value.absent()
          : Value(abilityScoreMethod),
      abilityScoreProvenance: abilityScoreProvenance == null && nullToAbsent
          ? const Value.absent()
          : Value(abilityScoreProvenance),
      strength: strength == null && nullToAbsent
          ? const Value.absent()
          : Value(strength),
      dexterity: dexterity == null && nullToAbsent
          ? const Value.absent()
          : Value(dexterity),
      constitution: constitution == null && nullToAbsent
          ? const Value.absent()
          : Value(constitution),
      intelligence: intelligence == null && nullToAbsent
          ? const Value.absent()
          : Value(intelligence),
      wisdom: wisdom == null && nullToAbsent
          ? const Value.absent()
          : Value(wisdom),
      charisma: charisma == null && nullToAbsent
          ? const Value.absent()
          : Value(charisma),
      className: Value(className),
      level: Value(level),
      experience: experience == null && nullToAbsent
          ? const Value.absent()
          : Value(experience),
      currentHitPoints: currentHitPoints == null && nullToAbsent
          ? const Value.absent()
          : Value(currentHitPoints),
      maximumHitPoints: maximumHitPoints == null && nullToAbsent
          ? const Value.absent()
          : Value(maximumHitPoints),
      temporaryHitPoints: temporaryHitPoints == null && nullToAbsent
          ? const Value.absent()
          : Value(temporaryHitPoints),
      portraitAssetPath: portraitAssetPath == null && nullToAbsent
          ? const Value.absent()
          : Value(portraitAssetPath),
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
      backgroundId: serializer.fromJson<String?>(json['backgroundId']),
      backgroundName: serializer.fromJson<String?>(json['backgroundName']),
      backgroundSummary: serializer.fromJson<String?>(
        json['backgroundSummary'],
      ),
      abilityScoreMethod: serializer.fromJson<String?>(
        json['abilityScoreMethod'],
      ),
      abilityScoreProvenance: serializer.fromJson<String?>(
        json['abilityScoreProvenance'],
      ),
      strength: serializer.fromJson<int?>(json['strength']),
      dexterity: serializer.fromJson<int?>(json['dexterity']),
      constitution: serializer.fromJson<int?>(json['constitution']),
      intelligence: serializer.fromJson<int?>(json['intelligence']),
      wisdom: serializer.fromJson<int?>(json['wisdom']),
      charisma: serializer.fromJson<int?>(json['charisma']),
      className: serializer.fromJson<String>(json['className']),
      level: serializer.fromJson<int>(json['level']),
      experience: serializer.fromJson<int?>(json['experience']),
      currentHitPoints: serializer.fromJson<int?>(json['currentHitPoints']),
      maximumHitPoints: serializer.fromJson<int?>(json['maximumHitPoints']),
      temporaryHitPoints: serializer.fromJson<int?>(json['temporaryHitPoints']),
      portraitAssetPath: serializer.fromJson<String?>(
        json['portraitAssetPath'],
      ),
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
      'backgroundId': serializer.toJson<String?>(backgroundId),
      'backgroundName': serializer.toJson<String?>(backgroundName),
      'backgroundSummary': serializer.toJson<String?>(backgroundSummary),
      'abilityScoreMethod': serializer.toJson<String?>(abilityScoreMethod),
      'abilityScoreProvenance': serializer.toJson<String?>(
        abilityScoreProvenance,
      ),
      'strength': serializer.toJson<int?>(strength),
      'dexterity': serializer.toJson<int?>(dexterity),
      'constitution': serializer.toJson<int?>(constitution),
      'intelligence': serializer.toJson<int?>(intelligence),
      'wisdom': serializer.toJson<int?>(wisdom),
      'charisma': serializer.toJson<int?>(charisma),
      'className': serializer.toJson<String>(className),
      'level': serializer.toJson<int>(level),
      'experience': serializer.toJson<int?>(experience),
      'currentHitPoints': serializer.toJson<int?>(currentHitPoints),
      'maximumHitPoints': serializer.toJson<int?>(maximumHitPoints),
      'temporaryHitPoints': serializer.toJson<int?>(temporaryHitPoints),
      'portraitAssetPath': serializer.toJson<String?>(portraitAssetPath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Character copyWith({
    String? id,
    String? name,
    String? raceName,
    Value<String?> backgroundId = const Value.absent(),
    Value<String?> backgroundName = const Value.absent(),
    Value<String?> backgroundSummary = const Value.absent(),
    Value<String?> abilityScoreMethod = const Value.absent(),
    Value<String?> abilityScoreProvenance = const Value.absent(),
    Value<int?> strength = const Value.absent(),
    Value<int?> dexterity = const Value.absent(),
    Value<int?> constitution = const Value.absent(),
    Value<int?> intelligence = const Value.absent(),
    Value<int?> wisdom = const Value.absent(),
    Value<int?> charisma = const Value.absent(),
    String? className,
    int? level,
    Value<int?> experience = const Value.absent(),
    Value<int?> currentHitPoints = const Value.absent(),
    Value<int?> maximumHitPoints = const Value.absent(),
    Value<int?> temporaryHitPoints = const Value.absent(),
    Value<String?> portraitAssetPath = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Character(
    id: id ?? this.id,
    name: name ?? this.name,
    raceName: raceName ?? this.raceName,
    backgroundId: backgroundId.present ? backgroundId.value : this.backgroundId,
    backgroundName: backgroundName.present
        ? backgroundName.value
        : this.backgroundName,
    backgroundSummary: backgroundSummary.present
        ? backgroundSummary.value
        : this.backgroundSummary,
    abilityScoreMethod: abilityScoreMethod.present
        ? abilityScoreMethod.value
        : this.abilityScoreMethod,
    abilityScoreProvenance: abilityScoreProvenance.present
        ? abilityScoreProvenance.value
        : this.abilityScoreProvenance,
    strength: strength.present ? strength.value : this.strength,
    dexterity: dexterity.present ? dexterity.value : this.dexterity,
    constitution: constitution.present ? constitution.value : this.constitution,
    intelligence: intelligence.present ? intelligence.value : this.intelligence,
    wisdom: wisdom.present ? wisdom.value : this.wisdom,
    charisma: charisma.present ? charisma.value : this.charisma,
    className: className ?? this.className,
    level: level ?? this.level,
    experience: experience.present ? experience.value : this.experience,
    currentHitPoints: currentHitPoints.present
        ? currentHitPoints.value
        : this.currentHitPoints,
    maximumHitPoints: maximumHitPoints.present
        ? maximumHitPoints.value
        : this.maximumHitPoints,
    temporaryHitPoints: temporaryHitPoints.present
        ? temporaryHitPoints.value
        : this.temporaryHitPoints,
    portraitAssetPath: portraitAssetPath.present
        ? portraitAssetPath.value
        : this.portraitAssetPath,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Character copyWithCompanion(CharactersCompanion data) {
    return Character(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      raceName: data.raceName.present ? data.raceName.value : this.raceName,
      backgroundId: data.backgroundId.present
          ? data.backgroundId.value
          : this.backgroundId,
      backgroundName: data.backgroundName.present
          ? data.backgroundName.value
          : this.backgroundName,
      backgroundSummary: data.backgroundSummary.present
          ? data.backgroundSummary.value
          : this.backgroundSummary,
      abilityScoreMethod: data.abilityScoreMethod.present
          ? data.abilityScoreMethod.value
          : this.abilityScoreMethod,
      abilityScoreProvenance: data.abilityScoreProvenance.present
          ? data.abilityScoreProvenance.value
          : this.abilityScoreProvenance,
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
      className: data.className.present ? data.className.value : this.className,
      level: data.level.present ? data.level.value : this.level,
      experience: data.experience.present
          ? data.experience.value
          : this.experience,
      currentHitPoints: data.currentHitPoints.present
          ? data.currentHitPoints.value
          : this.currentHitPoints,
      maximumHitPoints: data.maximumHitPoints.present
          ? data.maximumHitPoints.value
          : this.maximumHitPoints,
      temporaryHitPoints: data.temporaryHitPoints.present
          ? data.temporaryHitPoints.value
          : this.temporaryHitPoints,
      portraitAssetPath: data.portraitAssetPath.present
          ? data.portraitAssetPath.value
          : this.portraitAssetPath,
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
          ..write('backgroundId: $backgroundId, ')
          ..write('backgroundName: $backgroundName, ')
          ..write('backgroundSummary: $backgroundSummary, ')
          ..write('abilityScoreMethod: $abilityScoreMethod, ')
          ..write('abilityScoreProvenance: $abilityScoreProvenance, ')
          ..write('strength: $strength, ')
          ..write('dexterity: $dexterity, ')
          ..write('constitution: $constitution, ')
          ..write('intelligence: $intelligence, ')
          ..write('wisdom: $wisdom, ')
          ..write('charisma: $charisma, ')
          ..write('className: $className, ')
          ..write('level: $level, ')
          ..write('experience: $experience, ')
          ..write('currentHitPoints: $currentHitPoints, ')
          ..write('maximumHitPoints: $maximumHitPoints, ')
          ..write('temporaryHitPoints: $temporaryHitPoints, ')
          ..write('portraitAssetPath: $portraitAssetPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    name,
    raceName,
    backgroundId,
    backgroundName,
    backgroundSummary,
    abilityScoreMethod,
    abilityScoreProvenance,
    strength,
    dexterity,
    constitution,
    intelligence,
    wisdom,
    charisma,
    className,
    level,
    experience,
    currentHitPoints,
    maximumHitPoints,
    temporaryHitPoints,
    portraitAssetPath,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Character &&
          other.id == this.id &&
          other.name == this.name &&
          other.raceName == this.raceName &&
          other.backgroundId == this.backgroundId &&
          other.backgroundName == this.backgroundName &&
          other.backgroundSummary == this.backgroundSummary &&
          other.abilityScoreMethod == this.abilityScoreMethod &&
          other.abilityScoreProvenance == this.abilityScoreProvenance &&
          other.strength == this.strength &&
          other.dexterity == this.dexterity &&
          other.constitution == this.constitution &&
          other.intelligence == this.intelligence &&
          other.wisdom == this.wisdom &&
          other.charisma == this.charisma &&
          other.className == this.className &&
          other.level == this.level &&
          other.experience == this.experience &&
          other.currentHitPoints == this.currentHitPoints &&
          other.maximumHitPoints == this.maximumHitPoints &&
          other.temporaryHitPoints == this.temporaryHitPoints &&
          other.portraitAssetPath == this.portraitAssetPath &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CharactersCompanion extends UpdateCompanion<Character> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> raceName;
  final Value<String?> backgroundId;
  final Value<String?> backgroundName;
  final Value<String?> backgroundSummary;
  final Value<String?> abilityScoreMethod;
  final Value<String?> abilityScoreProvenance;
  final Value<int?> strength;
  final Value<int?> dexterity;
  final Value<int?> constitution;
  final Value<int?> intelligence;
  final Value<int?> wisdom;
  final Value<int?> charisma;
  final Value<String> className;
  final Value<int> level;
  final Value<int?> experience;
  final Value<int?> currentHitPoints;
  final Value<int?> maximumHitPoints;
  final Value<int?> temporaryHitPoints;
  final Value<String?> portraitAssetPath;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CharactersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.raceName = const Value.absent(),
    this.backgroundId = const Value.absent(),
    this.backgroundName = const Value.absent(),
    this.backgroundSummary = const Value.absent(),
    this.abilityScoreMethod = const Value.absent(),
    this.abilityScoreProvenance = const Value.absent(),
    this.strength = const Value.absent(),
    this.dexterity = const Value.absent(),
    this.constitution = const Value.absent(),
    this.intelligence = const Value.absent(),
    this.wisdom = const Value.absent(),
    this.charisma = const Value.absent(),
    this.className = const Value.absent(),
    this.level = const Value.absent(),
    this.experience = const Value.absent(),
    this.currentHitPoints = const Value.absent(),
    this.maximumHitPoints = const Value.absent(),
    this.temporaryHitPoints = const Value.absent(),
    this.portraitAssetPath = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CharactersCompanion.insert({
    required String id,
    required String name,
    required String raceName,
    this.backgroundId = const Value.absent(),
    this.backgroundName = const Value.absent(),
    this.backgroundSummary = const Value.absent(),
    this.abilityScoreMethod = const Value.absent(),
    this.abilityScoreProvenance = const Value.absent(),
    this.strength = const Value.absent(),
    this.dexterity = const Value.absent(),
    this.constitution = const Value.absent(),
    this.intelligence = const Value.absent(),
    this.wisdom = const Value.absent(),
    this.charisma = const Value.absent(),
    required String className,
    required int level,
    this.experience = const Value.absent(),
    this.currentHitPoints = const Value.absent(),
    this.maximumHitPoints = const Value.absent(),
    this.temporaryHitPoints = const Value.absent(),
    this.portraitAssetPath = const Value.absent(),
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
    Expression<String>? backgroundId,
    Expression<String>? backgroundName,
    Expression<String>? backgroundSummary,
    Expression<String>? abilityScoreMethod,
    Expression<String>? abilityScoreProvenance,
    Expression<int>? strength,
    Expression<int>? dexterity,
    Expression<int>? constitution,
    Expression<int>? intelligence,
    Expression<int>? wisdom,
    Expression<int>? charisma,
    Expression<String>? className,
    Expression<int>? level,
    Expression<int>? experience,
    Expression<int>? currentHitPoints,
    Expression<int>? maximumHitPoints,
    Expression<int>? temporaryHitPoints,
    Expression<String>? portraitAssetPath,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (raceName != null) 'race_name': raceName,
      if (backgroundId != null) 'background_id': backgroundId,
      if (backgroundName != null) 'background_name': backgroundName,
      if (backgroundSummary != null) 'background_summary': backgroundSummary,
      if (abilityScoreMethod != null)
        'ability_score_method': abilityScoreMethod,
      if (abilityScoreProvenance != null)
        'ability_score_provenance': abilityScoreProvenance,
      if (strength != null) 'strength': strength,
      if (dexterity != null) 'dexterity': dexterity,
      if (constitution != null) 'constitution': constitution,
      if (intelligence != null) 'intelligence': intelligence,
      if (wisdom != null) 'wisdom': wisdom,
      if (charisma != null) 'charisma': charisma,
      if (className != null) 'class_name': className,
      if (level != null) 'level': level,
      if (experience != null) 'experience': experience,
      if (currentHitPoints != null) 'current_hit_points': currentHitPoints,
      if (maximumHitPoints != null) 'maximum_hit_points': maximumHitPoints,
      if (temporaryHitPoints != null)
        'temporary_hit_points': temporaryHitPoints,
      if (portraitAssetPath != null) 'portrait_asset_path': portraitAssetPath,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CharactersCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? raceName,
    Value<String?>? backgroundId,
    Value<String?>? backgroundName,
    Value<String?>? backgroundSummary,
    Value<String?>? abilityScoreMethod,
    Value<String?>? abilityScoreProvenance,
    Value<int?>? strength,
    Value<int?>? dexterity,
    Value<int?>? constitution,
    Value<int?>? intelligence,
    Value<int?>? wisdom,
    Value<int?>? charisma,
    Value<String>? className,
    Value<int>? level,
    Value<int?>? experience,
    Value<int?>? currentHitPoints,
    Value<int?>? maximumHitPoints,
    Value<int?>? temporaryHitPoints,
    Value<String?>? portraitAssetPath,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return CharactersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      raceName: raceName ?? this.raceName,
      backgroundId: backgroundId ?? this.backgroundId,
      backgroundName: backgroundName ?? this.backgroundName,
      backgroundSummary: backgroundSummary ?? this.backgroundSummary,
      abilityScoreMethod: abilityScoreMethod ?? this.abilityScoreMethod,
      abilityScoreProvenance:
          abilityScoreProvenance ?? this.abilityScoreProvenance,
      strength: strength ?? this.strength,
      dexterity: dexterity ?? this.dexterity,
      constitution: constitution ?? this.constitution,
      intelligence: intelligence ?? this.intelligence,
      wisdom: wisdom ?? this.wisdom,
      charisma: charisma ?? this.charisma,
      className: className ?? this.className,
      level: level ?? this.level,
      experience: experience ?? this.experience,
      currentHitPoints: currentHitPoints ?? this.currentHitPoints,
      maximumHitPoints: maximumHitPoints ?? this.maximumHitPoints,
      temporaryHitPoints: temporaryHitPoints ?? this.temporaryHitPoints,
      portraitAssetPath: portraitAssetPath ?? this.portraitAssetPath,
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
    if (backgroundId.present) {
      map['background_id'] = Variable<String>(backgroundId.value);
    }
    if (backgroundName.present) {
      map['background_name'] = Variable<String>(backgroundName.value);
    }
    if (backgroundSummary.present) {
      map['background_summary'] = Variable<String>(backgroundSummary.value);
    }
    if (abilityScoreMethod.present) {
      map['ability_score_method'] = Variable<String>(abilityScoreMethod.value);
    }
    if (abilityScoreProvenance.present) {
      map['ability_score_provenance'] = Variable<String>(
        abilityScoreProvenance.value,
      );
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
    if (className.present) {
      map['class_name'] = Variable<String>(className.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (experience.present) {
      map['experience'] = Variable<int>(experience.value);
    }
    if (currentHitPoints.present) {
      map['current_hit_points'] = Variable<int>(currentHitPoints.value);
    }
    if (maximumHitPoints.present) {
      map['maximum_hit_points'] = Variable<int>(maximumHitPoints.value);
    }
    if (temporaryHitPoints.present) {
      map['temporary_hit_points'] = Variable<int>(temporaryHitPoints.value);
    }
    if (portraitAssetPath.present) {
      map['portrait_asset_path'] = Variable<String>(portraitAssetPath.value);
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
          ..write('backgroundId: $backgroundId, ')
          ..write('backgroundName: $backgroundName, ')
          ..write('backgroundSummary: $backgroundSummary, ')
          ..write('abilityScoreMethod: $abilityScoreMethod, ')
          ..write('abilityScoreProvenance: $abilityScoreProvenance, ')
          ..write('strength: $strength, ')
          ..write('dexterity: $dexterity, ')
          ..write('constitution: $constitution, ')
          ..write('intelligence: $intelligence, ')
          ..write('wisdom: $wisdom, ')
          ..write('charisma: $charisma, ')
          ..write('className: $className, ')
          ..write('level: $level, ')
          ..write('experience: $experience, ')
          ..write('currentHitPoints: $currentHitPoints, ')
          ..write('maximumHitPoints: $maximumHitPoints, ')
          ..write('temporaryHitPoints: $temporaryHitPoints, ')
          ..write('portraitAssetPath: $portraitAssetPath, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CharactersTable characters = $CharactersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [characters];
}

typedef $$CharactersTableCreateCompanionBuilder =
    CharactersCompanion Function({
      required String id,
      required String name,
      required String raceName,
      Value<String?> backgroundId,
      Value<String?> backgroundName,
      Value<String?> backgroundSummary,
      Value<String?> abilityScoreMethod,
      Value<String?> abilityScoreProvenance,
      Value<int?> strength,
      Value<int?> dexterity,
      Value<int?> constitution,
      Value<int?> intelligence,
      Value<int?> wisdom,
      Value<int?> charisma,
      required String className,
      required int level,
      Value<int?> experience,
      Value<int?> currentHitPoints,
      Value<int?> maximumHitPoints,
      Value<int?> temporaryHitPoints,
      Value<String?> portraitAssetPath,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$CharactersTableUpdateCompanionBuilder =
    CharactersCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> raceName,
      Value<String?> backgroundId,
      Value<String?> backgroundName,
      Value<String?> backgroundSummary,
      Value<String?> abilityScoreMethod,
      Value<String?> abilityScoreProvenance,
      Value<int?> strength,
      Value<int?> dexterity,
      Value<int?> constitution,
      Value<int?> intelligence,
      Value<int?> wisdom,
      Value<int?> charisma,
      Value<String> className,
      Value<int> level,
      Value<int?> experience,
      Value<int?> currentHitPoints,
      Value<int?> maximumHitPoints,
      Value<int?> temporaryHitPoints,
      Value<String?> portraitAssetPath,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

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

  ColumnFilters<String> get backgroundId => $composableBuilder(
    column: $table.backgroundId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get backgroundName => $composableBuilder(
    column: $table.backgroundName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get backgroundSummary => $composableBuilder(
    column: $table.backgroundSummary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get abilityScoreMethod => $composableBuilder(
    column: $table.abilityScoreMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get abilityScoreProvenance => $composableBuilder(
    column: $table.abilityScoreProvenance,
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

  ColumnFilters<int> get currentHitPoints => $composableBuilder(
    column: $table.currentHitPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maximumHitPoints => $composableBuilder(
    column: $table.maximumHitPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get temporaryHitPoints => $composableBuilder(
    column: $table.temporaryHitPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get portraitAssetPath => $composableBuilder(
    column: $table.portraitAssetPath,
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

  ColumnOrderings<String> get backgroundId => $composableBuilder(
    column: $table.backgroundId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get backgroundName => $composableBuilder(
    column: $table.backgroundName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get backgroundSummary => $composableBuilder(
    column: $table.backgroundSummary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get abilityScoreMethod => $composableBuilder(
    column: $table.abilityScoreMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get abilityScoreProvenance => $composableBuilder(
    column: $table.abilityScoreProvenance,
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

  ColumnOrderings<int> get currentHitPoints => $composableBuilder(
    column: $table.currentHitPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maximumHitPoints => $composableBuilder(
    column: $table.maximumHitPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get temporaryHitPoints => $composableBuilder(
    column: $table.temporaryHitPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get portraitAssetPath => $composableBuilder(
    column: $table.portraitAssetPath,
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

  GeneratedColumn<String> get backgroundId => $composableBuilder(
    column: $table.backgroundId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get backgroundName => $composableBuilder(
    column: $table.backgroundName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get backgroundSummary => $composableBuilder(
    column: $table.backgroundSummary,
    builder: (column) => column,
  );

  GeneratedColumn<String> get abilityScoreMethod => $composableBuilder(
    column: $table.abilityScoreMethod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get abilityScoreProvenance => $composableBuilder(
    column: $table.abilityScoreProvenance,
    builder: (column) => column,
  );

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

  GeneratedColumn<String> get className =>
      $composableBuilder(column: $table.className, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get experience => $composableBuilder(
    column: $table.experience,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currentHitPoints => $composableBuilder(
    column: $table.currentHitPoints,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maximumHitPoints => $composableBuilder(
    column: $table.maximumHitPoints,
    builder: (column) => column,
  );

  GeneratedColumn<int> get temporaryHitPoints => $composableBuilder(
    column: $table.temporaryHitPoints,
    builder: (column) => column,
  );

  GeneratedColumn<String> get portraitAssetPath => $composableBuilder(
    column: $table.portraitAssetPath,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
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
          (
            Character,
            BaseReferences<_$AppDatabase, $CharactersTable, Character>,
          ),
          Character,
          PrefetchHooks Function()
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
                Value<String?> backgroundId = const Value.absent(),
                Value<String?> backgroundName = const Value.absent(),
                Value<String?> backgroundSummary = const Value.absent(),
                Value<String?> abilityScoreMethod = const Value.absent(),
                Value<String?> abilityScoreProvenance = const Value.absent(),
                Value<int?> strength = const Value.absent(),
                Value<int?> dexterity = const Value.absent(),
                Value<int?> constitution = const Value.absent(),
                Value<int?> intelligence = const Value.absent(),
                Value<int?> wisdom = const Value.absent(),
                Value<int?> charisma = const Value.absent(),
                Value<String> className = const Value.absent(),
                Value<int> level = const Value.absent(),
                Value<int?> experience = const Value.absent(),
                Value<int?> currentHitPoints = const Value.absent(),
                Value<int?> maximumHitPoints = const Value.absent(),
                Value<int?> temporaryHitPoints = const Value.absent(),
                Value<String?> portraitAssetPath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CharactersCompanion(
                id: id,
                name: name,
                raceName: raceName,
                backgroundId: backgroundId,
                backgroundName: backgroundName,
                backgroundSummary: backgroundSummary,
                abilityScoreMethod: abilityScoreMethod,
                abilityScoreProvenance: abilityScoreProvenance,
                strength: strength,
                dexterity: dexterity,
                constitution: constitution,
                intelligence: intelligence,
                wisdom: wisdom,
                charisma: charisma,
                className: className,
                level: level,
                experience: experience,
                currentHitPoints: currentHitPoints,
                maximumHitPoints: maximumHitPoints,
                temporaryHitPoints: temporaryHitPoints,
                portraitAssetPath: portraitAssetPath,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String raceName,
                Value<String?> backgroundId = const Value.absent(),
                Value<String?> backgroundName = const Value.absent(),
                Value<String?> backgroundSummary = const Value.absent(),
                Value<String?> abilityScoreMethod = const Value.absent(),
                Value<String?> abilityScoreProvenance = const Value.absent(),
                Value<int?> strength = const Value.absent(),
                Value<int?> dexterity = const Value.absent(),
                Value<int?> constitution = const Value.absent(),
                Value<int?> intelligence = const Value.absent(),
                Value<int?> wisdom = const Value.absent(),
                Value<int?> charisma = const Value.absent(),
                required String className,
                required int level,
                Value<int?> experience = const Value.absent(),
                Value<int?> currentHitPoints = const Value.absent(),
                Value<int?> maximumHitPoints = const Value.absent(),
                Value<int?> temporaryHitPoints = const Value.absent(),
                Value<String?> portraitAssetPath = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => CharactersCompanion.insert(
                id: id,
                name: name,
                raceName: raceName,
                backgroundId: backgroundId,
                backgroundName: backgroundName,
                backgroundSummary: backgroundSummary,
                abilityScoreMethod: abilityScoreMethod,
                abilityScoreProvenance: abilityScoreProvenance,
                strength: strength,
                dexterity: dexterity,
                constitution: constitution,
                intelligence: intelligence,
                wisdom: wisdom,
                charisma: charisma,
                className: className,
                level: level,
                experience: experience,
                currentHitPoints: currentHitPoints,
                maximumHitPoints: maximumHitPoints,
                temporaryHitPoints: temporaryHitPoints,
                portraitAssetPath: portraitAssetPath,
                createdAt: createdAt,
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
      (Character, BaseReferences<_$AppDatabase, $CharactersTable, Character>),
      Character,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CharactersTableTableManager get characters =>
      $$CharactersTableTableManager(_db, _db.characters);
}
