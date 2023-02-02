class Todo{
  final String? name;
  final String? age;
  final bool? isDebt;
  final DateTime? time;


  Todo({this.name, this.age, this.isDebt,this.time});

  factory Todo.fromRTDB(Map<String,dynamic> data){
    return Todo(
      name: data['name']??"Adam",
      age: data['age']??"18",
      isDebt: data['isDebt']??false,
      time: (data['time']!=null)?
      DateTime.fromMillisecondsSinceEpoch(data['time']):
      DateTime.now(),
    );
  }
}