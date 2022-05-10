import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../db/db.dart';
import '../page/view_pack_list.dart';

class PackingListItemWidgetStream extends StatefulWidget {
  const PackingListItemWidgetStream({Key? key, required this.packingListId}) : super(key: key);

  final int packingListId;

  @override
  PackingListItemWidgetStreamState createState() {
    return PackingListItemWidgetStreamState(packingListId: packingListId);
  }
}

class PackingListItemWidgetStreamState extends State<PackingListItemWidgetStream> {
  PackingListItemWidgetStreamState({required this.packingListId});
  MyDatabase get db => Provider.of<MyDatabase>(context, listen: false);

  late int packingListId;

  @override
  void initState() {
    super.initState();
    this.packingListId = packingListId;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<PackingListItem>>(
        stream: db.watchPackingListItemsEntries(packingListId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const SizedBox(
              child: Text("No items yet...create some"),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data?.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              if (snapshot.data == null) {
                return Text("EMPTY");
              }

              final PackingListItem item = snapshot.data![index];

              return Column(
                children: <Widget>[
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Card(child: ListTile(
                          title: SizedBox(width: 50, child: Text(item.title)),
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
