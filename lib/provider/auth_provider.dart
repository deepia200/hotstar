import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String? _userId;
  String? _password;

  String? _name;
  String? _email;
  String? _phone;
  Map<String, String>? _address;
  String? _documentImagePath;

  bool get isAuthenticated => _userId != null;

  String? get userId => _userId;
  String? get password => _password;
  String? get name => _name;
  String? get email => _email;
  String? get phone => _phone;
  Map<String, String>? get address => _address;
  String? get documentImagePath => _documentImagePath;

  AuthProvider() {
    _loadCredentials(); // Load on startup
  }

  // Set user credentials and save them
  void setUser({required String userId, required String password}) async {
    _userId = userId;
    _password = password;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
    await prefs.setString('password', password);
    notifyListeners();
  }

  bool login(String userId, String password) {
    return userId == _userId && password == _password;
  }

  void logout() async {
    _userId = null;
    _password = null;
    _name = null;
    _email = null;
    _phone = null;
    _address = null;
    _documentImagePath = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all stored data
    notifyListeners();
  }

  Future<void> _loadCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    _userId = prefs.getString('userId');
    _password = prefs.getString('password');
    _name = prefs.getString('name');
    _email = prefs.getString('email');
    _phone = prefs.getString('phone');

    final street = prefs.getString('address_street');
    final city = prefs.getString('address_city');
    final state = prefs.getString('address_state');
    final zip = prefs.getString('address_zip');

    if (street != null && city != null && state != null && zip != null) {
      _address = {
        'street': street,
        'city': city,
        'state': state,
        'zip': zip,
      };
    }

    _documentImagePath = prefs.getString('documentImagePath');

    notifyListeners();
  }

  void setName(String value) async {
    _name = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', value);
    notifyListeners();
  }

  void setEmail(String value) async {
    _email = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', value);
    notifyListeners();
  }

  void setPhone(String value) async {
    _phone = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('phone', value);
    notifyListeners();
  }

  void setAddress(Map<String, String> newAddress) async {
    _address = newAddress;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('address_street', newAddress['street'] ?? '');
    await prefs.setString('address_city', newAddress['city'] ?? '');
    await prefs.setString('address_state', newAddress['state'] ?? '');
    await prefs.setString('address_zip', newAddress['zip'] ?? '');
    notifyListeners();
  }

  void setDocumentImage(String path) async {
    _documentImagePath = path;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('documentImagePath', path);
    notifyListeners();
  }
}
