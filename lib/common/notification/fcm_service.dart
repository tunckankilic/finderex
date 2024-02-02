import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:finderex/controllers/token_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FCMService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final androidChannel = const AndroidNotificationChannel(
    "@string/default_channel_id",
    "Important Notifications",
    description: "This channel is used for important notifications",
    importance: Importance.defaultImportance,
  );

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    log("FCM Token: $fcmToken");
  }

  // Future initLocalNotifications() async {
  //   const ios = DarwinInitializationSettings();
  //   const android = AndroidInitializationSettings("@drawable/ic_launcher");
  //   const settings = InitializationSettings(android: android, iOS: ios);
  //   await flutterLocalNotificationsPlugin.initialize(
  //     settings,
  //     onDidReceiveBackgroundNotificationResponse: (payload) {
  //       final message = RemoteMessage.fromMap(jsonDecode(payload as String));
  //       handleBackgroundMessage(message);
  //     },
  //   );
  //   final platform =
  //       flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>();
  //   await platform?.createNotificationChannel(androidChannel);
  // }

  Future initPushNotifications() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> setupFCM() async {
    await _firebaseMessaging.requestPermission();
    final token = await _firebaseMessaging.getToken();
    log("Token: $token");
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    initPushNotifications();
    // initLocalNotifications();
    // FCM token'ını dinleme
    _firebaseMessaging.onTokenRefresh.listen((String? newToken) {
      log("New FCM Token: $newToken");
      // Yeni token'ı sunucuya gönderme (isteğe bağlı)
    });

    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Uygulama açıkken gelen bildirimleri dinleme
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("Received message: ${message.notification?.title}");
      final notification = message.notification;
      if (notification == null) return;
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
              androidChannel.id, androidChannel.name,
              channelDescription: androidChannel.description,
              icon: "@drawable/ic_launcher"),
        ),
        payload: jsonEncode(
          message.toMap(),
        ),
      );
    });

    // Uygulama arkaplanda veya kapalıyken gelen bildirimleri dinleme
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log("Opened app from notification: ${message.notification?.title}");
    });

    // Uygulama kapalıyken gelen bildirimden açılma durumunu kontrol etme
    final RemoteMessage? initialMessage =
        await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      log("Opened app from notification: ${initialMessage.notification?.title}");
    }

    // FCM token'ını alma
    String? fcmToken = await _firebaseMessaging.getToken();
    log("FCM Token: $fcmToken");
    var sp = await SharedPreferences.getInstance();
    sp.getString(TokenStorage.sTokenKey) != null
        ? sendFCMTokenToServer(fcmToken!)
        : null;
    // FCM token'ını sunucuya gönderme (isteğe bağlı)
    // Bu adımda sunucunuza kullanıcının FCM token'ını gönderebilirsiniz.
    // Bu token'ı kullanarak kullanıcıya özgü bildirim gönderebilirsiniz.
  }

  Future<void> sendFCMTokenToServer(String fcmToken) async {
    // Sunucunuzun API endpoint'i
    const String apiUrl = 'https://demoauthv2.finderex.io/v2/user/fcm-token';
    var sp = await SharedPreferences.getInstance();
    var token = sp.getString(TokenStorage.sTokenKey);
    // Sunucuya gönderilecek veri
    final Map<String, dynamic> requestData = {
      "type_of": "mobile",
      "token": fcmToken,
      "is_act": true,
    };

    // HTTP POST isteği oluştur
    final http.Response response = await http
        .post(Uri.parse(apiUrl), body: json.encode(requestData), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });

    // Sunucudan dönen cevap
    if (response.statusCode == 200) {
      log('FCM token successfully sent to server.');
    } else {
      log('Failed to send FCM token to server. Status code: ${response.statusCode}');
    }
  }

  Future<void> handleBackgroundMessage(RemoteMessage message) async {
    log("Title: ${message.notification!.title}");
    log("Body: ${message.notification!.body}");
    log("Data: ${message.data}");
  }

  static Future<void> onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // Burada bildirim tıklanınca yapılacak işlemleri gerçekleştirebilirsiniz.
  }

  static Future<void> selectNotification(String payload) async {
    // Burada bildirim tıklanınca yapılacak işlemleri gerçekleştirebilirsiniz.
  }
}


  // static Future<void> initialize() async {
  //   const AndroidInitializationSettings initializationSettingsAndroid =
  //       AndroidInitializationSettings('@mipmap/ic_launcher');
  //   const initializationSettingsIOS = DarwinInitializationSettings(
  //       onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  //   InitializationSettings initializationSettings =
  //       const InitializationSettings(
  //           android: initializationSettingsAndroid,
  //           iOS: initializationSettingsIOS);
  //   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  // }

  // static Future<void> showNotification(String title, String body) async {
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails(
  //     channelId,
  //     channelName,
  //     importance: Importance.max,
  //     priority: Priority.high,
  //     showWhen: false,
  //   );
  //   const NotificationDetails platformChannelSpecifics =
  //       NotificationDetails(android: androidPlatformChannelSpecifics);
  //   await flutterLocalNotificationsPlugin.show(
  //     0,
  //     title,
  //     body,
  //     platformChannelSpecifics,
  //     payload: 'Default_Sound',
  //   );
  // }
