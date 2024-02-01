import 'package:car_pool/classes/themes/light_theme.dart';
import 'package:car_pool/classes/utils/filtered_order_history.dart';
import 'package:car_pool/state_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'order_container_state.dart';

class OrderHistoryList extends StatefulWidget {
  const OrderHistoryList({super.key});

  @override
  State<OrderHistoryList> createState() => _OrderHistoryListState();
}

class _OrderHistoryListState extends State<OrderHistoryList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<StateController>(builder: (context, ctrl, child) {
      // if (ctrl.reloadOrders) {
      //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //     ctrl.reloadMyOrders();
      //     ctrl.toggleReloadBool();
      //   });
      // }
      return Container(
        width: 1.sw,
        height: 443.h,
        decoration: BoxDecoration(
          color: LightTheme.backgroundTheme,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: FutureBuilder(
            future: ctrl.myOrders,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: LightTheme.mainTheme,
                  ),
                );
              }
              final ordersFetched = snapshot.data!;
              if (ordersFetched.isEmpty) {
                return SizedBox(
                  height: 420.h,
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Image.asset(
                      "assets/images/noNoti.png",
                      scale: 0.5,
                      color: LightTheme.thirdbackgroundTheme,
                    ),
                    10.verticalSpace,
                    Text(
                      'No Orders yet.',
                      style: TextStyle(
                          color: LightTheme.thirdbackgroundTheme,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp),
                    )
                  ]),
                );
              }
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 5.h),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ...getFilteredList(ordersFetched, ctrl.buttonPressed)
                          .map((order) => OrderHistoryContainer(order: order)),
                    ],
                  ),
                ),
              );
            }),
      );
    });
  }
}
