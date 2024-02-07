import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("images/onboarding/hg.png"),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SvgPicture.asset("images/splash.svg"),
          ),
        ),
      ],
    );
  }
}
