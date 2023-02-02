import 'package:flutter/material.dart';

class AnimateFive extends StatefulWidget {
  const AnimateFive({Key? key}) : super(key: key);

  @override
  State<AnimateFive> createState() => _AnimateFiveState();
}

class _AnimateFiveState extends State<AnimateFive> {
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
            child: AnimatedAlign(
                curve: Curves.fastOutSlowIn,
                alignment: selected? Alignment.bottomLeft:Alignment.topRight,
                duration: const Duration(seconds: 1),
                child: const Icon(Icons.home,size: 50,color: Colors.pink),
            ),
          ),
        ),
      ),
    );
  }
}
