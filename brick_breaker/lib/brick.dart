import 'package:flutter/material.dart';

class MyBrick extends StatelessWidget {
  const MyBrick({Key? key, required this.brickHeight, required this.brickWidth, required this.brickX, required this.brickY, required this.brickBroken}) : super(key: key);

  final double brickHeight;
  final double brickWidth;
  final double brickX;
  final double brickY;
  final bool brickBroken;

  @override
  Widget build(BuildContext context) {
    print("Data: ${(2*brickX*brickWidth)/(2 - brickWidth)}");
    print("DataX: $brickX");
    return brickBroken
      ? Container()
      : Container(
        alignment: Alignment((2*brickX+brickWidth)/(2 - brickWidth), brickY),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            height: MediaQuery.of(context).size.height * brickHeight / 2,
            width: MediaQuery.of(context).size.width * brickWidth / 2,
            color: Colors.black,
          ),
        ),
      );
  }
}
