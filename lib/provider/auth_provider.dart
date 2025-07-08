// // import 'dart:convert';
// //
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:shared_preferences/shared_preferences.dart';
// //
// // import '../service/api_service.dart';
// //
// // class AuthProvider extends ChangeNotifier {
// //
// //   String? _username;
// //   String? _password;
// //   String? _name;
// //   String? _email;
// //   String? _birthdate;
// //   String? _phone;
// //   Map<String, String>? _address;
// //   String? _fullAddress;
// //   String? _country;
// //
// //
// //
// //   String? _aadhaarImagePath;
// //   String? _otherDocumentImagePath;
// //   bool _isKycVerified = false;
// //
// //   // Getters
// //   bool get isAuthenticated => _username != null;
// //   String? get username => _username;
// //   String? get password => _password;
// //   String? get name => _name;
// //   String? get email => _email;
// //   String? get birthdate => _birthdate;
// //   String? get phone => _phone;
// //   Map<String, String>? get address => _address;
// //   String? get fullAddress => _fullAddress;
// //   String? get country => _country;
// //   String? get aadhaarImagePath => _aadhaarImagePath;
// //   String? get otherDocumentImagePath => _otherDocumentImagePath;
// //   bool get isKycVerified => _isKycVerified;
// //
// //   AuthProvider() {
// //     _loadCredentials();
// //   }
// //
// //   void setUser({required String username, required String password}) async {
// //     _username = username;
// //     _password = password;
// //     final prefs = await SharedPreferences.getInstance();
// //     await prefs.setString('username',username);
// //     await prefs.setString('password', password);
// //     notifyListeners();
// //   }
// //
// //   // bool login(String userId, String password) {
// //   //   return userId == _username && password == _password;
// //   // }
// //
// //   void logout() async {
// //     _username = null;
// //     _password = null;
// //     _name = null;
// //     _email = null;
// //     _phone = null;
// //     _address = null;
// //     _fullAddress = null;
// //     _country = null;
// //     _aadhaarImagePath = null;
// //     _otherDocumentImagePath = null;
// //     _isKycVerified = false;
// //
// //     final prefs = await SharedPreferences.getInstance();
// //     await prefs.clear();
// //     notifyListeners();
// //   }
// //
// //   Future<void> _loadCredentials() async {
// //     final prefs = await SharedPreferences.getInstance();
// //     _username = prefs.getString('username');
// //     _password = prefs.getString('password');
// //     _name = prefs.getString('name');
// //     _email = prefs.getString('email');
// //     _phone = prefs.getString('phone');
// //     _fullAddress = prefs.getString('fullAddress');
// //     _country = prefs.getString('country');
// //
// //     final street = prefs.getString('address_street');
// //     final city = prefs.getString('address_city');
// //     final state = prefs.getString('address_state');
// //     final zip = prefs.getString('address_zip');
// //
// //     if (city != null && state != null && zip != null) {
// //       _address = {
// //         'street': street ?? '',
// //         'city': city,
// //         'state': state,
// //         'zip': zip,
// //       };
// //     }
// //
// //     _aadhaarImagePath = prefs.getString('aadhaarImagePath');
// //     _otherDocumentImagePath = prefs.getString('otherDocumentImagePath');
// //     _isKycVerified = prefs.getBool('isKycVerified') ?? false;
// //
// //     notifyListeners();
// //   }
// //
// //   void setName(String value) async {
// //     _name = value;
// //     final prefs = await SharedPreferences.getInstance();
// //     await prefs.setString('name', value);
// //     notifyListeners();
// //   }
// //
// //   void setEmail(String value) async {
// //     _email = value;
// //     final prefs = await SharedPreferences.getInstance();
// //     await prefs.setString('email', value);
// //     notifyListeners();
// //   }
// //
// //   void setPhone(String value) async {
// //     _phone = value;
// //     final prefs = await SharedPreferences.getInstance();
// //     await prefs.setString('phone', value);
// //     notifyListeners();
// //   }
// //
// //   void setAddress(Map<String, String> newAddress) async {
// //     _address = newAddress;
// //     final prefs = await SharedPreferences.getInstance();
// //     await prefs.setString('address_street', newAddress['street'] ?? '');
// //     await prefs.setString('address_city', newAddress['city'] ?? '');
// //     await prefs.setString('address_state', newAddress['state'] ?? '');
// //     await prefs.setString('address_zip', newAddress['zip'] ?? '');
// //     notifyListeners();
// //   }
// //
// //   void setFullAddress(String value) async {
// //     _fullAddress = value;
// //     final prefs = await SharedPreferences.getInstance();
// //     await prefs.setString('fullAddress', value);
// //     notifyListeners();
// //   }
// //
// //   void setCountry(String value) async {
// //     _country = value;
// //     final prefs = await SharedPreferences.getInstance();
// //     await prefs.setString('country', value);
// //     notifyListeners();
// //   }
// //
// //   void setAadhaarImage(String path) async {
// //     _aadhaarImagePath = path;
// //     final prefs = await SharedPreferences.getInstance();
// //     await prefs.setString('aadhaarImagePath', path);
// //     notifyListeners();
// //   }
// //
// //   void setOtherDocumentImage(String path) async {
// //     _otherDocumentImagePath = path;
// //     final prefs = await SharedPreferences.getInstance();
// //     await prefs.setString('otherDocumentImagePath', path);
// //     notifyListeners();
// //   }
// //
// //   void completeKyc() async {
// //     _isKycVerified = true;
// //     final prefs = await SharedPreferences.getInstance();
// //     await prefs.setBool('isKycVerified', true);
// //     notifyListeners();
// //   }
// //
// //   Future<Map<String, dynamic>?> signup(Map<String, dynamic> body) async {
// //     final url = Uri.parse("https://stag.aanandi.in/reel_life_otts/public/api/ott/users");
// //     try {
// //       final response = await http.post(
// //         url,
// //         headers: {
// //           'Content-Type': 'application/json',
// //           'Accept': 'application/json',
// //         },
// //         body: jsonEncode(body),
// //       );
// //       if (response.statusCode == 200 || response.statusCode == 201) {
// //         final result = jsonDecode(response.body);
// //         final username = result['username']?.toString();
// //         // final username = result['username'];
// //
// //         if (username != null && username != null) {
// //           _username = username;
// //           _password = body['password'];
// //           _name = body['full_name'];
// //           _email = body['email'];
// //
// //           final prefs = await SharedPreferences.getInstance();
// //           await prefs.setString('userId', _username!);
// //           await prefs.setString('password', _password!);
// //           await prefs.setString('name', _name!);
// //           await prefs.setString('email', _email!);
// //
// //           notifyListeners();
// //         }
// //         return result;
// //       } else {
// //         print("Signup failed: ${response.body}");
// //       }
// //     } catch (e) {
// //       print("Signup error: $e");
// //     }
// //     return null;
// //   }
// //   Future<Map<String, dynamic>?> signupApiCall(String name, String email, String password, String userType) async {
// //     final url = Uri.parse('https://stag.aanandi.in/reel_life_otts/public/api/ott/users');
// //
// //     final response = await http.post(
// //       url,
// //       body: {
// //         'name': name,
// //         'email': email,
// //         'password': password,
// //         'user_type': userType,
// //       },
// //     );
// //
// //     if (response.statusCode == 200) {
// //       final data = json.decode(response.body);
// //       return data;
// //     } else {
// //       return null;
// //     }
// //   }
// //   Future<bool> login(String username, String password) async {
// //     final data = await ApiService.loginUser(username, password);
// //
// //     if (data != null) {
// //       _username = username;
// //       _password = password;
// //
// //       final prefs = await SharedPreferences.getInstance();
// //       await prefs.setString('username', username);
// //       await prefs.setString('password', password);
// //
// //       notifyListeners();
// //       return true;
// //     } else {
// //       return false;
// //     }
// //   }
// //
// //   Future<void> loadSavedLogin() async {
// //     final prefs = await SharedPreferences.getInstance();
// //     _username = prefs.getString('username');
// //     _password = prefs.getString('password');
// //     notifyListeners();
// //   }
// //   Future<bool> updateKycDetails({
// //     required String address,
// //     required String pincode,
// //     required String city,
// //     required String state,
// //     required String country,
// //   }) async {
// //     if (_username == null) {
// //       print("Cannot update KYC: Username is null.");
// //       return false;
// //     }
// //
// //     final success = await ApiService.updateKycDetails(
// //       username: _username!,
// //       address: address,
// //       pincode: pincode,
// //       city: city,
// //       state: state,
// //       country: country,
// //     );
// //
// //     if (success) {
// //       // Save to local state and SharedPreferences
// //       _fullAddress = address;
// //       _country = country;
// //       _address = {
// //         'street': '',
// //         'city': city,
// //         'state': state,
// //         'zip': pincode,
// //       };
// //
// //       final prefs = await SharedPreferences.getInstance();
// //       await prefs.setString('fullAddress', address);
// //       await prefs.setString('country', country);
// //       await prefs.setString('address_city', city);
// //       await prefs.setString('address_state', state);
// //       await prefs.setString('address_zip', pincode);
// //       await prefs.setString('address_street', '');
// //
// //       _isKycVerified = true;
// //       await prefs.setBool('isKycVerified', true);
// //
// //       notifyListeners();
// //       return true;
// //     } else {
// //       return false;
// //     }
// //   }
// //
// //
// // }
//
// //
// // import 'dart:convert';
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:shared_preferences/shared_preferences.dart';
// //
// // class AuthProvider extends ChangeNotifier {
// //   String? _username;
// //   String? _password;
// //   String? _name;
// //   String? _email;
// //   String? _birthdate;
// //   String? _phone;
// //   Map<String, String>? _address;
// //   String? _fullAddress;
// //   String? _country;
// //   String? _aadhaarImagePath;
// //   String? _otherDocumentImagePath;
// //   bool _isKycVerified = false;
// //
// //   // Getters
// //   bool get isAuthenticated => _username != null;
// //   String? get username => _username;
// //   String? get password => _password;
// //   String? get name => _name;
// //   String? get email => _email;
// //   String? get birthdate => _birthdate;
// //   String? get phone => _phone;
// //   Map<String, String>? get address => _address;
// //   String? get fullAddress => _fullAddress;
// //   String? get country => _country;
// //   String? get aadhaarImagePath => _aadhaarImagePath;
// //   String? get otherDocumentImagePath => _otherDocumentImagePath;
// //   bool get isKycVerified => _isKycVerified;
// //
// //   AuthProvider() {
// //     _loadCredentials();
// //   }
// //
// //   Future<void> _loadCredentials() async {
// //     final prefs = await SharedPreferences.getInstance();
// //     _username = prefs.getString('username');
// //     _password = prefs.getString('password');
// //     _name = prefs.getString('name');
// //     _email = prefs.getString('email');
// //     _birthdate = prefs.getString('birthdate');
// //     _phone = prefs.getString('phone');
// //     _fullAddress = prefs.getString('fullAddress');
// //     _country = prefs.getString('country');
// //
// //     final street = prefs.getString('address_street');
// //     final city = prefs.getString('address_city');
// //     final state = prefs.getString('address_state');
// //     final zip = prefs.getString('address_zip');
// //
// //     if (city != null && state != null && zip != null) {
// //       _address = {
// //         'street': street ?? '',
// //         'city': city,
// //         'state': state,
// //         'zip': zip,
// //       };
// //     }
// //
// //     _aadhaarImagePath = prefs.getString('aadhaarImagePath');
// //     _otherDocumentImagePath = prefs.getString('otherDocumentImagePath');
// //     _isKycVerified = prefs.getBool('isKycVerified') ?? false;
// //
// //     notifyListeners();
// //   }
// //
// //   Future<void> setUserData(Map<String, dynamic> data) async {
// //     final prefs = await SharedPreferences.getInstance();
// //     _name = data['full_name'];
// //     _email = data['email'];
// //     _password = data['password'];
// //     _birthdate = data['birthdate'];
// //
// //     await prefs.setString('name', _name ?? '');
// //     await prefs.setString('email', _email ?? '');
// //     await prefs.setString('password', _password ?? '');
// //     if (_birthdate != null) {
// //       await prefs.setString('birthdate', _birthdate!);
// //     }
// //
// //     notifyListeners();
// //   }
// //
// //   Future<void> logout() async {
// //     _username = null;
// //     _password = null;
// //     _name = null;
// //     _email = null;
// //     _birthdate = null;
// //     _phone = null;
// //     _address = null;
// //     _fullAddress = null;
// //     _country = null;
// //     _aadhaarImagePath = null;
// //     _otherDocumentImagePath = null;
// //     _isKycVerified = false;
// //
// //     final prefs = await SharedPreferences.getInstance();
// //     await prefs.clear();
// //     notifyListeners();
// //   }
// //
// //   Future<void> setUser({required String username, required String password}) async {
// //     _username = username;
// //     _password = password;
// //     final prefs = await SharedPreferences.getInstance();
// //     await prefs.setString('username', username);
// //     await prefs.setString('password', password);
// //     notifyListeners();
// //   }
// //
// //   Future<void> setName(String value) async {
// //     _name = value;
// //     final prefs = await SharedPreferences.getInstance();
// //     await prefs.setString('name', value);
// //     notifyListeners();
// //   }
// //
// //   Future<void> setEmail(String value) async {
// //     _email = value;
// //     final prefs = await SharedPreferences.getInstance();
// //     await prefs.setString('email', value);
// //     notifyListeners();
// //   }
// //
// //   Future<void> setBirthdate(String value) async {
// //     _birthdate = value;
// //     final prefs = await SharedPreferences.getInstance();
// //     await prefs.setString('birthdate', value);
// //     notifyListeners();
// //   }
// //
// //   Future<void> setPhone(String value) async {
// //     _phone = value;
// //     final prefs = await SharedPreferences.getInstance();
// //     await prefs.setString('phone', value);
// //     notifyListeners();
// //   }
// //
// //   Future<void> setAddress(Map<String, String> newAddress) async {
// //     _address = newAddress;
// //     final prefs = await SharedPreferences.getInstance();
// //     await prefs.setString('address_street', newAddress['street'] ?? '');
// //     await prefs.setString('address_city', newAddress['city'] ?? '');
// //     await prefs.setString('address_state', newAddress['state'] ?? '');
// //     await prefs.setString('address_zip', newAddress['zip'] ?? '');
// //     notifyListeners();
// //   }
// //
// //   Future<void> setFullAddress(String value) async {
// //     _fullAddress = value;
// //     final prefs = await SharedPreferences.getInstance();
// //     await prefs.setString('fullAddress', value);
// //     notifyListeners();
// //   }
// //
// //   Future<void> setCountry(String value) async {
// //     _country = value;
// //     final prefs = await SharedPreferences.getInstance();
// //     await prefs.setString('country', value);
// //     notifyListeners();
// //   }
// //
// //   Future<void> setAadhaarImage(String path) async {
// //     _aadhaarImagePath = path;
// //     final prefs = await SharedPreferences.getInstance();
// //     await prefs.setString('aadhaarImagePath', path);
// //     notifyListeners();
// //   }
// //
// //   Future<void> setOtherDocumentImage(String path) async {
// //     _otherDocumentImagePath = path;
// //     final prefs = await SharedPreferences.getInstance();
// //     await prefs.setString('otherDocumentImagePath', path);
// //     notifyListeners();
// //   }
// //
// //   Future<void> completeKyc() async {
// //     _isKycVerified = true;
// //     final prefs = await SharedPreferences.getInstance();
// //     await prefs.setBool('isKycVerified', true);
// //     notifyListeners();
// //   }
// //
// //   Future<Map<String, dynamic>?> signup(Map<String, dynamic> body) async {
// //     final url = Uri.parse("https://stag.aanandi.in/reel_life_otts/public/api/ott/users");
// //     try {
// //       final response = await http.post(
// //         url,
// //         headers: {'Content-Type': 'application/json'},
// //         body: jsonEncode(body),
// //       );
// //
// //       if (response.statusCode == 200 || response.statusCode == 201) {
// //         final result = jsonDecode(response.body);
// //         final username = result['username']?.toString();
// //         if (username != null) {
// //           _username = username;
// //           _password = body['password'];
// //           _name = body['full_name'];
// //           _email = body['email'];
// //
// //           final prefs = await SharedPreferences.getInstance();
// //           await prefs.setString('username', _username!);
// //           await prefs.setString('password', _password!);
// //           await prefs.setString('name', _name!);
// //           await prefs.setString('email', _email!);
// //           notifyListeners();
// //         }
// //         return result;
// //       } else {
// //         print("Signup failed: ${response.body}");
// //       }
// //     } catch (e) {
// //       print("Signup error: $e");
// //     }
// //     return null;
// //   }
// //
// //   Future<bool> login(String username, String password) async {
// //     final url = Uri.parse("https://stag.aanandi.in/reel_life_otts/public/api/ott/login");
// //     try {
// //       final response = await http.post(
// //         url,
// //         body: {'username': username, 'password': password},
// //       );
// //       print("Login response: ${response.body}");
// //
// //       if (response.statusCode == 200) {
// //         _username = username;
// //         _password = password;
// //
// //         final prefs = await SharedPreferences.getInstance();
// //         await prefs.setString('username', username);
// //         await prefs.setString('password', password);
// //
// //         notifyListeners();
// //         return true;
// //       } else {
// //         print("Login failed: ${response.body}");
// //         return false;
// //       }
// //     } catch (e) {
// //       print("Login error: $e");
// //       return false;
// //     }
// //   }
// //
// //   Future<void> loadSavedLogin() async {
// //     final prefs = await SharedPreferences.getInstance();
// //     _username = prefs.getString('username');
// //     _password = prefs.getString('password');
// //     notifyListeners();
// //   }
// //
// //   Future<bool> submitKycDetails({
// //     required String address,
// //     required String pincode,
// //     required String city,
// //     required String state,
// //     required String country,
// //     required String phone,
// //   }) async {
// //     final url = Uri.parse("https://stag.aanandi.in/reel_life_otts/public/api/ott/kyc");
// //
// //     try {
// //       final response = await http.post(
// //         url,
// //         headers: {'Content-Type': 'application/json'},
// //         body: jsonEncode({
// //           "username": _username,
// //           "address": address,
// //           "pincode": pincode,
// //           "city": city,
// //           "state": state,
// //           "country": country,
// //           "phone": phone,
// //         }),
// //       );
// //
// //       if (response.statusCode == 200 || response.statusCode == 201) {
// //         await setFullAddress(address);
// //         await setCountry(country);
// //         await setAddress({'street': '', 'city': city, 'state': state, 'zip': pincode});
// //         await setPhone(phone);
// //         await completeKyc();
// //         return true;
// //       } else {
// //         print("KYC POST failed: ${response.body}");
// //         return false;
// //       }
// //     } catch (e) {
// //       print("KYC POST error: $e");
// //       return false;
// //     }
// //   }
// //
// //   Future<void> fetchUserDetails(int userId) async {
// //     final url = 'https://stag.aanandi.in/reel_life_otts/public/api/ott/users/$userId';
// //     try {
// //       final response = await http.get(Uri.parse(url));
// //       if (response.statusCode == 200) {
// //         final data = json.decode(response.body);
// //         final user = data['data'];
// //
// //         await setName(user['full_name']);
// //         await setEmail(user['email']);
// //         await setBirthdate(user['date_of_birth']);
// //       } else {
// //         print("Failed to fetch user: ${response.statusCode}");
// //       }
// //     } catch (e) {
// //       print("Error fetching user: $e");
// //     }
// //   }
// //
// //   Future<void> fetchUserData(String userId) async {
// //     try {
// //       final response = await http.get(Uri.parse('https://stag.aanandi.in/reel_life_otts/public/api/ott/users/$userId'));
// //       if (response.statusCode == 200) {
// //         final data = jsonDecode(response.body);
// //         await setName(data['name']);
// //         await setEmail(data['email']);
// //         await setBirthdate(data['dob']);
// //         await setPhone(data['phone']);
// //         await setFullAddress(data['full_address']);
// //         await setAddress({
// //           'zip': data['zip'],
// //           'city': data['city'],
// //           'state': data['state'],
// //           'street': data['street'] ?? '',
// //         });
// //         await setCountry(data['country']);
// //       }
// //     } catch (e) {
// //       print('Failed to fetch user data: $e');
// //     }
// //   }
// // }
//
// // Same import section
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:hotstar/service/api_methods.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../service/api_service.dart';
//
// class AuthProvider extends ChangeNotifier {
//   String? _username;
//   String? _password;
//   String? _fname;
//   String? _email;
//   String? _birthdate;
//   String? _phone;
//   Map<String, String>? _address;
//   String? _fullAddress;
//   String? _country;
//   String? _aadhaarImagePath;
//   String? _otherDocumentImagePath;
//   bool _isKycVerified = false;
//
//   // Getters
//   bool get isAuthenticated => _username != null;
//
//   String? get username => _username;
//
//   String? get password => _password;
//
//   String? get fname => _fname;
//
//   String? get email => _email;
//
//   String? get birthdate => _birthdate;
//
//   String? get phone => _phone;
//
//   Map<String, String>? get address => _address;
//
//   String? get fullAddress => _fullAddress;
//
//   String? get country => _country;
//
//   String? get aadhaarImagePath => _aadhaarImagePath;
//
//   String? get otherDocumentImagePath => _otherDocumentImagePath;
//
//   bool get isKycVerified => _isKycVerified;
//
//   AuthProvider() {
//     _loadCredentials();
//   }
//
//   Future<void> _loadCredentials() async {
//     final prefs = await SharedPreferences.getInstance();
//     _username = prefs.getString('username');
//     _password = prefs.getString('password');
//     _fname = prefs.getString('fname');
//     _email = prefs.getString('email');
//     _phone = prefs.getString('phone');
//     _fullAddress = prefs.getString('fullAddress');
//     _country = prefs.getString('country');
//
//     final street = prefs.getString('address_street');
//     final city = prefs.getString('address_city');
//     final state = prefs.getString('address_state');
//     final zip = prefs.getString('address_zip');
//
//     if (city != null && state != null && zip != null) {
//       _address = {
//         'street': street ?? '',
//         'city': city,
//         'state': state,
//         'zip': zip,
//       };
//     }
//
//     _aadhaarImagePath = prefs.getString('aadhaarImagePath');
//     _otherDocumentImagePath = prefs.getString('otherDocumentImagePath');
//     _isKycVerified = prefs.getBool('isKycVerified') ?? false;
//
//     notifyListeners();
//   }
//
//   void logout() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.clear();
//     _username = null;
//     _password = null;
//     _fname = null;
//     _email = null;
//     _phone = null;
//     _address = null;
//     _fullAddress = null;
//     _country = null;
//     _aadhaarImagePath = null;
//     _otherDocumentImagePath = null;
//     _isKycVerified = false;
//     notifyListeners();
//   }
//
//   void setUser({required String id, required String password}) async {
//     _username = id;
//     _password = password;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('username', id);
//     await prefs.setString('password', password);
//     notifyListeners();
//   }
//
//   void setName(String value) async {
//     _fname = value;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('fname', value);
//     notifyListeners();
//   }
//
//   void setEmail(String value) async {
//     _email = value;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('email', value);
//     notifyListeners();
//   }
//
//   void setPhone(String value) async {
//     _phone = value;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('phone', value);
//     notifyListeners();
//   }
//
//   void setAddress(Map<String, String> newAddress) async {
//     _address = newAddress;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('address_street', newAddress['street'] ?? '');
//     await prefs.setString('address_city', newAddress['city'] ?? '');
//     await prefs.setString('address_state', newAddress['state'] ?? '');
//     await prefs.setString('address_zip', newAddress['zip'] ?? '');
//     notifyListeners();
//   }
//
//   void setFullAddress(String value) async {
//     _fullAddress = value;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('fullAddress', value);
//     notifyListeners();
//   }
//
//   void setCountry(String value) async {
//     _country = value;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('country', value);
//     notifyListeners();
//   }
//
//   void setAadhaarImage(String path) async {
//     _aadhaarImagePath = path;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('aadhaarImagePath', path);
//     notifyListeners();
//   }
//
//   void setOtherDocumentImage(String path) async {
//     _otherDocumentImagePath = path;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('otherDocumentImagePath', path);
//     notifyListeners();
//   }
//
//   void completeKyc() async {
//     _isKycVerified = true;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isKycVerified', true);
//     notifyListeners();
//   }
//
// //login
//   Future<Map<String, dynamic>> login(String id, String password) async {
//     try {
//       final data = await ApiMethods.login(id, password);
//
//       _username = id;
//       _password = password;
//
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString("userdetails", jsonEncode(data));
//       await prefs.setString('id', id); // Saving as username for consistency
//       await prefs.setString('password', password);
//       await prefs.setString('memberType', data['member_type'].toString());
//
//       notifyListeners();
//       return data;
//     } catch (e) {
//       print("Login error in provider: $e");
//       return {};
//     }
//   }
//
//
//   Future<void> loadSavedLogin() async {
//     final prefs = await SharedPreferences.getInstance();
//     _username = prefs.getString('id'); // ✅ fix key
//     _password = prefs.getString('password');
//     notifyListeners();
//   }
//
//
//
//   // --- KYC Form Submission ---
//   // Future<bool> submitKycDetails({
//   //   required String phone,
//   //   required String username,
//   //   required String address,
//   //   required String pincode,
//   //   required String city,
//   //   required String state,
//   //   required String country,
//   //   required File aadhaarImage,
//   //   File? otherDocImage,
//   // }) async {
//   //   try {
//   //     final uri = Uri.parse('https://stag.aanandi.in/reel_life_otts/public/api/ott/kyc');
//   //     final request = http.MultipartRequest('POST', uri);
//   //
//   //     // Add text fields
//   //     request.fields['phone'] = phone;
//   //     request.fields['username'] = username;
//   //     request.fields['address'] = address;
//   //     request.fields['pincode'] = pincode;
//   //     request.fields['city'] = city;
//   //     request.fields['state'] = state;
//   //     request.fields['country'] = country;
//   //
//   //     print('KYC Payload:');
//   //     print('username: $username');
//   //     print('Phone: $phone');
//   //     print('Address: $address');
//   //     print('Pincode: $pincode');
//   //     print('City: $city');
//   //     print('State: $state');
//   //     print('Country: $country');
//   //     print('Aadhaar Path: ${aadhaarImage.path}');
//   //     if (otherDocImage != null) {
//   //       print('Other Doc Path: ${otherDocImage.path}');
//   //     }
//   //
//   //
//   //     // Add Aadhaar image (required)
//   //     request.files.add(
//   //       await http.MultipartFile.fromPath('aadhaar_card', aadhaarImage.path),
//   //     );
//   //
//   //     // Add other optional document
//   //     if (otherDocImage != null) {
//   //       request.files.add(
//   //         await http.MultipartFile.fromPath('other_document', otherDocImage.path),
//   //       );
//   //     }
//   //
//   //     // Send the request
//   //     final response = await request.send();
//   //     final responseBody = await response.stream.bytesToString();
//   //     final responseData = jsonDecode(responseBody);
//   //
//   //     print('KYC response status: ${response.statusCode}');
//   //     print('KYC response body: $responseData');
//   //
//   //     // Check for API success response
//   //     if ((response.statusCode == 200 && responseData['status'] == 'success') ||
//   //         (response.statusCode == 400 && responseData['message'] == 'No changes made to user data')) {
//   //       return true;
//   //     }
//   //
//   //     else {
//   //       print('KYC submission failed: ${responseData['message']}');
//   //       return false;
//   //     }
//   //   } catch (e) {
//   //     print('Error during KYC: $e');
//   //     return false;
//   //   }
//   // }
//   //kyc details
//   Future<bool> submitKycDetails({
//     required String username,
//     required String phone,
//     required String address,
//     required String pincode,
//     required String city,
//     required String state,
//     required String country,
//     required File aadhaarImage,
//     File? panCardImage,
//     File? otherDocImage,
//   }) async {
//     return await ApiService.submitKycDetails(
//       username: username,
//       phone: phone,
//       address: address,
//       pincode: pincode,
//       city: city,
//       state: state,
//       country: country,
//       aadhaarImage: aadhaarImage,
//       panCardImage: panCardImage,
//       otherDocImage: otherDocImage,
//     );
//   }
//
//   // Add this method to fetch user details by ID
//   Future<void> fetchUserDetailsById(String userId) async {
//     try {
//       final userData = await ApiService.fetchUserDetailsById(userId);
//
//       _username = userData['username'];
//       _email = userData['email'];
//       _fname = userData['fname'];
//       _phone = userData['phone'];
//       _birthdate = userData['date_of_birth'];
//       _fullAddress = userData['full_address'];
//       _country = userData['Country'];
//
//       _address = {
//         'city': userData['city'],
//         'state': userData['State'],
//         'zip': userData['Pincode'].toString(),
//         'street': '',
//       };
//
//       if (userData['aadhaar_card'] != null) {
//         _aadhaarImagePath = userData['aadhaar_card'];
//       }
//
//       if (userData['pan_card'] != null) {
//         _otherDocumentImagePath = userData['pan_card'];
//       }
//
//       _isKycVerified = _fname != null &&
//           _phone != null &&
//           _fullAddress != null &&
//           _address != null &&
//           _aadhaarImagePath != null;
//
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString('username', _username ?? '');
//       await prefs.setString('email', _email ?? '');
//       await prefs.setString('fname', _fname ?? '');
//       await prefs.setString('phone', _phone ?? '');
//       await prefs.setString('birthdate', _birthdate ?? '');
//       await prefs.setString('fullAddress', _fullAddress ?? '');
//       await prefs.setString('country', _country ?? '');
//
//       if (_address != null) {
//         await prefs.setString('address_city', _address!['city'] ?? '');
//         await prefs.setString('address_state', _address!['state'] ?? '');
//         await prefs.setString('address_zip', _address!['zip'] ?? '');
//       }
//
//       if (_aadhaarImagePath != null) {
//         await prefs.setString('aadhaarImagePath', _aadhaarImagePath!);
//       }
//
//       if (_otherDocumentImagePath != null) {
//         await prefs.setString('otherDocumentImagePath', _otherDocumentImagePath!);
//       }
//
//       await prefs.setBool('isKycVerified', _isKycVerified);
//
//       notifyListeners();
//     } catch (e) {
//       print("Fetch user error: $e");
//     }
//   }
//
//
//
// }
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hotstar/service/api_methods.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  String? _id;
  String? _password;
  String? _fname;
  String? _email;
  String? _birthdate;
  String? _phone;
  String? _memberType;
  Map<String, String>? _address;
  String? _fullAddress;
  String? _country;
  String? _pan;
  String? _bank;
  String? _ifsc;
  String? _acno;
  String? _aadhaarImagePath;
  String? _otherDocumentImagePath;
  String? _bankScanImagePath;
  String? _profileImage;
  bool _isKycVerified = false;

  // Getters
  bool get isAuthenticated => _id != null;

  String? get id => _id;
  String? get password => _password;
  String? get fname => _fname;
  String? get email => _email;
  String? get birthdate => _birthdate;
  String? get phone => _phone;
  String? get memberType => _memberType;
  Map<String, String>? get address => _address;
  String? get fullAddress => _fullAddress;
  String? get country => _country;
  String? get pan => _pan;
  String? get bank => _bank;
  String? get ifsc => _ifsc;
  String? get acno => _acno;
  String? get aadhaarImagePath => _aadhaarImagePath;
  String? get otherDocumentImagePath => _otherDocumentImagePath;
  String? get bankScanImagePath => _bankScanImagePath;
  String? get profileImage => _profileImage;
  bool get isKycVerified => _isKycVerified;

  AuthProvider() {
    loadCredentials();
  }

  Future<void> loadCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    _id = prefs.getString('id');
    _password = prefs.getString('password');
    _fname = prefs.getString('fname');
    _email = prefs.getString('email');
    _phone = prefs.getString('phone');
    _memberType = prefs.getString('memberType');
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
    _bankScanImagePath = prefs.getString('bankScanImagePath');
    _profileImage = prefs.getString('profileImage');
    _isKycVerified = prefs.getBool('isKycVerified') ?? false;

    notifyListeners();
  }

  Future<void> loadSavedLogin() async {
    final prefs = await SharedPreferences.getInstance();
    _id = prefs.getString('id');
    _password = prefs.getString('password');
    _memberType = prefs.getString('memberType');
    notifyListeners();
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    _id = null;
    _password = null;
    _fname = null;
    _email = null;
    _phone = null;
    _memberType = null;
    _address = null;
    _fullAddress = null;
    _country = null;
    _aadhaarImagePath = null;
    _otherDocumentImagePath = null;
    _bankScanImagePath = null;
    _profileImage = null;
    _isKycVerified = false;

    notifyListeners();
  }

  Future<Map<String, dynamic>> login(String id, String password) async {
    try {
      final data = await ApiMethods.login(id, password);

      _id = id;
      _password = password;
      _fname = data['fname'];
      _email = data['email'];
      _memberType = data['member_type'].toString();

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("userdetails", jsonEncode(data));
      await prefs.setString('id', id);
      await prefs.setString('password', password);
      await prefs.setString('memberType', _memberType ?? '');
      await prefs.setString('fname', _fname ?? '');
      await prefs.setString('email', _email ?? '');

      notifyListeners();
      return data;
    } catch (e) {
      print("Login error in provider: $e");
      return {};
    }
  }

  void setUser({required String id, required String password}) async {
    _id = id;
    _password = password;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', id);
    await prefs.setString('password', password);
    notifyListeners();
  }

  void setName(String value) async {
    _fname = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fname', value);
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

  Future<bool> submitKycDetails({
    required String username,
    required String phone,
    required String address,
    required String pincode,
    required String city,
    required String state,
    required String country,
    required String panNumber,
    required String adharNumber,
    required String bankName,
    required String ifscCode,
    required String accountNumber,
    required String beneficiaryName,
  }) async {
    return await ApiMethods.submitKycDetails(
      id: username,
      phone: phone,
      address: address,
      pincode: pincode,
      city: city,
      state: state,
      country: country,
      panNumber: panNumber,
      adharNumber: adharNumber,
      bankName: bankName,
      ifscCode: ifscCode,
      accountNumber: accountNumber,
      beneficiaryName: beneficiaryName,
    );
  }

  Future<void> fetchUserDetailsById(String id) async {
    try {
      final userData = await ApiMethods.fetchUserDetailsById(id);

      _id = userData['id'];
      _fname = userData['fname'];
      _email = userData['email'];
      _phone = userData['phone'];
      _birthdate = userData['dob'];
      _fullAddress = userData['address'];
      _country = userData['country'];
      _pan = userData['pan'];
      _bank = userData['bank'];
      _ifsc = userData['ifsc'];
      _acno = userData['acno'];
      _memberType = userData['member_type'].toString();

      _address = {
        'city': userData['city'],
        'state': userData['state'],
        'zip': userData['pin'].toString(),
      };

      _aadhaarImagePath = userData['aadhar_scan'];
      _otherDocumentImagePath = userData['pan_scan'];
      _bankScanImagePath = userData['bank_scan'];
      _profileImage = userData['img'];

      _isKycVerified = _fname != null &&
          _phone != null &&
          _fullAddress != null &&
          _aadhaarImagePath != null &&
          _pan != null;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('id', _id ?? '');
      await prefs.setString('fname', _fname ?? '');
      await prefs.setString('email', _email ?? '');
      await prefs.setString('phone', _phone ?? '');
      await prefs.setString('birthdate', _birthdate ?? '');
      await prefs.setString('fullAddress', _fullAddress ?? '');
      await prefs.setString('country', _country ?? '');
      await prefs.setString('pan', _pan ?? '');
      await prefs.setString('bank', _bank ?? '');
      await prefs.setString('ifsc', _ifsc ?? '');
      await prefs.setString('acno', _acno ?? '');
      await prefs.setString('memberType', _memberType ?? '');

      if (_address != null) {
        await prefs.setString('address_city', _address!['city'] ?? '');
        await prefs.setString('address_state', _address!['state'] ?? '');
        await prefs.setString('address_zip', _address!['zip'] ?? '');
      }

      await prefs.setString('aadhaarImagePath', _aadhaarImagePath ?? '');
      await prefs.setString('otherDocumentImagePath', _otherDocumentImagePath ?? '');
      await prefs.setString('bankScanImagePath', _bankScanImagePath ?? '');
      await prefs.setString('profileImage', _profileImage ?? '');
      await prefs.setBool('isKycVerified', _isKycVerified);

      notifyListeners();
    } catch (e) {
      print("Fetch user error: $e");
    }
  }

  Future<void> uploadProfileImage(File file) async {
    if (_id == null) return;

    final result = await ApiMethods.uploadProfileImage(id: _id!, imageFile: file);
    if (result) {
      await fetchUserDetailsById(_id!);
    }
  }
}


// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:hotstar/service/api_methods.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../service/api_service.dart';
//
// class AuthProvider extends ChangeNotifier {
//   String? _id;
//   String? _password;
//   String? _fname;
//   String? _email;
//   String? _birthdate;
//   String? _phone;
//   Map<String, String>? _address;
//   String? _fullAddress;
//   String? _country;
//   String? _pan;
//   String? _bank;
//   String? _ifsc;
//   String? _acno;
//   String? _aadhaarImagePath;
//   String? _otherDocumentImagePath;
//   String? _bankScanImagePath;
//   String? _profileImage;
//   bool _isKycVerified = false;
//
//   // Getters
//   bool get isAuthenticated => _id != null;
//
//   String? get id => _id;
//   String? get password => _password;
//   String? get fname => _fname;
//   String? get email => _email;
//   String? get birthdate => _birthdate;
//   String? get phone => _phone;
//   Map<String, String>? get address => _address;
//   String? get fullAddress => _fullAddress;
//   String? get country => _country;
//   String? get pan => _pan;
//   String? get bank => _bank;
//   String? get ifsc => _ifsc;
//   String? get acno => _acno;
//   String? get aadhaarImagePath => _aadhaarImagePath;
//   String? get otherDocumentImagePath => _otherDocumentImagePath;
//   String? get bankScanImagePath => _bankScanImagePath;
//   String? get profileImage => _profileImage;
//   bool get isKycVerified => _isKycVerified;
//
//   AuthProvider() {
//     loadCredentials();
//   }
//
//   Future<void> loadCredentials() async {
//     final prefs = await SharedPreferences.getInstance();
//     _id = prefs.getString('id');
//     _password = prefs.getString('password');
//     _fname = prefs.getString('fname');
//     _email = prefs.getString('email');
//     _phone = prefs.getString('phone');
//     _fullAddress = prefs.getString('fullAddress');
//     _country = prefs.getString('country');
//
//     final street = prefs.getString('address_street');
//     final city = prefs.getString('address_city');
//     final state = prefs.getString('address_state');
//     final zip = prefs.getString('address_zip');
//
//     if (city != null && state != null && zip != null) {
//       _address = {
//         'street': street ?? '',
//         'city': city,
//         'state': state,
//         'zip': zip,
//       };
//     }
//
//     _aadhaarImagePath = prefs.getString('aadhaarImagePath');
//     _otherDocumentImagePath = prefs.getString('otherDocumentImagePath');
//     _isKycVerified = prefs.getBool('isKycVerified') ?? false;
//
//     notifyListeners();
//   }
//
//   void logout() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.clear();
//     _id = null;
//     _password = null;
//     _fname = null;
//     _email = null;
//     _phone = null;
//     _address = null;
//     _fullAddress = null;
//     _country = null;
//     _aadhaarImagePath = null;
//     _otherDocumentImagePath = null;
//     _isKycVerified = false;
//     _profileImage = null;
//
//     notifyListeners();
//   }
//
//
//   void setUser({required String id, required String password}) async {
//     _id = id;
//     _password = password;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('id', id);
//     await prefs.setString('password', password);
//     notifyListeners();
//   }
//
//   void setName(String value) async {
//     _fname = value;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('fname', value);
//     notifyListeners();
//   }
//
//   void setEmail(String value) async {
//     _email = value;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('email', value);
//     notifyListeners();
//   }
//
//   void setPhone(String value) async {
//     _phone = value;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('phone', value);
//     notifyListeners();
//   }
//
//   void setAddress(Map<String, String> newAddress) async {
//     _address = newAddress;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('address_street', newAddress['street'] ?? '');
//     await prefs.setString('address_city', newAddress['city'] ?? '');
//     await prefs.setString('address_state', newAddress['state'] ?? '');
//     await prefs.setString('address_zip', newAddress['zip'] ?? '');
//     notifyListeners();
//   }
//
//   void setFullAddress(String value) async {
//     _fullAddress = value;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('fullAddress', value);
//     notifyListeners();
//   }
//
//   void setCountry(String value) async {
//     _country = value;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('country', value);
//     notifyListeners();
//   }
//
//   void setAadhaarImage(String path) async {
//     _aadhaarImagePath = path;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('aadhaarImagePath', path);
//     notifyListeners();
//   }
//
//   void setOtherDocumentImage(String path) async {
//     _otherDocumentImagePath = path;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('otherDocumentImagePath', path);
//     notifyListeners();
//   }
//
//   void completeKyc() async {
//     _isKycVerified = true;
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isKycVerified', true);
//     notifyListeners();
//   }
//
//   // Login method
//   Future<Map<String, dynamic>> login(String id, String password) async {
//     try {
//       final data = await ApiMethods.login(id, password);
//
//       _id = id;
//       _password = password;
//       _fname = data['fname'];
//       _email = data['email'];
//
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString("userdetails", jsonEncode(data));
//       await prefs.setString('id', id);
//       await prefs.setString('password', password);
//       await prefs.setString('memberType', data['member_type'].toString());
//       await prefs.setString('fname', _fname ?? '');
//       await prefs.setString('email', _email ?? '');
//
//       notifyListeners();
//       return data;
//     } catch (e) {
//       print("Login error in provider: $e");
//       return {};
//     }
//   }
//
//   Future<void> loadSavedLogin() async {
//     final prefs = await SharedPreferences.getInstance();
//     _id = prefs.getString('id');
//     _password = prefs.getString('password');
//     notifyListeners();
//   }
//
//   // KYC submission
//
//   // other properties and methods...
//
//   Future<bool> submitKycDetails({
//   required String username,
//   required String phone,
//   required String address,
//   required String pincode,
//   required String city,
//   required String state,
//   required String country,
//   required String panNumber,
//   required String adharNumber,
//   required String bankName,
//   required String ifscCode,
//   required String accountNumber,
//   required String beneficiaryName,
//   }) async {
//   return await ApiMethods.submitKycDetails(
//   id: username,
//   phone: phone,
//   address: address,
//   pincode: pincode,
//   city: city,
//   state: state,
//   country: country,
//   panNumber: panNumber,
//     adharNumber: adharNumber,
//   bankName: bankName,
//   ifscCode: ifscCode,
//   accountNumber: accountNumber,
//   beneficiaryName: beneficiaryName,
//   );
//   }
//
//
//   // Fetch user details
//   Future<void> fetchUserDetailsById(String id) async {
//     try {
//       final userData = await ApiMethods.fetchUserDetailsById(id);
//
//       _id = userData['id'];
//       _fname = userData['fname'];
//       _email = userData['email'];
//       _phone = userData['phone'];
//       _birthdate = userData['dob'];
//       _fullAddress = userData['address'];
//       _country = userData['country'];
//       _pan = userData['pan'];
//       _bank = userData['bank'];
//       _ifsc = userData['ifsc'];
//       _acno = userData['acno'];
//
//
//       _address = {
//         'city': userData['city'],
//         'state': userData['state'],
//         'zip': userData['pin'].toString(),
//       };
//
//       _aadhaarImagePath = userData['aadhar_scan'];
//       _otherDocumentImagePath = userData['pan_scan'];
//       _bankScanImagePath = userData['bank_scan'];
//
//       // ✅ Assign profile image
//       _profileImage = userData['img']; // or whatever the exact key is
//
//       _isKycVerified = _fname != null &&
//           _phone != null &&
//           _fullAddress != null &&
//           _aadhaarImagePath != null &&
//           _pan != null;
//
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString('id', _id ?? '');
//       await prefs.setString('fname', _fname ?? '');
//       await prefs.setString('email', _email ?? '');
//       await prefs.setString('phone', _phone ?? '');
//       await prefs.setString('birthdate', _birthdate ?? '');
//       await prefs.setString('fullAddress', _fullAddress ?? '');
//       await prefs.setString('country', _country ?? '');
//       await prefs.setString('pan', _pan ?? '');
//       await prefs.setString('bank', _bank ?? '');
//       await prefs.setString('ifsc', _ifsc ?? '');
//       await prefs.setString('acno', _acno ?? '');
//
//       if (_address != null) {
//         await prefs.setString('address_city', _address!['city'] ?? '');
//         await prefs.setString('address_state', _address!['state'] ?? '');
//         await prefs.setString('address_zip', _address!['zip'] ?? '');
//       }
//
//       await prefs.setString('aadhaarImagePath', _aadhaarImagePath ?? '');
//       await prefs.setString('otherDocumentImagePath', _otherDocumentImagePath ?? '');
//       await prefs.setString('bankScanImagePath', _bankScanImagePath ?? '');
//       await prefs.setString('profileImage', _profileImage ?? '');
//       await prefs.setBool('isKycVerified', _isKycVerified);
//
//       notifyListeners();
//     } catch (e) {
//       print("Fetch user error: $e");
//     }
//   }
//   // 📤 Upload profile image using internal _id
//   Future<void> uploadProfileImage(File file) async {
//     if (_id == null) return;
//
//     final result = await ApiMethods.uploadProfileImage(id: _id!, imageFile: file);
//     if (result) {
//       await fetchUserDetailsById(_id!);
//     }
//   }
//
// }
