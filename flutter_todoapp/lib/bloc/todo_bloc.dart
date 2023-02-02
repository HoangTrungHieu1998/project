import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_todoapp/boxes.dart';
import 'package:flutter_todoapp/objectbox.g.dart';
import 'package:flutter_todoapp/todo_hive.dart';
import 'package:flutter_todoapp/todo_objectbox.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc(TodoState initialState) : super(initialState);

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
   try{
     yield* event.applyAsync(state: state,bloc: this);
   }catch(e){
     yield state;
   }
  }
}
