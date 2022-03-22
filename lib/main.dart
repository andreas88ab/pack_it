import 'package:flutter/material.dart';
import 'package:pack_it_v1/page/add_pack_list.dart';
import 'package:pack_it_v1/widget/navigation_drawer_widget.dart';
import 'package:pack_it_v1/widget/packing_list_widget_stream.dart';
import 'package:provider/provider.dart';

import 'db/db.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<MyDatabase>(
      create: (context) => MyDatabase(),
      dispose: (context, db) => db.close(),
      child: MaterialApp(
        title: 'Pack it',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  MyDatabase get db => Provider.of<MyDatabase>(context, listen: false);

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
            builder: (context) => Padding(
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
                                style: TextStyle(fontWeight: FontWeight.normal))
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
                    PackingListWidgetStream(),
                  ],
                ))));
  }
}
