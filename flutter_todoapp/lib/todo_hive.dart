import 'package:hive/hive.dart';
part 'todo_hive.g.dart';

@HiveType(typeId: 0)
class TodoHive extends HiveObject{

  @HiveField(0)
  String? name;

  @HiveField(1)
  int? age;

  @HiveField(2)
  bool? isDebt;

  TodoHive({this.name,this.age,this.isDebt});

}