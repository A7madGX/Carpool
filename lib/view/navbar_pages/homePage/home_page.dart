// ignore_for_file: unused_import

import 'package:car_pool/view/navbar_pages/homePage/components/routes_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../classes/themes/light_theme.dart';
import '../../../../state_controller.dart';
import '../components/title.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StateController>(builder: (context, controller, child) {
      return SingleChildScrollView(
        child: Column(
          children: [
            const MainTitle(title: 'Home'),
            15.verticalSpace,
            // const Search(),
            // 30.verticalSpace,
            // const MySlider(),
            // 5.verticalSpace,
            const RoutesSection(),
          ],
        ),
      );
    });
  }
}
