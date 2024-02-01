import 'package:car_pool/classes/themes/light_theme.dart';
import 'package:car_pool/classes/utils/statuses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../model/order.dart';

class OrderHistoryContainer extends StatefulWidget {
  final OrderHistory order;
  const OrderHistoryContainer({super.key, required this.order});

  @override
  State<OrderHistoryContainer> createState() => _OrderHistoryContainerState();
}

class _OrderHistoryContainerState extends State<OrderHistoryContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      width: 1.sw,
      height: 82.h,
      decoration: BoxDecoration(
        color: LightTheme.thirdbackgroundTheme,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        children: [
          Container(
            width: 15.w,
            decoration: BoxDecoration(
              color: getStatusColor(widget.order.status),
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(15.r),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.order.trip.driverName,
                        style: TextStyle(
                          color: LightTheme.fontTheme,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.order.trip.tripDate.substring(0, 5) +
                            widget.order.trip.tripDate.substring(10, 20),
                        style: TextStyle(
                            color: LightTheme.secondaryfontTheme,
                            fontSize: 12.sp,
                            fontStyle: FontStyle.italic),
                      )
                    ],
                  ),
                  Divider(
                    height: 10.h,
                    thickness: 1,
                    color: LightTheme.secondaryfontTheme,
                  ),
                  Row(
                    children: [
                      Text(
                        'PickUp:',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: LightTheme.secondaryfontTheme,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      30.horizontalSpace,
                      Text(widget.order.trip.pickUpLocation,
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: LightTheme.fontTheme,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Destination:',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: LightTheme.secondaryfontTheme,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      7.horizontalSpace,
                      Text(widget.order.trip.destination,
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: LightTheme.fontTheme,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Price:',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: LightTheme.secondaryfontTheme,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      40.horizontalSpace,
                      Text(
                        'EGP ${widget.order.trip.price}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: LightTheme.decline,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
