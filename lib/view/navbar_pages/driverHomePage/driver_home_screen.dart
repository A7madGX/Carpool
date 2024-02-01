// ignore_for_file: unused_import

import 'package:car_pool/view/navbar_pages/driverHomePage/components/add_trip_button.dart';
import 'package:car_pool/view/navbar_pages/driverHomePage/components/trip_section.dart';
import 'package:car_pool/view/navbar_pages/homePage/components/routes_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../classes/themes/light_theme.dart';
import '../../../../state_controller.dart';
import '../components/title.dart';

class HomeDriver extends StatelessWidget {
  const HomeDriver({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StateController>(builder: (context, controller, child) {
      return SingleChildScrollView(
        child: Column(
          children: [
            const MainTitle(title: 'Home'),
            15.verticalSpace,
            Stack(
              children: [
                const DriverTripsSection(),
                Positioned(
                  bottom: 10.h,
                  right: 0,
                  child: const AddButton(),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
