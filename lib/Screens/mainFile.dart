import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

import '../Controllers/videoStreamingController.dart';

// Generate userID with 6 digit length
final String userID = Random().nextInt(900000 + 100000).toString();

class HomePage extends StatelessWidget {
  HomePage({super.key});

  VideoStreamingController videoStreamingController = Get.find();

  // Generate Live Streaming ID with 6 digit length
  final liveIDController = TextEditingController(
    text: Random().nextInt(900000 + 100000).toString(),
  );

  @override
  Widget build(BuildContext context) {
    var buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: const Color(0xff034ada),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.35,
                child: LottieBuilder.asset(
                  "assets/golive_animations.json",
                ),
              ),
              const SizedBox(height: 80),
              Text(
                "User ID: ${videoStreamingController.userIdentification.value}",
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: videoStreamingController.liveIdController,
                decoration: const InputDecoration(
                  labelText: 'Enter ID to Join or Start a Live Stream',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  jumpToLivePage(context,
                      liveID: videoStreamingController.liveIdController.text,
                      isHost: true);
                },
                child: Container(
                  height: 50,
                  width: size.width,
                  color: Colors.black,
                  child: const Center(
                    child: Text(
                      'Go Live',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              // ElevatedButton(
              //   style: buttonStyle,
              //   child: const Text(''),
              //   onPressed: () {},
              // ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () {
                  jumpToLivePage(context,
                      liveID: videoStreamingController.liveIdController.text,
                      isHost: false);
                },
                child: Container(
                  height: 50,
                  width: size.width,
                  color: Colors.green,
                  child: const Center(
                    child: Text(
                      'Watch Live',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              // ElevatedButton(
              //   style: buttonStyle,
              //   child:
              //   onPressed: () {},
              // ),
            ],
          ),
        ),
      ),
    );
  }

  // Go to Live Page
  jumpToLivePage(BuildContext context,
      {required String liveID, required bool isHost}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LivePage(
          liveID: liveID,
          isHost: isHost,
        ),
      ),
    );
  }
}

// Live Page Prebuilt UI from ZEGOCLOUD UIKits
class LivePage extends StatelessWidget {
  final String liveID;
  final bool isHost;

  LivePage({
    super.key,
    required this.liveID,
    this.isHost = false,
  });

  // Read AppID and AppSign from .env file
  // Make sure you replace with your own
  final int appID = int.parse(dotenv.get('ZEGO_APP_ID'));
  final String appSign = dotenv.get('ZEGO_APP_SIGN');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveStreaming(
        appID: appID,
        appSign: appSign,
        userID: userID,
        userName: 'user_$userID',
        liveID: liveID,
        config: isHost
            ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
            : ZegoUIKitPrebuiltLiveStreamingConfig.audience()
          ..audioVideoViewConfig.showAvatarInAudioMode = true
          ..audioVideoViewConfig.showSoundWavesInAudioMode = true,
      ),
    );
  }
}
