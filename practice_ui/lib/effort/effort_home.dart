import 'package:flutter/material.dart';

class HelpSection extends StatelessWidget {
  const HelpSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Contact Us',
          style: TextStyle(color: Colors.orange),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            Center(
                child: Image.asset(
                  'assets/images/contactus2.png',
                  height: 250,
                )),
            const SizedBox(height: 20,),
            Text(
              'Have an issue  or query? \nFeel free to contact us',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20,color: Colors.grey[800]),
            ),
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 120,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.white,

                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 20,offset: Offset(0,10)
                          )
                        ]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.alternate_email,color: Colors.orange,size: 50,),
                        Text('Write to us :',style: TextStyle(color: Colors.orange),),
                        Text('help@gmail.com')
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 120,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.white,

                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 20,offset: const Offset(0,10)
                          )
                        ]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: const[
                        Icon(Icons.phone,color: Colors.orange,size: 50,),
                        Text('Call us :',style: TextStyle(color: Colors.orange)),
                        Text('+911- 123456788')
                      ],
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 120,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.white,

                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 20,offset: const Offset(0,10)
                          )
                        ]
                    ),                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: const [
                      Icon(Icons.help_outline,color: Colors.orange,size: 50,),
                      Text('FAQs :',style: TextStyle(color: Colors.orange)),
                      Text('Frequently asked questions',textAlign: TextAlign.center,)
                    ],
                  ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 120,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.white,

                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 20,offset: const Offset(0,10)
                          )
                        ]
                    ),                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: const [
                      Icon(Icons.location_on,color: Colors.orange,size: 50,),
                      Text('Locate to us :',style: TextStyle(color: Colors.orange)),
                      Text('Find us on Google Maps',textAlign: TextAlign.center,)
                    ],
                  ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 30,),
            const Text('Copyright (c) 2020 The Growing Developer'),
            const Text('All rights reserved'),
            const SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }
}