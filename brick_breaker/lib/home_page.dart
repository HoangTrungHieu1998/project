import 'dart:async';

import 'package:brick_breaker/ball.dart';
import 'package:brick_breaker/brick.dart';
import 'package:brick_breaker/cover_screen.dart';
import 'package:brick_breaker/gameover_screen.dart';
import 'package:brick_breaker/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

enum Direction {up, down, left, right}

class _HomePageState extends State<HomePage> {

  // ball variables
  double ballX = 0;
  double ballY = 0;
  double ballXIncrement = 0.01;
  double ballYIncrement = 0.01;
  var ballYDirection = Direction.down;
  var ballXDirection = Direction.left;

  //player variables
  double playerX = -0.2;
  double playerWidth = 0.4;

  //brick variables
  static double brickX = -1 + wallGap;
  static double brickY = -0.9;
  static double brickWidth = 0.4;
  static double brickHeight = 0.05;
  static double brickGap = 0.1;
  static int numberOfBrickInRow = 4;
  static double wallGap = 0.5 *(2-numberOfBrickInRow*brickWidth - (numberOfBrickInRow-1)*brickGap);
  bool brickBroken = false;

  List myBricks = [
    [brickX + 0*(brickWidth + brickGap),brickY,false],
    [brickX + 1*(brickWidth + brickGap),brickY,false],
    [brickX + 2*(brickWidth + brickGap),brickY,false],
    [brickX + 3*(brickWidth + brickGap),brickY,false],
  ];

  //game settings
  bool hasGameStart = false;
  bool isGameOver = false;

  void startGame() {
    hasGameStart = true;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      setState(() {
        //update direction
        updateDirection();

        //move ball
        moveBall();

        //check if player dead
        if(isPlayerDead()){
          timer.cancel();
          isGameOver = true;
        }

        //check if brick is hit
        checkForBrokenBricks();
      });
    });
  }

  void resetGame(){
    setState(() {
      playerX = -0.2;
      ballX = 0;
      ballY = 0;
      isGameOver = false;
      hasGameStart = false;
      myBricks = [
        [brickX + 0*(brickWidth + brickGap),brickY,false],
        [brickX + 1*(brickWidth + brickGap),brickY,false],
        [brickX + 2*(brickWidth + brickGap),brickY,false],
        [brickX + 3*(brickWidth + brickGap),brickY,false],
      ];
    });
  }

  void checkForBrokenBricks(){
    // Check for when ball hits bottom or brick
    for(int i =0; i<myBricks.length; i++){
      if(ballX >= myBricks[i][0] &&
          ballX <= myBricks[i][0] + brickWidth &&
          ballY <= myBricks[i][1] + brickHeight &&
          myBricks[i][2] == false){
        setState(() {
          myBricks[i][2] = true;

          // since brick is broken, update direction of ball
          // base on which side of the brick is hit
          // to do this, calculate the distance of the ball from each of the 4 sides
          // the smallest distance is the side the ball has it
          double leftSideDis = (myBricks[i][0] - ballX).abs();
          double rightSideDis = (myBricks[i][0] + brickWidth - ballX).abs();
          double topSideDis = (myBricks[i][0] - ballY).abs();
          double bottomSideDis = (myBricks[i][0] + brickWidth - ballY).abs();

          String min = findMin(leftSideDis,rightSideDis,topSideDis,bottomSideDis);

          switch(min){
            case 'left':
            // If ball hit right side of brick then
              ballXDirection = Direction.left;
              break;
            case 'right':
            // If ball hit left side of brick then
              ballXDirection = Direction.right;
              break;
            case 'up':
            // If ball hit top side of brick then
              ballYDirection = Direction.up;
              break;
            case 'down':
            // If ball hit bottom side of brick then
              ballYDirection = Direction.down;
              break;
          }
        });
      }
    }
  }

  String findMin(double leftSideDis, double rightSideDis, double topSideDis, double bottomSideDis) {
    List<double> myList = [
      leftSideDis,
      rightSideDis,
      topSideDis,
      bottomSideDis
    ];

    double currentMin = leftSideDis;
    for(int i =0; i< myList.length; i++){
      if (myList[i]<currentMin) {
        currentMin = myList[i];
      }  
    }

    if((currentMin - leftSideDis).abs() < 0.01){
      return 'left';
    }else if ((currentMin - rightSideDis).abs() < 0.01) {
      return 'right';
    }else if ((currentMin - topSideDis).abs() < 0.01) {
      return 'up';
    }else if ((currentMin - bottomSideDis).abs() < 0.01) {
      return 'down';
    }
    return "";
  }

  bool isPlayerDead(){
    if (ballY >=1){
      return true;
    }
    return false;
  }

  // Update direction of ball
  void updateDirection(){
    setState(() {
      // ball go up when it hit player
      if(ballY >= 0.9 && ballX >= playerX && ballX <= playerX + playerWidth){
        ballYDirection = Direction.up;
      }

      // ball go up when it hit player
      else if(ballY <= -1){
        ballYDirection = Direction.down;
      }

      // ball go up when it hit player
      if(ballX >=1){
        ballXDirection = Direction.left;
      }

      // ball go up when it hit player
      else if(ballX <=-1){
        ballXDirection = Direction.right;
      }
    });
  }

  // Move Ball
  void moveBall(){
    setState(() {
      // move horizontal
      if(ballXDirection == Direction.left){
        ballX -= ballXIncrement;
      }else if(ballXDirection == Direction.right){
        ballX += ballXIncrement;
      }

      // move vertical
      if(ballYDirection == Direction.down){
        ballY += ballYIncrement;
      }else if(ballYDirection == Direction.up){
        ballY -= ballYIncrement;
      }
    });
  }

  void moveLeft() {
    setState(() {
      // Avoid moving out of screen
      if(!(playerX - 0.2 <-1)){
        playerX -= 0.2;
      }
    });
  }

  void moveRight() {
    setState(() {
      // Avoid moving out of screen
      if(!(playerX + playerWidth >=1)){
        playerX += 0.2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Gap : $wallGap");
    return RawKeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKey: (event){
          if(event.isKeyPressed(LogicalKeyboardKey.arrowLeft)){
            moveLeft();
          }else if(event.isKeyPressed(LogicalKeyboardKey.arrowRight)){
            moveRight();
          }
        },
        child: GestureDetector(
          onTap: startGame,
          child: Scaffold(
            backgroundColor: Colors.blue.shade300,
            body: Center(
              child: Stack(
                children: [
                  //Tap to play
                  CoverScreen(hasGameStart: hasGameStart),

                  //Game Over Screen
                  GameOverScreen(
                      isGameOver: isGameOver,
                      function: resetGame,
                  ),

                  //Ball
                  MyBall(
                      ballX: ballX,
                      ballY: ballY,
                      hasGameStart: hasGameStart,
                      isGameOver: isGameOver,
                  ),

                  //Player
                  MyPlayer(
                      playerX: playerX,
                      playerWidth: playerWidth
                  ),

                  //Bricks
                  // ListView.builder(
                  //     itemCount: myBricks.length,
                  //     itemBuilder: (BuildContext context, int index){
                  //       return MyBrick(
                  //         brickHeight: brickHeight,
                  //         brickWidth: brickWidth,
                  //         brickX: myBricks[index][0],
                  //         brickY: myBricks[index][1],
                  //         brickBroken: brickBroken,);
                  //     }
                  // ),
                  MyBrick(
                    brickHeight: brickHeight,
                    brickWidth: brickWidth,
                    brickX: myBricks[0][0],
                    brickY: myBricks[0][1],
                    brickBroken: myBricks[0][2],),
                  MyBrick(
                    brickHeight: brickHeight,
                    brickWidth: brickWidth,
                    brickX: myBricks[1][0],
                    brickY: myBricks[1][1],
                    brickBroken: myBricks[1][2],),
                  MyBrick(
                    brickHeight: brickHeight,
                    brickWidth: brickWidth,
                    brickX: myBricks[2][0],
                    brickY: myBricks[2][1],
                    brickBroken: myBricks[2][2],),
                  MyBrick(
                    brickHeight: brickHeight,
                    brickWidth: brickWidth,
                    brickX: myBricks[3][0],
                    brickY: myBricks[3][1],
                    brickBroken: myBricks[3][2],),
                ],
              ),
            ),
          ),
        )
    );
  }
}



