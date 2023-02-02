import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class MyBall extends StatelessWidget {
  const MyBall({Key? key, required this.ballX, required this.ballY, required this.isGameOver, required this.hasGameStart}) : super(key: key);
  final double ballX;
  final double ballY;
  final bool isGameOver;
  final bool hasGameStart;

  @override
  Widget build(BuildContext context) {
    return hasGameStart
        ?Container(
          alignment: Alignment(ballX, ballY),
          child: Container(
            height: 15,
            width: 15,
            decoration: BoxDecoration(
                color: isGameOver?Colors.black:Colors.grey.shade600,
                shape: BoxShape.circle
            ),
          ),
        )
        :Container(
          alignment: Alignment(ballX, ballY),
          child: AvatarGlow(
            endRadius: 60.0,
            child: Material(
              elevation: 8.0,
              shape: const CircleBorder(),
              child: CircleAvatar(
                radius: 7.0,
                backgroundColor: Colors.black,
                child: Container(
                  height: 15,
                  width: 15,
                  decoration: BoxDecoration(
                      color: isGameOver?Colors.black:Colors.grey.shade600,
                      shape: BoxShape.circle
                  ),
                ),
              ),
            ),
          ),
    );
  }
}
