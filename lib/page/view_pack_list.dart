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

  late PackingList packingList;

  late TextEditingController controller;

  MyDatabase get db => Provider.of<MyDatabase>(context, listen: false);

  @override
  void initState() {
    this.controller = TextEditingController(text: packingList.title);
    this.packingListId = packingListId;
    _getPackingList().then((value) => {
      this.packingList = new PackingList(id: value.id, title: value.title)
    });
    super.initState();
  }

   Future<PackingList> _getPackingList() async {
    return db.getPackingList(packingListId);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
            ),
            Text(packingList.title),
            ElevatedButton(
                onPressed: () => {
                      openDialog(context),
                    },
                child: Icon(Icons.edit))
          ],
        ));
  }

  Future openDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Packing list name'),
            content: TextField(
              autofocus: true,
              controller: controller,
            ),
            actions: [
              TextButton(
                  onPressed: () => submit(context), child: Text('Submit'))
            ],
          ));

  void submit(BuildContext context) {
    _editPackingListEntry();
    Navigator.of(context).pop();
  }

  void _editPackingListEntry() {
    if (controller.text.isNotEmpty) {
      db.editPackingList(PackingListsCompanion(
          id: Value.ofNullable(packingList.id),
          title: Value.ofNullable(controller.text)));
      controller.clear();
    }
  }
}
