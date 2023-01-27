import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:live_streaming/Screens/newUsersFinal.dart';

class UserController extends GetxController {
  var userId = {
    "123456": "Raju Rai",
    "234567": "Shivam Singh",
    "345678": "Shivaay Oberoi",
    "456789": "Anil Gupta",
    "567890": "Anshika Gupta",
    "122222": "Anwar Ali",
    "111111": "Sumit Saurav",
    "222222": "Kajal Patel",
    "333333": "Sandeep Srivastava",
    "444444": "Neel Patel",
    "555555": "Ritik Shankar",
    "666666": "Pramod Prasad",
    "777777": "brijmohan",
    "888888": "Ravi Yadav",
    "999999": "John Amanda",
    "000000": "Jhonny Prasad",
    "010101": "Sanoj Prasad",
  };

  TextEditingController userIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var userIdentification = "".obs;

  loginUser() {
    if (userId.containsKey(userIdController.text) &&
        passwordController.text == "1234") {
      // Get.to(() => const AllUsers());
      Get.to(() => const NewUsersFinal());
    } else {}
  }

  setOnline(String id) {
    var collection = FirebaseFirestore.instance.collection('users');
    collection.doc(id).update({"online": true});
  }

  setOffline(String id) {
    var collection = FirebaseFirestore.instance.collection('users');
    collection.doc(id).update({"online": false});
  }
}
