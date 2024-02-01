import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../classes/themes/light_theme.dart';
import '../../state_controller.dart';

class MyNavItem extends StatelessWidget {
  final int myIndex;
  final IconData myIcon;
  const MyNavItem({super.key, required this.myIcon, required this.myIndex});

  @override
  Widget build(BuildContext context) {
    return Consumer<StateController>(builder: (context, controller, child) {
      final int currentIndex = controller.selectedpageIndex;
      return GestureDetector(
        onTap: () {
          controller.selectPageFromNav(myIndex);
        },
        child: Container(
          decoration: BoxDecoration(
              color: LightTheme.navbarTheme.withOpacity(0.01),
              borderRadius: BorderRadius.circular(50.r)),
          padding: EdgeInsets.all(10.w),
          child: TweenAnimationBuilder(
              duration: const Duration(milliseconds: 300),
              tween: ColorTween(
                  begin: LightTheme.darkgreyTheme,
                  end: (currentIndex == myIndex) ? LightTheme.mainTheme : LightTheme.darkgreyTheme),
              builder: (context, val, child) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      myIcon,
                      color: val,
                      size: 30.w,
                    ),
                    2.verticalSpace,
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: (currentIndex == myIndex) ? 1 : 0.01,
                      child: Icon(
                        Icons.circle,
                        size: 5.r,
                        color: val,
                      ),
                    )
                  ],
                );
              }),
        ),
      );
    });
  }
}
