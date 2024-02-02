import 'package:finderex/view/notifications/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.to(
              () => NotificationView(),
            );
          },
          child: Text("Notifications"),
        ),
      ),
    );
  }
}
