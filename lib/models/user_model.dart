class UserModel {
  final int id;
  final String fullName;
  final String email;
  final String? dateOfBirth;
  final String? memberType;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    this.dateOfBirth,
    this.memberType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? json['user_id'] ?? 0,
      fullName: json['full_name'] ?? '',
      email: json['email'] ?? '',
      dateOfBirth: json['date_of_birth'],
      memberType: json['member_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'date_of_birth': dateOfBirth,
      'member_type': memberType,
    };
  }
}