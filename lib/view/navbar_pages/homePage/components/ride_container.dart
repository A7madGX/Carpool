import 'package:car_pool/classes/themes/light_theme.dart';
import 'package:car_pool/classes/utils/date_parser.dart';
import 'package:car_pool/state_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../classes/utils/statuses.dart';
import '../../../../model/order.dart';
import '../../../../model/trip.dart';
import '../../../../model/user_info.dart';
import '../../components/my_dialog_box.dart';

class RideContainer extends StatefulWidget {
  final Trip myTrip;
  const RideContainer({
    super.key,
    required this.myTrip,
  });

  @override
  State<RideContainer> createState() => _RideContainerState();
}

class _RideContainerState extends State<RideContainer> {
  late final timeRemaining = calcTimeDiff(strToDate(widget.myTrip.tripDate), DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Consumer<StateController>(builder: (context, ctrl, _) {
      return FutureBuilder(
          future: ctrl.myInfo,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(
                color: LightTheme.mainTheme,
              );
            }
            UserProfileInfo myInfo = snapshot.data!;
            return Container(
              decoration: BoxDecoration(
                  color: LightTheme.thirdbackgroundTheme,
                  borderRadius: BorderRadius.circular(25.r),
                  border: Border.all(color: LightTheme.secondarybackgroundTheme)),
              margin: EdgeInsets.symmetric(vertical: 5.h),
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        tripToString(widget.myTrip.status),
                        style: TextStyle(
                          color: getTripStatusColor(widget.myTrip.status),
                          decoration: TextDecoration.underline,
                          decorationThickness: 0.5,
                          fontStyle: FontStyle.italic,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  8.verticalSpace,
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: LightTheme.backgroundTheme,
                        radius: 35.r,
                        child: Icon(
                          Icons.person,
                          size: 50.sp,
                          color: LightTheme.greyTheme,
                        ),
                      ),
                      10.horizontalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Driver:',
                                style: TextStyle(
                                  color: LightTheme.secondaryfontTheme,
                                  fontSize: 12.sp,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              42.horizontalSpace,
                              Text(
                                widget.myTrip.driverName,
                                style: TextStyle(
                                    color: LightTheme.fontTheme,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'PickUp:',
                                style: TextStyle(
                                  color: LightTheme.secondaryfontTheme,
                                  fontSize: 12.sp,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              35.horizontalSpace,
                              Text(
                                widget.myTrip.pickUpLocation,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  color: LightTheme.fontTheme,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Destination:',
                                style: TextStyle(
                                  color: LightTheme.secondaryfontTheme,
                                  fontSize: 12.sp,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              12.horizontalSpace,
                              Text(
                                widget.myTrip.destination,
                                style: TextStyle(
                                  color: LightTheme.fontTheme,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Price:',
                                style: TextStyle(
                                  color: LightTheme.secondaryfontTheme,
                                  fontSize: 12.sp,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              45.horizontalSpace,
                              Text(
                                'EGP ${widget.myTrip.price}',
                                style: TextStyle(
                                    color: LightTheme.fontTheme,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'PickUp Date:',
                                style: TextStyle(
                                  color: LightTheme.secondaryfontTheme,
                                  fontSize: 12.sp,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              8.horizontalSpace,
                              Text(
                                widget.myTrip.tripDate,
                                style: TextStyle(
                                  color: LightTheme.fontTheme,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Booking Deadline:',
                        style: TextStyle(
                          color: LightTheme.secondaryfontTheme,
                          fontSize: 11.sp,
                        ),
                      ),
                      5.horizontalSpace,
                      ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 65.w, minWidth: 65.w),
                        child: Text(
                          (timeRemaining == 'Closed') ? 'Closed' : '$timeRemaining left',
                          style: TextStyle(
                            color: (timeRemaining == 'Closed' && !ctrl.closeRemainingTime)
                                ? LightTheme.decline
                                : LightTheme.accept,
                            fontSize: 11.sp,
                          ),
                        ),
                      )
                    ],
                  ),
                  2.verticalSpace,
                  SizedBox(
                    height: 25.h,
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: (timeRemaining == 'Closed' && !ctrl.closeRemainingTime)
                            ? LightTheme.darkgreyTheme
                            : LightTheme.mainTheme,
                      ),
                      onPressed: () {
                        if (timeRemaining == 'Closed' && !ctrl.closeRemainingTime) return;
                        showDialog(
                            context: context,
                            builder: (context) {
                              return MyDialog(
                                  order: OrderHistory(
                                name: myInfo.name,
                                phoneNumber: myInfo.phoneNumber,
                                status: OrderStatus.pending,
                                trip: widget.myTrip,
                              ));
                            });
                      },
                      icon: Icon(
                        Icons.calendar_month_rounded,
                        size: 17.sp,
                        color: (timeRemaining == 'Closed' && !ctrl.closeRemainingTime)
                            ? LightTheme.secondaryfontTheme
                            : Colors.white,
                      ),
                      label: Text(
                        'Book',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: (timeRemaining == 'Closed' && !ctrl.closeRemainingTime)
                              ? LightTheme.secondaryfontTheme
                              : Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          });
    });
  }
}
