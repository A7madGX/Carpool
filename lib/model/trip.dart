import 'package:cloud_firestore/cloud_firestore.dart';

import '../classes/utils/statuses.dart';

class Trip {
  final String? id;
  final String? driverId;
  final String driverName;
  final int price;
  final String pickUpLocation;
  final String destination;
  final String tripDate;
  final TripStatus status;

  Trip({
    this.id,
    this.driverId,
    required this.driverName,
    required this.price,
    required this.pickUpLocation,
    required this.destination,
    required this.tripDate,
    required this.status,
  });

  static Trip emptyTrip() {
    return Trip(
      driverId: '0',
      driverName: '0',
      price: 0,
      pickUpLocation: '0',
      destination: '0',
      tripDate: '0',
      status: TripStatus.pending,
    );
  }

  factory Trip.fromJson(Map<String, dynamic> json) => Trip(
        driverId: json['driverId'] ?? '',
        driverName: json['driverName'] ?? '',
        price: json['price'] ?? '',
        pickUpLocation: json['from'] ?? '',
        destination: json['to'] ?? '',
        tripDate: json['tripDate'] ?? '',
        status: stringToTripStatus(json['status']),
      );

  factory Trip.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return Trip(
        id: document.id,
        driverId: data['driverId'],
        driverName: data["driverName"] ?? '',
        price: data["price"] ?? '',
        pickUpLocation: data['from'] ?? '',
        destination: data['to'] ?? '',
        tripDate: data['tripDate'] ?? '',
        status: stringToTripStatus(data['status']),
      );
    } else {
      return emptyTrip();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'driverId': driverId ?? '0000',
      'driverName': driverName,
      'price': price,
      'from': pickUpLocation,
      'to': destination,
      'tripDate': tripDate,
      'status': tripToString(status),
    };
  }
}
