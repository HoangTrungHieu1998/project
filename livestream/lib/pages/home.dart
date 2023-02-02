import 'package:flutter/material.dart';
import 'package:livestream/pages/director.dart';
import 'package:livestream/pages/participant.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _channelName = TextEditingController();
  final _userName = TextEditingController();
  late int uid = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserUID();
  }

  Future<void> getUserUID() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int? storeUid = sharedPreferences.getInt("localUid");
    if(storeUid != null){
      uid = storeUid;
      print("storeUid: $uid");
    }else{
      int time = DateTime.now().millisecondsSinceEpoch;
      uid - int.parse(time.toString().substring(1,time.toString().length-3));
      sharedPreferences.setInt("localUid", uid);
      print("settingUid: $uid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/sos.png"),
            const SizedBox(height: 5,),
            const Text("Multi Streaming with Friends",style: TextStyle(fontSize: 20),),
            const SizedBox(height: 40,),
            SizedBox(
                width: MediaQuery.of(context).size.width*0.85,
                child: TextField(
                  controller: _userName,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.grey)
                    ),
                    hintText: 'User Name'
                  ),
                )),
            const SizedBox(height: 8,),
            SizedBox(
                width: MediaQuery.of(context).size.width*0.85,
                child: TextField(
                  controller: _channelName,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.grey)
                      ),
                      hintText: 'Channel Name'
                  ),
                )),
            const SizedBox(height: 8,),
            TextButton(
                onPressed: () async {
                  await [Permission.camera,Permission.microphone].request();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context)=>Participant(
                        channelName: _channelName.text,uid: uid,userName: _userName.text,)));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Participant  ',
                      style: TextStyle(fontSize: 20),),
                    Icon(Icons.live_tv)
                  ],
                )),
            TextButton(
                onPressed: () async{
                  await [Permission.camera,Permission.microphone].request();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const Director()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Director  ',
                      style: TextStyle(fontSize: 20),),
                    Icon(Icons.cut)
                  ],
                )),
          ],
        ),
      ),
    );
  }

}
