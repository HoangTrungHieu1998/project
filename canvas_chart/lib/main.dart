import 'dart:io';
import 'dart:math';
import 'package:canvas_chart/signlaR/socket_page.dart';
import 'package:flutter/material.dart';

import 'chart/progress_chart.dart';

void main(){
  HttpOverrides.global = MyHttpOverrides();
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
      home: const SocketPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

final rng = Random();
const dayCount = 7;

class _MyHomePageState extends State<MyHomePage> {
  late List<Score> _scores;

  @override
  void initState() {
    // TODO: implement initState
    final scores = List<Score>.generate(dayCount, (index){
      final y = rng.nextDouble() * 30.0;
      final d = DateTime.now().add(Duration(days: -dayCount+index));
      return Score(y, d);
    });
    setState(() {
      _scores = scores;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        color: Colors.red,
        child: SizedBox(
          height: 150.0,
          child: ProgressChart(scores: _scores),
        ),
      )

    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}