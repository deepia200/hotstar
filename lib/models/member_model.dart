// lib/models/member_model.dart
class Member {
  final String name;
  final String email;
  final String userId;
  final List<Member> children;
  

  Member({
    required this.name,
    required this.email,
    required this.userId,
    this.children = const [],
  });
}
