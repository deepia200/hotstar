// lib/providers/user_provider.dart
import 'dart:io';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  // Profile (from signup or profile screen)
  String _name = 'John Doe';
  String _email = 'john@example.com';
  String _password = '123456';
  File? _profileImage;

  // KYC Info
  String _phone = '';
  String _address = '';
  String _govtId = '';

  // Distributor
  String _distributorId = '';

  // Getters
  String get name => _name;
  String get email => _email;
  String get password => _password;
  File? get profileImage => _profileImage;

  String get phone => _phone;
  String get address => _address;
  String get govtId => _govtId;

  String get distributorId => _distributorId;

  // Setters
  void updateProfile(String newName, String newEmail, String newPassword) {
    _name = newName;
    _email = newEmail;
    _password = newPassword;
    notifyListeners();
  }

  void updateProfileImage(File? imageFile) {
    _profileImage = imageFile;
    notifyListeners();
  }

  void setKycData(String phone, String address, String govtId) {
    _phone = phone;
    _address = address;
    _govtId = govtId;
    notifyListeners();
  }

  void setDistributorId(String id) {
    _distributorId = id;
    notifyListeners();
  }
}
