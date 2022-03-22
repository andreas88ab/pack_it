import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:pack_it_v1/utils/utility.dart';
import 'package:provider/provider.dart';
import 'dart:developer';

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
              MyCustomForm(),
            ],
          )),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  final createListController = TextEditingController();

  MyDatabase get db => Provider.of<MyDatabase>(context, listen: false);

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    createListController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
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
                  return 'Please enter a list name';
                }
                return null;
              },
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
                              content: Text('${createListController.text} created'),
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
      log('_createPackingListEntry');
      // We write the entry here. Notice how we don't have to call setState()
      // or anything - moor will take care of updating the list automatically.
      db.addPackingList(PackingListsCompanion(title: Value.ofNullable(createListController.text)));
      createListController.clear();
    }
  }
}
