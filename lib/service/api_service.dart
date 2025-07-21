import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';
import '../provider/auth_provider.dart';

class ApiService {
  static const baseUrl = 'https://stag.aanandi.in/reel_life_otts/public/api/ott';
         static const  imageBaseUrl = 'https://stag.aanandi.in/reel_life_otts/storage/app/public/';

  /// Signup user and return response Map on success, else null
  // static Future<Map<String, dynamic>?> signupUser(
  //     String fullName,
  //     String email,
  //     String password,
  //     // String dateOfBirth,
  //     String phone,
  //     String memberType,
  //     ) async {
  //   final url = Uri.parse('$baseUrl/users');
  //
  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //       },
  //       body: jsonEncode({
  //         'full_name': fullName,
  //         'email': email,
  //         'password': password,
  //         // 'date_of_birth': dateOfBirth,
  //         'phone': phone,
  //         'member_type': memberType,
  //       }),
  //     );
  //
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       final Map<String, dynamic> data = jsonDecode(response.body);
  //       return data;
  //     } else {
  //       print('Signup failed: ${response.statusCode} ${response.body}');
  //       return null;
  //     }
  //   } catch (e) {
  //     print('Signup exception: $e');
  //     return null;
  //   }
  // }
  // static Future<Map<String, dynamic>> login(String username, String password) async {
  //   final url = Uri.parse('$baseUrl/login');
  //
  //   try {
  //     final response = await http.post(url, body: {
  //       'username': username,
  //       'password': password,
  //     });
  //
  //     if (response.statusCode == 200) {
  //       final jsonResp = jsonDecode(response.body);
  //       if (jsonResp['data'] is Map<String, dynamic>) {
  //         return jsonResp['data'];
  //       } else {
  //         throw Exception("Expected map in response.");
  //       }
  //     } else {
  //       throw Exception("Login failed: ${response.body}");
  //     }
  //   } catch (e) {
  //     print("Login error: $e");
  //     rethrow;
  //   }
  // }

  // static Future<Map<String, dynamic>> fetchUserDetailsById(String userId) async {
  //   final url = Uri.parse('$baseUrl/users/$userId');
  //
  //   try {
  //     final response = await http.get(url);
  //     if (response.statusCode == 200) {
  //       final jsonResp = jsonDecode(response.body);
  //       return jsonResp['data'];
  //     } else {
  //       throw Exception("Failed to fetch user details.");
  //     }
  //   } catch (e) {
  //     print('Fetch user details error: $e');
  //     rethrow;
  //   }
  // }
  //
  // static Future<bool> submitKycDetails({
  //   required String username,
  //   required String phone,
  //   required String address,
  //   required String pincode,
  //   required String city,
  //   required String state,
  //   required String country,
  //   required File aadhaarImage,
  //   File? panCardImage,
  //   File? otherDocImage,
  // }) async {
  //   try {
  //     final uri = Uri.parse('$baseUrl/kyc');
  //     final request = http.MultipartRequest('POST', uri);
  //
  //     request.fields.addAll({
  //       'username': username,
  //       'phone': phone,
  //       'address': address,
  //       'pincode': pincode,
  //       'city': city,
  //       'state': state,
  //       'country': country,
  //     });
  //
  //     request.files.add(await http.MultipartFile.fromPath('aadhaar_card', aadhaarImage.path));
  //
  //     if (panCardImage != null) {
  //       request.files.add(await http.MultipartFile.fromPath('pan_card', panCardImage.path));
  //     }
  //
  //     if (otherDocImage != null) {
  //       request.files.add(await http.MultipartFile.fromPath('other_document', otherDocImage.path));
  //     }
  //
  //     final response = await request.send();
  //     final responseBody = await response.stream.bytesToString();
  //     final responseData = jsonDecode(responseBody);
  //
  //     if (response.statusCode == 200) {
  //       final message = responseData['message']?.toString().toLowerCase() ?? '';
  //       return message.contains('kyc submitted successfully') ||
  //           message.contains('no changes made to user data');
  //     }
  //
  //     print('KYC submission failed: ${responseData['message']}');
  //     return false;
  //   } catch (e) {
  //     print('Error during KYC: $e');
  //     return false;
  //   }
  // }

  // // Fetch content
  // static Future<http.Response> fetchContent() {
  //   final url = Uri.parse('$baseUrl/contents');
  //   return http.get(url, headers: {
  //     'Accept': 'application/json',
  //   });
  // }
  // // Fetch content details by ID
  // static Future<http.Response> fetchContentDetails(String contentId) {
  //   final url = Uri.parse('$baseUrl/contents/$contentId');
  //   return http.get(url, headers: {
  //     'Accept': 'application/json',
  //   });
  // }

  static Future<http.Response> fetchContent() async {
    return await http.get(Uri.parse("$baseUrl/contents"));
  }

  // static Future<http.Response> fetchContent(BuildContext context) async {
  //   try {
  //     final authProvider = Provider.of<AuthProvider>(context, listen: false);
  //     final userId = authProvider.id.toString();
  //
  //     final url = Uri.parse("$baseUrl/contents/$userId");
  //     print("Fetch all content URL: $url");
  //
  //     return await http.get(url);
  //   } catch (e) {
  //     print("Exception in fetchContent: $e");
  //     throw e;
  //   }
  // }


  // static Future<http.Response> fetchContentById(int contentId, String userId) async {
  //   final url = Uri.parse("$baseUrl/contents/$contentId/$userId");
  //   print("deepika");
  //   print(url);
  //   return await http.get(url);
  //
  // }

  static Future<http.Response> fetchContentById(int contentId, BuildContext context) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final userId = authProvider.id.toString();
      print("Deep : $userId");


      final url = Uri.parse("$baseUrl/contents/$contentId/$userId");
      print("Fetch content URL: $url");

      return await http.get(url);
    } catch (e) {
      print("Exception in fetchContentById: $e");
      throw e;
    }
  }



  // static Future<http.Response> fetchContentDetails(int contentId, String userId) async {
  //   try {
  //     final url = Uri.parse('$baseUrl/contents/$contentId/$userId');
  //     final response = await http.get(url);
  //     return response;
  //   } catch (e) {
  //     print("Exception in fetchContentDetails: $e");
  //     throw e;
  //   }
  // }
  static Future<http.Response> fetchContentDetails(String contentId, BuildContext context) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final userId = authProvider.id.toString();
      print("yuv : $userId");

      final url = Uri.parse("$baseUrl/contents/$contentId/$userId");
      print("API URL: $url");

      final response = await http.get(url);
      return response;
    } catch (e) {
      print("Exception in fetchContentDetails: $e");
      throw e;
    }
  }


  static Future<Map<String, dynamic>?> getHomeData() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/home"));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return jsonData;
      } else {
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }
  static Future<Map<String, dynamic>?> getcastData(String cast_name) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/movies-by-cast/$cast_name"));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return jsonData;
      } else {
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }

  // api_service.dart

  static Future<List<Map<String, dynamic>>> fetchTopPopularShows() async {
    final url = Uri.parse('$baseUrl/content/popular');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List content = data['most_popular_content'];

        // Sort by watch_count descending and take top 10
        content.sort((a, b) => (b['watch_count'] ?? 0).compareTo(a['watch_count'] ?? 0));
        return content.take(10).cast<Map<String, dynamic>>().toList();
      } else {
        print("API Error: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Exception while fetching popular shows: $e");
      return [];
    }
  }
  static Future<Map<String, dynamic>> payNow({
    required String userId,
    required int movieId,
    required int amount, // not String!
  }) async {
    final url = Uri.parse('$baseUrl/pay-now');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': userId,
        'movie_id': movieId,
        'amount': amount, // Send as int
      }),
    );
    print("pk");
    print(response.body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return {
        'status': 'error',
        'message': 'Failed to create payment order',
      };
    }
  }


}



// static Future<List<dynamic>?> getPopularShows() async {
  //   try {
  //     final response = await http.get(Uri.parse("$baseUrl/home"));
  //
  //     print("Response Body: ${response.body}"); // ADD THIS LINE
  //
  //     if (response.statusCode == 200) {
  //       final jsonData = json.decode(response.body);
  //
  //       if (jsonData.containsKey('popular_shows') && jsonData['popular_shows'] is List) {
  //         return jsonData['popular_shows'];
  //       } else {
  //         print("popular_shows not found or not a list");
  //         return [];
  //       }
  //     } else {
  //       print("Error: ${response.statusCode}");
  //       return null;
  //     }
  //   } catch (e) {
  //     print("Exception: $e");
  //     return null;
  //   }
  // }
  //


/// Returns the full image URL for a given image path.
// static String getImageUrl(String? imagePath) {
//   if (imagePath == null || imagePath.isEmpty) {
//     return '';
//   }
//   const imageBaseUrl = 'https://stag.aanandi.in/reel_life_otts/storage/app/';
//   return '$imageBaseUrl/$imagePath';
// }





