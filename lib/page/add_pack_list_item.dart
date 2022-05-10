import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:pack_it_v1/utils/utility.dart';
import 'package:provider/provider.dart';
import '../db/db.dart';

class AddPackListItem extends StatelessWidget {
  const AddPackListItem({Key? key, required this.packingListId}) : super(key: key);

  final int packingListId;

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
              AddPackListItemForm(packingListId: packingListId),
            ],
          )),
    );
  }
}

class AddPackListItemForm extends StatefulWidget {
  const AddPackListItemForm({Key? key, required this.packingListId}) : super(key: key);

  final int packingListId;

  @override
  AddPackListItemFormState createState() {
    return AddPackListItemFormState(packingListId: packingListId);
  }
}

class AddPackListItemFormState extends State<AddPackListItemForm> {
  AddPackListItemFormState({required this.packingListId});

  late int packingListId;

  late TextEditingController createListItemController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    this.packingListId = packingListId;
    createListItemController = TextEditingController();
  }

  MyDatabase get db => Provider.of<MyDatabase>(context, listen: false);

  @override
  void dispose() {
    createListItemController.dispose();
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
              validator: (value) {
                return Utility.getValidationTextPackingListItemName(value);
              },
              autocorrect: true,
              controller: createListItemController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Add list item name",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _createPackingListItemEntry(packingListId: packingListId);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Created new list'),
                        ));
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Create'),
                  )
                ]),
          ),
        ],
      ),
    );
  }

  void _createPackingListItemEntry({required int packingListId}) {
    if (createListItemController.text.isNotEmpty) {
      db.addPackingListItem(PackingListItemsCompanion(packingListId: Value.ofNullable(packingListId), title: Value.ofNullable(createListItemController.text)));
      createListItemController.clear();
    }
  }
}
