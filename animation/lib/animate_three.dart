import 'package:flutter/material.dart';

class AnimateThree extends StatefulWidget {
  const AnimateThree({Key? key}) : super(key: key);

  @override
  State<AnimateThree> createState() => _AnimateThreeState();
}

class _AnimateThreeState extends State<AnimateThree> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: GestureDetector(
            onTap: (){
              setState(() {
                selected = !selected;
              });
            },
            child: AnimatedDefaultTextStyle(
              style: selected?
              const TextStyle(fontSize: 30,color: Colors.green,fontWeight: FontWeight.bold):
              const TextStyle(fontSize: 16,color: Colors.pink,fontFamily: "Roboto",fontStyle: FontStyle.italic),
              duration: const Duration(seconds: 1),
              child: const Text("Hieu so handsome"),
            ),
          ),
        ),
      ),
    );
  }
}
