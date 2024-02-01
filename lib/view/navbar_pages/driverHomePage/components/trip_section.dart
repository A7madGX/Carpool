import 'package:car_pool/classes/themes/light_theme.dart';
import 'package:car_pool/state_controller.dart';
import 'package:car_pool/view/navbar_pages/driverHomePage/components/driver_trip_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DriverTripsSection extends StatefulWidget {
  const DriverTripsSection({super.key});

  @override
  State<DriverTripsSection> createState() => _DriverTripsSectionState();
}

class _DriverTripsSectionState extends State<DriverTripsSection> {
  @override
  Widget build(BuildContext context) {
    return Consumer<StateController>(builder: (context, ctrl, _) {
      // if (ctrl.reloadOrders) {
      //   ctrl.reloadMyOrders();
      //   ctrl.toggleReloadBool();
      // }
      return Column(
        children: [
          Row(
            children: [
              Text(
                'My Trips',
                style: TextStyle(
                  color: LightTheme.fontTheme,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          5.verticalSpace,
          FutureBuilder(
              future: ctrl.myTrips,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    children: [
                      200.verticalSpace,
                      CircularProgressIndicator(
                        color: LightTheme.mainTheme,
                      ),
                      230.verticalSpace,
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
                      return DriverContainer(
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
