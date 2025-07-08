// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class DashboardProvider with ChangeNotifier {
//   int _directCount = 0;
//   int _networkCount = 0;
//   int _networkTreeCount = 0;
//
//   int get directCount => _directCount;
//   int get networkCount => _networkCount;
//   int get networkTreeCount => _networkTreeCount;
//
//   Future<void> loadDashboardData() async {
//     const String userId = 'company01'; // Replace dynamically if needed
//     final Uri url = Uri.parse('https://stag.aanandi.in/mlm_ott/my-api/public/api/dashboard/counts/$userId');
//
//     try {
//       final response = await http.get(url);
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//
//         if (data['status'] == 'success') {
//           _directCount = data['data']['direct_count'] ?? 0;
//           _networkCount = data['data']['network_count'] ?? 0;
//           _networkTreeCount = data['data']['network_tree_count'] ?? 0;
//           notifyListeners();
//         } else {
//           throw Exception(data['message'] ?? 'Failed to load dashboard data');
//         }
//       } else {
//         throw Exception('Server error: ${response.statusCode}');
//       }
//     } catch (e) {
//       debugPrint('Dashboard load error: $e');
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/api_methods.dart'; // Make sure path is correct

class DashboardProvider with ChangeNotifier {
  int _directCount = 0;
  int _networkCount = 0;
  int _networkTreeCount = 0;

  int get directCount => _directCount;
  int get networkCount => _networkCount;
  int get networkTreeCount => _networkTreeCount;

  Future<void> loadDashboardData() async {
    final prefs = await SharedPreferences.getInstance();
    final id =  await prefs.getString('id');
    try {
      const String userId = 'company01'; // You can fetch from SharedPreferences if needed
      final data = await ApiMethods.fetchDashboardCounts(id as String);

      _directCount = data['direct_count'] ?? 0;
      _networkCount = data['network_count'] ?? 0;
      _networkTreeCount = data['network_tree_count'] ?? 0;

      notifyListeners();
    } catch (e) {
      debugPrint('Dashboard data fetch error: $e');
    }
  }
}
