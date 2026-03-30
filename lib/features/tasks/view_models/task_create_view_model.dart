import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'task_create_state.dart';

final taskCreateViewModelProvider =
    StateNotifierProvider<TaskCreateViewModel, TaskCreateState>((ref) {
      return TaskCreateViewModel();
    });

class TaskCreateViewModel extends StateNotifier<TaskCreateState> {
  TaskCreateViewModel() : super(TaskCreateState.initial());

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

    await Future<void>.delayed(const Duration(milliseconds: 300));

    state = state.copyWith(isSaving: false, errorMessage: null);
    return true;
  }
}
