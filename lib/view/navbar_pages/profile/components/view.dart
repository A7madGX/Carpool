import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../classes/themes/light_theme.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with SingleTickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 5))
      ..repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (animationController.isAnimating) {
              animationController.stop();
            } else {
              animationController.repeat();
            }
          },
          child: RotationTransition(
            alignment: Alignment.center,
            turns: animationController,
            child: CircleAvatar(
              radius: 52.r,
              backgroundColor: LightTheme.mainTheme,
              child: CircleAvatar(
                backgroundColor: LightTheme.mainTheme,
                radius: 50.r,
                backgroundImage: const AssetImage("assets/images/Kaneki.jpg"),
              ),
            ),
          ),
        ),
        10.verticalSpace,
        Text(
          'Ahmed Gamil',
          style:
              TextStyle(color: LightTheme.fontTheme, fontWeight: FontWeight.bold, fontSize: 15.sp),
        ),
        3.verticalSpace,
        Text(
          '@19P4664',
          style: TextStyle(
              color: LightTheme.secondaryfontTheme, fontWeight: FontWeight.bold, fontSize: 12.sp),
        ),
      ],
    );
  }
}
