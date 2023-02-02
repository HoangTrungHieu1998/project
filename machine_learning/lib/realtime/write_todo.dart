import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class TodoDialog extends StatefulWidget {

  const TodoDialog({
    Key? key,
  }) : super(key: key);

  @override
  _TodoDialogState createState() => _TodoDialogState();
}

class _TodoDialogState extends State<TodoDialog> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final DatabaseReference _messagesRef =
  FirebaseDatabase.instance.ref().child('/order');
  //final database = FirebaseDatabase.instance.ref();



  bool isDebt = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: const Text("Add Todo"),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 8),
              buildName(),
              const SizedBox(height: 8),
              buildAmount(),
              const SizedBox(height: 8),
              buildRadioButtons(),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        buildCancelButton(context),
        buildAddButton(context),
      ],
    );
  }

  Widget buildName() => TextFormField(
    controller: nameController,
    decoration: const InputDecoration(
      border: OutlineInputBorder(),
      hintText: 'Enter Name',
    ),
    validator: (name) =>
    name != null && name.isEmpty ? 'Enter a name' : null,
  );

  Widget buildAmount() => TextFormField(
    decoration: const InputDecoration(
      border: OutlineInputBorder(),
      hintText: 'Enter Age',
    ),
    keyboardType: TextInputType.number,
    validator: (age) => age != null && int.tryParse(age) == null
        ? 'Enter a valid number'
        : null,
    controller: ageController,
  );

  Widget buildRadioButtons() => Column(
    children: [
      RadioListTile<bool>(
        title: const Text('Poor'),
        value: true,
        groupValue: isDebt,
        onChanged: (value) => setState(() => isDebt = value!),
      ),
      RadioListTile<bool>(
        title: const Text('Rich'),
        value: false,
        groupValue: isDebt,
        onChanged: (value) => setState(() => isDebt = value!),
      ),
    ],
  );

  Widget buildCancelButton(BuildContext context) => TextButton(
    child: const Text('Cancel'),
    onPressed: () => Navigator.of(context).pop(),
  );

  Widget buildAddButton(BuildContext context) {

    return TextButton(
      child: const Text("Add"),
      onPressed: () async {
        final isValid = formKey.currentState!.validate();

        if (isValid) {
          final name = nameController.text;
          final age = int.tryParse(ageController.text) ?? 0;

          final todo = <String,dynamic>{
            'name':name,
            'age':age,
            'isDebt':isDebt,
            'time':DateTime.now().millisecondsSinceEpoch
          };

          _messagesRef.push()
              .set(todo)
              .then((value) => print("Todo have been add"))
              .catchError((onError)=>print("You have an error $onError"));
          setState(() {

          });

          Navigator.of(context).pop();
        }
      },
    );
  }
}