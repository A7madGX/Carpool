import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../components/title.dart';
import '../components/settings_list.dart';
import '../components/view.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const MainTitle(title: 'Settings'),
          30.verticalSpace,
          const ProfileView(),
          30.verticalSpace,
          const SettingsList(),
        ],
      ),
    );
  }
}
