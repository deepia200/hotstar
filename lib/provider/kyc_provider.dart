// provider/kyc_provider.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/kyc_model.dart';
import '../models/user_model.dart';

class KycProvider with ChangeNotifier {
  UserModel? userModel;
  KycDetails? _details;

  KycDetails? get details => _details;

  void setKycDetails(KycDetails details) {
    _details = details;
    notifyListeners();
  }

  Future<void> fetchUserById(String id) async {
    final url = Uri.parse("https://stag.aanandi.in/reel_life_otts/public/api/ott/users/$id");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        userModel = UserModel.fromJson(data['data']);
        notifyListeners();
      } else {
        throw Exception("Failed to load user data");
      }
    } catch (e) {
      print("Error: $e");
    }
  }


}
