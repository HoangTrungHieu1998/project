

import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:machine_learning/google_ml/ml_home.dart';
import 'package:machine_learning/login/authentication.dart';
import 'package:machine_learning/realtime/home_real.dart';
import 'package:provider/provider.dart';

import 'login/home.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error in fetching the cameras: $e');
  }
  runApp(ChangeNotifierProvider(
      create: (context)=>ApplicationState(),
      builder: (context,_)=>const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Machine Learning",
      theme: ThemeData(
        primarySwatch: Colors.deepPurple
      ),
      home: const MLHome(),
    );
  }
}

