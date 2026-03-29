import '../enums/status_enum.dart';
import '../models/status_model.dart';

List<StatusModel> statusesData = [
  StatusModel(label: "To Do", status: StatusEnum.ToDo),
  StatusModel(label: "In Progress", status: StatusEnum.InProgress),
  StatusModel(label: "Completed", status: StatusEnum.Completed),
];
