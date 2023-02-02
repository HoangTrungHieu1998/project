import 'dart:math';

import 'package:flutter/material.dart';

class AnimateFour extends StatefulWidget {
  const AnimateFour({Key? key}) : super(key: key);

  @override
  State<AnimateFour> createState() => _AnimateFourState();
}

class _AnimateFourState extends State<AnimateFour> {
  double _width = 70;
  double _height = 70;
  Color _color = Colors.green;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(10);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: GestureDetector(
            onTap: (){
              setState(() {
                // random generator
                final random = Random();

                // random dimension generator
                _width = random.nextInt(500).toDouble();
                _height = random.nextInt(500).toDouble();

                // random color generator
                _color = Color.fromRGBO(
                  random.nextInt(300),
                  random.nextInt(300),
                  random.nextInt(300),
                  1,
                );

                // random radius generator
                _borderRadius =
                    BorderRadius.circular(random.nextInt(100).toDouble());
              });
            },
            child: AnimatedContainer(
              width: _width,
              height: _height,
              decoration: BoxDecoration(
                color: _color,
                borderRadius: _borderRadius,
              ),
              duration: const Duration(seconds: 1),
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
      ),
    );
  }
}
