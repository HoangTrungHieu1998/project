import 'package:family_chat/component/context_class.dart';
import 'package:family_chat/component/main_dialog.dart';
import 'package:family_chat/home/main_page.dart';
import 'package:family_chat/service/cloud_service.dart';
import 'package:flutter/material.dart';

import '../component/cache_manager.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
                      'Đăng ký',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    onChanged: (value){
                      username = value;
                    },
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Tên đăng nhập',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    onChanged: (value){
                      password = value;
                    },
                    obscureText: hidePassword,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Mật khẩu',
                      suffixIcon: InkWell(
                        onTap: (){
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        child: const Icon(Icons.remove_red_eye),
                      )
                    ),
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 30),
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                      child: const Text('Đăng ký'),
                      onPressed: () async{
                        final check = await CloudService.instance.checkUserName(name: username);
                        switch(check){
                          case 0:
                            final result = CloudService.instance.createAccount(
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
                                  content: 'Bạn không thể đăng ký ngay lúc này vui lòng thử lại sau ít phút',
                                  defaultActionText: 'Đã hiểu'
                              );
                            }
                            break;
                          case 1:
                            MainDialog.instance.showAlertDialog(
                                context: context,
                                title: "Thông báo",
                                content: 'Tài khoản này đã tồn tại',
                                defaultActionText: 'Đã hiểu'
                            );
                            break;
                          case 2:
                            MainDialog.instance.showAlertDialog(
                                context: context,
                                title: "Thông báo",
                                content: 'Hệ thống đang gặp lỗi vui lòng đăng ký lại sau ít phút',
                                defaultActionText: 'Đã hiểu'
                            );
                            break;
                          default:
                            MainDialog.instance.showAlertDialog(
                                context: context,
                                title: "Thông báo",
                                content: 'Hệ thống đang gặp lỗi vui lòng đăng ký lại sau ít phút',
                                defaultActionText: 'Đã hiểu'
                            );
                        }
                      },
                    )
                ),
              ],
            )),
      ),
    );
  }
}
