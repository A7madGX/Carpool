import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../classes/themes/light_theme.dart';
import '../../../model/order.dart';
import '../../../service/user_service.dart';
import '../../../state_controller.dart';

class MyDialog extends StatefulWidget {
  final OrderHistory order;
  const MyDialog({super.key, required this.order});

  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  bool payWithCash = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<StateController>(builder: (context, controller, child) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3.w, sigmaY: 3.h),
        child: AnimatedContainer(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          margin: EdgeInsets.only(top: 280.h, bottom: 18.h, right: 15.w, left: 15.w),
          decoration: BoxDecoration(
              color: LightTheme.secondarybackgroundTheme.withOpacity(0.95),
              borderRadius: BorderRadius.circular(15.r)),
          duration: const Duration(milliseconds: 500),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    'Payment',
                    style: TextStyle(
                        color: LightTheme.fontTheme, fontSize: 14.sp, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              5.verticalSpace,
              GestureDetector(
                onTap: () {
                  setState(() {
                    payWithCash = false;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: LightTheme.lightGreyTheme,
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(
                        color: LightTheme.mainTheme,
                        width: (payWithCash) ? 0 : 3.w,
                      )),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.h),
                        child: Container(
                          height: 50.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              border: Border.all(color: Colors.red, width: 3.w),
                              color: LightTheme.secondarybackgroundTheme,
                              image: const DecorationImage(
                                  image: AssetImage('assets/images/Mastercard.jpg'),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "**** **** **** 2654",
                              style: TextStyle(
                                  color: LightTheme.secondaryfontTheme,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '07/24',
                              style: TextStyle(
                                  color: LightTheme.secondaryfontTheme,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              10.verticalSpace,
              GestureDetector(
                onTap: () {
                  setState(() {
                    payWithCash = true;
                  });
                },
                child: Container(
                  height: 65.h,
                  decoration: BoxDecoration(
                      color: LightTheme.lightGreyTheme,
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(
                        color: LightTheme.mainTheme,
                        width: (payWithCash) ? 3.w : 0,
                      )),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.h),
                        child: Container(
                          height: 50.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.r),
                            border: Border.all(color: Colors.red, width: 3.w),
                            color: LightTheme.lightGreyTheme,
                          ),
                          child: Icon(
                            Icons.attach_money,
                            size: 30.sp,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      Text(
                        'Pay Cash',
                        style: TextStyle(
                            color: LightTheme.secondaryfontTheme,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              10.verticalSpace,
              Row(
                children: [
                  Text(
                    'Payment Details',
                    style: TextStyle(
                        color: LightTheme.fontTheme, fontSize: 14.sp, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              5.verticalSpace,
              Container(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 15.w),
                height: 90.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: LightTheme.navbarTheme, borderRadius: BorderRadius.circular(15.r)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sub Total',
                          style: TextStyle(
                              color: LightTheme.fontTheme.withOpacity(0.7),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'EGP ${widget.order.trip.price.toStringAsFixed(2)}',
                          style: TextStyle(
                              color: LightTheme.fontTheme.withOpacity(0.7),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    3.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Fees',
                          style: TextStyle(
                              color: LightTheme.fontTheme.withOpacity(0.7),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'EGP 0.00',
                          style: TextStyle(
                              color: LightTheme.fontTheme.withOpacity(0.7),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Divider(
                      height: 20.h,
                      color: LightTheme.secondaryfontTheme,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                              color: LightTheme.fontTheme,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'EGP ${(widget.order.trip.price).toStringAsFixed(2)}',
                          style: TextStyle(
                              color: LightTheme.fontTheme,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              7.verticalSpace,
              SizedBox(
                width: double.infinity,
                height: 30.h,
                child: ElevatedButton(
                  style:
                      ButtonStyle(backgroundColor: MaterialStateProperty.all(LightTheme.mainTheme)),
                  onPressed: () async {
                    await UserService.addOrder(widget.order);
                    if (!context.mounted) return;
                    context.read<StateController>().reloadMyOrders();
                    AwesomeDialog(
                      buttonsTextStyle: TextStyle(fontSize: 18.sp, color: Colors.white),
                      dialogBackgroundColor: LightTheme.backgroundTheme,
                      btnOkColor: LightTheme.mainTheme,
                      context: context,
                      dialogType: DialogType.success,
                      animType: AnimType.rightSlide,
                      title: 'Payment Successful',
                      desc: 'A Notification will be sent shortly..',
                      btnOkOnPress: () {
                        // controller.addOrder(order);
                        Navigator.of(context).pop();
                      },
                    ).show();
                  },
                  child: Text(
                    'Submit Order',
                    style: TextStyle(
                        color: LightTheme.lightGreyTheme,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
