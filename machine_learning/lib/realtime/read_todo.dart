import 'package:flutter/material.dart';

class ReadTodo extends StatefulWidget {
  const ReadTodo({Key? key}) : super(key: key);

  @override
  _ReadTodoState createState() => _ReadTodoState();
}

class _ReadTodoState extends State<ReadTodo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Read Todo"),),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
