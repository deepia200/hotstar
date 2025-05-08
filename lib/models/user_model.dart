import 'package:flutter/material.dart';

class UserModel with ChangeNotifier {
  String? name;
  String? email;
  String? userType; // 'Member' or 'Guest'
  String? userId;

  void setUser({
    required String userType,
    String? name,
    String? email,
    required String userId,
  }) {
    this.userType = userType;
    this.name = name;
    this.email = email;
    this.userId = userId;
    notifyListeners();
  }

  void clearUser() {
    name = null;
    email = null;
    userType = null;
    userId = null;
    notifyListeners();
  }
}
