// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../classes/themes/light_theme.dart';
import '../../../../state_controller.dart';

class Logout extends StatelessWidget {
  const Logout({super.key});

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
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 0.5.sw),
                child: Text(
                  'Are you sure you want to logout?',
                  style: TextStyle(
                      color: LightTheme.fontTheme, fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  context.read<StateController>().resetControllers();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: LightTheme.backgroundTheme,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                        side: BorderSide(
                          color: LightTheme.secondaryTheme,
                        ))),
                child: Text(
                  'Logout',
                  style: TextStyle(color: LightTheme.secondaryTheme),
                ),
              ),
            ],
          )
        ],
      );
    });
  }
}
