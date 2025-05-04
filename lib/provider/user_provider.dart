// lib/providers/profile_provider.dart
import 'dart:io';
import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  String _name = 'John Doe';
  String _email = 'john@example.com';
  String _password = '123456';
  File? _profileImage;

  String get name => _name;
  String get email => _email;
  String get password => _password;
  File? get profileImage => _profileImage;

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
}
