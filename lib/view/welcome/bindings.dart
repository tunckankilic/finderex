import 'package:finderex/view/welcome/controller.dart';
import 'package:get/get.dart';

class WelcomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WelcomeController());
  }
}
