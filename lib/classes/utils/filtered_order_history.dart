import 'package:car_pool/classes/utils/statuses.dart';

import '../../model/order.dart';

List<OrderHistory> getFilteredList(List<OrderHistory> orders, OrderStatus status) {
  if (status == OrderStatus.none) return orders;
  return orders.where((order) => order.status == status).toList();
}
