// ignore_for_file: avoid_print
import 'package:car_pool/classes/utils/statuses.dart';
import 'package:car_pool/model/user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/order.dart';
import '../model/trip.dart';

abstract class UserService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static late String myUniqueId;

  static Future<void> initialize() async {
    myUniqueId = FirebaseAuth.instance.currentUser!.uid;
  }

  static Future<UserProfileInfo> getUserInfo() async {
    try {
      final documentSnapshot = await _db.collection('Users').doc(myUniqueId).get();
      if (documentSnapshot.exists) {
        return UserProfileInfo.fromSnapshot(documentSnapshot);
      } else {
        print('el doc fady ya walla');
        return UserProfileInfo.emptyUser();
      }
    } on Exception catch (e) {
      print(e.toString());
      return UserProfileInfo.emptyUser();
    }
  }

  static Future<void> addUser(UserProfileInfo user) async {
    try {
      await _db.collection('Users').doc(myUniqueId).set(user.toJson());
    } on Exception catch (e) {
      print(e.toString());
    }
  }

// User APIs ------------------------------------------------------------------------
  static Future<List<Trip>> getAvailableTrips() async {
    final List<Trip> availableTrips = [];
    try {
      final documentSnapshots = await _db.collection('Trips').get();
      for (var doc in documentSnapshots.docs) {
        final tripItem = Trip.fromSnapshot(doc);
        availableTrips.add(tripItem);
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return availableTrips;
  }

  static Future<List<OrderHistory>> getOrders() async {
    final List<OrderHistory> orders = [];
    try {
      final documentSnapshots = await _db
          .collection('Orders')
          .where(
            'userId',
            isEqualTo: myUniqueId,
          )
          .get();
      for (var doc in documentSnapshots.docs) {
        final tripItem = OrderHistory.fromSnapshot(doc);
        orders.add(tripItem);
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return orders;
  }

  static Future<void> addOrder(OrderHistory order) async {
    final body = order.toJson();
    body['userId'] = myUniqueId;
    try {
      await _db.collection('Orders').add(body);
      print('done');
    } on Exception catch (e) {
      print(e.toString());
    }
  }

// Driver APIs ------------------------------------------------------------------------
  static Future<void> addTrip(Trip trip) async {
    final body = trip.toJson();
    body['driverId'] = myUniqueId;
    try {
      await _db.collection('Trips').add(body);
      print('done');
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  static Future<List<Trip>> getDriverTrips() async {
    final List<Trip> trips = [];
    try {
      final documentSnapshots = await _db
          .collection('Trips')
          .where(
            'driverId',
            isEqualTo: myUniqueId,
          )
          .get();
      for (var doc in documentSnapshots.docs) {
        final tripItem = Trip.fromSnapshot(doc);
        trips.add(tripItem);
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return trips;
  }

  static Future<List<OrderHistory>> getDriverOrders() async {
    final List<OrderHistory> orders = [];
    try {
      final documentSnapshots = await _db.collection('Orders').get();
      for (var doc in documentSnapshots.docs) {
        if (doc.data()['trip']['driverId'] == myUniqueId) {
          final tripItem = OrderHistory.fromSnapshot(doc);
          orders.add(tripItem);
        }
      }
    } on Exception catch (e) {
      print(e.toString());
    }
    return orders;
  }

  static Future<void> editOrderStatus(String orderId, OrderStatus newStatus) async {
    final body = {
      'status': statusToString(newStatus),
    };
    try {
      await _db.collection('Orders').doc(orderId).update(body);
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  static Future<void> editTripStatus(String tripId, TripStatus newStatus) async {
    final body = {
      'status': tripToString(newStatus),
    };
    try {
      await _db.collection('Trips').doc(tripId).update(body);
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  static Future<void> editAmount(
      {required String userId, required String driverId, required int amount}) async {
    try {
      final userInfo = await _db.collection('Users').doc(userId).get();
      final oldUserBalance = userInfo.data()!['balance'];
      final newUserBalance = oldUserBalance - amount;

      final driverInfo = await _db.collection('Users').doc(driverId).get();
      final oldDriverBalance = driverInfo.data()!['balance'];
      final newDriverBalance = oldDriverBalance + amount;

      await _db.collection('Users').doc(userId).update({
        'balance': newUserBalance,
      });
      await _db.collection('Users').doc(driverId).update({
        'balance': newDriverBalance,
      });
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
