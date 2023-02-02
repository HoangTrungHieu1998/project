import 'package:family_chat/chat/chat_page.dart';
import 'package:flutter/material.dart';

class ListFriend extends StatelessWidget {
  final String username;
  const ListFriend({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ChatPage(username: username,)));
      },
      child: Container(
        padding: const EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  const CircleAvatar(
                    backgroundImage: NetworkImage('https://i1.wp.com/noitoisong.com/wp-content/uploads/2021/06/bear.jpeg?ssl=1'),
                    maxRadius: 30,
                  ),
                  const SizedBox(width: 16,),
                  Container(
                    color: Colors.transparent,
                    child: Text(username, style: const TextStyle(fontSize: 16),),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chat)
          ],
        ),
      ),
    );
  }
}
