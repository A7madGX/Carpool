import 'package:car_pool/classes/themes/light_theme.dart';
import 'package:car_pool/state_controller.dart';
import 'package:car_pool/view/navbar_pages/homePage/components/ride_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

class RoutesSection extends StatefulWidget {
  const RoutesSection({super.key});

  @override
  State<RoutesSection> createState() => _RoutesSectionState();
}

class _RoutesSectionState extends State<RoutesSection> {
  @override
  Widget build(BuildContext context) {
    return Consumer<StateController>(builder: (context, ctrl, _) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Available Trips',
                style: TextStyle(
                  color: LightTheme.fontTheme,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FlutterSwitch(
                activeColor: LightTheme.mainTheme,
                inactiveColor: LightTheme.secondarybackgroundTheme,
                width: 50.0.w,
                height: 30.0.h,
                toggleSize: 20.0.r,
                value: ctrl.closeRemainingTime,
                borderRadius: 15.0.r,
                padding: 6.0.w,
                onToggle: (val) {
                  ctrl.toggleRemainingButton();
                },
              )
            ],
          ),
          5.verticalSpace,
          FutureBuilder(
              future: ctrl.availableTrips,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    children: [
                      200.verticalSpace,
                      CircularProgressIndicator(
                        color: LightTheme.mainTheme,
                      ),
                    ],
                  );
                }
                final availableTripsFetched = snapshot.data!;
                if (availableTripsFetched.isEmpty) {
                  return SizedBox(
                    height: 460.h,
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Image.asset(
                        "assets/images/noNoti.png",
                        scale: 0.5,
                        color: LightTheme.thirdbackgroundTheme,
                      ),
                      10.verticalSpace,
                      Text(
                        'No Trips yet.',
                        style: TextStyle(
                            color: LightTheme.thirdbackgroundTheme,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp),
                      )
                    ]),
                  );
                }
                return SizedBox(
                  height: 460.h,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    itemCount: availableTripsFetched.length,
                    itemBuilder: (context, index) {
                      return RideContainer(
                        myTrip: availableTripsFetched[index],
                      );
                    },
                  ),
                );
              })
        ],
      );
    });
  }
}
