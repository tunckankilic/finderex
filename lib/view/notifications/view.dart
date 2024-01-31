import 'dart:developer';

import 'package:finderex/view/notifications/controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

  permissionRequest() async {
    final fcm = FirebaseMessaging.instance;
    fcm.requestPermission();
    final token = await fcm.getToken();
    log("Token: $token");
  }

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
      child: const Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            NotificationTitle(),
            NotificationCaregoryRow(),
            NotificationColumnTitle(),
            NotificationColumn(),
          ],
        ),
      ),
    );
  }
}

class NotificationTitle extends StatelessWidget {
  const NotificationTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Bildirimler",
            style: TextStyle(
                fontWeight: FontWeight.w700, color: Colors.white, fontSize: 24),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.close,
              size: 30,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationCaregoryRow extends StatelessWidget {
  const NotificationCaregoryRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF21212D),
      height: 60,
      width: double.infinity,
      child: const SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            NotificationTab(),
            NotificationTab(),
            NotificationTab(),
          ],
        ),
      ),
    );
  }
}

class NotificationTab extends StatelessWidget {
  const NotificationTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          color: const Color(0xFF6E4AFC),
          borderRadius: BorderRadius.circular(16)),
      height: 40,
      width: 130,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("images/ringing_bell.png"),
          const SizedBox(
            width: 5,
          ),
          const Text(
            "Tümü (32)",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class NotificationOption extends StatelessWidget {
  const NotificationOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
        } else if (direction == DismissDirection.startToEnd) {}
      },
      key: UniqueKey(),
      child: Column(
        children: [
          SizedBox(
            height: 90,
            width: double.infinity,
            child: Row(
              children: [
                Image.asset(
                  "images/Alarm.png",
                  height: 40,
                  width: 40,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Şifreniz başarılı bir şekilde değiştirildi.",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Row(
                      children: [
                        Text(
                          "You get 1BTC.",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Alarmlar",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFD85252)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      DateTime.now().toString(),
                      style: const TextStyle(
                        color: Color(0xFF8D93A1),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            indent: 20,
            endIndent: 20,
            color: Colors.white,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class NotificationColumn extends StatelessWidget {
  const NotificationColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: ListView(
        children: const [
          NotificationOption(),
          NotificationOption(),
          NotificationOption(),
          NotificationOption(),
          NotificationOption(),
          NotificationOption(),
          NotificationOption(),
          NotificationOption(),
          NotificationOption(),
        ],
      ),
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
