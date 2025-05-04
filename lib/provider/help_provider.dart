import 'package:flutter/material.dart';

class HelpProvider extends ChangeNotifier {
  final List<String> _expandedItems = [];

  List<String> get expandedItems => _expandedItems;

  void toggleItem(String title) {
    if (_expandedItems.contains(title)) {
      _expandedItems.remove(title);
    } else {
      _expandedItems.add(title);
    }
    notifyListeners();
  }

  bool isExpanded(String title) => _expandedItems.contains(title);
}
