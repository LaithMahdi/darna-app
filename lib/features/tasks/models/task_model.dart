import '../enums/status_enum.dart';

class TaskModel {
  String title;
  String affectedBy;
  StatusEnum status;
  String date;

  TaskModel({
    required this.title,
    required this.affectedBy,
    required this.status,
    required this.date,
  });

  @override
  String toString() {
    return 'TaskModel{title: $title, affectedBy: $affectedBy, status: $status, date: $date}';
  }
}
