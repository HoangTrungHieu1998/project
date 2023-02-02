part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  final List? todo;

  const TodoState([this.todo]);
  @override
  List<Object?> get props => (todo ?? []);
}

class TodoUnInitial extends TodoState{
  TodoUnInitial():super([]);

  @override
  String toString() => "Todo UnInitial";
}

class TodoInitial extends TodoState {
  TodoInitial():super([]);

  @override
  String toString() => "Todo Initial";
}
class TodoSuccess extends TodoState {
  final List<TodoHive> todoHive;
  TodoSuccess(this.todoHive):super([todoHive]);

  @override
  String toString() => "Todo Success";
}
class TodoUnSuccess extends TodoState {
  TodoUnSuccess():super([]);

  @override
  String toString() => "Todo Failed";
}
class TodoFailed extends TodoState {
  TodoFailed():super([]);

  @override
  String toString() => "Todo Failed";
}

class BoxInitial extends TodoState {
  BoxInitial():super([]);

  @override
  String toString() => "Todo Initial";
}
class BoxSuccess extends TodoState {
  final List<TodoObjectBox> todoBox;
  BoxSuccess(this.todoBox):super([todoBox]);

  @override
  String toString() => "Box Success";
}
class BoxUnSuccess extends TodoState {
  BoxUnSuccess():super([]);

  @override
  String toString() => "Box UnSuccess";
}
class BoxFailed extends TodoState {
  BoxFailed():super([]);

  @override
  String toString() => "Box Failed";
}
