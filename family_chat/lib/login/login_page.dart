import 'package:family_chat/sign_up/sign_up_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../component/cache_manager.dart';
import '../component/main_dialog.dart';
import '../home/main_page.dart';
import '../service/cloud_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPagePageState();
}

class _LoginPagePageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String username = "";
  String password = "";

  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    margin: const EdgeInsets.only(top: 50),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Family Chat',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Đăng nhập',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        alignment: Alignment.centerLeft,
                        child: const Text("Tên đăng nhập",style: TextStyle(fontSize: 16),),
                      ),
                      TextField(
                        onChanged: (value){
                          username = value;
                        },
                        controller: nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Tên đăng nhập',
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Column(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          alignment: Alignment.centerLeft,
                          child: const Text("Mật khẩu",style: TextStyle(fontSize: 16),),
                      ),
                      TextField(
                        onChanged: (value){
                          password = value;
                        },
                        obscureText: hidePassword,
                        controller: passwordController,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            hintText: 'Mật khẩu',
                            suffixIcon: InkWell(
                              onTap: (){
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              child: const Icon(Icons.remove_red_eye),
                            )
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 30),
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Đăng nhập'),
                      onPressed: () async {
                        final result = await CloudService.instance.login(
                            name: username,
                            password: password
                        );
                        if(result){
                          setState(() {
                            CacheManager.instance.set('login', username);
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const MainPage()));
                          });
                        }else{
                          MainDialog.instance.showAlertDialog(
                              context: context,
                              title: "Thông báo",
                              content: 'Bạn chưa có tài khoản',
                              defaultActionText: 'Đã hiểu'
                          );
                        }
                      },
                    )
                ),
                Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 10),
                    child: RichText(
                      text: TextSpan(
                        text: 'Bạn không có tài khoản ? ',
                        style: const TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                              text: 'Đăng ký',
                              style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),
                              recognizer: TapGestureRecognizer()..onTap = (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const SignUpPage()));
                              }
                          ),
                        ],
                      ),
                    )
                ),
              ],
            )),
      ),
    );
  }
}
