import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:pack_it_v1/utils/utility.dart';
import 'package:provider/provider.dart';
import '../db/db.dart';

class AddPackList extends StatelessWidget {
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
              AddPackListForm(),
            ],
          )),
    );
  }
}

// Create a Form widget.
class AddPackListForm extends StatefulWidget {
  const AddPackListForm({Key? key}) : super(key: key);

  @override
  AddPackListFormState createState() {
    return AddPackListFormState();
  }
}

class AddPackListFormState extends State<AddPackListForm> {
  final _formKey = GlobalKey<FormState>();

  final createListController = TextEditingController();

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
              validator: (value) {
                return Utility.getValidationTextPackingListName(value);
              },
              autocorrect: true,
              controller: createListController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Add list name",
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
                        _createPackingListEntry();
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
  void _createPackingListEntry() {
    if (createListController.text.isNotEmpty) {
      db.addPackingList(PackingListsCompanion(title: Value.ofNullable(createListController.text)));
      createListController.clear();
    }
  }
}
