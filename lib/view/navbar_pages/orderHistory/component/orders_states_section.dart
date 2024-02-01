import 'package:car_pool/classes/utils/statuses.dart';
import 'package:car_pool/view/navbar_pages/orderHistory/component/state_button.dart';
import 'package:flutter/material.dart';

class OrderStatesSection extends StatefulWidget {
  const OrderStatesSection({super.key});

  @override
  State<OrderStatesSection> createState() => _OrderStatesSectionState();
}

class _OrderStatesSectionState extends State<OrderStatesSection> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        StateButton(
          state: OrderStatus.pending,
        ),
        StateButton(
          state: OrderStatus.approved,
        ),
        StateButton(
          state: OrderStatus.rejected,
        ),
      ],
    );
  }
}
