import 'package:flutter/material.dart';
import 'package:moor_db_viewer/moor_db_viewer.dart';
import 'package:provider/provider.dart';

import '../db/db.dart';

class NavigationDrawerWidget extends StatefulWidget {
  @override
  NavigationDrawerWidgetState createState() {
    return NavigationDrawerWidgetState();
  }
}

class NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final padding = EdgeInsets.symmetric(horizontal: 20);

  MyDatabase get bloc => Provider.of<MyDatabase>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            height: 30.0,
          ),
          ListTile(
            title: Text('View Database'),
            leading: Icon(Icons.archive),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return MoorDbViewer(bloc);
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}
