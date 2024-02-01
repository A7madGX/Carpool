import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileInfo {
  final String? id;
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  final int balance;

  UserProfileInfo({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    this.balance = 5000,
  });

  static UserProfileInfo emptyUser() {
    return UserProfileInfo(
      id: '0',
      name: '0',
      email: '0',
      password: '0',
      phoneNumber: '0',
    );
  }

  factory UserProfileInfo.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserProfileInfo(
        id: document.id,
        name: data['name'] ?? '',
        email: data['email'] ?? '',
        password: data['password'] ?? '',
        phoneNumber: data['phoneNumber'] ?? '',
        balance: data['balance'] ?? '',
      );
    } else {
      return emptyUser();
    }
  }

  factory UserProfileInfo.fromLocal(Map<String, dynamic> json) => UserProfileInfo(
        id: json['ID'],
        name: json['NAME'],
        email: json['EMAIL'],
        password: json['PASSWORD'],
        phoneNumber: json['PHONE'],
        balance: json['BALANCE'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'phoneNumber': phoneNumber,
        'balance': balance,
      };
}
