import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimateSix extends StatefulWidget {
  const AnimateSix({Key? key}) : super(key: key);

  @override
  State<AnimateSix> createState() => _AnimateSixState();
}

class _AnimateSixState extends State<AnimateSix> with TickerProviderStateMixin {

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 10),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget? child){
                return Transform.rotate(
                    angle: _controller.value * 2.0 * math.pi,
                    child: child,
                );
              },
              child: Container(
                width: 200.0,
                height: 200.0,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text('Whee!',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                ),
              ),
          ),
        ),
      ),
    );
  }
}
