import '../../../core/functions/format_date.dart';
import '../models/task_user.dart';

class TaskCreateState {
  final String title;
  final String description;
  final String dueDate;
  final List<TaskUser> availableUsers;
  final Set<String> selectedUserIds;
  final bool isSaving;
  final String? errorMessage;

  const TaskCreateState({
    required this.title,
    required this.description,
    required this.dueDate,
    required this.availableUsers,
    required this.selectedUserIds,
    required this.isSaving,
    this.errorMessage,
  });

  factory TaskCreateState.initial() {
    return TaskCreateState(
      title: '',
      description: '',
      dueDate: FormatDate.formatToDayMonthYear(DateTime.now()),
      availableUsers: const <TaskUser>[],
      selectedUserIds: const {},
      isSaving: false,
    );
  }

  TaskCreateState copyWith({
    String? title,
    String? description,
    String? dueDate,
    List<TaskUser>? availableUsers,
    Set<String>? selectedUserIds,
    bool? isSaving,
    String? errorMessage,
  }) {
    return TaskCreateState(
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      availableUsers: availableUsers ?? this.availableUsers,
      selectedUserIds: selectedUserIds ?? this.selectedUserIds,
      isSaving: isSaving ?? this.isSaving,
      errorMessage: errorMessage,
    );
  }

  List<TaskUser> get selectedUsers => availableUsers
      .where((user) => selectedUserIds.contains(user.id))
      .toList();
}
