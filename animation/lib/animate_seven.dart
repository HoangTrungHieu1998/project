import 'package:flutter/material.dart';

class AnimateSeven extends StatefulWidget {
  const AnimateSeven({Key? key}) : super(key: key);

  @override
  State<AnimateSeven> createState() => _AnimateSevenState();
}

class _AnimateSevenState extends State<AnimateSeven> {
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
            child: AnimatedOpacity(
                opacity: selected? 0.3:1.0,
                duration: const Duration(seconds: 1),
                child: SizedBox(
                  height: 300,
                  child: Image.asset('assets/images/live.jpg',fit: BoxFit.cover),
                ),
            ),
          ),
        ),
      ),
    );
  }
}
