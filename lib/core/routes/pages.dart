import 'package:finderex/core/routes/routes.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AppPages {
  static const INITIAL = AppRoutes.INITIAL;
  static const APPlication = AppRoutes.Application;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static final List<GetPage> routes = [
    // GetPage(
    //   name: AppRoutes.INITIAL,
    //   page: () => const WelcomePage(),
    //   binding: WelcomeBinding(),
    //   middlewares: [
    //     RouteWelcomeMiddleware(priority: 1),
    //   ],
    // ),
    // GetPage(
    //   name: AppRoutes.SIGN_IN,
    //   page: () => SignInPage(),
    //   binding: SignInBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.Application,
    //   page: () => ApplicationPage(),
    //   binding: ApplicationBinding(),
    //   // middlewares: [
    //   //   RouteAuthMiddleware(priority: 1),
    //   // ],
    // ),
    // GetPage(
    //   name: AppRoutes.Contact,
    //   page: () => const ContactPage(),
    //   binding: ContactBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.Chat,
    //   page: () => const ChatPage(),
    //   binding: ChatBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.Photoimgview,
    //   page: () => const PhotoImgViewPage(),
    //   binding: PhotoImgViewBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.Me,
    //   page: () => const ProfilePage(),
    //   binding: ProfileBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.Message,
    //   page: () => const MessagePage(),
    // )
  ];
}
