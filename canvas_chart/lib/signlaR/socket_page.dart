import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:signalr_core/signalr_core.dart';

class SocketPage extends StatefulWidget {
  const SocketPage({Key? key}) : super(key: key);

  @override
  State<SocketPage> createState() => _SocketPageState();
}

class _SocketPageState extends State<SocketPage> {
  final server = "https://10.0.2.2:5001/chathub";
  late HubConnection connection;
  String user = "";
  String message = "";
  final userController = TextEditingController();
  final messageController = TextEditingController();
  List<String> listUser = [];
  List<String> listMessage = [];
  List<String> listUserTwo = [];
  List<String> listMessageTwo = [];

  @override
  void initState() {
    // TODO: implement initState
    initSignalR();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
              const EdgeInsets.only(top: 20, right: 8, left: 8, bottom: 8),
              child: TextField(
                onChanged: (value) {
                  user = value;
                },
                controller: userController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Enter User Name"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  message = value;
                },
                controller: messageController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Enter Message"),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  print("connection ID HIen Tai la " +
                      connection.connectionId.toString());
                  print("$user : $message");
                  if (connection.state == HubConnectionState.connected) {
                    _sendMessage(user, message);
                    // await connection.invoke("SendMessage",args: <String>[
                    //   user,
                    //   message
                    // ] );
                  }
                },
                child: const Text("Send Message")),
            Expanded(
                child: ListView.builder(
                    itemCount: listUser.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Text(
                          "${listUser[index]} says: ${listMessage[index]}");
                    })),

          ],
        ),
      ),
    );
  }

  void initSignalR() {
    connection = HubConnectionBuilder()
        .withUrl(
        server,
        HttpConnectionOptions(
          logging: (level, message) => print(message),
        ))
        .build();
    connection.start();
    connection.onclose((error) => print("connection close"));
    connection.on("984", _handleMessage);
    connection.on("ReceiveMessageTwo", _handleMessageTwo);
    // _joinToGroup();

    print("connection ID HIen Tai la " + connection.connectionId.toString());
  }

  void _handleAClientProvidedFunction(List<Object> parameters) {
    // logger.log(LogLevel.Information, "Server invoked the method");
  }

  _handleMessage(List<dynamic>? args) {
    setState(() {
      listUser.add(args![0]);
      listMessage.add(args[1]);
    });
  }

  _handleMessageTwo(List<dynamic>? args) {
    setState(() {
      listUserTwo.add(args![0]);
      listMessageTwo.add(args[1]);
    });
  }

  _joinToGroup() async {
    var url = Uri.parse('https://10.0.2.2:5001/api/Message/JoinGroup');
    var body = jsonEncode({
      'UserConnectionId': connection.connectionId ?? "1234",
      'GroupName': 'Room1'
    });
    var response = await http.post(url, body: body, headers: {
      "Accept": "application/json",
      "content-type": "application/json"
    });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  _sendMessage(String name, String message) async {
    var url = Uri.parse('https://10.0.2.2:5001/api/Message/SendMessage');
    var body = jsonEncode({'Type': name, 'Information': message});
    var response = await http.post(url, body: body, headers: {
      "Accept": "application/json",
      "content-type": "application/json"
    });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  _sendMessageToGroup(String name, String message) async {
    var url = Uri.parse('https://10.0.2.2:5001/api/Message/SendToGroup');
    var body = jsonEncode({'Type': name, 'Information': message});
    var response = await http.post(url, body: body, headers: {
      "Accept": "application/json",
      "content-type": "application/json"
    });
    connection.on("Room1", (arguments) {});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}
