import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../db/db.dart';
import 'dart:developer';

class ViewPackList extends StatelessWidget {
  const ViewPackList({Key? key, required this.packingListId}) : super(key: key);

  final int packingListId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyCustomForm(packingListId: packingListId),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key, required this.packingListId}) : super(key: key);

  final int packingListId;

  @override
  MyCustomFormState createState() {
    return MyCustomFormState(packingListId: packingListId);
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  MyCustomFormState({required this.packingListId});

  late int packingListId;

  late TextEditingController controller;

  MyDatabase get db => Provider.of<MyDatabase>(context, listen: false);

  @override
  void initState() {
    this.packingListId = packingListId;
    this.controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<PackingList>(
        stream: db.watchPackingListEntry(packingListId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox(
              child: Text("No data"),
            );
          }
          if (snapshot.hasError) {
            return const Text('Something went wrong.');
          }

          PackingList pl = snapshot.requireData;
          
          return new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Text(pl.title),
                  ElevatedButton(
                      onPressed: () =>
                      {
                        openDialog(context, pl.id),
                      },
                      child: Icon(Icons.edit))
                ],
              ));
        });
  }

  Future openDialog(BuildContext context, int id) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Packing list name'),
            content: TextField(
              autofocus: true,
              controller: controller,
            ),
            actions: [
              TextButton(
                  onPressed: () => submit(context, id), child: Text('Submit'))
            ],
          ));

  void submit(BuildContext context, int id) {
    _editPackingListEntry(id);
    Navigator.of(context).pop();
  }

  void _editPackingListEntry(int id) {
    if (controller.text.isNotEmpty) {
      db.editPackingList(PackingListsCompanion(
          id: Value.ofNullable(id),
          title: Value.ofNullable(controller.text)));
      controller.clear();
    }
  }
}
