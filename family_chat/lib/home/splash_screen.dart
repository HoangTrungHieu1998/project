import 'dart:async';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:family_chat/home/home.dart';
import 'package:family_chat/home/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../component/cache_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int totalDots = 5;
  double currentPosition  = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    run();
    Timer.periodic(const Duration(seconds: 2), (timer) {
      final login = CacheManager.instance.get<String>("login", "");
      if(login.isEmpty){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const HomePage()));
      }else{
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const MainPage()));
      }
      timer.cancel();
    });

  }

  void run(){
    setState(() {
      Timer.periodic(const Duration(milliseconds: 400), (timer) {
        if(currentPosition <totalDots-1){
          currentPosition = currentPosition+1;
        }else{
          currentPosition = 0;
        }
        timer.cancel();
        run();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 168, 243, 1),
      body: SafeArea(
        child: Center(
            child: Column(
              children: [
                const Image(image: AssetImage('assets/images/logo.png'),fit: BoxFit.fill,),
                DotsIndicator(
                  dotsCount: totalDots,
                  position: currentPosition,
                  decorator: const DotsDecorator(
                    color: Colors.black87, // Inactive color
                    activeColor: Colors.redAccent,
                  ),
                )
              ],
            )
        ),
      )
    );
  }
}
