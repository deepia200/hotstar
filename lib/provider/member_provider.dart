import 'package:flutter/material.dart';
import '../models/member_model.dart';

class MemberProvider with ChangeNotifier {
  List<Member> _members = [
    // Member(
    //   name: 'Alice',
    //   email: 'alice@example.com',
    //   userId: 'A123',
    //   children: [
    //     Member(
    //       name: 'Bob',
    //       email: 'bob@example.com',
    //       userId: 'B456',
    //     ),
    //     Member(
    //       name: 'Charlie',
    //       email: 'charlie@example.com',
    //       userId: 'C789',
    //     ),
    //   ],
    // ),
  ];

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
