class AboutUsModel {
  final String appVision;
  final List<String> features;
  final String contactEmail;

  AboutUsModel({
    required this.appVision,
    required this.features,
    required this.contactEmail,
  });

  factory AboutUsModel.fromJson(Map<String, dynamic> json) {
    return AboutUsModel(
      appVision: json['app_vision'] ?? '',
      features: List<String>.from(json['features'] ?? []),
      contactEmail: json['contact_email'] ?? '',
    );
  }
}