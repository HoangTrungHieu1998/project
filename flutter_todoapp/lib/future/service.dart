import 'package:flutter_todoapp/todo_hive.dart';

class Service{
  // Service._();
  // static final Service instance = Service._();

  Future<TodoHive> loadDatabase() async {
    try {
      Future.delayed(Duration(seconds: 3));
      print("this got called?!?");
      return TodoHive(name: "John",isDebt: true,age: 22);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}