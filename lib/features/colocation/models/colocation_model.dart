import 'package:cloud_firestore/cloud_firestore.dart';

class ColocationModel {
  final String id;
  final String name;
  final String inviteCode;
  final String createdBy;
  final int membersCount;
  final int maxMembers;
  final List<String> memberIds;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ColocationModel({
    required this.id,
    required this.name,
    required this.inviteCode,
    required this.createdBy,
    required this.membersCount,
    required this.maxMembers,
    required this.memberIds,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ColocationModel.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
  ) {
    final data = doc.data() ?? <String, dynamic>{};
    final createdAtRaw = data['createdAt'];
    final updatedAtRaw = data['updatedAt'];

    return ColocationModel(
      id: doc.id,
      name: (data['name'] ?? '') as String,
      inviteCode: (data['inviteCode'] ?? '') as String,
      createdBy: (data['createdBy'] ?? '') as String,
      membersCount: (data['membersCount'] ?? 0) as int,
      maxMembers: (data['maxMembers'] ?? 0) as int,
      memberIds: List<String>.from(data['memberIds'] ?? const <String>[]),
      createdAt: createdAtRaw is Timestamp
          ? createdAtRaw.toDate()
          : DateTime.now(),
      updatedAt: updatedAtRaw is Timestamp
          ? updatedAtRaw.toDate()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'inviteCode': inviteCode,
      'createdBy': createdBy,
      'membersCount': membersCount,
      'maxMembers': maxMembers,
      'memberIds': memberIds,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }
}
