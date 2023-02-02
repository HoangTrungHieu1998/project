import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practice_ui/coffee/coffee_tile.dart';

class CoffeeHome extends StatefulWidget {
  const CoffeeHome({Key? key}) : super(key: key);

  @override
  State<CoffeeHome> createState() => _CoffeeHomeState();
}

class _CoffeeHomeState extends State<CoffeeHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const Icon(Icons.menu),
        actions: const[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(Icons.person),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[900],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: ""
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: ""
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: ""
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text("Find the best coffee for you",
                style: GoogleFonts.bebasNeue(
                  fontSize: 56,
                  color: Colors.white
                ),),
          ),
          const SizedBox(height: 25,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Find your coffee..",
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade600)
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade600)
                )
              ),
            ),
          ),
          const SizedBox(height: 25,),
          Expanded(
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  const CoffeeTile(),
                  const CoffeeTile(),
                  const CoffeeTile(),
                ],
              )
          )
        ],
      ),
    );
  }
}
