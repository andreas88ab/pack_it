import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:developer';

import '../db/db.dart';

class PackingListWidget extends StatefulWidget {
  const PackingListWidget({Key? key}) : super(key: key);

  @override
  PackingListWidgetState createState() {
    return PackingListWidgetState();
  }
}

class PackingListWidgetState extends State<PackingListWidget> {
  MyDatabase get db => Provider.of<MyDatabase>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: FutureBuilder<List<PackingList>>(
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const SizedBox();
          }

          return ListView.builder(
            itemCount: snapshot.data?.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              if (snapshot.data == null) {
                return Text("EMPTY");
              }
              ;
              final PackingList item = snapshot.data![index];

              return Column(
                children: <Widget>[
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ListTile(
                          title: SizedBox(width: 50, child: Text(item.title)),
                          subtitle: new Text('Number of items'),
                          onTap: () {
                            log("$item.title - clicked");
                          }))
                ],
              );
            },
          );
        },
        future: db.allPackingListEntries,
      ),
    );
  }
}
