class ColocatorModel {
  final String userId;
  String fullName;
  String email;
  bool isAdmin;
  String joinAt;

  ColocatorModel({
    required this.userId,
    required this.fullName,
    required this.email,
    this.isAdmin = false,
    required this.joinAt,
  });
}
