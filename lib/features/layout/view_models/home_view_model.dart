import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/constants/app_color.dart';
import '../models/home_stat_model.dart';
import '../../tasks/models/task_model.dart';
import '../../tasks/service/task_service.dart';
import '../../colocation/models/colocator_model.dart';
import '../../colocation/service/colocation_service.dart';

class HomeViewModel {
  final Ref ref;

  HomeViewModel({required this.ref});

  // Get upcoming tasks for the current user (next 7 days)
  Stream<List<TaskModel>> getUpcomingTasks({required String userId}) {
    final taskService = ref.read(taskServiceProvider);
    return taskService.watchTasksForUser(userId: userId).map((tasks) {
      final now = DateTime.now();
      final sevenDaysFromNow = now.add(Duration(days: 7));

      // Filter tasks within next 7 days
      final upcomingTasks = tasks.where((task) {
        if (task.dueDate == null) return false;
        return task.dueDate!.isAfter(now) &&
            task.dueDate!.isBefore(sevenDaysFromNow);
      }).toList();

      // Sort by due date
      upcomingTasks.sort((a, b) => a.dueDate!.compareTo(b.dueDate!));

      return upcomingTasks;
    });
  }

  // Get task history (completed tasks from current user)
  Stream<List<TaskModel>> getTaskHistory({required String userId}) {
    final taskService = ref.read(taskServiceProvider);
    return taskService.watchTasksForUser(userId: userId).map((tasks) {
      // Filter completed tasks
      final historyTasks = tasks
          .where((task) => task.status.name == 'Completed')
          .toList();

      // Sort by updated date (most recent first)
      historyTasks.sort(
        (a, b) => (b.updatedAt ?? DateTime(1970)).compareTo(
          a.updatedAt ?? DateTime(1970),
        ),
      );

      return historyTasks.take(10).toList(); // Limit to 10
    });
  }

  // Get household members
  Stream<List<ColocatorModel>> getHouseholdMembers({required String userId}) {
    final colocationService = ref.read(colocationServiceProvider);
    return colocationService.watchUserColocations(userId: userId).asyncMap((
      colocations,
    ) async {
      if (colocations.isEmpty) {
        return <ColocatorModel>[];
      }

      // Get members from first colocation
      final members = await colocationService
          .watchColocationMembers(colocationId: colocations[0].id)
          .first;
      return members;
    });
  }

  // Get home stats (pending, current, reminders, balance)
  Stream<List<HomeStatModel>> getHomeStats({required String userId}) {
    final taskService = ref.read(taskServiceProvider);
    return taskService.watchTasksForUser(userId: userId).map((tasks) {
      final now = DateTime.now();
      final threeDaysFromNow = now.add(Duration(days: 3));

      // Pending Tasks (ToDo status)
      final pendingCount = tasks.where((t) => t.status.name == 'ToDo').length;

      // Current Tasks (InProgress status)
      final inProgressCount = tasks
          .where((t) => t.status.name == 'InProgress')
          .length;

      // Reminders (tasks due within 3 days)
      final remindersCount = tasks
          .where((task) {
            if (task.dueDate == null) return false;
            return task.dueDate!.isAfter(now) &&
                task.dueDate!.isBefore(threeDaysFromNow);
          })
          .where((task) => task.status.name != 'Completed')
          .length;

      return [
        HomeStatModel(
          title: 'Pending Tasks',
          value: pendingCount.toString(),
          icon: LucideIcons.clock,
          color: AppColor.gold,
        ),
        HomeStatModel(
          title: 'Current Tasks',
          value: inProgressCount.toString(),
          icon: LucideIcons.check,
          color: AppColor.success,
        ),
        HomeStatModel(
          title: 'Reminders',
          value: remindersCount.toString(),
          icon: LucideIcons.bell,
          color: AppColor.primary,
        ),
        HomeStatModel(
          title: 'Your Balance',
          value: '0€',
          icon: LucideIcons.circleDollarSign,
          color: AppColor.blue02,
        ),
      ];
    });
  }
}

// Riverpod Providers
final taskServiceProvider = Provider((ref) => TaskService());

final colocationServiceProvider = Provider((ref) => ColocationService());

final homeViewModelProvider = Provider((ref) {
  return HomeViewModel(ref: ref);
});

// For a specific user
final upcomingTasksProvider = StreamProvider.family<List<TaskModel>, String>((
  ref,
  userId,
) {
  final viewModel = ref.watch(homeViewModelProvider);
  return viewModel.getUpcomingTasks(userId: userId);
});

final taskHistoryProvider = StreamProvider.family<List<TaskModel>, String>((
  ref,
  userId,
) {
  final viewModel = ref.watch(homeViewModelProvider);
  return viewModel.getTaskHistory(userId: userId);
});

final householdMembersProvider =
    StreamProvider.family<List<ColocatorModel>, String>((ref, userId) {
      final viewModel = ref.watch(homeViewModelProvider);
      return viewModel.getHouseholdMembers(userId: userId);
    });

final homeStatsProvider = StreamProvider.family<List<HomeStatModel>, String>((
  ref,
  userId,
) {
  final viewModel = ref.watch(homeViewModelProvider);
  return viewModel.getHomeStats(userId: userId);
});
