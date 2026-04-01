import 'package:cloud_firestore/cloud_firestore.dart';

import '../enums/status_enum.dart';
import 'task_status_mapper.dart';

class TaskStatusHistoryEntry {
  final StatusEnum from;
  final StatusEnum to;
  final String changedBy;
  final DateTime changedAt;

  const TaskStatusHistoryEntry({
    required this.from,
    required this.to,
    required this.changedBy,
    required this.changedAt,
  });

  factory TaskStatusHistoryEntry.fromMap(Map<String, dynamic> map) {
    final changedAtRaw = map['changedAt'];
    return TaskStatusHistoryEntry(
      from: taskStatusFromString((map['from'] ?? 'ToDo') as String),
      to: taskStatusFromString((map['to'] ?? 'ToDo') as String),
      changedBy: (map['changedBy'] ?? '') as String,
      changedAt: changedAtRaw is Timestamp
          ? changedAtRaw.toDate()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'from': taskStatusToString(from),
      'to': taskStatusToString(to),
      'changedBy': changedBy,
      'changedAt': Timestamp.fromDate(changedAt),
    };
  }
}
