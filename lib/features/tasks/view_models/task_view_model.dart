import 'dart:developer';

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
  final selectedDate = ref.watch(selectedTaskDateProvider);

  log('taskListProvider: selectedDate=$selectedDate, userId=$user.uid');

  if (selectedDate == null) {
    return service.watchTasksForUser(userId: user.uid);
  }

  return service.watchTasksForUserByDate(userId: user.uid, date: selectedDate);
});

final selectedTaskDateProvider = StateProvider<DateTime?>((ref) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
});

final selectedTaskStatusProvider = StateProvider<StatusEnum?>((ref) => null);

final filteredTaskListProvider = Provider<AsyncValue<List<TaskModel>>>((ref) {
  final tasksAsync = ref.watch(taskListProvider);
  final selectedStatus = ref.watch(selectedTaskStatusProvider);

  final result = tasksAsync.whenData((tasks) {
    log(
      'filteredTaskListProvider: tasks=${tasks.length}, selectedStatus=$selectedStatus',
    );
    return tasks
        .where((task) {
          final matchesStatus =
              selectedStatus == null || task.status == selectedStatus;
          return matchesStatus;
        })
        .toList(growable: false);
  });

  log('filteredTaskListProvider result: $result');
  return result;
});
