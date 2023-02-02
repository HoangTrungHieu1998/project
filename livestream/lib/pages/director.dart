import 'package:app_popup_menu/app_popup_menu.dart';
import 'package:flutter/cupertino.dart';

class Director extends StatefulWidget {
  const Director({Key? key}) : super(key: key);

  @override
  State<Director> createState() => _DirectorState();
}

class _DirectorState extends State<Director> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Director"),
      ),
    );
  }
}
