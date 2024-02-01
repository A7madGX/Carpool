import 'package:car_pool/model/trip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../classes/utils/statuses.dart';

class OrderHistory {
  final String? id;
  final String? userId;
  final String name;
  final String phoneNumber;
  final Trip trip;
  OrderStatus status;

  OrderHistory({
    this.id,
    this.userId,
    required this.name,
    required this.phoneNumber,
    required this.trip,
    required this.status,
  });

  static OrderHistory emptyOrderHistory() {
    return OrderHistory(
      id: '0',
      userId: '0',
      name: '0',
      phoneNumber: '0',
      trip: Trip.emptyTrip(),
      status: OrderStatus.none,
    );
  }

  factory OrderHistory.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return OrderHistory(
        id: document.id,
        userId: data['userId'],
        name: data['name'],
        phoneNumber: data['phoneNumber'],
        trip: Trip.fromJson(data['trip']),
        status: stringToStatus(data['status']),
      );
    }
    return emptyOrderHistory();
  }

  Map<String, dynamic> toJson() {
    return {
      'trip': trip.toJson(),
      'status': statusToString(status),
      'name': name,
      'phoneNumber': phoneNumber,
    };
  }
}
