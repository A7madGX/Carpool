import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../state_controller.dart';
import '../components/title.dart';
import '../orderHistory/component/orders_states_section.dart';
import 'components/receivedOrder_list.dart';

class ReceivedOrder extends StatefulWidget {
  const ReceivedOrder({super.key});

  @override
  State<ReceivedOrder> createState() => _ReceivedOrderState();
}

class _ReceivedOrderState extends State<ReceivedOrder> {
  @override
  Widget build(BuildContext context) {
    return Consumer<StateController>(builder: (context, controller, child) {
      return SingleChildScrollView(
        child: Column(
          children: [
            const MainTitle(title: 'Received Orders'),
            10.verticalSpace,
            const OrderStatesSection(),
            10.verticalSpace,
            const ReceivedOrderList(),
          ],
        ),
      );
    });
  }
}
