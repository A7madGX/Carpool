import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:car_pool/view/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        curve: Curves.bounceInOut,
        duration: 1000,
        backgroundColor: Colors.black,
        splashTransition: SplashTransition.slideTransition,
        splash: Image.asset(
          "assets/images/splash.png",
        ),
        splashIconSize: 400.w,
        nextScreen: const SignUp());
  }
}
