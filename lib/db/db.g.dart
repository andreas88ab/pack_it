// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class PackingList extends DataClass implements Insertable<PackingList> {
  final int id;
  final String title;
  PackingList({required this.id, required this.title});
  factory PackingList.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return PackingList(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    return map;
  }

  PackingListsCompanion toCompanion(bool nullToAbsent) {
    return PackingListsCompanion(
      id: Value(id),
      title: Value(title),
    );
  }

  factory PackingList.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PackingList(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
    };
  }

  PackingList copyWith({int? id, String? title}) => PackingList(
        id: id ?? this.id,
        title: title ?? this.title,
      );
  @override
  String toString() {
    return (StringBuffer('PackingList(')
          ..write('id: $id, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PackingList &&
          other.id == this.id &&
          other.title == this.title);
}

class PackingListsCompanion extends UpdateCompanion<PackingList> {
  final Value<int> id;
  final Value<String> title;
  const PackingListsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
  });
  PackingListsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
  }) : title = Value(title);
  static Insertable<PackingList> custom({
    Expression<int>? id,
    Expression<String>? title,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
    });
  }

  PackingListsCompanion copyWith({Value<int>? id, Value<String>? title}) {
    return PackingListsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PackingListsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }
}

class $PackingListsTable extends PackingLists
    with TableInfo<$PackingListsTable, PackingList> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PackingListsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 6, maxTextLength: 32),
      type: const StringType(),
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title];
  @override
  String get aliasedName => _alias ?? 'packing_lists';
  @override
  String get actualTableName => 'packing_lists';
  @override
  VerificationContext validateIntegrity(Insertable<PackingList> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PackingList map(Map<String, dynamic> data, {String? tablePrefix}) {
    return PackingList.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $PackingListsTable createAlias(String alias) {
    return $PackingListsTable(attachedDatabase, alias);
  }
}

class PackingListItem extends DataClass implements Insertable<PackingListItem> {
  final int id;
  final int packingListId;
  final String title;
  PackingListItem(
      {required this.id, required this.packingListId, required this.title});
  factory PackingListItem.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return PackingListItem(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      packingListId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}packing_list_id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['packing_list_id'] = Variable<int>(packingListId);
    map['title'] = Variable<String>(title);
    return map;
  }

  PackingListItemsCompanion toCompanion(bool nullToAbsent) {
    return PackingListItemsCompanion(
      id: Value(id),
      packingListId: Value(packingListId),
      title: Value(title),
    );
  }

  factory PackingListItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PackingListItem(
      id: serializer.fromJson<int>(json['id']),
      packingListId: serializer.fromJson<int>(json['packingListId']),
      title: serializer.fromJson<String>(json['title']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'packingListId': serializer.toJson<int>(packingListId),
      'title': serializer.toJson<String>(title),
    };
  }

  PackingListItem copyWith({int? id, int? packingListId, String? title}) =>
      PackingListItem(
        id: id ?? this.id,
        packingListId: packingListId ?? this.packingListId,
        title: title ?? this.title,
      );
  @override
  String toString() {
    return (StringBuffer('PackingListItem(')
          ..write('id: $id, ')
          ..write('packingListId: $packingListId, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, packingListId, title);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PackingListItem &&
          other.id == this.id &&
          other.packingListId == this.packingListId &&
          other.title == this.title);
}

class PackingListItemsCompanion extends UpdateCompanion<PackingListItem> {
  final Value<int> id;
  final Value<int> packingListId;
  final Value<String> title;
  const PackingListItemsCompanion({
    this.id = const Value.absent(),
    this.packingListId = const Value.absent(),
    this.title = const Value.absent(),
  });
  PackingListItemsCompanion.insert({
    this.id = const Value.absent(),
    required int packingListId,
    required String title,
  })  : packingListId = Value(packingListId),
        title = Value(title);
  static Insertable<PackingListItem> custom({
    Expression<int>? id,
    Expression<int>? packingListId,
    Expression<String>? title,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (packingListId != null) 'packing_list_id': packingListId,
      if (title != null) 'title': title,
    });
  }

  PackingListItemsCompanion copyWith(
      {Value<int>? id, Value<int>? packingListId, Value<String>? title}) {
    return PackingListItemsCompanion(
      id: id ?? this.id,
      packingListId: packingListId ?? this.packingListId,
      title: title ?? this.title,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (packingListId.present) {
      map['packing_list_id'] = Variable<int>(packingListId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PackingListItemsCompanion(')
          ..write('id: $id, ')
          ..write('packingListId: $packingListId, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }
}

class $PackingListItemsTable extends PackingListItems
    with TableInfo<$PackingListItemsTable, PackingListItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PackingListItemsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _packingListIdMeta =
      const VerificationMeta('packingListId');
  @override
  late final GeneratedColumn<int?> packingListId = GeneratedColumn<int?>(
      'packing_list_id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: true,
      $customConstraints: 'NULLABLE REFERENCES packingLists(id)');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 32),
      type: const StringType(),
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, packingListId, title];
  @override
  String get aliasedName => _alias ?? 'packing_list_items';
  @override
  String get actualTableName => 'packing_list_items';
  @override
  VerificationContext validateIntegrity(Insertable<PackingListItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('packing_list_id')) {
      context.handle(
          _packingListIdMeta,
          packingListId.isAcceptableOrUnknown(
              data['packing_list_id']!, _packingListIdMeta));
    } else if (isInserting) {
      context.missing(_packingListIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PackingListItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    return PackingListItem.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $PackingListItemsTable createAlias(String alias) {
    return $PackingListItemsTable(attachedDatabase, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $PackingListsTable packingLists = $PackingListsTable(this);
  late final $PackingListItemsTable packingListItems =
      $PackingListItemsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [packingLists, packingListItems];
}
