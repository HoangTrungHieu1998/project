import 'package:animation/animate_five.dart';
import 'package:animation/animate_four.dart';
import 'package:animation/animate_one.dart';
import 'package:animation/animate_seven.dart';
import 'package:animation/animate_six.dart';
import 'package:animation/animate_two.dart';
import 'package:flutter/material.dart';

import 'animate_three.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget{
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const AnimateOne()));
                    },
                    child: const Text("Animate One")
                ),
                ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const AnimateTwo()));
                    },
                    child: const Text("Animate Two")),
                ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const AnimateThree()));
                    },
                    child: const Text("Animate Three")),
                ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const AnimateFour()));
                    },
                    child: const Text("Animate Four")),
                ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const AnimateFive()));
                    },
                    child: const Text("Animate Five")),
                ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const AnimateSix()));
                    },
                    child: const Text("Animate Six")),
                ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const AnimateSeven()));
                    },
                    child: const Text("Animate Seven")),
              ],
            ),
          ),
        ),
      );
  }

}
