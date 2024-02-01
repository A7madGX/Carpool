import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../classes/themes/light_theme.dart';
import '../../state_controller.dart';
import 'navbar_item.dart';

class MyNavBar extends StatelessWidget {
  const MyNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StateController>(builder: (context, controller, child) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 70.w),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.r),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3.w, sigmaY: 3.h),
            child: Container(
              height: 60.h,
              decoration: BoxDecoration(
                  // backgroundBlendMode: BlendMode.luminosity,
                  color: LightTheme.secondarybackgroundTheme.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(30.r)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyNavItem(
                    myIcon: Icons.home_filled,
                    myIndex: 0,
                  ),
                  MyNavItem(
                    myIcon: Icons.history,
                    myIndex: 1,
                  ),
                  // MyNavItem(
                  //   myIcon: Icons.notifications,
                  //   myIndex: 2,
                  // ),
                  MyNavItem(
                    myIcon: Icons.settings,
                    myIndex: 2,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
