import 'package:flutter/material.dart';
import 'package:flutter_todoapp/bloc/todo_bloc.dart';
import 'package:flutter_todoapp/todo_hive.dart';

class TodoDialog extends StatefulWidget {
  final TodoHive? todo;
  final TodoBloc? bloc;

  const TodoDialog({
    Key? key,
    this.todo,
    required this.bloc,
  }) : super(key: key);

  @override
  _TodoDialogState createState() => _TodoDialogState();
}

class _TodoDialogState extends State<TodoDialog> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ageController = TextEditingController();

  bool isDebt = true;

  @override
  void initState() {
    super.initState();

    if (widget.todo != null) {
      final todo = widget.todo!;

      nameController.text = todo.name!;
      ageController.text = todo.age!.toString();
      isDebt = todo.isDebt!;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.todo != null;
    final title = isEditing ? 'Edit Transaction' : 'Add Transaction';

    return AlertDialog(
      title: Text(title),
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
        buildAddButton(context, isEditing: isEditing),
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

  Widget buildAddButton(BuildContext context, {required bool isEditing}) {
    final text = isEditing ? 'Save' : 'Add';

    return TextButton(
      child: Text(text),
      onPressed: () async {
        final isValid = formKey.currentState!.validate();

        if (isValid) {
          final name = nameController.text;
          final age = int.tryParse(ageController.text) ?? 0;

          widget.bloc!.add(AddTodo(name: name,age: age,isDebt: isDebt));

          Navigator.of(context).pop();
        }
      },
    );
  }
}