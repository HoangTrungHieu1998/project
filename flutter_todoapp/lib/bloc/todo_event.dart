part of 'todo_bloc.dart';

abstract class TodoEvent{
  Stream<TodoState> applyAsync({TodoState? state, TodoBloc? bloc});
}

class UnInitial extends TodoEvent{
  @override
  Stream<TodoState> applyAsync({TodoState? state, TodoBloc? bloc})async* {
    yield TodoUnInitial();
  }
}

class AddTodo extends TodoEvent{
  String? name;
  int? age;
  bool? isDebt;

  AddTodo({this.name,this.age,this.isDebt});

  @override
  Stream<TodoState> applyAsync({TodoState? state, TodoBloc? bloc}) async*{
    try{
      yield TodoInitial();
      final todo = TodoHive()
        ..name = name
        ..age = age
        ..isDebt = isDebt;

      Boxes.getTodo().add(todo);// Add todo to list todo

      final todoHive = Boxes.getTodo().values.toList().cast<TodoHive>();
      yield TodoSuccess(todoHive);

    }catch(e){
      yield TodoFailed();
    }
  }
}

class LoadTodo extends TodoEvent{

  @override
  Stream<TodoState> applyAsync({TodoState? state, TodoBloc? bloc}) async*{
    try{
      yield TodoInitial();
      final todo = Boxes.getTodo().values.toList().cast<TodoHive>();
      if(todo.isNotEmpty){
        yield TodoSuccess(todo);
      }else{
        yield TodoUnSuccess();
      }
    }catch(e){
      yield TodoFailed();
    }
  }
}

class DeleteTodo extends TodoEvent{
  final TodoHive? todoHive;

  DeleteTodo({this.todoHive});

  @override
  Stream<TodoState> applyAsync({TodoState? state, TodoBloc? bloc}) async*{
    try{
      yield TodoInitial();
      todoHive!.delete();
      final todo = Boxes.getTodo().values.toList().cast<TodoHive>();
      if(todo.isNotEmpty){
        yield TodoSuccess(todo);
      }else{
        yield TodoUnSuccess();
      }
    }catch(e){
      yield TodoFailed();
    }
  }
}

class AddBox extends TodoEvent{
  final Store? store;
  String? name;
  int? age;
  bool? isDebt;

  AddBox({this.name,this.age,this.isDebt,this.store});

  @override
  Stream<TodoState> applyAsync({TodoState? state, TodoBloc? bloc}) async*{
    try{
      yield BoxInitial();
      final todo = TodoObjectBox()
        ..name = name
        ..age = age
        ..isDebt = isDebt;

      final box = store!.box<TodoObjectBox>();
      box.put(todo);// Add todo to list todo

      final todoBox = box.getAll();
      yield BoxSuccess(todoBox);

    }catch(e){
      yield BoxFailed();
    }
  }
}

class LoadBox extends TodoEvent{

  final Store? store;
  LoadBox({this.store});

  @override
  Stream<TodoState> applyAsync({TodoState? state, TodoBloc? bloc}) async*{
    try{
      yield BoxInitial();
      final todoBox = store!.box<TodoObjectBox>().getAll();
      if(todoBox.isNotEmpty){
        yield BoxSuccess(todoBox);
      }else{
        yield BoxUnSuccess();
      }
    }catch(e){
      yield BoxFailed();
    }
  }
}

class DeleteBox extends TodoEvent{
  final Store? store;
  final TodoObjectBox? todoBox;

  DeleteBox({this.todoBox,this.store});

  @override
  Stream<TodoState> applyAsync({TodoState? state, TodoBloc? bloc}) async*{
    try{
      yield BoxInitial();
      final box = store!.box<TodoObjectBox>();
      box.remove(todoBox!.id);
      final todo = box.getAll();
      if(todo.isNotEmpty){
        yield BoxSuccess(todo);
      }else{
        yield BoxUnSuccess();
      }
    }catch(e){
      yield BoxFailed();
    }
  }
}
