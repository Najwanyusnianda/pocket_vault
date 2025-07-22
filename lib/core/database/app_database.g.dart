// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $DocumentsTable extends Documents
    with TableInfo<$DocumentsTable, Document> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
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
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _thumbnailPathMeta = const VerificationMeta(
    'thumbnailPath',
  );
  @override
  late final GeneratedColumn<String> thumbnailPath = GeneratedColumn<String>(
    'thumbnail_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<MainType?, String> mainType =
      GeneratedColumn<String>(
        'main_type',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<MainType?>($DocumentsTable.$convertermainTypen);
  @override
  late final GeneratedColumnWithTypeConverter<SubType?, String> subType =
      GeneratedColumn<String>(
        'sub_type',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<SubType?>($DocumentsTable.$convertersubTypen);
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
    'tags',
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
  static const VerificationMeta _creationDateMeta = const VerificationMeta(
    'creationDate',
  );
  @override
  late final GeneratedColumn<DateTime> creationDate = GeneratedColumn<DateTime>(
    'creation_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedDateMeta = const VerificationMeta(
    'updatedDate',
  );
  @override
  late final GeneratedColumn<DateTime> updatedDate = GeneratedColumn<DateTime>(
    'updated_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expirationDateMeta = const VerificationMeta(
    'expirationDate',
  );
  @override
  late final GeneratedColumn<DateTime> expirationDate =
      GeneratedColumn<DateTime>(
        'expiration_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    filePath,
    thumbnailPath,
    mainType,
    subType,
    tags,
    notes,
    creationDate,
    updatedDate,
    expirationDate,
    isArchived,
    isFavorite,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'documents';
  @override
  VerificationContext validateIntegrity(
    Insertable<Document> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
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
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('thumbnail_path')) {
      context.handle(
        _thumbnailPathMeta,
        thumbnailPath.isAcceptableOrUnknown(
          data['thumbnail_path']!,
          _thumbnailPathMeta,
        ),
      );
    }
    if (data.containsKey('tags')) {
      context.handle(
        _tagsMeta,
        tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('creation_date')) {
      context.handle(
        _creationDateMeta,
        creationDate.isAcceptableOrUnknown(
          data['creation_date']!,
          _creationDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_creationDateMeta);
    }
    if (data.containsKey('updated_date')) {
      context.handle(
        _updatedDateMeta,
        updatedDate.isAcceptableOrUnknown(
          data['updated_date']!,
          _updatedDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedDateMeta);
    }
    if (data.containsKey('expiration_date')) {
      context.handle(
        _expirationDateMeta,
        expirationDate.isAcceptableOrUnknown(
          data['expiration_date']!,
          _expirationDateMeta,
        ),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Document map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Document(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      filePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      )!,
      thumbnailPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}thumbnail_path'],
      ),
      mainType: $DocumentsTable.$convertermainTypen.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}main_type'],
        ),
      ),
      subType: $DocumentsTable.$convertersubTypen.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}sub_type'],
        ),
      ),
      tags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      creationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creation_date'],
      )!,
      updatedDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_date'],
      )!,
      expirationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expiration_date'],
      ),
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
    );
  }

  @override
  $DocumentsTable createAlias(String alias) {
    return $DocumentsTable(attachedDatabase, alias);
  }

  static TypeConverter<MainType, String> $convertermainType =
      const MainTypeConverter();
  static TypeConverter<MainType?, String?> $convertermainTypen =
      NullAwareTypeConverter.wrap($convertermainType);
  static TypeConverter<SubType, String> $convertersubType =
      const SubTypeConverter();
  static TypeConverter<SubType?, String?> $convertersubTypen =
      NullAwareTypeConverter.wrap($convertersubType);
}

class Document extends DataClass implements Insertable<Document> {
  final int id;
  final String title;
  final String? description;
  final String filePath;
  final String? thumbnailPath;
  final MainType? mainType;
  final SubType? subType;
  final String? tags;
  final String? notes;
  final DateTime creationDate;
  final DateTime updatedDate;
  final DateTime? expirationDate;
  final bool isArchived;
  final bool isFavorite;
  const Document({
    required this.id,
    required this.title,
    this.description,
    required this.filePath,
    this.thumbnailPath,
    this.mainType,
    this.subType,
    this.tags,
    this.notes,
    required this.creationDate,
    required this.updatedDate,
    this.expirationDate,
    required this.isArchived,
    required this.isFavorite,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['file_path'] = Variable<String>(filePath);
    if (!nullToAbsent || thumbnailPath != null) {
      map['thumbnail_path'] = Variable<String>(thumbnailPath);
    }
    if (!nullToAbsent || mainType != null) {
      map['main_type'] = Variable<String>(
        $DocumentsTable.$convertermainTypen.toSql(mainType),
      );
    }
    if (!nullToAbsent || subType != null) {
      map['sub_type'] = Variable<String>(
        $DocumentsTable.$convertersubTypen.toSql(subType),
      );
    }
    if (!nullToAbsent || tags != null) {
      map['tags'] = Variable<String>(tags);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['creation_date'] = Variable<DateTime>(creationDate);
    map['updated_date'] = Variable<DateTime>(updatedDate);
    if (!nullToAbsent || expirationDate != null) {
      map['expiration_date'] = Variable<DateTime>(expirationDate);
    }
    map['is_archived'] = Variable<bool>(isArchived);
    map['is_favorite'] = Variable<bool>(isFavorite);
    return map;
  }

  DocumentsCompanion toCompanion(bool nullToAbsent) {
    return DocumentsCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      filePath: Value(filePath),
      thumbnailPath: thumbnailPath == null && nullToAbsent
          ? const Value.absent()
          : Value(thumbnailPath),
      mainType: mainType == null && nullToAbsent
          ? const Value.absent()
          : Value(mainType),
      subType: subType == null && nullToAbsent
          ? const Value.absent()
          : Value(subType),
      tags: tags == null && nullToAbsent ? const Value.absent() : Value(tags),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      creationDate: Value(creationDate),
      updatedDate: Value(updatedDate),
      expirationDate: expirationDate == null && nullToAbsent
          ? const Value.absent()
          : Value(expirationDate),
      isArchived: Value(isArchived),
      isFavorite: Value(isFavorite),
    );
  }

  factory Document.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Document(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      filePath: serializer.fromJson<String>(json['filePath']),
      thumbnailPath: serializer.fromJson<String?>(json['thumbnailPath']),
      mainType: serializer.fromJson<MainType?>(json['mainType']),
      subType: serializer.fromJson<SubType?>(json['subType']),
      tags: serializer.fromJson<String?>(json['tags']),
      notes: serializer.fromJson<String?>(json['notes']),
      creationDate: serializer.fromJson<DateTime>(json['creationDate']),
      updatedDate: serializer.fromJson<DateTime>(json['updatedDate']),
      expirationDate: serializer.fromJson<DateTime?>(json['expirationDate']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'filePath': serializer.toJson<String>(filePath),
      'thumbnailPath': serializer.toJson<String?>(thumbnailPath),
      'mainType': serializer.toJson<MainType?>(mainType),
      'subType': serializer.toJson<SubType?>(subType),
      'tags': serializer.toJson<String?>(tags),
      'notes': serializer.toJson<String?>(notes),
      'creationDate': serializer.toJson<DateTime>(creationDate),
      'updatedDate': serializer.toJson<DateTime>(updatedDate),
      'expirationDate': serializer.toJson<DateTime?>(expirationDate),
      'isArchived': serializer.toJson<bool>(isArchived),
      'isFavorite': serializer.toJson<bool>(isFavorite),
    };
  }

  Document copyWith({
    int? id,
    String? title,
    Value<String?> description = const Value.absent(),
    String? filePath,
    Value<String?> thumbnailPath = const Value.absent(),
    Value<MainType?> mainType = const Value.absent(),
    Value<SubType?> subType = const Value.absent(),
    Value<String?> tags = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? creationDate,
    DateTime? updatedDate,
    Value<DateTime?> expirationDate = const Value.absent(),
    bool? isArchived,
    bool? isFavorite,
  }) => Document(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    filePath: filePath ?? this.filePath,
    thumbnailPath: thumbnailPath.present
        ? thumbnailPath.value
        : this.thumbnailPath,
    mainType: mainType.present ? mainType.value : this.mainType,
    subType: subType.present ? subType.value : this.subType,
    tags: tags.present ? tags.value : this.tags,
    notes: notes.present ? notes.value : this.notes,
    creationDate: creationDate ?? this.creationDate,
    updatedDate: updatedDate ?? this.updatedDate,
    expirationDate: expirationDate.present
        ? expirationDate.value
        : this.expirationDate,
    isArchived: isArchived ?? this.isArchived,
    isFavorite: isFavorite ?? this.isFavorite,
  );
  Document copyWithCompanion(DocumentsCompanion data) {
    return Document(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      thumbnailPath: data.thumbnailPath.present
          ? data.thumbnailPath.value
          : this.thumbnailPath,
      mainType: data.mainType.present ? data.mainType.value : this.mainType,
      subType: data.subType.present ? data.subType.value : this.subType,
      tags: data.tags.present ? data.tags.value : this.tags,
      notes: data.notes.present ? data.notes.value : this.notes,
      creationDate: data.creationDate.present
          ? data.creationDate.value
          : this.creationDate,
      updatedDate: data.updatedDate.present
          ? data.updatedDate.value
          : this.updatedDate,
      expirationDate: data.expirationDate.present
          ? data.expirationDate.value
          : this.expirationDate,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Document(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('filePath: $filePath, ')
          ..write('thumbnailPath: $thumbnailPath, ')
          ..write('mainType: $mainType, ')
          ..write('subType: $subType, ')
          ..write('tags: $tags, ')
          ..write('notes: $notes, ')
          ..write('creationDate: $creationDate, ')
          ..write('updatedDate: $updatedDate, ')
          ..write('expirationDate: $expirationDate, ')
          ..write('isArchived: $isArchived, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    filePath,
    thumbnailPath,
    mainType,
    subType,
    tags,
    notes,
    creationDate,
    updatedDate,
    expirationDate,
    isArchived,
    isFavorite,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Document &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.filePath == this.filePath &&
          other.thumbnailPath == this.thumbnailPath &&
          other.mainType == this.mainType &&
          other.subType == this.subType &&
          other.tags == this.tags &&
          other.notes == this.notes &&
          other.creationDate == this.creationDate &&
          other.updatedDate == this.updatedDate &&
          other.expirationDate == this.expirationDate &&
          other.isArchived == this.isArchived &&
          other.isFavorite == this.isFavorite);
}

class DocumentsCompanion extends UpdateCompanion<Document> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<String> filePath;
  final Value<String?> thumbnailPath;
  final Value<MainType?> mainType;
  final Value<SubType?> subType;
  final Value<String?> tags;
  final Value<String?> notes;
  final Value<DateTime> creationDate;
  final Value<DateTime> updatedDate;
  final Value<DateTime?> expirationDate;
  final Value<bool> isArchived;
  final Value<bool> isFavorite;
  const DocumentsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.filePath = const Value.absent(),
    this.thumbnailPath = const Value.absent(),
    this.mainType = const Value.absent(),
    this.subType = const Value.absent(),
    this.tags = const Value.absent(),
    this.notes = const Value.absent(),
    this.creationDate = const Value.absent(),
    this.updatedDate = const Value.absent(),
    this.expirationDate = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.isFavorite = const Value.absent(),
  });
  DocumentsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    required String filePath,
    this.thumbnailPath = const Value.absent(),
    this.mainType = const Value.absent(),
    this.subType = const Value.absent(),
    this.tags = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime creationDate,
    required DateTime updatedDate,
    this.expirationDate = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.isFavorite = const Value.absent(),
  }) : title = Value(title),
       filePath = Value(filePath),
       creationDate = Value(creationDate),
       updatedDate = Value(updatedDate);
  static Insertable<Document> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? filePath,
    Expression<String>? thumbnailPath,
    Expression<String>? mainType,
    Expression<String>? subType,
    Expression<String>? tags,
    Expression<String>? notes,
    Expression<DateTime>? creationDate,
    Expression<DateTime>? updatedDate,
    Expression<DateTime>? expirationDate,
    Expression<bool>? isArchived,
    Expression<bool>? isFavorite,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (filePath != null) 'file_path': filePath,
      if (thumbnailPath != null) 'thumbnail_path': thumbnailPath,
      if (mainType != null) 'main_type': mainType,
      if (subType != null) 'sub_type': subType,
      if (tags != null) 'tags': tags,
      if (notes != null) 'notes': notes,
      if (creationDate != null) 'creation_date': creationDate,
      if (updatedDate != null) 'updated_date': updatedDate,
      if (expirationDate != null) 'expiration_date': expirationDate,
      if (isArchived != null) 'is_archived': isArchived,
      if (isFavorite != null) 'is_favorite': isFavorite,
    });
  }

  DocumentsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String?>? description,
    Value<String>? filePath,
    Value<String?>? thumbnailPath,
    Value<MainType?>? mainType,
    Value<SubType?>? subType,
    Value<String?>? tags,
    Value<String?>? notes,
    Value<DateTime>? creationDate,
    Value<DateTime>? updatedDate,
    Value<DateTime?>? expirationDate,
    Value<bool>? isArchived,
    Value<bool>? isFavorite,
  }) {
    return DocumentsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      filePath: filePath ?? this.filePath,
      thumbnailPath: thumbnailPath ?? this.thumbnailPath,
      mainType: mainType ?? this.mainType,
      subType: subType ?? this.subType,
      tags: tags ?? this.tags,
      notes: notes ?? this.notes,
      creationDate: creationDate ?? this.creationDate,
      updatedDate: updatedDate ?? this.updatedDate,
      expirationDate: expirationDate ?? this.expirationDate,
      isArchived: isArchived ?? this.isArchived,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (thumbnailPath.present) {
      map['thumbnail_path'] = Variable<String>(thumbnailPath.value);
    }
    if (mainType.present) {
      map['main_type'] = Variable<String>(
        $DocumentsTable.$convertermainTypen.toSql(mainType.value),
      );
    }
    if (subType.present) {
      map['sub_type'] = Variable<String>(
        $DocumentsTable.$convertersubTypen.toSql(subType.value),
      );
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (creationDate.present) {
      map['creation_date'] = Variable<DateTime>(creationDate.value);
    }
    if (updatedDate.present) {
      map['updated_date'] = Variable<DateTime>(updatedDate.value);
    }
    if (expirationDate.present) {
      map['expiration_date'] = Variable<DateTime>(expirationDate.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('filePath: $filePath, ')
          ..write('thumbnailPath: $thumbnailPath, ')
          ..write('mainType: $mainType, ')
          ..write('subType: $subType, ')
          ..write('tags: $tags, ')
          ..write('notes: $notes, ')
          ..write('creationDate: $creationDate, ')
          ..write('updatedDate: $updatedDate, ')
          ..write('expirationDate: $expirationDate, ')
          ..write('isArchived: $isArchived, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }
}

class $BundlesTable extends Bundles with TableInfo<$BundlesTable, Bundle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BundlesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconNameMeta = const VerificationMeta(
    'iconName',
  );
  @override
  late final GeneratedColumn<String> iconName = GeneratedColumn<String>(
    'icon_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _creationDateMeta = const VerificationMeta(
    'creationDate',
  );
  @override
  late final GeneratedColumn<DateTime> creationDate = GeneratedColumn<DateTime>(
    'creation_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    iconName,
    color,
    creationDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bundles';
  @override
  VerificationContext validateIntegrity(
    Insertable<Bundle> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon_name')) {
      context.handle(
        _iconNameMeta,
        iconName.isAcceptableOrUnknown(data['icon_name']!, _iconNameMeta),
      );
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('creation_date')) {
      context.handle(
        _creationDateMeta,
        creationDate.isAcceptableOrUnknown(
          data['creation_date']!,
          _creationDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_creationDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Bundle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Bundle(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      iconName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon_name'],
      ),
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      ),
      creationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creation_date'],
      )!,
    );
  }

  @override
  $BundlesTable createAlias(String alias) {
    return $BundlesTable(attachedDatabase, alias);
  }
}

class Bundle extends DataClass implements Insertable<Bundle> {
  final int id;
  final String name;
  final String? iconName;
  final String? color;
  final DateTime creationDate;
  const Bundle({
    required this.id,
    required this.name,
    this.iconName,
    this.color,
    required this.creationDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || iconName != null) {
      map['icon_name'] = Variable<String>(iconName);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    map['creation_date'] = Variable<DateTime>(creationDate);
    return map;
  }

  BundlesCompanion toCompanion(bool nullToAbsent) {
    return BundlesCompanion(
      id: Value(id),
      name: Value(name),
      iconName: iconName == null && nullToAbsent
          ? const Value.absent()
          : Value(iconName),
      color: color == null && nullToAbsent
          ? const Value.absent()
          : Value(color),
      creationDate: Value(creationDate),
    );
  }

  factory Bundle.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Bundle(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      iconName: serializer.fromJson<String?>(json['iconName']),
      color: serializer.fromJson<String?>(json['color']),
      creationDate: serializer.fromJson<DateTime>(json['creationDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'iconName': serializer.toJson<String?>(iconName),
      'color': serializer.toJson<String?>(color),
      'creationDate': serializer.toJson<DateTime>(creationDate),
    };
  }

  Bundle copyWith({
    int? id,
    String? name,
    Value<String?> iconName = const Value.absent(),
    Value<String?> color = const Value.absent(),
    DateTime? creationDate,
  }) => Bundle(
    id: id ?? this.id,
    name: name ?? this.name,
    iconName: iconName.present ? iconName.value : this.iconName,
    color: color.present ? color.value : this.color,
    creationDate: creationDate ?? this.creationDate,
  );
  Bundle copyWithCompanion(BundlesCompanion data) {
    return Bundle(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      iconName: data.iconName.present ? data.iconName.value : this.iconName,
      color: data.color.present ? data.color.value : this.color,
      creationDate: data.creationDate.present
          ? data.creationDate.value
          : this.creationDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Bundle(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('iconName: $iconName, ')
          ..write('color: $color, ')
          ..write('creationDate: $creationDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, iconName, color, creationDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Bundle &&
          other.id == this.id &&
          other.name == this.name &&
          other.iconName == this.iconName &&
          other.color == this.color &&
          other.creationDate == this.creationDate);
}

class BundlesCompanion extends UpdateCompanion<Bundle> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> iconName;
  final Value<String?> color;
  final Value<DateTime> creationDate;
  const BundlesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.iconName = const Value.absent(),
    this.color = const Value.absent(),
    this.creationDate = const Value.absent(),
  });
  BundlesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.iconName = const Value.absent(),
    this.color = const Value.absent(),
    required DateTime creationDate,
  }) : name = Value(name),
       creationDate = Value(creationDate);
  static Insertable<Bundle> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? iconName,
    Expression<String>? color,
    Expression<DateTime>? creationDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (iconName != null) 'icon_name': iconName,
      if (color != null) 'color': color,
      if (creationDate != null) 'creation_date': creationDate,
    });
  }

  BundlesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? iconName,
    Value<String?>? color,
    Value<DateTime>? creationDate,
  }) {
    return BundlesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      iconName: iconName ?? this.iconName,
      color: color ?? this.color,
      creationDate: creationDate ?? this.creationDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (iconName.present) {
      map['icon_name'] = Variable<String>(iconName.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (creationDate.present) {
      map['creation_date'] = Variable<DateTime>(creationDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BundlesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('iconName: $iconName, ')
          ..write('color: $color, ')
          ..write('creationDate: $creationDate')
          ..write(')'))
        .toString();
  }
}

class $BundleDocumentsTable extends BundleDocuments
    with TableInfo<$BundleDocumentsTable, BundleDocument> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BundleDocumentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _documentIdMeta = const VerificationMeta(
    'documentId',
  );
  @override
  late final GeneratedColumn<int> documentId = GeneratedColumn<int>(
    'document_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES documents (id)',
    ),
  );
  static const VerificationMeta _bundleIdMeta = const VerificationMeta(
    'bundleId',
  );
  @override
  late final GeneratedColumn<int> bundleId = GeneratedColumn<int>(
    'bundle_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES bundles (id)',
    ),
  );
  static const VerificationMeta _dateAddedMeta = const VerificationMeta(
    'dateAdded',
  );
  @override
  late final GeneratedColumn<DateTime> dateAdded = GeneratedColumn<DateTime>(
    'date_added',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [documentId, bundleId, dateAdded];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bundle_documents';
  @override
  VerificationContext validateIntegrity(
    Insertable<BundleDocument> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('document_id')) {
      context.handle(
        _documentIdMeta,
        documentId.isAcceptableOrUnknown(data['document_id']!, _documentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_documentIdMeta);
    }
    if (data.containsKey('bundle_id')) {
      context.handle(
        _bundleIdMeta,
        bundleId.isAcceptableOrUnknown(data['bundle_id']!, _bundleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bundleIdMeta);
    }
    if (data.containsKey('date_added')) {
      context.handle(
        _dateAddedMeta,
        dateAdded.isAcceptableOrUnknown(data['date_added']!, _dateAddedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {documentId, bundleId};
  @override
  BundleDocument map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BundleDocument(
      documentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}document_id'],
      )!,
      bundleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bundle_id'],
      )!,
      dateAdded: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_added'],
      )!,
    );
  }

  @override
  $BundleDocumentsTable createAlias(String alias) {
    return $BundleDocumentsTable(attachedDatabase, alias);
  }
}

class BundleDocument extends DataClass implements Insertable<BundleDocument> {
  final int documentId;
  final int bundleId;
  final DateTime dateAdded;
  const BundleDocument({
    required this.documentId,
    required this.bundleId,
    required this.dateAdded,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['document_id'] = Variable<int>(documentId);
    map['bundle_id'] = Variable<int>(bundleId);
    map['date_added'] = Variable<DateTime>(dateAdded);
    return map;
  }

  BundleDocumentsCompanion toCompanion(bool nullToAbsent) {
    return BundleDocumentsCompanion(
      documentId: Value(documentId),
      bundleId: Value(bundleId),
      dateAdded: Value(dateAdded),
    );
  }

  factory BundleDocument.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BundleDocument(
      documentId: serializer.fromJson<int>(json['documentId']),
      bundleId: serializer.fromJson<int>(json['bundleId']),
      dateAdded: serializer.fromJson<DateTime>(json['dateAdded']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'documentId': serializer.toJson<int>(documentId),
      'bundleId': serializer.toJson<int>(bundleId),
      'dateAdded': serializer.toJson<DateTime>(dateAdded),
    };
  }

  BundleDocument copyWith({
    int? documentId,
    int? bundleId,
    DateTime? dateAdded,
  }) => BundleDocument(
    documentId: documentId ?? this.documentId,
    bundleId: bundleId ?? this.bundleId,
    dateAdded: dateAdded ?? this.dateAdded,
  );
  BundleDocument copyWithCompanion(BundleDocumentsCompanion data) {
    return BundleDocument(
      documentId: data.documentId.present
          ? data.documentId.value
          : this.documentId,
      bundleId: data.bundleId.present ? data.bundleId.value : this.bundleId,
      dateAdded: data.dateAdded.present ? data.dateAdded.value : this.dateAdded,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BundleDocument(')
          ..write('documentId: $documentId, ')
          ..write('bundleId: $bundleId, ')
          ..write('dateAdded: $dateAdded')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(documentId, bundleId, dateAdded);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BundleDocument &&
          other.documentId == this.documentId &&
          other.bundleId == this.bundleId &&
          other.dateAdded == this.dateAdded);
}

class BundleDocumentsCompanion extends UpdateCompanion<BundleDocument> {
  final Value<int> documentId;
  final Value<int> bundleId;
  final Value<DateTime> dateAdded;
  final Value<int> rowid;
  const BundleDocumentsCompanion({
    this.documentId = const Value.absent(),
    this.bundleId = const Value.absent(),
    this.dateAdded = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BundleDocumentsCompanion.insert({
    required int documentId,
    required int bundleId,
    this.dateAdded = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : documentId = Value(documentId),
       bundleId = Value(bundleId);
  static Insertable<BundleDocument> custom({
    Expression<int>? documentId,
    Expression<int>? bundleId,
    Expression<DateTime>? dateAdded,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (documentId != null) 'document_id': documentId,
      if (bundleId != null) 'bundle_id': bundleId,
      if (dateAdded != null) 'date_added': dateAdded,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BundleDocumentsCompanion copyWith({
    Value<int>? documentId,
    Value<int>? bundleId,
    Value<DateTime>? dateAdded,
    Value<int>? rowid,
  }) {
    return BundleDocumentsCompanion(
      documentId: documentId ?? this.documentId,
      bundleId: bundleId ?? this.bundleId,
      dateAdded: dateAdded ?? this.dateAdded,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (documentId.present) {
      map['document_id'] = Variable<int>(documentId.value);
    }
    if (bundleId.present) {
      map['bundle_id'] = Variable<int>(bundleId.value);
    }
    if (dateAdded.present) {
      map['date_added'] = Variable<DateTime>(dateAdded.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BundleDocumentsCompanion(')
          ..write('documentId: $documentId, ')
          ..write('bundleId: $bundleId, ')
          ..write('dateAdded: $dateAdded, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $DocumentsTable documents = $DocumentsTable(this);
  late final $BundlesTable bundles = $BundlesTable(this);
  late final $BundleDocumentsTable bundleDocuments = $BundleDocumentsTable(
    this,
  );
  late final DocumentsDao documentsDao = DocumentsDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    documents,
    bundles,
    bundleDocuments,
  ];
}

typedef $$DocumentsTableCreateCompanionBuilder =
    DocumentsCompanion Function({
      Value<int> id,
      required String title,
      Value<String?> description,
      required String filePath,
      Value<String?> thumbnailPath,
      Value<MainType?> mainType,
      Value<SubType?> subType,
      Value<String?> tags,
      Value<String?> notes,
      required DateTime creationDate,
      required DateTime updatedDate,
      Value<DateTime?> expirationDate,
      Value<bool> isArchived,
      Value<bool> isFavorite,
    });
typedef $$DocumentsTableUpdateCompanionBuilder =
    DocumentsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String?> description,
      Value<String> filePath,
      Value<String?> thumbnailPath,
      Value<MainType?> mainType,
      Value<SubType?> subType,
      Value<String?> tags,
      Value<String?> notes,
      Value<DateTime> creationDate,
      Value<DateTime> updatedDate,
      Value<DateTime?> expirationDate,
      Value<bool> isArchived,
      Value<bool> isFavorite,
    });

final class $$DocumentsTableReferences
    extends BaseReferences<_$AppDatabase, $DocumentsTable, Document> {
  $$DocumentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BundleDocumentsTable, List<BundleDocument>>
  _bundleDocumentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.bundleDocuments,
    aliasName: $_aliasNameGenerator(
      db.documents.id,
      db.bundleDocuments.documentId,
    ),
  );

  $$BundleDocumentsTableProcessedTableManager get bundleDocumentsRefs {
    final manager = $$BundleDocumentsTableTableManager(
      $_db,
      $_db.bundleDocuments,
    ).filter((f) => f.documentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _bundleDocumentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DocumentsTableFilterComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
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

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get thumbnailPath => $composableBuilder(
    column: $table.thumbnailPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<MainType?, MainType, String> get mainType =>
      $composableBuilder(
        column: $table.mainType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<SubType?, SubType, String> get subType =>
      $composableBuilder(
        column: $table.subType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creationDate => $composableBuilder(
    column: $table.creationDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedDate => $composableBuilder(
    column: $table.updatedDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expirationDate => $composableBuilder(
    column: $table.expirationDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> bundleDocumentsRefs(
    Expression<bool> Function($$BundleDocumentsTableFilterComposer f) f,
  ) {
    final $$BundleDocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bundleDocuments,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BundleDocumentsTableFilterComposer(
            $db: $db,
            $table: $db.bundleDocuments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DocumentsTableOrderingComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
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

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get thumbnailPath => $composableBuilder(
    column: $table.thumbnailPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mainType => $composableBuilder(
    column: $table.mainType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subType => $composableBuilder(
    column: $table.subType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creationDate => $composableBuilder(
    column: $table.creationDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedDate => $composableBuilder(
    column: $table.updatedDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expirationDate => $composableBuilder(
    column: $table.expirationDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DocumentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<String> get thumbnailPath => $composableBuilder(
    column: $table.thumbnailPath,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<MainType?, String> get mainType =>
      $composableBuilder(column: $table.mainType, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SubType?, String> get subType =>
      $composableBuilder(column: $table.subType, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get creationDate => $composableBuilder(
    column: $table.creationDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedDate => $composableBuilder(
    column: $table.updatedDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get expirationDate => $composableBuilder(
    column: $table.expirationDate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  Expression<T> bundleDocumentsRefs<T extends Object>(
    Expression<T> Function($$BundleDocumentsTableAnnotationComposer a) f,
  ) {
    final $$BundleDocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bundleDocuments,
      getReferencedColumn: (t) => t.documentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BundleDocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.bundleDocuments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$DocumentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DocumentsTable,
          Document,
          $$DocumentsTableFilterComposer,
          $$DocumentsTableOrderingComposer,
          $$DocumentsTableAnnotationComposer,
          $$DocumentsTableCreateCompanionBuilder,
          $$DocumentsTableUpdateCompanionBuilder,
          (Document, $$DocumentsTableReferences),
          Document,
          PrefetchHooks Function({bool bundleDocumentsRefs})
        > {
  $$DocumentsTableTableManager(_$AppDatabase db, $DocumentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DocumentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DocumentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DocumentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> filePath = const Value.absent(),
                Value<String?> thumbnailPath = const Value.absent(),
                Value<MainType?> mainType = const Value.absent(),
                Value<SubType?> subType = const Value.absent(),
                Value<String?> tags = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> creationDate = const Value.absent(),
                Value<DateTime> updatedDate = const Value.absent(),
                Value<DateTime?> expirationDate = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
              }) => DocumentsCompanion(
                id: id,
                title: title,
                description: description,
                filePath: filePath,
                thumbnailPath: thumbnailPath,
                mainType: mainType,
                subType: subType,
                tags: tags,
                notes: notes,
                creationDate: creationDate,
                updatedDate: updatedDate,
                expirationDate: expirationDate,
                isArchived: isArchived,
                isFavorite: isFavorite,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<String?> description = const Value.absent(),
                required String filePath,
                Value<String?> thumbnailPath = const Value.absent(),
                Value<MainType?> mainType = const Value.absent(),
                Value<SubType?> subType = const Value.absent(),
                Value<String?> tags = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime creationDate,
                required DateTime updatedDate,
                Value<DateTime?> expirationDate = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
              }) => DocumentsCompanion.insert(
                id: id,
                title: title,
                description: description,
                filePath: filePath,
                thumbnailPath: thumbnailPath,
                mainType: mainType,
                subType: subType,
                tags: tags,
                notes: notes,
                creationDate: creationDate,
                updatedDate: updatedDate,
                expirationDate: expirationDate,
                isArchived: isArchived,
                isFavorite: isFavorite,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DocumentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({bundleDocumentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (bundleDocumentsRefs) db.bundleDocuments,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (bundleDocumentsRefs)
                    await $_getPrefetchedData<
                      Document,
                      $DocumentsTable,
                      BundleDocument
                    >(
                      currentTable: table,
                      referencedTable: $$DocumentsTableReferences
                          ._bundleDocumentsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$DocumentsTableReferences(
                            db,
                            table,
                            p0,
                          ).bundleDocumentsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.documentId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$DocumentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DocumentsTable,
      Document,
      $$DocumentsTableFilterComposer,
      $$DocumentsTableOrderingComposer,
      $$DocumentsTableAnnotationComposer,
      $$DocumentsTableCreateCompanionBuilder,
      $$DocumentsTableUpdateCompanionBuilder,
      (Document, $$DocumentsTableReferences),
      Document,
      PrefetchHooks Function({bool bundleDocumentsRefs})
    >;
typedef $$BundlesTableCreateCompanionBuilder =
    BundlesCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> iconName,
      Value<String?> color,
      required DateTime creationDate,
    });
typedef $$BundlesTableUpdateCompanionBuilder =
    BundlesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> iconName,
      Value<String?> color,
      Value<DateTime> creationDate,
    });

final class $$BundlesTableReferences
    extends BaseReferences<_$AppDatabase, $BundlesTable, Bundle> {
  $$BundlesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BundleDocumentsTable, List<BundleDocument>>
  _bundleDocumentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.bundleDocuments,
    aliasName: $_aliasNameGenerator(db.bundles.id, db.bundleDocuments.bundleId),
  );

  $$BundleDocumentsTableProcessedTableManager get bundleDocumentsRefs {
    final manager = $$BundleDocumentsTableTableManager(
      $_db,
      $_db.bundleDocuments,
    ).filter((f) => f.bundleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _bundleDocumentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BundlesTableFilterComposer
    extends Composer<_$AppDatabase, $BundlesTable> {
  $$BundlesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get iconName => $composableBuilder(
    column: $table.iconName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creationDate => $composableBuilder(
    column: $table.creationDate,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> bundleDocumentsRefs(
    Expression<bool> Function($$BundleDocumentsTableFilterComposer f) f,
  ) {
    final $$BundleDocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bundleDocuments,
      getReferencedColumn: (t) => t.bundleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BundleDocumentsTableFilterComposer(
            $db: $db,
            $table: $db.bundleDocuments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BundlesTableOrderingComposer
    extends Composer<_$AppDatabase, $BundlesTable> {
  $$BundlesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get iconName => $composableBuilder(
    column: $table.iconName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creationDate => $composableBuilder(
    column: $table.creationDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BundlesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BundlesTable> {
  $$BundlesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get iconName =>
      $composableBuilder(column: $table.iconName, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<DateTime> get creationDate => $composableBuilder(
    column: $table.creationDate,
    builder: (column) => column,
  );

  Expression<T> bundleDocumentsRefs<T extends Object>(
    Expression<T> Function($$BundleDocumentsTableAnnotationComposer a) f,
  ) {
    final $$BundleDocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bundleDocuments,
      getReferencedColumn: (t) => t.bundleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BundleDocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.bundleDocuments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BundlesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BundlesTable,
          Bundle,
          $$BundlesTableFilterComposer,
          $$BundlesTableOrderingComposer,
          $$BundlesTableAnnotationComposer,
          $$BundlesTableCreateCompanionBuilder,
          $$BundlesTableUpdateCompanionBuilder,
          (Bundle, $$BundlesTableReferences),
          Bundle,
          PrefetchHooks Function({bool bundleDocumentsRefs})
        > {
  $$BundlesTableTableManager(_$AppDatabase db, $BundlesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BundlesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BundlesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BundlesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> iconName = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<DateTime> creationDate = const Value.absent(),
              }) => BundlesCompanion(
                id: id,
                name: name,
                iconName: iconName,
                color: color,
                creationDate: creationDate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> iconName = const Value.absent(),
                Value<String?> color = const Value.absent(),
                required DateTime creationDate,
              }) => BundlesCompanion.insert(
                id: id,
                name: name,
                iconName: iconName,
                color: color,
                creationDate: creationDate,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BundlesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({bundleDocumentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (bundleDocumentsRefs) db.bundleDocuments,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (bundleDocumentsRefs)
                    await $_getPrefetchedData<
                      Bundle,
                      $BundlesTable,
                      BundleDocument
                    >(
                      currentTable: table,
                      referencedTable: $$BundlesTableReferences
                          ._bundleDocumentsRefsTable(db),
                      managerFromTypedResult: (p0) => $$BundlesTableReferences(
                        db,
                        table,
                        p0,
                      ).bundleDocumentsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.bundleId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$BundlesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BundlesTable,
      Bundle,
      $$BundlesTableFilterComposer,
      $$BundlesTableOrderingComposer,
      $$BundlesTableAnnotationComposer,
      $$BundlesTableCreateCompanionBuilder,
      $$BundlesTableUpdateCompanionBuilder,
      (Bundle, $$BundlesTableReferences),
      Bundle,
      PrefetchHooks Function({bool bundleDocumentsRefs})
    >;
typedef $$BundleDocumentsTableCreateCompanionBuilder =
    BundleDocumentsCompanion Function({
      required int documentId,
      required int bundleId,
      Value<DateTime> dateAdded,
      Value<int> rowid,
    });
typedef $$BundleDocumentsTableUpdateCompanionBuilder =
    BundleDocumentsCompanion Function({
      Value<int> documentId,
      Value<int> bundleId,
      Value<DateTime> dateAdded,
      Value<int> rowid,
    });

final class $$BundleDocumentsTableReferences
    extends
        BaseReferences<_$AppDatabase, $BundleDocumentsTable, BundleDocument> {
  $$BundleDocumentsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $DocumentsTable _documentIdTable(_$AppDatabase db) =>
      db.documents.createAlias(
        $_aliasNameGenerator(db.bundleDocuments.documentId, db.documents.id),
      );

  $$DocumentsTableProcessedTableManager get documentId {
    final $_column = $_itemColumn<int>('document_id')!;

    final manager = $$DocumentsTableTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_documentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BundlesTable _bundleIdTable(_$AppDatabase db) =>
      db.bundles.createAlias(
        $_aliasNameGenerator(db.bundleDocuments.bundleId, db.bundles.id),
      );

  $$BundlesTableProcessedTableManager get bundleId {
    final $_column = $_itemColumn<int>('bundle_id')!;

    final manager = $$BundlesTableTableManager(
      $_db,
      $_db.bundles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bundleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BundleDocumentsTableFilterComposer
    extends Composer<_$AppDatabase, $BundleDocumentsTable> {
  $$BundleDocumentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get dateAdded => $composableBuilder(
    column: $table.dateAdded,
    builder: (column) => ColumnFilters(column),
  );

  $$DocumentsTableFilterComposer get documentId {
    final $$DocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BundlesTableFilterComposer get bundleId {
    final $$BundlesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bundleId,
      referencedTable: $db.bundles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BundlesTableFilterComposer(
            $db: $db,
            $table: $db.bundles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BundleDocumentsTableOrderingComposer
    extends Composer<_$AppDatabase, $BundleDocumentsTable> {
  $$BundleDocumentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get dateAdded => $composableBuilder(
    column: $table.dateAdded,
    builder: (column) => ColumnOrderings(column),
  );

  $$DocumentsTableOrderingComposer get documentId {
    final $$DocumentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableOrderingComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BundlesTableOrderingComposer get bundleId {
    final $$BundlesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bundleId,
      referencedTable: $db.bundles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BundlesTableOrderingComposer(
            $db: $db,
            $table: $db.bundles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BundleDocumentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BundleDocumentsTable> {
  $$BundleDocumentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get dateAdded =>
      $composableBuilder(column: $table.dateAdded, builder: (column) => column);

  $$DocumentsTableAnnotationComposer get documentId {
    final $$DocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.documentId,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BundlesTableAnnotationComposer get bundleId {
    final $$BundlesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bundleId,
      referencedTable: $db.bundles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BundlesTableAnnotationComposer(
            $db: $db,
            $table: $db.bundles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BundleDocumentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BundleDocumentsTable,
          BundleDocument,
          $$BundleDocumentsTableFilterComposer,
          $$BundleDocumentsTableOrderingComposer,
          $$BundleDocumentsTableAnnotationComposer,
          $$BundleDocumentsTableCreateCompanionBuilder,
          $$BundleDocumentsTableUpdateCompanionBuilder,
          (BundleDocument, $$BundleDocumentsTableReferences),
          BundleDocument,
          PrefetchHooks Function({bool documentId, bool bundleId})
        > {
  $$BundleDocumentsTableTableManager(
    _$AppDatabase db,
    $BundleDocumentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BundleDocumentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BundleDocumentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BundleDocumentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> documentId = const Value.absent(),
                Value<int> bundleId = const Value.absent(),
                Value<DateTime> dateAdded = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BundleDocumentsCompanion(
                documentId: documentId,
                bundleId: bundleId,
                dateAdded: dateAdded,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int documentId,
                required int bundleId,
                Value<DateTime> dateAdded = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BundleDocumentsCompanion.insert(
                documentId: documentId,
                bundleId: bundleId,
                dateAdded: dateAdded,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BundleDocumentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({documentId = false, bundleId = false}) {
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
                    if (documentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.documentId,
                                referencedTable:
                                    $$BundleDocumentsTableReferences
                                        ._documentIdTable(db),
                                referencedColumn:
                                    $$BundleDocumentsTableReferences
                                        ._documentIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (bundleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.bundleId,
                                referencedTable:
                                    $$BundleDocumentsTableReferences
                                        ._bundleIdTable(db),
                                referencedColumn:
                                    $$BundleDocumentsTableReferences
                                        ._bundleIdTable(db)
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

typedef $$BundleDocumentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BundleDocumentsTable,
      BundleDocument,
      $$BundleDocumentsTableFilterComposer,
      $$BundleDocumentsTableOrderingComposer,
      $$BundleDocumentsTableAnnotationComposer,
      $$BundleDocumentsTableCreateCompanionBuilder,
      $$BundleDocumentsTableUpdateCompanionBuilder,
      (BundleDocument, $$BundleDocumentsTableReferences),
      BundleDocument,
      PrefetchHooks Function({bool documentId, bool bundleId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$DocumentsTableTableManager get documents =>
      $$DocumentsTableTableManager(_db, _db.documents);
  $$BundlesTableTableManager get bundles =>
      $$BundlesTableTableManager(_db, _db.bundles);
  $$BundleDocumentsTableTableManager get bundleDocuments =>
      $$BundleDocumentsTableTableManager(_db, _db.bundleDocuments);
}
