import 'package:flutter_todoapp/todo_hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Boxes {
  static Box<TodoHive> getTodo() =>
      Hive.box<TodoHive>('todo_hive');
}