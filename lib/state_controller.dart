import 'package:car_pool/localStorage/mydatabase.dart';
import 'package:car_pool/model/user_info.dart';
import 'package:car_pool/service/user_service.dart';
import 'package:flutter/material.dart';

import 'classes/themes/light_theme.dart';
import 'classes/utils/statuses.dart';
import 'model/order.dart';
import 'model/trip.dart';

class StateController extends ChangeNotifier {
  // Darkmode controller
  bool darkMode = false;
  void toggleThemeMode() {
    darkMode = !darkMode;
    LightTheme.toDarkMode(darkMode);
    notifyListeners();
  }

  // NavPages controller
  final PageController pgCtrl = PageController(initialPage: 0);
  int selectedpageIndex = 0;
  void selectPage(int index) {
    selectedpageIndex = index;
    notifyListeners();
  }

  void selectPageFromNav(int index) {
    pgCtrl.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.linear);
    notifyListeners();
  }

  // Settings controller
  int profilepageIndex = 0;
  void selectProfileIndex(int index) {
    profilepageIndex = index;
    notifyListeners();
  }

  // Reset Controllers
  void resetControllers() {
    profilepageIndex = 0;
    selectedpageIndex = 0;
    buttonPressed = OrderStatus.none;
    notifyListeners();
  }

  // Trips Controller
  final List<Trip> trips = [];
  // void addTrips(List<Trip> fetchedTrips) {
  //   trips = fetchedTrips;
  //   notifyListeners();
  // }

  Trip getTripById(String tripId) {
    if (trips.isEmpty) {
      return Trip.emptyTrip();
    }
    return trips.where((trip) => trip.driverId == tripId).first;
  }

  // Order State Controller
  OrderStatus buttonPressed = OrderStatus.none;
  void onStateButton(OrderStatus state) {
    buttonPressed = state;
    notifyListeners();
  }

  // Driver/Rider Mode
  bool isDriver = false;
  void toggleDriverMode() {
    isDriver = !isDriver;
    notifyListeners();
  }

  late Future<UserProfileInfo> myInfo;
  late Future<List<Trip>> availableTrips;
  late Future<List<OrderHistory>> myOrders;
  late Future<List<Trip>> myTrips;
  late Future<List<OrderHistory>> receivedOrders;

  late UserProfileInfo myFetchedInfo;
  // User Data Fetching
  void fetchAllUserData() {
    myInfo = UserService.getUserInfo();
    myInfo.then((value) => myFetchedInfo = value);
    availableTrips = UserService.getAvailableTrips();
    myOrders = UserService.getOrders();
    notifyListeners();
  }

  // Driver Data Fetching
  void fetchAllDriverData() {
    myInfo = UserService.getUserInfo();
    myInfo.then((value) {
      myFetchedInfo = value;
    });
    receivedOrders = UserService.getDriverOrders();
    myTrips = UserService.getDriverTrips();
    notifyListeners();
  }

  void insertUserInfoLocally() {
    myInfo.then((profileInfo) {
      LocalDatabase.writing('''
        INSERT INTO 'CARPOOL'
        ('ID', 'NAME', 'EMAIL', 'PHONE', 'PASSWORD', 'BALANCE') VALUES 
        ('${profileInfo.id}', '${profileInfo.name}', '${profileInfo.email}', '${profileInfo.phoneNumber}', '${profileInfo.password}', ${profileInfo.balance})
        ''');
    });
  }

  void updateUserInfoLocally() {
    myInfo.then((profileInfo) {
      LocalDatabase.updating('''
        UPDATE 'CARPOOL' SET
        'NAME' = '${profileInfo.name}',
        'EMAIL' = '${profileInfo.email}',
        'PHONE' = '${profileInfo.phoneNumber}',
        'PASSWORD' = '${profileInfo.password}',
        'BALANCE' = ${profileInfo.balance}
          WHERE ID = '${profileInfo.id}'
        ''');
    });
  }

  void reloadMyOrders() {
    if (isDriver) {
      receivedOrders = UserService.getDriverOrders();
    } else {
      myOrders = UserService.getOrders();
    }
    notifyListeners();
  }

  void reloadMyTrips() {
    myTrips = UserService.getDriverTrips();
    notifyListeners();
  }

  void reloadMyInfo() {
    myInfo = UserService.getUserInfo();
    updateUserInfoLocally();
    notifyListeners();
  }

  // Switch for time remaining
  bool closeRemainingTime = false;
  void toggleRemainingButton() {
    closeRemainingTime = !closeRemainingTime;
    notifyListeners();
  }
}
