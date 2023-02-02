import 'package:flutter/material.dart';

class AnimateOne extends StatefulWidget {
  const AnimateOne({Key? key}) : super(key: key);

  @override
  State<AnimateOne> createState() => _AnimateOneState();
}

class _AnimateOneState extends State<AnimateOne> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedSize(
          duration: const Duration(seconds: 1),
          child: SizedBox(
            height: double.infinity,
            child: Image.asset('assets/images/live.jpg',fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
