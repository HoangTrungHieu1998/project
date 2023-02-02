import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AnimateTwo extends StatefulWidget {
  const AnimateTwo({Key? key}) : super(key: key);

  @override
  State<AnimateTwo> createState() => _AnimateTwoState();
}

class _AnimateTwoState extends State<AnimateTwo> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: 200,
          height: 350,
          child: Stack(
            children: <Widget>[
              AnimatedPositioned(
                width: selected ? 200.0 : 50.0,
                height: selected ? 50.0 : 200.0,
                top: selected ? 50.0 : 150.0,
                duration: const Duration(seconds: 2),
                curve: Curves.fastOutSlowIn,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = !selected;
                    });
                  },
                  child: Container(
                    color: Colors.blue,
                    child: const Center(child: Text('Tap me')),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
