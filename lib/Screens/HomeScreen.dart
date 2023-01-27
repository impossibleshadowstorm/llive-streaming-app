import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:live_streaming/Controllers/videoStreamingController.dart';
import 'package:live_streaming/Screens/liveStreamingPage.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  VideoStreamingController videoStreamingController = Get.find();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final String userID = Random().nextInt(900000 + 100000).toString();
    videoStreamingController.userIdentification.value = userID;
    print(videoStreamingController.userIdentification.value);

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
                  Get.to(() => LivePage(
                        liveId: videoStreamingController.liveIdController.text,
                        isHost: true,
                      ));
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
              const SizedBox(height: 16),
              InkWell(
                onTap: () {
                  Get.to(() => LivePage(
                      liveId: videoStreamingController.liveIdController.text));
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
            ],
          ),
        ),
      ),
    );
  }
}
