

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:machine_learning/realtime/read_todo.dart';
import 'package:machine_learning/realtime/todo.dart';
import 'package:machine_learning/realtime/write_todo.dart';

class HomeReal extends StatefulWidget {
  const HomeReal({Key? key}) : super(key: key);

  @override
  _HomeRealState createState() => _HomeRealState();
}

class _HomeRealState extends State<HomeReal> {

  final database = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("MY TO DO"),),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Check My Todo"),
          SizedBox(height: 6,width: MediaQuery.of(context).size.width,),
          StreamBuilder(
              stream: database.child('order').orderByKey().limitToLast(10).onValue,
              builder: (context,snapshot){
                final tilesList = <ListTile>[];
                if(snapshot.hasData){
                  final myTodo = Map<String,dynamic>.from(snapshot.data as Map<String,dynamic>);
                  myTodo.forEach((key, value) {
                    final nextTodo = Todo.fromRTDB(Map<String,dynamic>.from(value));
                    final totoTile = ListTile(
                      leading: const Icon(Icons.local_cafe),
                      title: Text(nextTodo.name!),
                      subtitle: Text(nextTodo.age!),
                    );
                    tilesList.add(totoTile);
                  });
                }
                return Expanded(
                    child: ListView(
                      children: tilesList,
                    )
                );
              }
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>showDialog(
            context: context,
            builder: (BuildContext context) {
              return const TodoDialog();
            }),
        child: const Icon(Icons.add),
      ),
    );
  }
}
