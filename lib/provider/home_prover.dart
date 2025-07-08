import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeProvider with ChangeNotifier {
  bool _isLoading = false;
  Map<String, dynamic> _homeData = {};

  bool get isLoading => _isLoading;
  Map<String, dynamic> get homeData => _homeData;

  Future<void> fetchHomeData() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse('https://stag.aanandi.in/reel_life_otts/public/api/ott/home'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['status'] == 'success') {
          _homeData = jsonData['data'];
        }
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
