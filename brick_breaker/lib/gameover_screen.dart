import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameOverScreen extends StatelessWidget {
  const GameOverScreen({Key? key, required this.isGameOver, this.function}) : super(key: key);

  final bool isGameOver;
  final GestureTapCallback? function;

  //font
  static var gameFont = GoogleFonts.pressStart2p(
    textStyle: const TextStyle(
      color: Colors.black,letterSpacing: 0, fontSize: 28
    )
  );

  @override
  Widget build(BuildContext context) {
    return isGameOver
        ? Stack(
          children: [
            Container(
                alignment: const Alignment(0 ,-0.3),
                child: Text(
                    "G A M E  O V E R",
                    style: gameFont,
                ),
              ),
            Container(
                alignment: const Alignment(0 , 0),
                child: GestureDetector(
                  onTap: function,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        color: Colors.black,
                        child: const Text(
                            "Play Again",
                          style:  TextStyle(color: Colors.white),
                        )
                    ),
                  ),
                )
              ),
          ],
        )
        : Container();
  }
}
