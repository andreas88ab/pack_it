import 'package:flutter/material.dart';
import 'package:pack_it_v1/page/add_pack_list.dart';
import 'package:pack_it_v1/widget/navigation_drawer_widget.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'domain/packing_list.dart';

void main() async {
  runApp(MyApp());

  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
    join(await getDatabasesPath(), 'pack_it_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE packing_list(id INTEGER PRIMARY KEY, name TEXT)',
      );
    },
    version: 1,
  );

  Future<void> insertPackingList(PackingList packingList) async {
    final db = await database;

    await db.insert(
      'packing_list',
      packingList.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  var packingListItem = PackingList(
    id: 0,
    name: 'Test_list',
  );

  await insertPackingList(packingListItem);

  Future<List<PackingList>> getPackingList() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('packing_list');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return PackingList(
        id: maps[i]['id'],
        name: maps[i]['name'],
      );
    });
  }

  List<PackingList> packingList = await getPackingList();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pack it',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: NavigationDrawerWidget(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return AddPackList();
                }),
            );
          },
        ),
        body: Builder(
            builder: (context) =>
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {
                                  Scaffold.of(context).openEndDrawer();
                                },
                                icon: Icon(Icons.settings))
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text.rich(
                          TextSpan(
                              text: 'Pack ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                    text: 'your stuff',
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal))
                              ]),
                          style: TextStyle(fontSize: 50),
                        ),
                        SizedBox(height: 30),
                        TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search, size: 18),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            hintText: 'Search',
                          ),
                        ),
                        SizedBox(height: 20),
                        Text('Your lists',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20)),
                        SizedBox(height: 10),
                      ],
                    ))));
  }
}