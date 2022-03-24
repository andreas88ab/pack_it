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

  late bool nameValidated;

  @override
  void initState() {
    super.initState();
    this.packingListId = packingListId;
    this.nameValidated = false;
    db.getPackingList(packingListId).then((value) => controller = TextEditingController(text: value.title));
    controller = TextEditingController();
    controller.addListener(_validate);
  }

  void _validate() {
    setState(() {
      nameValidated = controller.text.length > 6;
    });
    print('Text ${controller.text.length} value ${nameValidated}');
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
                        openDialog(context, pl.id, nameValidated),
                      },
                      child: Icon(Icons.edit))
                ],
              ));
        });
  }

  Future openDialog(BuildContext context, int id, bool val) =>
      showDialog(
          context: context,
          builder: (context) =>
              PackingListEditDialogBox(controller: controller, packingListId: packingListId,)
      );
}

class PackingListEditDialogBox extends StatefulWidget {
  const PackingListEditDialogBox({Key? key, required this.controller, required this.packingListId})
      : super(key: key);

  final TextEditingController controller;
  final int packingListId;

  @override
  _PackingListEditDialogBoxState createState() =>
      _PackingListEditDialogBoxState(controller: controller, packingListId: packingListId);
}

class _PackingListEditDialogBoxState extends State<PackingListEditDialogBox> {
  _PackingListEditDialogBoxState({required this.controller, required this.packingListId});

  late int packingListId;
  late TextEditingController controller;

  bool nameValidated = false;

  void _validate() {
    setState(() {
      nameValidated = controller.text.length > 6;
    });
  }

  MyDatabase get db => Provider.of<MyDatabase>(context, listen: false);

  @override
  void initState() {
    super.initState();
    this.controller = controller;
    controller.addListener(_validate);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Packing list name'),
      content: Container(
        child: TextField(
          autofocus: true,
          controller: controller,
          decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: nameValidated ? Colors.blue : Colors.red,),
              )),
        ),
      ),
      actions: [
        TextButton(
            onPressed: nameValidated ? () => submit(context, packingListId) : null,
            child: Text('Submit')
        )
      ],
    );
  }

  void submit(BuildContext context, int id) {
    _editPackingListEntry(id);
    Navigator.of(context).pop();
  }

  void _editPackingListEntry(int id) {
    if (controller.text.isNotEmpty) {
      db.editPackingList(PackingListsCompanion(
          id: Value.ofNullable(id), title: Value.ofNullable(controller.text)));
      controller.clear();
    }
  }
}
