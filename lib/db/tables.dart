import 'package:drift/drift.dart';

class PackingLists extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 6, max: 32)();
}

class PackingListItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get packingListId => integer().customConstraint('NULLABLE REFERENCES packingLists(id)')();
  TextColumn get title => text().withLength(min: 2, max: 32)();
}