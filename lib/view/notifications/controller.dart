import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:finderex/controllers/token_controller.dart';
import 'package:finderex/controllers/token_storage.dart';
import 'package:finderex/models/mock_notification_model.dart';
import 'package:finderex/models/notification_category_model.dart';
import 'package:finderex/view/login/controller.dart';
import 'package:finderex/view/notifications/view.dart';
import 'package:finderex/view/splash/view.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NotificationController extends GetxController {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Map<int, List<MockNotificationModel>> categoryCache = {};
  late PageController pageController;
  ScrollController scrollController = ScrollController();
  RxInt selectedIndex = 0.obs;
  RxInt currentPage = 1.obs;
  final RxList<NotificationCategoryModel> categories =
      <NotificationCategoryModel>[].obs;
  RxList<MockNotificationModel> modelList = <MockNotificationModel>[].obs;
  var activeCategory = Rx<NotificationCategoryModel?>(null);
  final RxList<MockNotificationModel> currentPageItems =
      <MockNotificationModel>[].obs;
  final RxList<bool> tabStates = <bool>[].obs;
  final RxList<List<MockNotificationModel>> categoryNotifications =
      <List<MockNotificationModel>>[].obs;
  final StreamController<List<NotificationCategoryModel>>
      _categoriesStreamController =
      StreamController<List<NotificationCategoryModel>>.broadcast();
  final androidChannel = const AndroidNotificationChannel(
    "@string/default_channel_id",
    "Important Notifications",
    description: "This channel is used for important notifications",
    importance: Importance.defaultImportance,
  );
  Stream<List<NotificationCategoryModel>> get categoriesStream =>
      _categoriesStreamController.stream;

  NotificationController() {
    pageController = PageController();
  }

  // String token =
  //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTQwNSwic291cmNlIjoib3RoZXIiLCJzZXNzaW9uIjoiYzUxYjZjYmQtYzExNi0xMWVlLTg3ODMtZDYzMTdmMzAxYThkIiwiZXhwIjoxODE1NjY1NDAzLCJpYXQiOjE3MDY4MDE0MDN9.GTdnhBpVjps2PtnIxAf0VbWjyjViangK5HE3ARAvLcI";

  String baseURL = 'https://democore.finderex.io/v1/notifications';
  @override
  void onInit() async {
    // await getToken();
    permissionRequest();
    fetchAndSetCategories();
    // fetchNotifications(1);
    super.onInit();
  }

  Future<void> cikisYap(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Çıkış yapmak istiyor musunuz ?"),
        content: Row(
          children: [
            ElevatedButton(
              onPressed: () async {
                await TokenStorage.removeSession();
                await TokenStorage.removeToken();
                Get.offAll(
                  Splash(),
                );
              },
              child: Text("Evet"),
            ),
            ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("Hayır"))
          ],
        ),
      ),
    );
  }

  // changePage metodunu güncelleyin
  void changePage(int pageIndex) {
    pageController.jumpToPage(pageIndex);
    currentPage.value = pageIndex;
  }

  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  void changeTabIndex(int index) {
    updateSelectedIndex(index);
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void permissionRequest() async {
    final fcm = FirebaseMessaging.instance;
    fcm.requestPermission();
    final token = await fcm.getToken();
    log("Token: $token");
  }

  // Future<String?> getToken() async {
  //   try {
  //     var sp = await SharedPreferences.getInstance();
  //     token = sp.getString(TokenStorage.sTokenKey);
  //     if (token != null && token!.isNotEmpty) {
  //       return token;
  //     } else {
  //       // Handle the case when the token is not available
  //       log('Token not found in SharedPreferences');
  //       return null;
  //     }
  //   } catch (e) {
  //     // Handle exceptions, such as SharedPreferences not being available
  //     log('Error while getting token from SharedPreferences: $e');
  //     return null;
  //   }
  // }

  Future<String> fetchCategories() async {
    var sp = await SharedPreferences.getInstance();
    final url =
        Uri.parse('https://democore.finderex.io/v1/notifications/categories/');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${sp.getString(TokenStorage.sTokenKey)}',
        'X-Lang-Code': 'tr',
      },
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load notifications');
    }
  }

  Future<void> fetchAndSetCategories() async {
    try {
      final String responseData = await fetchCategories();
      final Map<String, dynamic> data =
          json.decode(utf8.decode(responseData.codeUnits));

      if (data['error'] == false) {
        final List<dynamic> categoriesData = data['data'];

        List<NotificationCategoryModel> updatedCategories =
            categoriesData.map((category) {
          bool isActive = category['is_active'] ?? false;
          tabStates.add(isActive); // Tab durumunu ekleyin
          return NotificationCategoryModel(
            name: category['name'] ?? '',
            langCode: category['lang_code'] ?? '',
            isActive: isActive,
            catId: category['cat_id'] ?? 0,
          );
        }).toList();

        categories.assignAll(updatedCategories);

        // Yeni eklenen kısım
        _categoriesStreamController.add(updatedCategories);
        // Yeni eklenen kısım son
      } else {
        log('API Hata: ${data['message']}');
      }
    } catch (error) {
      log('Hata: $error');
    }
  }

  Future<void> _showNotification(MockNotificationModel notification) async {
    await flutterLocalNotificationsPlugin.show(
      notification.id.hashCode,
      notification.title,
      notification.content,
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidChannel.id,
          androidChannel.name,
          channelDescription: androidChannel.description,
          icon: "@drawable/ic_launcher",
        ),
      ),
      payload: notification.id, // Örneğin sadece id'yi payload olarak ekledik
    );
  }

  Future<List<MockNotificationModel>> fetchNotifications(int category) async {
    var sp = await SharedPreferences.getInstance();
    if (categoryCache.containsKey(category)) {
      // Kategori zaten önbellekte varsa, önbellekten veriyi al
      return categoryCache[category]!;
    }

    try {
      final response = await http.get(
        Uri.parse(
            'https://democore.finderex.io/v1/notifications?cid=$category'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${sp.getString(TokenStorage.sTokenKey)}',
          'X-Lang-Code': 'tr',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData =
            json.decode(utf8.decode(response.body.codeUnits))['data'];

        List<MockNotificationModel> notifications = jsonData
            .map((json) => MockNotificationModel.fromJson(json))
            .toList();

        // Kategorilere göre ayırın
        if (categoryNotifications.length <= category) {
          categoryNotifications.add(notifications);
        } else {
          categoryNotifications[category] = notifications;
        }

        update(); // Sayfa değiştikçe güncelleme yap

        // Bildirim gösterme işlemi
        for (var notification in notifications) {
          _showNotification(notification);
        }

        // Önbelleğe al
        categoryCache[category] = notifications;

        return notifications;
      } else {
        print("Server Response: ${response.body}");
        throw Exception('Failed to load notifications');
      }
    } catch (error) {
      print("Request Error: $error");
      throw Exception('Request failed');
    }
  }

  void updateCurrentPageItems() {
    currentPageItems.clear();

    if (currentPage.value < categoryNotifications.length) {
      currentPageItems.addAll(categoryNotifications[currentPage.value]);
    }
  }

  var pages = [
    // NotificationColumn(categoryFilter: 0),
    // NotificationColumn(categoryFilter: 1),
    // NotificationColumn(categoryFilter: 2),
    // NotificationColumn(categoryFilter: 3),
    NotificationColumn(categoryFilter: 0),
    NotificationColumn(categoryFilter: 1),
    NotificationColumn(categoryFilter: 2),
    NotificationColumn(categoryFilter: 3),
  ];
}
