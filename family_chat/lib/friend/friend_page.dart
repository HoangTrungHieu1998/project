import 'package:family_chat/friend/list_friend.dart';
import 'package:family_chat/service/cloud_service.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class FriendPage extends StatefulWidget {
  const FriendPage({Key? key}) : super(key: key);

  @override
  State<FriendPage> createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {

  List<User> username = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFriend();

  }

  void getFriend()async{
    final a = await CloudService.instance.getFriend();
    setState(() {
      username.addAll(a);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 16,left: 16,right: 16),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: InkWell(
                      onTap: (){
                        setState(() {
                        });
                      },
                      child: const Icon(Icons.search),
                    ),
                    labelText: 'Tìm bạn bè',
                    suffixIcon: InkWell(
                      onTap: (){
                        CloudService.instance.getFriend();
                      },
                      child: const Icon(Icons.person_add_alt),
                    )
                  ),
                )
              ),
              ListView.builder(
                itemCount: username.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 16),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
                  return ListFriend(username: username[index].username!);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
