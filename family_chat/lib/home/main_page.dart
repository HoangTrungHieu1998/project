import 'package:family_chat/chat/chat_page.dart';
import 'package:family_chat/friend/friend_page.dart';
import 'package:family_chat/profile/profile_page.dart';
import 'package:flutter/material.dart';

import '../chat/chat_home.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;
  Widget friendPage = const FriendPage();
  Widget chatPage = const ChatHome();
  Widget profilePage = const ProfilePage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("BottomNavigationBar Example"),
      // ),
      body:  getBody(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: "Friends",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Profile",
          )
        ],
        onTap: (int index) {
          onTapHandler(index);
        },
      ),
    );
  }

  Widget getBody( )  {
    if(selectedIndex == 0) {
      return friendPage;
    } else if(selectedIndex==1) {
      return chatPage;
    } else {
      return profilePage;
    }
  }

  void onTapHandler(int index)  {
    setState(() {
      selectedIndex = index;
    });
  }
}
