class ColocatorModel {
  String fullName;
  String email;
  bool isAdmin;
  String joinAt;

  ColocatorModel({
    required this.fullName,
    required this.email,
    this.isAdmin = false,
    required this.joinAt,
  });
}
