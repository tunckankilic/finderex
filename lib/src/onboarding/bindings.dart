import 'package:finderex/src/onboarding/controller.dart';
import 'package:get/get.dart';

class OnboardingBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<OnboardingController>((OnboardingController()));
  }
}
