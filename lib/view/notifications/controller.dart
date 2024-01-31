import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  permissionRequest() async {
    final fcm = FirebaseMessaging.instance;
    fcm.requestPermission();
    final token = await fcm.getToken();
    log("Token: $token");
  }

  // @override
  // void onReady() {
  //   permissionRequest();
  //   super.onReady();
  // }
}
