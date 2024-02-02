import 'dart:developer';
import 'package:finderex/common/notification/fcm_service.dart';
import 'package:finderex/controllers/token_storage.dart';
import 'package:finderex/view/login/view.dart';
import 'package:finderex/view/notifications/view.dart';
import 'package:finderex/view/onboarding/bindings.dart';
import 'package:finderex/view/onboarding/view.dart';
import 'package:finderex/view/splash/view.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  log('Handling a background message ${message.messageId}');
  log("Title: ${message.notification!.title}");
  log("Body: ${message.notification!.body}");
  log("Data: ${message.data}");
  // Create a notification for this
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Background Message Handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FCMService().setupFCM();
  await TokenStorage.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: const Splash(),
        initialBinding: OnboardingBinding(),
      ),
    );
  }
}
