import 'dart:developer';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:finderex/view/login/view.dart';
import 'package:finderex/view/onboarding/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Onboarding extends GetView<OnboardingController> {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    log("Height: ${MediaQuery.of(context).size.height}");
    log("Width: ${MediaQuery.of(context).size.width}");
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: Obx(() {
        int page = controller.state.index.value;
        return SizedBox(
          width: 360.w,
          height: 780.h,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PageView(
                  scrollDirection: Axis.horizontal,
                  reverse: false,
                  onPageChanged: (value) {
                    page = value;
                    controller.changePage(value);
                  },
                  controller: controller.pageController,
                  pageSnapping: true,
                  physics: const ClampingScrollPhysics(),
                  children: controller.pictures),
              Positioned(
                left: 24.w,
                bottom: 70.h,
                child: DotsIndicator(
                  position: controller.state.index.value,
                  dotsCount: 4,
                  reversed: false,
                  mainAxisAlignment: MainAxisAlignment.center,
                  decorator: DotsDecorator(
                    activeColor: controller.state.index.value == 0
                        ? const Color(0xFF00A998)
                        : controller.state.index.value == 1
                            ? const Color(0xFFFDB740)
                            : controller.state.index.value == 2
                                ? const Color(0xFF6E4AFC)
                                : controller.state.index.value == 3
                                    ? const Color(0xFFED1163)
                                    : const Color(0xFF484866),
                    size: Size(8.0.w, 4.0.h),
                    activeSize: Size(20.0.w, 4.0.h),
                    activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 24.w,
                bottom: 70.h,
                child: ElevatedButton(
                  onPressed: () {
                    if (controller.pageController.page !=
                        controller.pictures.length - 1) {
                      controller.pageController.nextPage(
                        duration: const Duration(milliseconds: 30),
                        curve: Curves.easeInOut,
                      );
                    } else if (controller.pageController.page ==
                        controller.pictures.length - 1) {
                      Get.to(
                        () => Login(),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    backgroundColor: controller.state.index.value == 0
                        ? const Color(0xFF00A998)
                        : controller.state.index.value == 1
                            ? const Color(0xFFFDB740)
                            : controller.state.index.value == 2
                                ? const Color(0xFF6E4AFC)
                                : controller.state.index.value == 3
                                    ? const Color(0xFFED1163)
                                    : const Color(0xFF484866),
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
