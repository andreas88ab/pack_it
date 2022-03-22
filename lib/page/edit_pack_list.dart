import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:pack_it_v1/utils/utility.dart';
import 'package:provider/provider.dart';
import 'dart:developer';

import '../db/db.dart';

class EditPackList extends StatelessWidget {
  const EditPackList({Key? key, required this.packingList}) : super(key: key);

  final PackingList packingList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 100,
              ),
              MyCustomForm(packingList: packingList),
            ],
          )),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key, required this.packingList}) : super(key: key);

  final PackingList packingList;

  @override
  MyCustomFormState createState() {
    return MyCustomFormState(packingList: packingList);
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  MyCustomFormState({required this.packingList});

  late PackingList packingList;

  final _formKey = GlobalKey<FormState>();

  late TextEditingController createListController;

  @override
  void initState() {
    this.createListController = TextEditingController(text: packingList.title);
    this.packingList = packingList;
    super.initState();
  }

  MyDatabase get db => Provider.of<MyDatabase>(context, listen: false);

  @override
  void dispose() {
    createListController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new SizedBox(
            height: 70,
            child: TextFormField(
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (Utility.hasValue(value)) {
                  return 'List name';
                }
                return null;
              },
              controller: createListController,
              autofocus: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _editPackingListEntry();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Edited'),
                    ));
                    Navigator.pop(context);
                  }
                },
                child: const Text('Edit'),
              ),
              Padding(
                  padding: EdgeInsets.all(20.0),
                  child: ElevatedButton.icon(
                      onPressed: () {
                        db.deletePackingList(
                            PackingListsCompanion(id: Value.ofNullable(packingList.id)));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Deleted'),
                        ));
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.delete),
                      label: const Text('Delete'),
                      style: ElevatedButton.styleFrom(primary: Colors.red)))
            ]),
          ),
        ],
      ),
    );
  }

  void _editPackingListEntry() {
    if (createListController.text.isNotEmpty) {
      db.editPackingList(PackingListsCompanion(
          id: Value.ofNullable(packingList.id),
          title: Value.ofNullable(createListController.text)));
      createListController.clear();
    }
  }
}
