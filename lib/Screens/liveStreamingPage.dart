import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:live_streaming/Controllers/userController.dart';
import 'package:live_streaming/Controllers/videoStreamingController.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

class LivePage extends StatefulWidget {
  final String liveId;
  final bool isHost;

  LivePage({
    Key? key,
    required this.liveId,
    this.isHost = false,
  }) : super(key: key);

  @override
  State<LivePage> createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  VideoStreamingController videoStreamingController = Get.find();

  UserController userController = Get.find();

  final int appID = int.parse(dotenv.get('ZEGO_APP_ID'));

  final String appSign = dotenv.get('ZEGO_APP_SIGN');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isHost) {
      userController.setOnline(widget.liveId);
    }
    print("initil");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (widget.isHost) {
      userController.setOffline(widget.liveId);
    }
    print("disposed");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveStreaming(
        appID: appID,
        appSign: appSign,
        userID: userController.userIdentification.value,
        userName: "user_${userController.userIdentification.value}",
        liveID: widget.liveId,
        config: widget.isHost
            ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
            : ZegoUIKitPrebuiltLiveStreamingConfig.audience()
          ..audioVideoViewConfig.showAvatarInAudioMode = true
          ..audioVideoViewConfig.showSoundWavesInAudioMode = true,
      ),
    );
  }
}
