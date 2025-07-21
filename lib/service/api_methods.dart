import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

import '../models/notification_model.dart';

class ApiMethods {
  static const baseUrl = 'https://stag.aanandi.in/mlm_ott/my-api/public/api';
  static const imgUrl =
      'https://stag.aanandi.in/mlm_ott/my-api/storage/app/public/';
  static Future<Map<String, dynamic>?> signupUser(
    String fname,
    String email,
    String pass,
    String phone,
    // String member_type,
  ) async {
    final url = Uri.parse('$baseUrl/signup');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          "fname": fname,
          "email": email,
          "pass": pass, // ✅ Important: 'pass', not 'password'
          "phone": phone,
          // "member_type": member_type, // ✅ Send "0" or "1"
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        print('Signup failed: ${response.statusCode} ${response.body}');
        return null;
      }
    } catch (e) {
      print('Signup exception: $e');
      return null;
    }
  }

  // static Future<Map<String, dynamic>> login(String id, String password) async {
  //   final url = Uri.parse('$baseUrl/login');
  //   print("deepika");
  //   print(id);
  //   print(password);
  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //       },
  //       body: jsonEncode({'id': id, 'password': password}),
  //     );
  //
  //     print('Response: ${response.statusCode}');
  //     print('Body: ${response.body}');
  //
  //     if (response.statusCode == 200) {
  //       final jsonResp = jsonDecode(response.body);
  //       print(jsonResp);
  //       if (jsonResp['status'] == 'success') {
  //         return jsonResp['data'];
  //       } else {
  //         throw Exception("Invalid response format");
  //       }
  //     } else {
  //       throw Exception("Login failed: ${response.body}");
  //     }
  //   } catch (e) {
  //     print("Login exception: $e");
  //     rethrow;
  //   }
  // }

  static Future<Map<String, dynamic>> login(String id, String password) async {
    final url = Uri.parse('$baseUrl/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id': id, 'password': password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // Should include 'status' and 'data'
    } else {
      throw Exception('Failed to login');
    }
  }

  // fetchUserDetailsById
  static Future<Map<String, dynamic>> fetchUserDetailsById(String id) async {
    final url = Uri.parse('$baseUrl/member/$id');

    try {
      final response = await http.get(url);
      print("Ayesha");
      print(response.body);

      if (response.statusCode == 200) {
        final jsonResp = jsonDecode(response.body);
        return jsonResp['member']; // <-- Important
      } else {
        throw Exception("Failed to fetch user details.");
      }
    } catch (e) {
      print('Fetch user details error: $e');
      rethrow;
    }
  }

  static String getImageUrl(String? path) {
    if (path == null || path.isEmpty) return '';
    return '$imgUrl/$path';
  }
  // static String getImageUrl(String? path) {
  //   if (path == null || path.isEmpty) return '';
  //   return '$baseUrl/$path';
  // }

  // Updated `submitKycDetails` in ApiService

  static Future<bool> submitKycDetails({
    required String id,
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
    try {
      final uri = Uri.parse('$baseUrl/$id/kycscreen');
      print(uri);
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'username': id,
          'phone': phone,
          'city': city,
          'state': state,
          'dist': city,
          'country': country,
          'pin': pincode,
          'pan': panNumber,
          'bank': bankName,
          'ifsc': ifscCode,
          'acno': accountNumber,
          'acname': beneficiaryName,
          'address': address,
          'adhar': adharNumber,
          'bank_verify': 'yes',
          'pan_verify': 'yes',
          'aadhar_verify': 'no',
        },
      );

      final responseData = jsonDecode(response.body);
      print("KYC API Response: $responseData");

      if (response.statusCode == 200 &&
          (responseData['message']?.toString().toLowerCase().contains(
                'success',
              ) ??
              false)) {
        return true;
      }

      print('KYC submission failed: ${responseData['message']}');
      return false;
    } catch (e) {
      print('Error during KYC: $e');
      return false;
    }
  }

  // uploadKycDocuments
  static Future<bool> uploadKycDocuments({
    required String id,
    required File aadhaarFile,
    required File panFile,
    required File bankFile,
  }) async {
    final url = Uri.parse('$baseUrl/$id/updatekyc');

    try {
      final request = http.MultipartRequest('POST', url);

      request.files.add(
        await http.MultipartFile.fromPath(
          'aadhar_scan',
          aadhaarFile.path,
          filename: basename(aadhaarFile.path),
        ),
      );

      request.files.add(
        await http.MultipartFile.fromPath(
          'pan_scan',
          panFile.path,
          filename: basename(panFile.path),
        ),
      );

      request.files.add(
        await http.MultipartFile.fromPath(
          'bank_scan',
          bankFile.path,
          filename: basename(bankFile.path),
        ),
      );

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      print('API Upload Response Code: ${response.statusCode}');
      print('API Upload Body: $responseBody');

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Upload KYC documents error: $e');
      return false;
    }
  }

  /// Upload profile image using multipart
  static Future<bool> uploadProfileImage({
    required String id,
    required File imageFile,
  }) async {
    final url = Uri.parse('$baseUrl/member/$id/update-image');

    try {
      final request = http.MultipartRequest('POST', url);

      request.files.add(
        await http.MultipartFile.fromPath(
          'img', // ✅ This key name must match what the backend expects
          imageFile.path,
          filename: basename(imageFile.path),
        ),
      );

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      print("🔄 Status: ${response.statusCode}");
      print("📦 Body: $responseBody");

      return response.statusCode == 200;
    } catch (e) {
      print("❌ Upload failed: $e");
      return false;
    }
  }

  /// Returns the full image URL for a given image path.
  static Future<Map<String, dynamic>> registerMember({
    required String name,
    required String email,
    required String fatherName,
    required String gender,
    required String address,
    required String reff,
    required String sponsor,
    required String phone,
  }) async {
    final url = Uri.parse('$baseUrl/register-member');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'father_name': fatherName,
        'gender': gender,
        'address': address,
        'reff': reff,
        'sponsor': sponsor,
        'phone': phone,
      }),
    );

    print("Response: ${response.body}");
    return jsonDecode(response.body);
  }

  static Future<List<Map<String, dynamic>>> fetchIncome(String id) async {
    final url = Uri.parse('$baseUrl/listIncome/$id');
    final response = await http.get(url);

    print("Requested URL: $url");
    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      if (body['status'] == 'success') {
        final List data = body['data'];
        return data
            .map<Map<String, dynamic>>(
              (item) => {
                'time': item['time'],
                'incm_type': item['incm_type'],
                'net': item['net'],
              },
            )
            .toList();
      } else {
        return []; // No data, but not an error
      }
    } else if (response.statusCode == 404) {
      // Gracefully handle "no records" response
      final body = json.decode(response.body);
      print("API message: ${body['message']}");
      return []; // Treat it as no data
    } else {
      throw Exception(
        'Failed to fetch income. Status code: ${response.statusCode}',
      );
    }
  }

  static Future<List<dynamic>> fetchReferrals(String userId) async {
    final url = Uri.parse('$baseUrl/getReferrals/$userId');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonBody = json.decode(response.body);
        if (jsonBody['status'] == 'success' && jsonBody['data'] is List) {
          return jsonBody['data'];
        } else {
          throw Exception('Invalid data structure');
        }
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  static Future<List<dynamic>> fetchdownReferrals(String userId) async {
    final url = Uri.parse('$baseUrl/getdownReferrals/$userId');
    final response = await http.get(url);
    print(response.body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonBody = json.decode(response.body);
      if (jsonBody['status'] == 'success') {
        final data = jsonBody['data'];
        final List<dynamic> downlines = data['downlines'] ?? [];
        return downlines;
      } else {
        throw Exception(jsonBody['message'] ?? 'Failed to fetch data');
      }
    } else {
      throw Exception('Server error: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> fetchDashboardCounts(
    String userId,
  ) async {
    final Uri url = Uri.parse('$baseUrl/dashboard/counts/$userId');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonBody = json.decode(response.body);
      if (jsonBody['status'] == 'success') {
        return jsonBody['data'];
      } else {
        throw Exception(
          jsonBody['message'] ?? 'Failed to fetch dashboard counts',
        );
      }
    } else {
      throw Exception('Server error: ${response.statusCode}');
    }
  }

  static Future<Map<String, dynamic>> fetchNetworkTree(String userId) async {
    final url = Uri.parse('$baseUrl/network-tree/$userId');
    final response = await http.get(url);
    print(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch network tree');
    }
  }

  static Future<Map<String, dynamic>> updatePassword({
    required String userId,
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final url = Uri.parse('$baseUrl/update-password/$userId');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "current_password": currentPassword,
        "update_password": newPassword,
        "confirm_password": confirmPassword,
      }),
    );

    final data = jsonDecode(response.body);
    return data;
  }

  static Future<String?> fetchUserNameById(String id) async {
    final url = Uri.parse('$baseUrl/member/$id');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final member = data['member'];
        if (member != null && member['fname'] != null) {
          return member['fname'];
        } else {
          return null;
        }
      } else {
        throw Exception("Error fetching user");
      }
    } catch (e) {
      throw Exception("Error fetching user");
    }
  }

  static Future<http.Response> updatePhoneNumber({
    required String id,
    required String currentPhone,
    required String updatePhone,
  }) async {
    final url = Uri.parse('$baseUrl/update-phone/$id');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "current_phone": currentPhone,
        "update_phone": updatePhone,
      }),
    );
    return response;
  }

  static Future<Map<String, dynamic>> updateNomineeDetails(
    String id,
    Map<String, dynamic> data,
  ) async {
    final url = Uri.parse('$baseUrl/members/$id/nominee-details');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update nominee details');
    }
  }

  static Future<Map<String, dynamic>> resetPassword(
    Map<String, dynamic> data,
  ) async {
    final url = Uri.parse('$baseUrl/reset-password');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    print("Reset Password Status: ${response.statusCode}");
    print("Response: ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to reset password');
    }
  }



  // Fetch Awards (Rewards)
  static Future<List<Map<String, dynamic>>> fetchAllRewards() async {
    final url = Uri.parse('$baseUrl/new_reward');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      if (body['status'] == 'success') {
        return List<Map<String, dynamic>>.from(body['data']);
      }
    }
    return [];
  }

  static Future<List<Map<String, dynamic>>> fetchSchemeData() async {
    final url = Uri.parse('$baseUrl/scheme_data');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      if (body['status'] == 'success') {
        return List<Map<String, dynamic>>.from(body['data']);
      }
    }
    return [];
  }
  static Future<AboutUsModel?> fetchAboutUsData() async {
    final url = Uri.parse('$baseUrl/about-us');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);
        if (jsonBody['status'] == 'success') {
          return AboutUsModel.fromJson(jsonBody['data']);
        }
      }
    } catch (e) {
      print('Error fetching About Us data: $e');
    }
    return null;
  }

  static Future<String> fetchContactMessage() async {
    final url = Uri.parse('$baseUrl/contact-message');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          return data['message'];
        } else {
          throw Exception('API returned error');
        }
      } else {
        throw Exception('Failed to load message');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<String> getSupportMessage() async {
    final url = Uri.parse('$baseUrl/support-message');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == 'success') {
          return data['data']['support_message'] ?? 'No support message found.';
        } else {
          return 'Failed to load support message.';
        }
      } else {
        return 'Server error: ${response.statusCode}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
  static Future<List<dynamic>> fetchTrainings() async {
    final url = Uri.parse('$baseUrl/trainings');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        if (body['status'] == 'success') {
          return body['trainings']; // Should return a List
        }
      }
      return [];
    } catch (e) {
      print('Error fetching trainings: $e');
      return [];
    }
  }
  Future<String?> fetchReferralCode(String userId) async {
    final url = Uri.parse('$baseUrl/referral-code/$userId');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'success') {
        return data['referralCode'];
      }
    }
    return null;
  }
  static Future<Map<String, dynamic>> sendOtp(String id) async {
    final url = Uri.parse('$baseUrl/send-otp');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id': id}),
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {'status': 'error', 'message': 'Exception: $e'};
    }
  }

  static Future<Map<String, dynamic>> verifyOtp(String id, String otp) async {
    final url = Uri.parse('$baseUrl/verify-otp');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id': id, 'otp': otp}),
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {'status': 'error', 'message': 'Exception: $e'};
    }
  }

}
