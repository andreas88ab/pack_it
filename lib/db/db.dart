import 'package:drift/native.dart';
import 'package:pack_it_v1/db/tables.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'dart:io';
part 'db.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {

    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [PackingLists, PackingListItems])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
        await into(packingLists).insert(PackingListsCompanion.insert(title: "Test packinglist"));
        await into(packingListItems).insert(PackingListItemsCompanion.insert(packingListId: 1, title: "Test packinglistitem"));
        await into(packingListItems).insert(PackingListItemsCompanion.insert(packingListId: 1, title: "Test 2 packinglistitem"));
      }
  );

  Stream<List<PackingList>> watchPackingListEntries() {
    return select(packingLists).watch();
  }

  Stream<PackingList> watchPackingListEntry(int id) {

    final query = select(packingLists)..where((tbl) => tbl.id.equals(id));

    return query.watchSingle();
  }

  Future<PackingList> getPackingList(int id) {
    final query = select(packingLists)..where((tbl) => tbl.id.equals(id));

    return query.getSingle();
  }

  Future<int> addPackingList(PackingListsCompanion entry) {
    return into(packingLists).insert(entry);
  }

  Future<bool> editPackingList(PackingListsCompanion entry) {
    return update(packingLists).replace(entry);
  }

  Future<int> deletePackingList(PackingListsCompanion entry) {
    return delete(packingLists).delete(entry);
  }

  Stream<List<PackingListItem>> watchPackingListItemsEntries(int packingListId) {
    final query = select(packingListItems)..where((tbl) => tbl.packingListId.equals(packingListId));

    return query.watch();
  }

  Future<int> addPackingListItem(PackingListItemsCompanion entry) {
    return into(packingListItems).insert(entry);
  }
}