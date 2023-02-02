import 'package:flutter/material.dart';

import 'configuration.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryGreen,
      padding: const EdgeInsets.only(top:50,bottom: 70,left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.asset("assets/images/logo.png",),
              ),
              const SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Oliver Owen',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  Text('Active Status',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))
                ],
              )
            ],
          ),

          Column(
            children: drawerItems.map((element) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(element['icon'],color: Colors.white,size: 30,),
                  const SizedBox(width: 10,),
                  Text(element['title'],style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20))
                ],
              ),
            )).toList(),
          ),

          Row(
            children: [
              const Icon(Icons.settings,color: Colors.white,),
              const SizedBox(width: 10,),
              const Text('Settings',style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              const SizedBox(width: 10,),
              Container(width: 2,height: 20,color: Colors.white,),
              const SizedBox(width: 10,),
              const Text('Log out',style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
            ],
          )
        ],
      ),

    );
  }
}