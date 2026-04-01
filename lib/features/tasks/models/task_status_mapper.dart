import '../enums/status_enum.dart';

StatusEnum taskStatusFromString(String value) {
  switch (value) {
    case 'Completed':
      return StatusEnum.Completed;
    case 'InProgress':
      return StatusEnum.InProgress;
    default:
      return StatusEnum.ToDo;
  }
}

String taskStatusToString(StatusEnum status) {
  switch (status) {
    case StatusEnum.Completed:
      return 'Completed';
    case StatusEnum.InProgress:
      return 'InProgress';
    case StatusEnum.ToDo:
      return 'ToDo';
  }
}
