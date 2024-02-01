import 'package:car_pool/view/navbar_pages/orderHistory/component/orders_states_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../state_controller.dart';
import '../components/title.dart';
import 'component/order_history_list.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    return Consumer<StateController>(builder: (context, controller, child) {
      return SingleChildScrollView(
        child: Column(
          children: [
            const MainTitle(title: 'Order History'),
            10.verticalSpace,
            const OrderStatesSection(),
            10.verticalSpace,
            const OrderHistoryList(),
          ],
        ),
      );
    });
  }
}
