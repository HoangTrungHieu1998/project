import 'package:flutter/material.dart';
import 'package:practice_ui/pet/pet_drawer.dart';
import 'package:practice_ui/pet/pet_home.dart';

class PetMain extends StatelessWidget {
  const PetMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const [
          DrawerScreen(),
          PetHome()
        ],
      ),

    );
  }
}
