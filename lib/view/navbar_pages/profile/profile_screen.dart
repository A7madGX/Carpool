import 'package:car_pool/view/navbar_pages/profile/profile_pages/Theme.dart';
import 'package:car_pool/view/navbar_pages/profile/profile_pages/logout.dart';
import 'package:car_pool/view/navbar_pages/profile/profile_pages/personal_info.dart';
import 'package:car_pool/view/navbar_pages/profile/profile_pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../state_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> profilePages = [
      const Profile(),
      const PersonalInfo(),
      const ThemePage(),
      const Logout(),
    ];
    return Consumer<StateController>(builder: (context, controller, child) {
      return profilePages[controller.profilepageIndex];
    });
  }
}
