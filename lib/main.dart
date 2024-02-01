// ignore_for_file: avoid_print

import 'package:car_pool/state_controller.dart';
import 'package:car_pool/view/main_screen.dart';
import 'package:car_pool/view/sign_in.dart';
import 'package:car_pool/view/sign_up.dart';
import 'package:car_pool/view/splash_screen/splash_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'classes/themes/light_theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => StateController(),
      ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print("myApp rebuilt");
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: Consumer<StateController>(builder: (context, controller, child) {
        return MaterialApp(
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          debugShowCheckedModeBanner: false,
          title: 'Car Pool',
          theme: ThemeData(
            textTheme: Theme.of(context).textTheme.apply(
                fontFamily: 'Outfit',
                bodyColor: LightTheme.fontTheme,
                displayColor: LightTheme.fontTheme),
            colorScheme: ColorScheme.fromSeed(seedColor: LightTheme.mainTheme),
            useMaterial3: true,
          ),
          initialRoute: '/splashscreen',
          routes: {
            '/splashscreen': (context) => const SplashScreen(),
            '/mainscreen': (context) => const MainScreen(),
            '/signupscreen': (context) => const SignUp(),
            '/signinscreen': (context) => const SignIn(),
          },
        );
      }),
    );
  }
}
