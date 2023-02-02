import 'package:family_chat/component/cache_manager.dart';
import 'package:family_chat/home/splash_screen.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
              margin: const EdgeInsets.only(top: 30),
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text('Đăng xuất'),
                onPressed: (){
                  CacheManager.instance.clear();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const SplashScreen()));
                },
              )
          ),
        ),
      )
    );
  }
}
