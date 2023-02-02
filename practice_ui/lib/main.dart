import 'package:flutter/material.dart';
import 'package:practice_ui/constants.dart';
import 'package:practice_ui/credit_card/dashboard.dart';
import 'package:practice_ui/daily_exercise/daily_home.dart';
import 'package:practice_ui/main_page.dart';
import 'package:practice_ui/plant/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Practice UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: kPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.orange
      ),
      home: const MainPage(),
    );
  }
}

