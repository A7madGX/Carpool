import 'package:car_pool/classes/themes/light_theme.dart';
import 'package:car_pool/classes/utils/statuses.dart';
import 'package:car_pool/service/user_service.dart';
import 'package:car_pool/state_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../model/trip.dart';

class DriverContainer extends StatefulWidget {
  final Trip myTrip;
  const DriverContainer({
    super.key,
    required this.myTrip,
  });

  @override
  State<DriverContainer> createState() => _DriverContainerState();
}

class _DriverContainerState extends State<DriverContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: LightTheme.thirdbackgroundTheme,
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(color: LightTheme.secondaryfontTheme, width: 1),
      ),
      margin: EdgeInsets.symmetric(vertical: 5.h),
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PickUp',
                    style: TextStyle(
                        color: LightTheme.secondaryfontTheme,
                        fontSize: 10.sp,
                        fontStyle: FontStyle.italic),
                  ),
                  3.verticalSpace,
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 150.w, maxHeight: 20.sp, minWidth: 150.w),
                    child: Text(
                      widget.myTrip.pickUpLocation,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: LightTheme.fontTheme,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Destination',
                    style: TextStyle(
                        color: LightTheme.secondaryfontTheme,
                        fontSize: 10.sp,
                        fontStyle: FontStyle.italic),
                  ),
                  3.verticalSpace,
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 120.w, maxHeight: 20.sp, minWidth: 120.w),
                    child: Text(
                      widget.myTrip.destination,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: LightTheme.fontTheme,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          10.verticalSpace,
          Text(
            'EGP ${widget.myTrip.price}',
            style: TextStyle(
              color: LightTheme.secondaryTheme,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.myTrip.tripDate,
                style: TextStyle(
                  color: LightTheme.secondaryfontTheme,
                  fontSize: 14.sp,
                  fontStyle: FontStyle.italic,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (widget.myTrip.status == TripStatus.completed) return;
                  TripStatus nextStatus = goToNextStatus(widget.myTrip.status);
                  await UserService.editTripStatus(
                    widget.myTrip.id!,
                    nextStatus,
                  );
                  if (context.mounted) {
                    context.read<StateController>().reloadMyTrips();
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tripToString(widget.myTrip.status),
                      style: TextStyle(
                        color: getTripStatusColor(widget.myTrip.status),
                        fontSize: 14.sp,
                        fontStyle: FontStyle.italic,
                        decoration: TextDecoration.underline,
                        decorationThickness: 0.7,
                      ),
                    ),
                    (widget.myTrip.status != TripStatus.completed)
                        ? Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 15.sp,
                            color: getTripStatusColor(widget.myTrip.status),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
