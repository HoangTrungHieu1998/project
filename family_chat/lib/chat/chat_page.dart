import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family_chat/constant.dart';
import 'package:family_chat/service/cloud_service.dart';
import 'package:flutter/material.dart';

import '../component/cache_manager.dart';
import '../models/chat_message.dart';

class ChatPage extends StatefulWidget {
  final String username;
  const ChatPage({Key? key, required this.username}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final login = CacheManager.instance.get<String>("login", "");
  TextEditingController messageController = TextEditingController();
  String message = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back,color: Colors.black,),
                  ),
                  const SizedBox(width: 2,),
                  const CircleAvatar(
                    backgroundImage: NetworkImage("https://i1.wp.com/noitoisong.com/wp-content/uploads/2021/06/bear.jpeg?ssl=1"),
                    maxRadius: 20,
                  ),
                  const SizedBox(width: 12,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(widget.username,style: const TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
                        const SizedBox(height: 6,),
                        Text("Online",style: TextStyle(color: Colors.grey.shade600, fontSize: 13),),
                      ],
                    ),
                  ),
                  const Icon(Icons.settings,color: Colors.black54,),
                ],
              ),
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            StreamBuilder(
                stream: CloudService.instance.getMessage(login,widget.username),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text(
                        'No message here',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                        ),
                      ),
                    );
                  }
                  final docs = snapshot.data as DocumentSnapshot;
                  if (!docs.exists) {
                    return const Center(
                      child: Text(
                        'No message here',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    reverse: true,
                    itemCount: docs[Constant.chatKey].length,
                    padding: const EdgeInsets.only(top: 10,bottom:60),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index){
                      return Container(
                        padding: const EdgeInsets.only(left: 14,right: 14,top: 10,bottom: 10),
                        child: Align(
                          alignment: (docs[Constant.chatKey][index]["sender"] != login?Alignment.topLeft:Alignment.topRight),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: (docs[Constant.chatKey][index]["sender"]  != login?Colors.grey.shade200:Colors.blue[200]),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Text(docs[Constant.chatKey][index]["message"], style: const TextStyle(fontSize: 15),),
                          ),
                        ),
                      );
                    },
                  );
                }
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 10,bottom: 10,top: 10),
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(Icons.add, color: Colors.white, size: 20, ),
                      ),
                    ),
                    const SizedBox(width: 15,),
                    Expanded(
                      child: TextField(
                        onChanged: (value){
                          message = value;
                        },
                        controller: messageController,
                        decoration: const InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none
                        ),
                      ),
                    ),
                    const SizedBox(width: 15,),
                    FloatingActionButton(
                      onPressed: ()async{
                        // Send Message
                        await CloudService.instance.sendMessage(login, widget.username, message);
                        message = "";
                        messageController.clear();
                      },
                      backgroundColor: Colors.blue,
                      elevation: 0,
                      child: const Icon(Icons.send,color: Colors.white,size: 18,),
                    ),
                  ],

                ),
              ),
            ),
          ],
        ),
    );
  }
}
