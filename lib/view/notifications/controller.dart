import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:finderex/controllers/token_storage.dart';
import 'package:finderex/models/mock_notification_model.dart';
import 'package:finderex/models/notification_category_model.dart';
import 'package:finderex/view/notifications/view.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class NotificationController extends GetxController {
  late PageController pageController;
  ScrollController scrollController = ScrollController();
  RxInt selectedIndex = 0.obs;
  RxInt currentPage = 1.obs;
  final RxList<NotificationCategoryModel> categories =
      <NotificationCategoryModel>[].obs;
  RxList<MockNotificationModel> modelList = <MockNotificationModel>[].obs;
  var activeCategory = Rx<NotificationCategoryModel?>(null);
  final RxList<Widget> currentPageItems = <Widget>[].obs;
  final RxList<bool> tabStates = <bool>[].obs;
  final RxList<MockNotificationModel> category0Notifications =
      <MockNotificationModel>[].obs;
  final RxList<MockNotificationModel> category1Notifications =
      <MockNotificationModel>[].obs;
  final RxList<MockNotificationModel> category2Notifications =
      <MockNotificationModel>[].obs;
  final RxList<MockNotificationModel> category3Notifications =
      <MockNotificationModel>[].obs;
  String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTQwNSwic291cmNlIjoib3RoZXIiLCJzZXNzaW9uIjoiYzUxYjZjYmQtYzExNi0xMWVlLTg3ODMtZDYzMTdmMzAxYThkIiwiZXhwIjoxODE1NjY1NDAzLCJpYXQiOjE3MDY4MDE0MDN9.GTdnhBpVjps2PtnIxAf0VbWjyjViangK5HE3ARAvLcI";

  String baseURL = 'https://democore.finderex.io/v1/notifications';
  @override
  void onInit() {
    permissionRequest();
    pageController = PageController();
    fetchAndSetCategories();
    fetchNotifications(1);
    super.onInit();
  }

  // changePage metodunu güncelleyin
  void changePage(int pageIndex) {
    currentPage.value = pageIndex;
    update(); // Sayfa değiştikçe güncelleme yap
    updateCurrentPageItems(); // Sayfa değiştikçe item'ları güncelle
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

  Future<String> fetchCategories() async {
    final url =
        Uri.parse('https://democore.finderex.io/v1/notifications/categories/');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
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

        categories.assignAll(categoriesData.map((category) {
          bool isActive = category['is_active'] ?? false;
          tabStates.add(isActive); // Tab durumunu ekleyin
          return NotificationCategoryModel(
            name: category['name'] ?? '',
            langCode: category['lang_code'] ?? '',
            isActive: isActive,
            catId: category['cat_id'] ?? 0,
          );
        }).toList());
      } else {
        log('API Hata: ${data['message']}');
      }
    } catch (error) {
      log('Hata: $error');
    }
  }

  Future<List<MockNotificationModel>> fetchNotifications(int category) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://democore.finderex.io/v1/notifications?cid=$category'),
        headers: {
          'Authorization': 'Bearer $token',
          'X-Lang-Code': 'tr',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData =
            json.decode(utf8.decode(response.body.codeUnits))['data'];
        // log(jsonData.toString());
        List<MockNotificationModel> notifications = jsonData
            .map((json) => MockNotificationModel.fromJson(json))
            .toList();
        for (int i = 0; i < notifications.length; i++) {
          log(notifications[i].title);
        }
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

  // Future<String> fetchNotifications(int category) async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse(
  //           'https://democore.finderex.io/v1/notifications?cid=$category'),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'X-Lang-Code': 'tr',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       return response.body;
  //     } else {
  //       print("Server Response: ${response.body}");
  //       throw Exception('Failed to load notifications');
  //     }
  //   } catch (error) {
  //     print("Request Error: $error");
  //     throw Exception('Request failed');
  //   }
  // }

  // Bu metod ile sayfa değiştiğinde currentPageItems güncellenecek
  void updateCurrentPageItems() {
    currentPageItems.clear(); // Mevcut listeyi temizle

    // // Yeni elemanları ekle
    // for (int i = 0; i < 5; i++) {
    //   currentPageItems.add(NotificationOption());
    // }
  }

  // Future<List<MockNotificationModel>> fetchNotifications(
  //     int categoryFilter) async {
  //   final String url = '$baseURL?cid=$categoryFilter';

  //   try {
  //     final response = await http.get(
  //       Uri.parse(url),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'X-Lang-Code': 'tr',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       final List<dynamic> jsonData = json.decode(response.body)['data'];

  //       List<MockNotificationModel> notifications = jsonData
  //           .map((json) => MockNotificationModel.fromJson(json))
  //           .toList();

  //       return notifications;
  //     } else {
  //       throw Exception('Failed to load notifications');
  //     }
  //   } catch (error) {
  //     log('Error: $error');
  //     throw Exception('Failed to load notifications');
  //   }
  // }

  // Future<void> fetchAndSetNotifications(int categoryFilter) async {
  //   try {
  //     List<MockNotificationModel> result =
  //         await fetchNotifications(categoryFilter);

  //     // İlgili kategoriye göre listeyi güncelle
  //     switch (categoryFilter) {
  //       case 0:
  //         category0Notifications.assignAll(result);
  //         break;
  //       case 1:
  //         category1Notifications.assignAll(result);
  //         break;
  //       case 2:
  //         category2Notifications.assignAll(result);
  //         break;
  //       case 3:
  //         category3Notifications.assignAll(result);
  //         break;
  //       default:
  //         break;
  //     }
  //   } catch (error) {
  //     // Hata durumunu ele al
  //     print('Error fetching notifications: $error');
  //   }
  // }

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


  // RxList<MockNotificationModel> getCombinedList() {
  //   return Rx.combineLatestList<MockNotificationModel>(streams);
  // }
  // Future<void> fetchDataForPage(int pageIndex) async {
  //   // Verileri çek
  //   List<MockNotificationModel> fetchedData =
  //       await fetchNotificationsForPageIndex(pageIndex);

  //   // Model listesini güncelle
  //   modelList.assignAll(fetchedData);

  //   // Sayfa değiştiğinde güncelleme yap
  //   updateCurrentPageItems();
  // }

  // Future<List<MockNotificationModel>> fetchNotificationsForPageIndex(
  //     int pageIndex) async {
  //   try {
  //     // Veriyi çekme işlemleri burada gerçekleştirilecek
  //     // Örneğin: API isteği ile veriyi çekme
  //     // Bu örnek fonksiyonunuzu projenize uygun şekilde güncelleyin
  //     String apiUrl = 'https://example.com/api/notifications?page=$pageIndex';
  //     final response = await http.get(
  //       Uri.parse(apiUrl),
  //       headers: {
  //         'Authorization': 'Bearer YOUR_BEARER_TOKEN',
  //         'X-Lang-Code': 'tr',
  //       },
  //     );

  //     if (response.statusCode == 200) {
  //       final List<dynamic> jsonData = json.decode(response.body)['data'];

  //       return jsonData
  //           .map((json) => MockNotificationModel.fromJson(json))
  //           .toList();
  //     } else {
  //       throw Exception('Failed to load notifications');
  //     }
  //   } catch (error) {
  //     throw Exception('Error fetching notifications: $error');
  //   }
  // }

  // @override
  // void onClose() {
  //   // StreamController'ları kapat
  //   streamController1.close();
  //   streamController2.close();
  //   streamController3.close();
  //   streamController4.close();
  //   super.onClose();
  // }


  // Future<Stream<List<MockNotificationModel>>> nFetchNotifications() async {
  //   // Kategori 0: Tüm bildirimler
  //   Stream<List<MockNotificationModel>> streamAll = _fetchNotifications(0);

  //   // Kategori 1: notify_category değeri 1 olanlar
  //   Stream<List<MockNotificationModel>> streamCategory1 =
  //       _fetchNotifications(1);

  //   // Kategori 2: notify_category değeri 2 olanlar
  //   Stream<List<MockNotificationModel>> streamCategory2 =
  //       _fetchNotifications(2);

  //   // Kategori 3: notify_category değeri 3 olanlar
  //   Stream<List<MockNotificationModel>> streamCategory3 =
  //       _fetchNotifications(3);

  //   // İlgili kategoriye göre stream'leri döndür
  //   return StreamZip([
  //     streamAll,
  //     streamCategory1,
  //     streamCategory2,
  //     streamCategory3,
  //   ]);
  // }


  // Future<Stream<List<MockNotificationModel>>> _fetchNotifications(
  //     int categoryFilter) async {
  //   late StreamController<List<MockNotificationModel>> controller;
  //   late StreamSubscription subscription;

  //   controller =
  //       StreamController<List<MockNotificationModel>>(onListen: () async {
  //     while (true) {
  //       try {
  //         final response = await http.get(
  //           Uri.parse('$notificationURL&category_id=$categoryFilter'),
  //           headers: {
  //             'Authorization': 'Bearer YOUR_BEARER_TOKEN',
  //             "X-Lang-Code": "tr",
  //           },
  //         );

  //         if (response.statusCode == 200) {
  //           final List<dynamic> jsonData = json.decode(response.body)['data'];

  //           // Filtreleme işlemi
  //           List<MockNotificationModel> filteredNotifications = jsonData
  //               .map((json) => MockNotificationModel.fromJson(json))
  //               .where((notification) =>
  //                   categoryFilter == 0 ||
  //                   notification.notify_category == categoryFilter)
  //               .toList();

  //           // Veriyi stream'e ekleyerek döndür
  //           controller.add(filteredNotifications);
  //         } else {
  //           throw Exception('Failed to load notifications');
  //         }
  //       } catch (e) {
  //         print('Error: $e');
  //       }

  //       // Belirli bir süre bekleyerek tekrar isteği yap
  //       await Future.delayed(Duration(seconds: 30));
  //     }
  //   }, onCancel: () {
  //     subscription.cancel();
  //   });

  //   subscription = controller.stream.listen((data) {});

  //   return controller.stream;
  // }


/*

  Future<void> _addDataToStream(
      StreamController<List<MockNotificationModel>> controller,
      int categoryFilter) async {
    while (true) {
      try {
        final response = await http.get(
          Uri.parse('$notificationURL&category_id=$categoryFilter'),
          headers: {
            'Authorization': 'Bearer YOUR_BEARER_TOKEN',
            "X-Lang-Code": "tr",
          },
        );

        if (response.statusCode == 200) {
          final List<dynamic> jsonData = json.decode(response.body)['data'];

          // Filtreleme işlemi
          List<MockNotificationModel> filteredNotifications = jsonData
              .map((json) => MockNotificationModel.fromJson(json))
              .where((notification) =>
                  categoryFilter == 0 ||
                  notification.notify_category == categoryFilter)
              .toList();

          // Veriyi stream'e ekleyerek döndür
          controller.add(filteredNotifications);
        } else {
          throw Exception('Failed to load notifications');
        }
      } catch (e) {
        log('Error: $e');
      }

      // Belirli bir süre bekleyerek tekrar isteği yap
      await Future.delayed(Duration(seconds: 30));
    }
  }


  // Future<List<MockNotificationModel>> fetchNotifications(
  //     int categoryFilter) async {
  //   final response = await http.get(
  //     Uri.parse(notificationURL),
  //     headers: {
  //       'Authorization': 'Bearer YOUR_BEARER_TOKEN',
  //       "X-Lang-Code": "tr",
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     final List<dynamic> jsonData = json.decode(response.body)['data'];

  //     // Filtreleme işlemi
  //     List<MockNotificationModel> filteredNotifications = jsonData
  //         .map((json) => MockNotificationModel.fromJson(json))
  //         .where((notification) =>
  //             categoryFilter == 0 ||
  //             notification.notify_category == categoryFilter)
  //         .toList();

  //     return filteredNotifications;
  //   } else {
  //     throw Exception('Failed to load notifications');
  //   }
  // }

  // late List<Stream<List<MockNotificationModel>>> streams;
  // late StreamController<List<MockNotificationModel>> streamController1;
  // late StreamController<List<MockNotificationModel>> streamController2;
  // late StreamController<List<MockNotificationModel>> streamController3;
  // late StreamController<List<MockNotificationModel>> streamController4;

 */