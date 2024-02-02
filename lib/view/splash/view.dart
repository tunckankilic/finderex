import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:finderex/main.dart';
import 'package:finderex/view/onboarding/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  static const routeName = "/Splash";
  const Splash({
    super.key,
  });

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late StreamSubscription subscription;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF000000),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 35.h,
            ),
            child: StreamBuilder(
              stream: Connectivity().onConnectivityChanged,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  ConnectivityResult? result = snapshot.data;
                  if (result == ConnectivityResult.mobile) {
                    return const Connected();
                  } else if (result == ConnectivityResult.wifi) {
                    return const Connected();
                  } else {
                    return noInternet();
                  }
                } else {
                  return loading();
                }
              },
            )),
      ),
    );
  }
}

Widget loading() {
  return const Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
    ),
  );
}

class Connected extends StatefulWidget {
  const Connected({super.key});

  @override
  State<Connected> createState() => _ConnectedState();
}

class _ConnectedState extends State<Connected> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () {
      Get.to(() => const Onboarding());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset("images/welcome.svg"),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(),
            const Spacer(),
            SvgPicture.asset("images/splash.svg"),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 50.h),
              child: Text(
                "Finderex’le dilediğin stratejiyi belirle, yatırımını özgürce yap. Esnek stratejiler, bağımsız kararlar, özgür yatırım.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
              ),
            )
          ],
        ),
      ],
    );
  }
}

Widget noInternet() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset("assets/auth/engel.svg"),
        ElevatedButton(
          onPressed: () {
            runApp(
              MyApp(),
            );
          },
          child: const Text("Re-Start"),
        ),
      ],
    ),
  );
}
