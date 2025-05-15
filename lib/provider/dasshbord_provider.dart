import 'package:flutter/material.dart';

class DashboardProvider with ChangeNotifier {
  int _networkCount = 0;
  int _directCount = 0;
  int _rewardCount = 0;
  int _awardCount = 0;

  int get networkCount => _networkCount;
  int get directCount => _directCount;
  int get rewardCount => _rewardCount;
  int get awardCount => _awardCount;

  void loadDashboardData() {
    // Simulate API or local data fetch
    _networkCount = 124;
    _directCount = 48;
    _rewardCount = 12;
    _awardCount = 5;
    notifyListeners();
  }
}
