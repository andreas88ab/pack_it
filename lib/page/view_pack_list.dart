import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../db/db.dart';
import '../utils/utility.dart';

class ViewPackList extends StatelessWidget {
  const ViewPackList({Key? key, required this.packingListId}) : super(key: key);

  final int packingListId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ViewPacklistForm(packingListId: packingListId),
    );
  }
}

class ViewPacklistForm extends StatefulWidget {
  const ViewPacklistForm({Key? key, required this.packingListId}) : super(key: key);

  final int packingListId;

  @override
  ViewPacklistFormState createState() {
    return ViewPacklistFormState(packingListId: packingListId);
  }
}

class ViewPacklistFormState extends State<ViewPacklistForm> {
  ViewPacklistFormState({required this.packingListId});

  late int packingListId;

  late TextEditingController controller;

  MyDatabase get db => Provider.of<MyDatabase>(context, listen: false);

  @override
  void initState() {
    super.initState();
    this.packingListId = packingListId;
    db.getPackingList(packingListId).then((value) => controller = TextEditingController(text: value.title));
    controller = TextEditingController();
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

  Future openDialog(BuildContext context, int id) =>
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

  final _formKey = GlobalKey<FormState>();

  late int packingListId;
  late TextEditingController controller;
  Color validationColor = Colors.blue;

  void _validate() {
    setState(() {
      validationColor = Utility.getValidationColorPackingListName(controller.text);
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
      content: Form(
        key: _formKey,
        child: TextFormField(
          validator: (value) {
            return Utility.getValidationTextPackingListName(value);
          },
          autocorrect: true,
          autofocus: true,
          controller: controller,
          decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: validationColor),
              )),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            // Validate returns true if the form is valid, or false otherwise.
            if (_formKey.currentState!.validate()) {
              submit(context, packingListId);
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }

  void submit(BuildContext context, int id) {
    _editPackingListEntry(id);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Name changed'),
    ));
    Navigator.of(context).pop();
  }

  void _editPackingListEntry(int id) {
    if (controller.text.isNotEmpty) {
      db.editPackingList(PackingListsCompanion(
          id: Value.ofNullable(id), title: Value.ofNullable(controller.text)));
    }
  }
}
