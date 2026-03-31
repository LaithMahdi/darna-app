import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../service/task_service.dart';
import 'task_create_state.dart';
import 'task_view_model.dart';
import '../../../core/functions/format_date.dart';

final taskCreateViewModelProvider =
    StateNotifierProvider<TaskCreateViewModel, TaskCreateState>((ref) {
      final service = ref.watch(taskServiceProvider);
      return TaskCreateViewModel(service: service);
    });

class TaskCreateViewModel extends StateNotifier<TaskCreateState> {
  final TaskService service;

  TaskCreateViewModel({required this.service})
    : super(TaskCreateState.initial()) {
    _loadTaskUsers();
  }

  Future<void> _loadTaskUsers() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final result = await service.fetchTaskUsers(currentUserId: user.uid);
    result.fold((_) {}, (users) {
      state = state.copyWith(availableUsers: users);
    });
  }

  void updateTitle(String value) {
    state = state.copyWith(title: value, errorMessage: null);
  }

  void updateDescription(String value) {
    state = state.copyWith(description: value, errorMessage: null);
  }

  void updateDate(String value) {
    state = state.copyWith(dueDate: value, errorMessage: null);
  }

  void setSelectedUsers(Set<String> selectedUserIds) {
    state = state.copyWith(
      selectedUserIds: Set<String>.from(selectedUserIds),
      errorMessage: null,
    );
  }

  void removeSelectedUser(String userId) {
    final updated = Set<String>.from(state.selectedUserIds)..remove(userId);
    state = state.copyWith(selectedUserIds: updated, errorMessage: null);
  }

  Future<bool> saveTask({required bool isFormValid}) async {
    if (!isFormValid) {
      state = state.copyWith(
        errorMessage: 'Please fix form errors before saving.',
      );
      return false;
    }

    if (state.selectedUserIds.isEmpty) {
      state = state.copyWith(
        errorMessage: 'Please choose at least one member for this task.',
      );
      return false;
    }

    state = state.copyWith(isSaving: true, errorMessage: null);

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      state = state.copyWith(
        isSaving: false,
        errorMessage: 'You must login first.',
      );
      return false;
    }

    final selectedUsers = state.availableUsers
        .where((member) => state.selectedUserIds.contains(member.id))
        .toList(growable: false);

    final result = await service.createTask(
      title: state.title,
      description: state.description,
      dueDateText: state.dueDate,
      selectedUsers: selectedUsers,
      createdBy: user.uid,
    );

    return result.fold(
      (error) {
        state = state.copyWith(isSaving: false, errorMessage: error);
        return false;
      },
      (_) {
        state = state.copyWith(isSaving: false, errorMessage: null);
        return true;
      },
    );
  }

  void resetForm() {
    state = state.copyWith(
      title: '',
      description: '',
      dueDate: FormatDate.formatToDayMonthYear(DateTime.now()),
      selectedUserIds: <String>{},
      isSaving: false,
      errorMessage: null,
    );
  }
}
