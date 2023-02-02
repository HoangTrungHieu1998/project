import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtm/agora_rtm.dart';
import 'package:flutter/material.dart';
import 'package:livestream/utils/appid.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

class Participant extends StatefulWidget {
  final String channelName;
  final String userName;
  final int uid;

  const Participant({Key? key, required this.channelName, required this.userName,required this.uid}) : super(key: key);

  @override
  State<Participant> createState() => _ParticipantState();
}

class _ParticipantState extends State<Participant> {
  List<int> _user =[];
  late RtcEngine _rtcEngine;
  AgoraRtmClient? _client;
  AgoraRtmChannel? _channel;
  bool muted = false;
  bool videoDisable = false;



  Future<void> initializeAgora() async{
    _rtcEngine = await RtcEngine.createWithContext(RtcEngineContext(appId));
    _client = await AgoraRtmClient.createInstance(appId);
    await _rtcEngine.enableVideo();
    await _rtcEngine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _rtcEngine.setClientRole(ClientRole.Broadcaster);

    // Callback for the rtc engine
    _rtcEngine.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (channel, uid, elapsed){
        setState(() {
          _user.add(uid);
        });
      },
      leaveChannel: (stats){
        setState(() {
          _user.clear();
        });
      }
    ));

    // Call back for the rtm client
    _client?.onMessageReceived = (AgoraRtmMessage message, String peerId){
      print("Private message from " +peerId+":"+ (message.text));
    };
    _client?.onConnectionStateChanged = (int state, int reason){
      print("Connection state change " +state.toString()+", reason:"+ reason.toString());
      if(state == 5){
        _channel?.leave();
        _client?.logout();
        _client?.destroy();
        print("Logged out");
      }
    };

    //Join the rtm and rtc channel
    await _client?.login(token, widget.uid.toString());
    _channel = await _client?.createChannel(widget.channelName);
    await _channel?.join();
    await _rtcEngine.joinChannel(null, widget.channelName, null, widget.uid);

    // Call back for the rtm channel
    _channel?.onMemberJoined =(AgoraRtmMember member){
      print("Member join: "+member.userId+", channel: "+member.channelId);
    };
    _channel?.onMemberLeft = (AgoraRtmMember member){
      print("Member left: "+member.userId+", channel: "+member.channelId);
    };
    _channel?.onMessageReceived = (AgoraRtmMessage message, AgoraRtmMember fromMember){
      print("Public message from "+fromMember.userId +": "+message.text);
    };


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeAgora();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _user.clear();
    _rtcEngine.leaveChannel();
    _rtcEngine.destroy();
    _channel?.leave();
    _client?.logout();
    _client?.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            _broadcastView(),
            _toolbar()
          ],
        ),
      ),
    );
  }

  Widget _broadcastView() {
    if(_user.isEmpty){
      return const Center(
        child: Text("No Users"),
      );
    }
    return const Expanded(
      child: RtcLocalView.SurfaceView(),
    );
  }

  Widget _toolbar() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
              onPressed: ()=>_onToggleMute(),
              child: Icon(
                  muted ? Icons.mic_off:Icons.mic,
                  color: muted? Colors.white : Colors.blueAccent,
                  size: 20,
              ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: muted? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12),
          ),
          RawMaterialButton(
              onPressed: ()=>_onCallEnd(context),
              child: const Icon(
                  Icons.call_end,
                  color: Colors.white,
                  size: 35,
              ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.redAccent,
            padding: const EdgeInsets.all(12),
          ),
          RawMaterialButton(
              onPressed: ()=>_onToggleVideoDisable(),
              child: const Icon(
                  Icons.videocam,
                  color: Colors.blueAccent,
                  size: 20,
              ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12),
          ),
          RawMaterialButton(
              onPressed: ()=>_onSwitchCamera(),
              child: const Icon(
                  Icons.switch_camera,
                  color: Colors.blueAccent,
                  size: 20,
              ),
            shape: const CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12),
          ),
        ],
      ),
    );
  }

  void _onToggleMute(){
    setState(() {
      muted = !muted;
    });
    _rtcEngine.muteLocalAudioStream(muted);
  }
  void _onToggleVideoDisable(){
    setState(() {
      videoDisable = !videoDisable;
    });
    _rtcEngine.muteLocalVideoStream(videoDisable);
  }
  void _onSwitchCamera(){
    _rtcEngine.switchCamera();
  }

  void _onCallEnd(BuildContext context){
    Navigator.of(context).pop();
  }
}

