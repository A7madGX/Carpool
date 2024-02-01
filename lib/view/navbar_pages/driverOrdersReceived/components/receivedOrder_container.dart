import 'package:car_pool/classes/themes/light_theme.dart';
import 'package:car_pool/classes/utils/statuses.dart';
import 'package:car_pool/service/user_service.dart';
import 'package:car_pool/state_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../model/order.dart';

class ReceivedOrderContainer extends StatefulWidget {
  final OrderHistory order;
  const ReceivedOrderContainer({super.key, required this.order});

  @override
  State<ReceivedOrderContainer> createState() => _ReceivedOrderContainerState();
}

class _ReceivedOrderContainerState extends State<ReceivedOrderContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      width: 1.sw,
      decoration: BoxDecoration(
          color: LightTheme.thirdbackgroundTheme,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(
            color: getStatusColor(widget.order.status),
            width: 1,
          )),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: LightTheme.backgroundTheme,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(15.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.order.name,
                            style: TextStyle(
                              color: LightTheme.fontTheme,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.order.phoneNumber,
                            style: TextStyle(
                              color: LightTheme.secondaryfontTheme,
                              fontSize: 10.sp,
                            ),
                          ),
                        ],
                      ),
                      (widget.order.status == OrderStatus.pending)
                          ? Row(
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    await UserService.editOrderStatus(
                                      widget.order.id!,
                                      OrderStatus.approved,
                                    );
                                    await UserService.editAmount(
                                      userId: widget.order.userId!,
                                      driverId: widget.order.trip.driverId!,
                                      amount: widget.order.trip.price,
                                    );

                                    if (!context.mounted) return;
                                    context.read<StateController>().reloadMyOrders();
                                    context.read<StateController>().reloadMyInfo();
                                  },
                                  iconSize: 25.r,
                                  icon: const Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await UserService.editOrderStatus(
                                      widget.order.id!,
                                      OrderStatus.rejected,
                                    );
                                    if (!context.mounted) return;
                                    context.read<StateController>().reloadMyOrders();
                                  },
                                  iconSize: 25.r,
                                  icon: const Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            )
                          : Text(
                              statusToString(widget.order.status),
                              style: TextStyle(
                                color: (widget.order.status == OrderStatus.approved)
                                    ? Colors.green
                                    : Colors.red,
                                fontSize: 12.sp,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
              // Divider(
              //   height: 10.h,
              //   thickness: 1,
              //   color: LightTheme.secondaryfontTheme,
              // ),
              Container(
                color: LightTheme.secondaryfontTheme,
                width: double.infinity,
                height: 1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.h),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'PickUp:',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: LightTheme.secondaryfontTheme,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        30.horizontalSpace,
                        Text(
                          widget.order.trip.pickUpLocation,
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: LightTheme.fontTheme,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    2.verticalSpace,
                    Row(
                      children: [
                        Text(
                          'Destination:',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: LightTheme.secondaryfontTheme,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        10.horizontalSpace,
                        Text(
                          widget.order.trip.destination,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: LightTheme.fontTheme,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    2.verticalSpace,
                    Row(
                      children: [
                        Text(
                          'PickUp Date:',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: LightTheme.secondaryfontTheme,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        5.horizontalSpace,
                        Text(
                          widget.order.trip.tripDate.substring(0, 5) +
                              widget.order.trip.tripDate.substring(10, 20),
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: LightTheme.fontTheme,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    2.verticalSpace,
                    Row(
                      children: [
                        Text(
                          'Price:',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: LightTheme.secondaryfontTheme,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        40.horizontalSpace,
                        Text(
                          'EGP ${widget.order.trip.price}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: LightTheme.secondaryTheme,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
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
