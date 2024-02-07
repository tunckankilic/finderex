import 'dart:developer';

import 'package:finderex/src/onboarding/state.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  final state = OnboardingState();
  OnboardingController();
  PageController pageController =
      PageController(initialPage: 0, keepPage: false, viewportFraction: 1);

  List<SizedBox> pictures = [
    SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Image.asset(
        "images/onboarding/giris1.png",
        fit: BoxFit.cover,
      ),
    ),
    SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Image.asset(
        "images/onboarding/giris2.png",
        fit: BoxFit.cover,
      ),
    ),
    SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Image.asset(
        "images/onboarding/giris3.png",
        fit: BoxFit.cover,
      ),
    ),
    SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Image.asset(
        "images/onboarding/giris4.png",
        fit: BoxFit.cover,
      ),
    ),
  ];

  changePage(int index) async {
    state.index.value = index;
  }

  permissionRequest() async {
    final fcm = FirebaseMessaging.instance;
    fcm.requestPermission();
    final token = await fcm.getToken();
    log("Token: $token");
  }

  @override
  void onReady() {
    permissionRequest();
    super.onReady();
  }
}
