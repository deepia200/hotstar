import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

class ApiMethods {
  static const baseUrl = 'https://stag.aanandi.in/mlm_ott/my-api/public/api';
  static const imgUrl = 'https://stag.aanandi.in/mlm_ott/my-api/storage/app/public/';
  static Future<Map<String, dynamic>?> signupUser(
    String fname,
    String email,
    String pass,
    String phone,
    // String member_type,
  ) async {
    final url = Uri.parse(
      '$baseUrl/signup',
    );

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

  static Future<Map<String, dynamic>> login(String id, String password) async {
    final url = Uri.parse('$baseUrl/login');
    print("deepika");
    print(id);
    print(password);
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'id': id, 'password': password}),
      );

      print('Response: ${response.statusCode}');
      print('Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResp = jsonDecode(response.body);
        print(jsonResp);
        if (jsonResp['status'] == 'success') {
          return jsonResp['data'];
        } else {
          throw Exception("Invalid response format");
        }
      } else {
        throw Exception("Login failed: ${response.body}");
      }
    } catch (e) {
      print("Login exception: $e");
      rethrow;
    }
  }
  // fetchUserDetailsById
  static Future<Map<String, dynamic>> fetchUserDetailsById(String id) async {
    final url = Uri.parse('$baseUrl/member/$id');
    print("deepika");
    print(url);

    try {
      final response = await http.get(url);
      print(response.body);

      if (response.statusCode == 200) {
        final jsonResp = jsonDecode(response.body);
        return jsonResp['data'];
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
    required String userId,
    required File aadhaarFile,
    required File panFile,
    required File bankFile,
  }) async {
    final url = Uri.parse('$baseUrl/$userId/updatekyc');

    try {
      final request = http.MultipartRequest('POST', url);

      request.files.add(await http.MultipartFile.fromPath(
        'aadhar_scan',
        aadhaarFile.path,
        filename: basename(aadhaarFile.path),
      ));

      request.files.add(await http.MultipartFile.fromPath(
        'pan_scan',
        panFile.path,
        filename: basename(panFile.path),
      ));

      request.files.add(await http.MultipartFile.fromPath(
        'bank_scan',
        bankFile.path,
        filename: basename(bankFile.path),
      ));

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
  // Fetch content
  static Future<http.Response> fetchContent() {
    final url = Uri.parse('$baseUrl/content');
    return http.get(url, headers: {'Accept': 'application/json'});
  }

  // Fetch content details by ID
  static Future<http.Response> fetchContentDetails(String contentId) {
    final url = Uri.parse('$baseUrl/content/$contentId');
    return http.get(url, headers: {'Accept': 'application/json'});
  }

  /// Returns the full image URL for a given image path.
  static Future<Map<String, dynamic>> registerMember({
    required String name,
    required String email,
    required String phone,
    required String reff,
  }) async {
    final url = Uri.parse('$baseUrl/register-member');
    final body = {
      'name': name,
      'email': email,
      'phone': phone,
      'reff': reff,
    };

    print('Sending POST to: $url');
    print('Body: $body');
    print('Deepika');

    final response = await http.post(url, body: body);
    print('Status Code: ${response.statusCode}');
    print('Response: ${response.body}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to register member');
    }
  }


  static Future<List<Map<String, dynamic>>> fetchIncome(String userId) async {
    final url = Uri.parse('$baseUrl/listIncome/$userId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      if (body['status'] == 'success') {
        final List data = body['data'];
        return data.map<Map<String, dynamic>>((item) => {
          'time': item['time'],
          'incm_type': item['incm_type'],
          'net': item['net'],
        }).toList();
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to fetch income');
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

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonBody = json.decode(response.body);
      if (jsonBody['status'] == 'success') {
        return jsonBody['data'] ?? [];
      } else {
        throw Exception(jsonBody['message'] ?? 'Failed to fetch data');
      }
    } else {
      throw Exception('Server error: ${response.statusCode}');
    }
  }
  static Future<Map<String, dynamic>> fetchDashboardCounts(String userId) async {
    final Uri url = Uri.parse('$baseUrl/dashboard/counts/$userId');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonBody = json.decode(response.body);
      if (jsonBody['status'] == 'success') {
        return jsonBody['data'];
      } else {
        throw Exception(jsonBody['message'] ?? 'Failed to fetch dashboard counts');
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




}
