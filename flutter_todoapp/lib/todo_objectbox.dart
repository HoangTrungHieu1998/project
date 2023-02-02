import 'package:objectbox/objectbox.dart';

@Entity()
class TodoObjectBox{

  int id =0;

  String? name;
  int? age;
  bool? isDebt;

  TodoObjectBox({this.name,this.age,this.isDebt});
}