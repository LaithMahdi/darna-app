import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../enums/status_enum.dart';
import 'task_status_history_entry.dart';
import 'task_status_mapper.dart';
export 'task_status_history_entry.dart';
export 'task_status_mapper.dart';

class TaskModel {
  final String id;
  String title;
  String description;
  String affectedBy;
  List<String> assignedUserIds;
  StatusEnum status;
  String date;
  DateTime? dueDate;
  String? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<TaskStatusHistoryEntry> statusHistory;

  TaskModel({
    this.id = '',
    required this.title,
    this.description = '',
    required this.affectedBy,
    this.assignedUserIds = const <String>[],
    required this.status,
    required this.date,
    this.dueDate,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.statusHistory = const <TaskStatusHistoryEntry>[],
  });

  factory TaskModel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? <String, dynamic>{};
    final dueDateRaw = data['dueDate'];
    final createdAtRaw = data['createdAt'];
    final updatedAtRaw = data['updatedAt'];
    final historyRaw = List<Map<String, dynamic>>.from(
      data['statusHistory'] ?? const <Map<String, dynamic>>[],
    );

    final dueDate = dueDateRaw is Timestamp ? dueDateRaw.toDate() : null;

    return TaskModel(
      id: doc.id,
      title: (data['title'] ?? '') as String,
      description: (data['description'] ?? '') as String,
      affectedBy: (data['affectedBy'] ?? 'Unassigned') as String,
      assignedUserIds: List<String>.from(
        data['assignedUserIds'] ?? const <String>[],
      ),
      status: taskStatusFromString((data['status'] ?? 'ToDo') as String),
      date: _formatTaskDate(dueDate),
      dueDate: dueDate,
      createdBy: (data['createdBy'] ?? '') as String,
      createdAt: createdAtRaw is Timestamp ? createdAtRaw.toDate() : null,
      updatedAt: updatedAtRaw is Timestamp ? updatedAtRaw.toDate() : null,
      statusHistory: historyRaw
          .map(TaskStatusHistoryEntry.fromMap)
          .toList(growable: false),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'affectedBy': affectedBy,
      'assignedUserIds': assignedUserIds,
      'status': taskStatusToString(status),
      'dueDate': dueDate != null ? Timestamp.fromDate(dueDate!) : null,
      'createdBy': createdBy,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
      'statusHistory': statusHistory
          .map((historyEntry) => historyEntry.toJson())
          .toList(growable: false),
    };
  }

  static String _formatTaskDate(DateTime? dueDate) {
    if (dueDate == null) return '';
    return DateFormat('MMM d, HH:mm').format(dueDate);
  }

  @override
  String toString() {
    return 'TaskModel{title: $title, affectedBy: $affectedBy, status: $status, date: $date}';
  }
}
