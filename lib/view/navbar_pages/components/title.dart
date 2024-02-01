import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../classes/themes/light_theme.dart';
import '../../../state_controller.dart';

class MainTitle extends StatelessWidget {
  final String title;
  const MainTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final titleLength = title.length * 9 + 10;
    return Consumer<StateController>(builder: (context, controller, child) {
      return Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 30.sp, fontWeight: FontWeight.bold, color: LightTheme.fontTheme),
              ),
              3.verticalSpace,
              TweenAnimationBuilder(
                duration: const Duration(milliseconds: 500),
                tween: Tween<double>(begin: 0, end: titleLength.toDouble()),
                builder: (context, value, child) {
                  return Container(
                    width: value.w,
                    height: 3.h,
                    decoration: BoxDecoration(
                        color: LightTheme.mainTheme, borderRadius: BorderRadius.circular(20.r)),
                    child: child,
                  );
                },
              ),
            ],
          ),
        ],
      );
    });
  }
}
