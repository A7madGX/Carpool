import 'package:car_pool/view/navbar_pages/profile/components/settings_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../classes/themes/light_theme.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.w),
      decoration: BoxDecoration(color: LightTheme.backgroundTheme),
      width: double.infinity,
      height: 325.h,
      child: const SingleChildScrollView(
        child: Column(
          children: [
            SettingsItem(
              myIcon: Icons.person,
              name: 'Personal Info',
              index: 1,
            ),
            SettingsItem(
              myIcon: Icons.mode,
              name: 'Theme',
              index: 2,
            ),
            SettingsItem(
              myIcon: Icons.logout,
              name: 'Logout',
              index: 3,
            ),
          ],
        ),
      ),
    );
  }
}
