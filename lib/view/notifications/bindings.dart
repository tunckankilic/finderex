import 'package:finderex/view/notifications/controller.dart';
import 'package:get/get.dart';

class NotificationBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(() => NotificationController());
  }
}
