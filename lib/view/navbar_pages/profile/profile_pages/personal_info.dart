import 'package:car_pool/localStorage/mydatabase.dart';
import 'package:car_pool/model/user_info.dart';
import 'package:car_pool/service/user_service.dart';
import 'package:car_pool/view/navbar_pages/profile/components/infoTile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../classes/themes/light_theme.dart';
import '../../../../state_controller.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({super.key});

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  UserProfileInfo? myPersonalInfo;
  void readPersonalInfoLocally() async {
    final response = await LocalDatabase.reading('''
      SELECT * FROM 'CARPOOL' WHERE ID = '${UserService.myUniqueId}';
      ''');
    myPersonalInfo = UserProfileInfo.fromLocal(response.first);
    setState(() {});
  }

  @override
  void initState() {
    readPersonalInfoLocally();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StateController>(builder: (context, controller, child) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
          CircleAvatar(
            radius: 52.r,
            backgroundColor: LightTheme.mainTheme,
            child: CircleAvatar(
              backgroundColor: LightTheme.mainTheme,
              radius: 50.r,
              backgroundImage: const AssetImage("assets/images/Kaneki.jpg"),
            ),
          ),
          20.verticalSpace,
          Container(
            decoration: BoxDecoration(
              color: LightTheme.thirdbackgroundTheme,
              borderRadius: BorderRadius.circular(10.r),
            ),
            padding: EdgeInsets.symmetric(vertical: 2.w),
            child: FutureBuilder(
                future: controller.myInfo,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(
                      color: LightTheme.mainTheme,
                    );
                  } else {
                    final infoStored = snapshot.data ?? myPersonalInfo!;
                    String email = infoStored.email;
                    email = email.replaceFirst('.driver', '');
                    return Column(
                      children: [
                        InfoTile(attribute: 'Name', value: infoStored.name),
                        InfoTile(attribute: 'Phone', value: infoStored.phoneNumber),
                        InfoTile(attribute: 'Email', value: email),
                        InfoTile(attribute: 'Password', value: infoStored.password),
                        InfoTile(attribute: 'Balance', value: 'EGP ${infoStored.balance}'),
                      ],
                    );
                  }
                }),
          ),
        ],
      );
    });
  }
}
