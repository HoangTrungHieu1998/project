import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todoapp/bloc/todo_bloc.dart';
import 'package:flutter_todoapp/objectbox.g.dart';
import 'package:flutter_todoapp/todo_dialog.dart';
import 'package:flutter_todoapp/todo_hive.dart';
import 'package:flutter_todoapp/todo_object_dialog.dart';
import 'package:flutter_todoapp/todo_objectbox.dart';
import 'package:hive/hive.dart';

import 'bloc/todo_init.dart';

class TodoObjectPage extends StatefulWidget {
  final Store? store;
  final TodoBloc? bloc;
  const TodoObjectPage({Key? key, this.bloc,this.store}) : super(key: key);

  @override
  _TodoObjectState createState() => _TodoObjectState();
}

class _TodoObjectState extends State<TodoObjectPage> {
  List<TodoObjectBox>? todo;
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  bool isDebt = true;

  List<TodoObjectBox>? _getTodoFromState(TodoState state) {
    List<TodoObjectBox>? todo;
    if (state is BoxSuccess) {
      todo = state.todoBox;
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
                          return TodoObjectDialog(bloc: widget.bloc,store: widget.store,);
                        });
                  },
                  child: const Icon(Icons.add),
                ))
          ],
        );
      },
    );
  }

  Widget buildButtons(BuildContext context, TodoObjectBox todo) {
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
            onPressed: () => widget.bloc!.add(DeleteBox(todoBox: todo,store: widget.store)),
          ),
        )
      ],
    );
  }

  _buildView(TodoState state) {
    if (state is BoxInitial) {
      return const Center(
        child: CupertinoActivityIndicator(),
      );
    } else if (state is BoxSuccess) {
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
    } else if (state is BoxUnSuccess) {
      return const Center(
        child: Text(
          "Not found todo list",
          style: TextStyle(fontSize: 30),
        ),
      );
    }
  }
}
