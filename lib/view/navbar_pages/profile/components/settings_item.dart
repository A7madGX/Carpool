import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../classes/themes/light_theme.dart';
import '../../../../state_controller.dart';

class SettingsItem extends StatelessWidget {
  final int index;
  final IconData myIcon;
  final String name;
  const SettingsItem({super.key, required this.myIcon, required this.name, required this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer<StateController>(builder: (context, controller, child) {
      return Column(
        children: [
          GestureDetector(
            onTap: () {
              controller.selectProfileIndex(index);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              width: double.infinity,
              height: 45.h,
              decoration: BoxDecoration(color: LightTheme.backgroundTheme),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5.w),
                          decoration: BoxDecoration(
                            color: LightTheme.thirdbackgroundTheme,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Icon(
                            myIcon,
                            color: LightTheme.mainTheme,
                          ),
                        ),
                        15.horizontalSpace,
                        Text(
                          name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                              color: LightTheme.fontTheme),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.navigate_next_sharp,
                    color: LightTheme.greyTheme,
                  )
                ],
              ),
            ),
          ),
          Divider(
            color: LightTheme.secondarybackgroundTheme,
            thickness: 0.5.h,
            endIndent: 15.w,
            indent: 55.w,
          )
        ],
      );
    });
  }
}
