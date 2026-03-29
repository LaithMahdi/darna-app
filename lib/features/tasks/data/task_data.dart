import '../enums/status_enum.dart';
import '../models/task_model.dart';

List<TaskModel> tasksData = [
  TaskModel(
    title: "Nettoyer la cuisine",
    affectedBy: "Lucas Dubois",
    status: StatusEnum.Completed,
    date: "Today, 20:00",
  ),
  TaskModel(
    title: "Sortir les poubelles",
    affectedBy: "Emma Bernard",
    status: StatusEnum.InProgress,
    date: "Tomoroow, 10:00",
  ),
  TaskModel(
    title: "Faire les courses",
    affectedBy: "Lucas Dubois",
    status: StatusEnum.ToDo,
    date: "Tomoroow, 10:00",
  ),
  TaskModel(
    title: "Appeler le médecin",
    affectedBy: "Emma Bernard",
    status: StatusEnum.ToDo,
    date: "Tomoroow, 10:00",
  ),
];
