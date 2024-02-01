// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import '../../../../classes/themes/light_theme.dart';
import '../../../../state_controller.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StateController>(builder: (context, controller, child) {
      return Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  controller.selectProfileIndex(0);
                },
                child: CircleAvatar(
                  backgroundColor: LightTheme.secondarybackgroundTheme,
                  child: Icon(
                    Icons.arrow_back_ios_sharp,
                    color: LightTheme.mainTheme,
                  ),
                ),
              )
            ],
          ),
          20.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Dark Mode',
                style: TextStyle(
                    color: LightTheme.fontTheme, fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              FlutterSwitch(
                activeColor: LightTheme.mainTheme,
                inactiveColor: LightTheme.secondarybackgroundTheme,
                width: 50.0.w,
                height: 30.0.h,
                toggleSize: 20.0.r,
                value: controller.darkMode,
                borderRadius: 15.0.r,
                padding: 6.0.w,
                onToggle: (val) {
                  controller.toggleThemeMode();
                },
              )
            ],
          )
        ],
      );
    });
  }
}
