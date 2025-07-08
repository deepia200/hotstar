import 'package:flutter/material.dart';
import '../models/member_model.dart';

class MemberProvider with ChangeNotifier {
  final List<Member> _members = [];

  List<Member> get members => _members;

  /// Adds a new member and notifies listeners
  void addMember(Member member) {
    _members.add(member);
    notifyListeners();
  }

  /// Removes a member by userId
  void removeMember(String userId) {
    _members.removeWhere((member) => member.userId == userId);
    notifyListeners();
  }

  /// Optional: Clear all members
  void clearMembers() {
    _members.clear();
    notifyListeners();
  }


}
