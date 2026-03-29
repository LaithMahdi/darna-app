import '../enums/status_enum.dart';

class StatusModel {
  String label;
  StatusEnum status;

  StatusModel({required this.label, required this.status});

  @override
  String toString() {
    return 'StatusModel{label: $label, status: $status}';
  }
}
