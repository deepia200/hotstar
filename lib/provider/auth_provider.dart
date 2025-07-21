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
  String? _kycStatus;
  Map<String, String>? _address;
  String? _fullAddress;
  String? _country;
  String? _pan;
  String? _aadhaar;
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
  String? get kycStatus => _kycStatus;
  String? get memberType => _memberType;
  Map<String, String>? get address => _address;
  String? get fullAddress => _fullAddress;
  String? get country => _country;
  String? get pan => _pan;
  String? get aadhaar => _aadhaar;
  String? get bank => _bank;
  String? get ifsc => _ifsc;
  String? get acno => _acno;
  String? get aadhaarImagePath => _aadhaarImagePath;
  String? get otherDocumentImagePath => _otherDocumentImagePath;
  String? get bankScanImagePath => _bankScanImagePath;
  String? get profileImage => _profileImage;
  bool get isKycVerified => _isKycVerified;

  set phone(String? value) {
    _phone = value;
    notifyListeners();
  }

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
print("hello g k hal chal");
print(_profileImage);
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

  // Future<Map<String, dynamic>> login(String id, String password) async {
  //   try {
  //     final data = await ApiMethods.login(id, password);
  //     print("Login API response: $data");
  //
  //     _id = id;
  //     _password = password;
  //     _fname = data['fname'];
  //     _email = data['email'];
  //     _phone = data['phone'];
  //     _memberType = data['member_type'].toString();
  //
  //     final prefs = await SharedPreferences.getInstance();
  //     await prefs.setString("userdetails", jsonEncode(data));
  //     await prefs.setString('id', id);
  //     await prefs.setString('phone', _phone ?? '');
  //     await prefs.setString('password', password);
  //     await prefs.setString('memberType', _memberType ?? '');
  //     await prefs.setString('fname', _fname ?? '');
  //     await prefs.setString('email', _email ?? '');
  //
  //     notifyListeners();
  //     return data;
  //   } catch (e) {
  //     print("Login error in provider: $e");
  //     return {};
  //   }
  // }
  Future<Map<String, dynamic>> login(String id, String password) async {
    try {
      final response = await ApiMethods.login(id, password);

      if (response['status'] == 'success') {
        final data = response['data']; // Get nested 'data' map

        _id = id;
        _password = password;
        _fname = data['fname'];
        _email = data['email'];
        _phone = data['phone'];
        _memberType = data['member_type'].toString();

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("userdetails", jsonEncode(data));
        await prefs.setString('id', id);
        await prefs.setString('phone', _phone ?? '');
        await prefs.setString('password', password);
        await prefs.setString('memberType', _memberType ?? '');
        await prefs.setString('fname', _fname ?? '');
        await prefs.setString('email', _email ?? '');

        notifyListeners();
        return data;
      } else {
        print("Login failed: ${response['message']}");
        return {};
      }
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
      print("deep--");
      print(userData);

      _id = userData['id'];
      _fname = userData['fname'];
      _email = userData['email'];
      _phone = userData['phone'];
      _birthdate = userData['dob'];
      _fullAddress = userData['address'];
      _country = userData['country'];
      _pan = userData['pan'];
      _aadhaar = userData['adhar'];
      _bank = userData['bank'];
      _ifsc = userData['ifsc'];
      _acno = userData['acno'];
      _memberType = userData['member_type'].toString();
      _profileImage = userData['img'];

      _address = {
        'city': userData['city'],
        'state': userData['state'],
        'zip': userData['pin'].toString(),
      };

      _aadhaarImagePath = userData['aadhar_scan'];
      _otherDocumentImagePath = userData['pan_scan'];
      _bankScanImagePath = userData['bank_scan'];

      _isKycVerified = _fname != null &&
          _phone != null &&
          _fullAddress != null &&
          _aadhaarImagePath != null &&
          _pan != null;

      // Save to SharedPreferences (optional)
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('id', _id ?? '');
      await prefs.setString('fname', _fname ?? '');
      await prefs.setString('email', _email ?? '');
      await prefs.setString('phone', _phone ?? '');
      await prefs.setString('birthdate', _birthdate ?? '');
      await prefs.setString('fullAddress', _fullAddress ?? '');
      await prefs.setString('country', _country ?? '');
      await prefs.setString('pan', _pan ?? '');
      await prefs.setString('aadhaar', _aadhaar ?? '');
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

  Future<String?> updatePhoneNumber(String newPhone) async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('id');
    final currentPhone = phone;

    if (id == null || currentPhone == null) return "User ID or current phone missing";

    try {
      final response = await ApiMethods.updatePhoneNumber(
        id: id,
        currentPhone: currentPhone,
        updatePhone: newPhone,
      );

      final data = jsonDecode(response.body);

      if (data['status'] == 'success') {
        phone = newPhone;
        notifyListeners();
        return null; // No error
      } else {
        return data['message'] ?? 'Failed to update phone number';
      }
    } catch (e) {
      return 'Error: $e';
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
//   String? _memberType;
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
//   String? get memberType => _memberType;
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
//
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
//   set phone(String? value) {
//     _phone = value;
//     notifyListeners(); // Optional: if UI should react to change
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
//   Future<String?> updatePhoneNumber(String newPhone) async {
//     final prefs = await SharedPreferences.getInstance();
//     final id = prefs.getString('id');
//     final currentPhone = phone;
//
//     if (id == null || currentPhone == null) return "User ID or current phone missing";
//
//     try {
//       final response = await ApiMethods.updatePhoneNumber(
//         id: id,
//         currentPhone: currentPhone,
//         updatePhone: newPhone,
//       );
//
//       final data = jsonDecode(response.body);
//
//       if (data['status'] == 'success') {
//         phone = newPhone;
//         notifyListeners();
//         return null; // No error
//       } else {
//         return data['message'] ?? 'Failed to update phone number';
//       }
//     } catch (e) {
//       return 'Error: $e';
//     }
//   }
//
//
// }
