import 'package:flutter_todoapp/future/service.dart';
import 'package:flutter_todoapp/todo_hive.dart';

class Controller{
  List<TodoHive>? todoHive;
  final Service service;

  Controller(this.service);


  void addTodo(TodoHive todo) {
    todoHive!.add(todo);
  }

  void checkboxSelected(bool newValue, int index) {
    todoHive![index].isDebt = newValue;
  }

  void clear() {
    todoHive!.clear();
  }

  Future<void> loadFromDatabase() async {
    todoHive!.add(await service.loadDatabase());
  }

}