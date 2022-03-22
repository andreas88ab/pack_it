import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../db/db.dart';
import '../page/view_pack_list.dart';

class PackingListWidgetStream extends StatefulWidget {
  const PackingListWidgetStream({Key? key}) : super(key: key);

  @override
  PackingListWidgetStreamState createState() {
    return PackingListWidgetStreamState();
  }
}

class PackingListWidgetStreamState extends State<PackingListWidgetStream> {
  MyDatabase get db => Provider.of<MyDatabase>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<PackingList>>(
        stream: db.watchPackingListEntries(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const SizedBox(
              child: Text("No lists yet...create some"),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data?.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              if (snapshot.data == null) {
                return Text("EMPTY");
              }

              final PackingList item = snapshot.data![index];

              return Column(
                children: <Widget>[
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Card(child: ListTile(
                          title: SizedBox(width: 50, child: Text(item.title)),
                          subtitle: new Text('Number of items'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ViewPackList(packingListId: item.id)),
                            );
                          })))
                ],
              );
            },
          );
        },
      ),
    );
  }
}
