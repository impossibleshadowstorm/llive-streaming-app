import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:live_streaming/Controllers/userController.dart';
import 'package:live_streaming/Screens/liveStreamingPage.dart';

class NewUsersFinal extends StatefulWidget {
  const NewUsersFinal({Key? key}) : super(key: key);

  @override
  State<NewUsersFinal> createState() => _NewUsersFinalState();
}

class _NewUsersFinalState extends State<NewUsersFinal> {
  UserController userController = Get.find();

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    final String userID = Random().nextInt(900000 + 100000).toString();
    userController.userIdentification.value = userID;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: StreamBuilder<QuerySnapshot>(
            stream: _usersStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Live Streaming Shopping",
                          textAlign: TextAlign.start,
                          style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.052,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            jumpToLivePage(context,
                                liveID: userController.userIdController.text,
                                isHost: true);
                          },
                          child: Container(
                            height: 40,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            color: Colors.black,
                            child: const Center(
                              child: Text(
                                "Go Live",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    height: (snapshot.data!.docs.length / 3 * 150) + 100,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 0.0,
                        mainAxisSpacing: 19.0,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        if (snapshot.data!.docs[index]["id"] !=
                            userController.userIdController.text) {
                          return InkWell(
                            onTap: () {
                              jumpToLivePage(context,
                                  liveID: snapshot.data!.docs[index]["id"],
                                  isHost: false);
                            },
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: snapshot.data!.docs[index]["online"]
                                        ? Colors.green
                                        : Colors.transparent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Container(
                                    height: 90,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: NetworkImage(snapshot
                                            .data!.docs[index]["image"]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  snapshot.data!.docs[index]["id"],
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: snapshot.data!.docs[index]["online"]
                                      ? Colors.green
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                ),
                                child: Container(
                                  height: 90,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          snapshot.data!.docs[index]["image"]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                snapshot.data!.docs[index]["id"],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
            future: FirebaseFirestore.instance.collection("users").get(),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Live Streaming Shopping",
                            textAlign: TextAlign.start,
                            style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.052,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              jumpToLivePage(context,
                                  liveID: userController.userIdController.text,
                                  isHost: true);
                            },
                            child: Container(
                              height: 40,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              color: Colors.black,
                              child: const Center(
                                child: Text(
                                  "Go Live",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      height: (snapshot.data!.docs.length / 3 * 150) + 100,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.docs.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 0.0,
                          mainAxisSpacing: 19.0,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          if (snapshot.data!.docs[index]["id"] !=
                              userController.userIdController.text) {
                            return InkWell(
                              onTap: () {
                                jumpToLivePage(context,
                                    liveID: snapshot.data!.docs[index]["id"],
                                    isHost: false);
                              },
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: snapshot.data!.docs[index]
                                              ["online"]
                                          ? Colors.green
                                          : Colors.transparent,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Container(
                                      height: 90,
                                      width: 90,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: NetworkImage(snapshot
                                              .data!.docs[index]["image"]),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    snapshot.data!.docs[index]["id"],
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: snapshot.data!.docs[index]["online"]
                                        ? Colors.green
                                        : Colors.transparent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Container(
                                    height: 90,
                                    width: 90,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: NetworkImage(snapshot
                                            .data!.docs[index]["image"]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  snapshot.data!.docs[index]["id"],
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ],
                );
              }
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  jumpToLivePage(BuildContext context,
      {required String liveID, required bool isHost}) {
    print(liveID);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LivePage(
          liveId: liveID,
          isHost: isHost,
        ),
      ),
    );
  }
}
