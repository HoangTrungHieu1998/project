import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todoapp/future/controller.dart';
import 'package:flutter_todoapp/future/service.dart';
import 'package:flutter_todoapp/todo_hive.dart';
import 'package:mockito/mockito.dart';

class MockService extends Mock implements Service{}

void main() {
  late MockService service = MockService();
  late Controller controller;

  setUp((){
    controller = Controller(service);
  });

  test("Test Mock", ()async{
    TodoHive hive = TodoHive(age: 22,isDebt: false,name: "John");

    when(service.loadDatabase()).thenAnswer(
          (realInvocation) => Future.value(hive),
    );
    await controller.loadFromDatabase();
    expect(controller.todoHive![0].name, "John");

  });
}