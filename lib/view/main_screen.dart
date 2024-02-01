// ignore_for_file: avoid_print

import 'package:car_pool/view/navbar_pages/driverHomePage/driver_home_screen.dart';
import 'package:car_pool/view/navbar_pages/driverOrdersReceived/received_orders_screen.dart';
import 'package:car_pool/view/navbar_pages/orderHistory/order_history_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../classes/themes/light_theme.dart';
import '../state_controller.dart';
import 'my_nav_bar/navbar.dart';
import 'navbar_pages/homePage/home_page.dart';
import 'navbar_pages/profile/profile_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> myPages = [
      (context.read<StateController>().isDriver) ? const HomeDriver() : const Home(),
      (context.read<StateController>().isDriver) ? const ReceivedOrder() : const OrderHistory(),
      // const Notifications(),
      const ProfileScreen(),
    ];
    return Consumer<StateController>(builder: (context, controller, child) {
      return SafeArea(
        child: Scaffold(
          extendBody: true,
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            child:
                // myPages[context.watch<StateController>().selectedpageIndex],
                PageView(
              controller: controller.pgCtrl,
              children: myPages,
              onPageChanged: (index) {
                controller.selectPage(index);
              },
            ),
          ),
          backgroundColor: LightTheme.backgroundTheme,
          bottomNavigationBar: const MyNavBar(),
        ),
      );
    });
  }
}
