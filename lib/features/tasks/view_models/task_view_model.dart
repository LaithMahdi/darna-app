import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../enums/status_enum.dart';
import '../models/task_model.dart';
import '../service/task_service.dart';

final taskServiceProvider = Provider<TaskService>((ref) {
  return TaskService();
});

final taskListProvider = StreamProvider<List<TaskModel>>((ref) {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    return Stream<List<TaskModel>>.value(const <TaskModel>[]);
  }

  final service = ref.watch(taskServiceProvider);
  return service.watchTasksForUser(userId: user.uid);
});

final selectedTaskDateProvider = StateProvider<DateTime?>((ref) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
});

final selectedTaskStatusProvider = StateProvider<StatusEnum?>((ref) => null);

final filteredTaskListProvider = Provider<AsyncValue<List<TaskModel>>>((ref) {
  final tasksAsync = ref.watch(taskListProvider);
  final selectedDate = ref.watch(selectedTaskDateProvider);
  final selectedStatus = ref.watch(selectedTaskStatusProvider);

  return tasksAsync.whenData((tasks) {
    return tasks
        .where((task) {
          final matchesStatus =
              selectedStatus == null || task.status == selectedStatus;

          final dueDate = task.dueDate;
          final matchesDate =
              selectedDate == null ||
              (dueDate != null &&
                  dueDate.year == selectedDate.year &&
                  dueDate.month == selectedDate.month &&
                  dueDate.day == selectedDate.day);

          return matchesStatus && matchesDate;
        })
        .toList(growable: false);
  });
});
