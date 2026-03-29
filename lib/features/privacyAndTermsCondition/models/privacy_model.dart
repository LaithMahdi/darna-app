class PrivacyModel {
  String title;
  String description;

  PrivacyModel({required this.title, required this.description});

  factory PrivacyModel.fromJson(Map<String, dynamic> json) {
    return PrivacyModel(
      title: json['title'] as String,
      description: json['description'] as String,
    );
  }

  @override
  String toString() {
    return 'PrivacyModel{title: $title, description: $description}';
  }
}
