import 'package:flutter_todoapp/bloc/todo_bloc.dart';
import 'package:flutter_todoapp/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class TodoInit{
  TodoBloc? bloc;
  TodoBloc? blocBox;

  TodoInit._();
  static final TodoInit _instance = TodoInit._();
  static TodoInit get instance => _instance;

  init(Store store) {
    bloc = TodoBloc(TodoInitial());
    bloc!.add(LoadTodo());
    blocBox = TodoBloc(BoxInitial());
    blocBox!.add(LoadBox(store: store));
  }
}