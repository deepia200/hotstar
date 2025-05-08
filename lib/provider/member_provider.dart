import 'package:flutter/material.dart';
import '../models/member_model.dart';

class MemberProvider with ChangeNotifier {
  List<Member> _members = [];

  List<Member> get members => _members;

  void addMember(Member member) {
    _members.add(member);
    notifyListeners();  // Notify the listeners to update the UI
  }

  void removeMember(String userId) {
    _members.removeWhere((member) => member.userId == userId);
    notifyListeners();
  }
}
