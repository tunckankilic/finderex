// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:finderex/models/mock_notification_model.dart';
import 'package:finderex/models/notification_category_model.dart';
import 'package:finderex/view/notifications/controller.dart';
import 'package:intl/intl.dart';

class NotificationView extends GetView<NotificationController> {
  NotificationView({super.key});
  final NotificationController controller = Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "images/login.png",
              ),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            NotificationTitle(),
            NotificationCategoryRow(),
            const NotificationColumnTitle(),
            SizedBox(
              height: 615.h,
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: controller.pages.length,
                onPageChanged: (index) {
                  controller.changePage(index);
                  controller.updateSelectedIndex(index);
                },
                itemBuilder: (context, index) {
                  return controller.pages[index];
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationTitle extends StatelessWidget {
  NotificationTitle({
    super.key,
  });
  NotificationController myController = Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 50.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Bildirimler",
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontSize: 24.sp),
          ),
          IconButton(
            onPressed: () {
              myController.cikisYap(context);
            },
            icon: Icon(
              Icons.close,
              size: 30.w,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationCategoryRow extends StatelessWidget {
  final NotificationController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF21212D),
      height: 60.h,
      width: double.infinity,
      child: Obx(
        () => SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(controller.categories.length, (index) {
              final category = controller.categories[index];
              final isActive = index == controller.currentPage.value;

              return NotificationTab(
                index: index,
                category: category,
                isActive:
                    index == controller.selectedIndex.value ? true : false,
                onTap: () {
                  controller.changePage(index);
                  log("index: $index");
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}

class NotificationOption extends StatelessWidget {
  final String title;
  final String content;
  final DateTime timestamp;

  const NotificationOption({
    Key? key,
    required this.title,
    required this.content,
    required this.timestamp,
  }) : super(key: key);

  String truncateText(String text, int maxLength) {
    return text.length > maxLength
        ? "${text.substring(0, maxLength)}..."
        : text;
  }

  @override
  Widget build(BuildContext context) {
    String formattedTimestamp =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(timestamp);

    return Column(
      children: [
        SizedBox(
          height: 90.h,
          width: double.infinity,
          child: Row(
            children: [
              Image.asset(
                "images/Alarm.png",
                height: 40.h,
                width: 40.w,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    truncateText(title, 45),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    children: [
                      Text(
                        truncateText(content, 50),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      // Text(
                      //   category,
                      //   style: const TextStyle(
                      //       fontSize: 14,
                      //       fontWeight: FontWeight.w400,
                      //       color: Color(0xFFD85252)),
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    formattedTimestamp,
                    style: TextStyle(
                      color: const Color(0xFF8D93A1),
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          indent: 20.w,
          endIndent: 20.w,
          color: Colors.white,
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}

class NotificationColumn extends StatefulWidget {
  final int categoryFilter;

  NotificationColumn({
    Key? key,
    required this.categoryFilter,
  }) : super(key: key);

  @override
  State<NotificationColumn> createState() => _NotificationColumnState();
}

class _NotificationColumnState extends State<NotificationColumn> {
  final NotificationController myController = Get.put(NotificationController());

  // Future<List<MockNotificationModel>> fetchNotifications(int category) async {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MockNotificationModel>>(
      future: myController.fetchNotifications(widget.categoryFilter),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: SizedBox(
                width: 50.w,
                height: 50.h,
                child: const CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Container(
            color: Colors.black,
            child: Image.asset("images/bilgi .png"),
          );
        } else {
          log("Snapshot: ${snapshot.data.toString()}");
          var notifications = snapshot.data!;
          for (int i = 0; i < notifications.length; i++) {
            log("zzzzzzzz");
            log(notifications[i].title);
            log("zzzzzzzz");
          }
          // log(
          //   notifications.toString(),
          // );
          // return SizedBox();
          return SizedBox(
            height: 600.h,
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                String title = notifications[index].title;
                String content = notifications[index].content;

                DateTime timestamp = DateTime.fromMillisecondsSinceEpoch(
                    notifications[index].createdAt);

                return NotificationOption(
                  title: title,
                  content: content,
                  timestamp: timestamp,
                );
              },
            ),
          );
        }
      },
    );
  }
}

class NotificationColumnTitle extends StatelessWidget {
  const NotificationColumnTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "2 Okunmamış mesaj",
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFFBFC2D9)),
          ),
          SizedBox(
            width: 5,
          ),
          Row(
            children: [
              Icon(
                Icons.edit,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Düzenle",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFBFC2D9)),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class NotificationTab extends StatefulWidget {
  final int index;
  final NotificationCategoryModel category;
  final bool isActive;
  final VoidCallback onTap;

  const NotificationTab({
    Key? key,
    required this.category,
    required this.index,
    required this.isActive,
    required this.onTap,
  }) : super(key: key);

  @override
  _NotificationTabState createState() => _NotificationTabState();
}

class _NotificationTabState extends State<NotificationTab> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: widget.isActive ? const Color(0xFF6E4AFC) : Colors.black,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          widget.category.name,
          style: TextStyle(
            color: widget.isActive ? Colors.white : const Color(0xFF8E8E8E),
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
