import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CoverScreen extends StatelessWidget {
  const CoverScreen({Key? key, required this.hasGameStart}) : super(key: key);
  final bool hasGameStart;

  //font
  static var gameFont = GoogleFonts.pressStart2p(
      textStyle: const TextStyle(
          color: Colors.black,letterSpacing: 0, fontSize: 28
      )
  );

  @override
  Widget build(BuildContext context) {
    return hasGameStart
        ? Container(
          alignment: const Alignment(0,-0.5),
          child: Text(
            "BRICK BREAKER",
            style: gameFont.copyWith(color: Colors.grey.shade800),
          ),
        )
        :Stack(
          children: [
            Container(
              alignment: const Alignment(0,-0.5),
              child: Text(
                "BRICK BREAKER",
                style: gameFont,
              ),
             ),
            Container(
              alignment: const Alignment(0,-0.1),
              child: const Text(
                "Tap To Play",
                style: TextStyle(color: Colors.black),
              ),
             ),
          ],
        );
  }
}
