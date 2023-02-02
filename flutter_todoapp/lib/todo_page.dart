import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todoapp/bloc/todo_bloc.dart';
import 'package:flutter_todoapp/todo_dialog.dart';
import 'package:flutter_todoapp/todo_hive.dart';
import 'package:hive/hive.dart';

import 'bloc/todo_init.dart';

class TodoPage extends StatefulWidget {
  final TodoBloc? bloc;

  const TodoPage({Key? key, this.bloc}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<TodoHive>? todo;
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  bool isDebt = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Hive.close();
    super.dispose();
  }

  List<TodoHive>? _getTodoFromState(TodoState state) {
    List<TodoHive>? todo;
    if (state is TodoSuccess) {
      todo = state.todoHive;
    }
    return todo;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      bloc: widget.bloc,
      builder: (BuildContext context, TodoState state) {
        return Stack(
          children: [
            _buildView(state),
            Positioned(
                bottom: 5,
                right: 5,
                child: FloatingActionButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return TodoDialog(bloc: widget.bloc);
                        });
                  },
                  child: const Icon(Icons.add),
                ))
          ],
        );
      },
    );
  }

  Widget buildButtons(BuildContext context, TodoHive todo) {
    return Row(
      children: [
        Expanded(
          child: TextButton.icon(
              label: const Text('Edit'),
              icon: const Icon(Icons.edit),
              onPressed: () {}),
        ),
        Expanded(
          child: TextButton.icon(
            label: const Text('Delete'),
            icon: const Icon(Icons.delete),
            onPressed: () => widget.bloc!.add(DeleteTodo(todoHive: todo)),
          ),
        )
      ],
    );
  }

  _buildView(TodoState state) {
    if (state is TodoInitial) {
      return const Center(
        child: CupertinoActivityIndicator(),
      );
    } else if (state is TodoSuccess) {
      todo = _getTodoFromState(state);
      return Column(
        children: [
          const SizedBox(
            height: 26,
          ),
          Expanded(
              child: ListView.builder(
                  physics: const ScrollPhysics(),
                  itemCount: todo!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: Colors.white,
                      child: ExpansionTile(
                        tilePadding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 8),
                        title: Text(
                          todo![index].name!,
                          maxLines: 2,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        subtitle: Text(todo![index].isDebt!
                            ? "You are poor"
                            : "You are rich"),
                        trailing: Text(
                          todo![index].age.toString(),
                          style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        children: [
                          buildButtons(context, todo![index]),
                        ],
                      ),
                    );
                  })),
        ],
      );
    } else if (state is TodoUnSuccess) {
      return const Center(
        child: Text(
          "Not found todo list",
          style: TextStyle(fontSize: 30),
        ),
      );
    }
  }
}
