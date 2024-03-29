import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

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

  final NotificationDetails androidNotificationDetails =
      const NotificationDetails(
    android: AndroidNotificationDetails(
      '@string/default_channel_id',
      'Important Notifications',
      channelDescription: 'This channel is used for important notifications',
      importance: Importance.defaultImportance,
    ),
  );

  static Future<void> onDidReceiveBackgroundNotificationResponse(
    NotificationResponse response,
  ) async {
    // final int id = response.id ?? 0;
    // final String? title = response.payload;
    // final String? body = response.payload;
    final String? payload = response.payload;

    if (payload != null) {
      await selectNotification(payload);
    }
  }

  Future<void> initialize() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();

    final InitializationSettings initializationSettings =
        const InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    // Bildirim kanalınızı ekleyin
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);

    // Bildirimlerinizi göstermek için initialize işlemini gerçekleştirin
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        final String? payload = response.payload;
        if (payload != null) {
          selectNotification(payload);
        }
      },
      onDidReceiveBackgroundNotificationResponse:
          FCMService.onDidReceiveBackgroundNotificationResponse,
    );

    // Örneğin: Periodik bir bildirim ekleyin
    await flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      'Periodic Title',
      'Periodic Body',
      RepeatInterval.hourly,
      androidNotificationDetails,
    );
  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    log("FCM Token: $fcmToken");
  }

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

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("Received message: ${message.notification?.title}");
      final notification = message.notification;
      if (notification == null) return;

      // API'den gelen bildirimin içindeki title ve body'yi kullanarak bildirim göster
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
    final tokenBox = await Hive.openBox<String>('tokenBox');
    final String? bToken = tokenBox.get('token');
    bToken != null ? sendFCMTokenToServer(fcmToken!) : null;
    // FCM token'ını sunucuya gönderme (isteğe bağlı)
    // Bu adımda sunucunuza kullanıcının FCM token'ını gönderebilirsiniz.
    // Bu token'ı kullanarak kullanıcıya özgü bildirim gönderebilirsiniz.
  }

  Future<void> sendFCMTokenToServer(String fcmToken) async {
    // Hive kutularını aç
    final tokenBox = await Hive.openBox<String>('tokenBox');
    final String? token = tokenBox.get('token');

    // Sunucunuzun API endpoint'i
    const String apiUrl = 'https://demoauthv2.finderex.io/v2/user/fcm-token';

    // Sunucuya gönderilecek veri
    final Map<String, dynamic> requestData = {
      "type_of": "mobile",
      "token": fcmToken,
      "is_act": true,
    };

    // HTTP POST isteği oluştur
    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      body: json.encode(requestData),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    // Sunucudan dönen cevap
    if (response.statusCode == 200) {
      print('FCM token successfully sent to server.');
    } else {
      print(
          'Failed to send FCM token to server. Status code: ${response.statusCode}');
    }
  }

  // Future<void> sendFCMTokenToServer(String fcmToken) async {
  //   // Sunucunuzun API endpoint'i
  //   const String apiUrl = 'https://demoauthv2.finderex.io/v2/user/fcm-token';
  //   var sp = await SharedPreferences.getInstance();
  //   var token = sp.getString(TokenStorage.sTokenKey);
  //   // Sunucuya gönderilecek veri
  //   final Map<String, dynamic> requestData = {
  //     "type_of": "mobile",
  //     "token": fcmToken,
  //     "is_act": true,
  //   };

  //   // HTTP POST isteği oluştur
  //   final http.Response response = await http
  //       .post(Uri.parse(apiUrl), body: json.encode(requestData), headers: {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $token',
  //   });

  //   // Sunucudan dönen cevap
  //   if (response.statusCode == 200) {
  //     log('FCM token successfully sent to server.');
  //   } else {
  //     log('Failed to send FCM token to server. Status code: ${response.statusCode}');
  //   }
  // }

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
