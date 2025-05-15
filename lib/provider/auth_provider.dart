import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String? _userId;
  String? _password;
  String? _name;
  String? _email;
  String? _phone;
  Map<String, String>? _address;
  String? _fullAddress;
  String? _country;

  String? _aadhaarImagePath;
  String? _otherDocumentImagePath;
  bool _isKycVerified = false;

  // Getters
  bool get isAuthenticated => _userId != null;
  String? get userId => _userId;
  String? get password => _password;
  String? get name => _name;
  String? get email => _email;
  String? get phone => _phone;
  Map<String, String>? get address => _address;
  String? get fullAddress => _fullAddress;
  String? get country => _country;
  String? get aadhaarImagePath => _aadhaarImagePath;
  String? get otherDocumentImagePath => _otherDocumentImagePath;
  bool get isKycVerified => _isKycVerified;

  AuthProvider() {
    _loadCredentials();
  }

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
    _fullAddress = null;
    _country = null;
    _aadhaarImagePath = null;
    _otherDocumentImagePath = null;
    _isKycVerified = false;

    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    notifyListeners();
  }

  Future<void> _loadCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    _userId = prefs.getString('userId');
    _password = prefs.getString('password');
    _name = prefs.getString('name');
    _email = prefs.getString('email');
    _phone = prefs.getString('phone');
    _fullAddress = prefs.getString('fullAddress');
    _country = prefs.getString('country');

    final street = prefs.getString('address_street');
    final city = prefs.getString('address_city');
    final state = prefs.getString('address_state');
    final zip = prefs.getString('address_zip');

    if (city != null && state != null && zip != null) {
      _address = {
        'street': street ?? '',
        'city': city,
        'state': state,
        'zip': zip,
      };
    }

    _aadhaarImagePath = prefs.getString('aadhaarImagePath');
    _otherDocumentImagePath = prefs.getString('otherDocumentImagePath');
    _isKycVerified = prefs.getBool('isKycVerified') ?? false;

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

  void setFullAddress(String value) async {
    _fullAddress = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fullAddress', value);
    notifyListeners();
  }

  void setCountry(String value) async {
    _country = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('country', value);
    notifyListeners();
  }

  void setAadhaarImage(String path) async {
    _aadhaarImagePath = path;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('aadhaarImagePath', path);
    notifyListeners();
  }

  void setOtherDocumentImage(String path) async {
    _otherDocumentImagePath = path;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('otherDocumentImagePath', path);
    notifyListeners();
  }

  void completeKyc() async {
    _isKycVerified = true;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isKycVerified', true);
    notifyListeners();
  }
}
