import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VideoStreamingController extends GetxController {
  TextEditingController liveIdController = TextEditingController(
    text: Random().nextInt(900000 + 100000).toString(),
  );

  var userIdentification = "".obs;
}
