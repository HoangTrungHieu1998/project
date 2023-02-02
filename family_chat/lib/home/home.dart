import 'package:family_chat/login/login_page.dart';
import 'package:family_chat/sign_up/sign_up_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 100),
                alignment: Alignment.center,
                child: const Image(image: AssetImage('assets/images/icon.png'),height: 100,)
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              width: 300,
              child: const Text(
                  'Sign up to spend more time with your friends '
                      'and discover fun things to do together',
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.only(top: 20),
              child: ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const SignUpPage()));
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(color: Colors.white)
                          )
                      )
                  ),
                  child: const Text('Create your new account')
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: RichText(
                text: TextSpan(
                  text: 'Already have a account ? ',
                  style: const TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                        text: 'Log in',
                        style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),
                        recognizer: TapGestureRecognizer()..onTap = (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const LoginPage()));
                        }
                    ),
                  ],
                ),
              )
            ),
          ],
        ),
      ),
    );
  }
}
