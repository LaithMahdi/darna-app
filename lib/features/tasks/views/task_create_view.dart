import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/config.dart';
import '../../../core/helper/date_picker_helper.dart';
import '../../../shared/buttons/custom_back_button.dart';
import '../../../shared/buttons/primary_button.dart';
import '../../../shared/spacer/spacer.dart';
import '../../../shared/text/sub_label.dart';
import '../view_models/task_create_view_model.dart';
import '../widgets/task_create_form.dart';
import '../widgets/task_create_users.dart';

class TaskCreateView extends ConsumerStatefulWidget {
  const TaskCreateView({super.key});

  @override
  ConsumerState<TaskCreateView> createState() => _TaskCreateViewState();
}

class _TaskCreateViewState extends ConsumerState<TaskCreateView> {
  final GlobalKey<FormState> _formTaskCreateKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final initialState = ref.read(taskCreateViewModelProvider);
    _dateController.text = initialState.dueDate;

    _titleController.addListener(() {
      ref
          .read(taskCreateViewModelProvider.notifier)
          .updateTitle(_titleController.text);
    });

    _descriptionController.addListener(() {
      ref
          .read(taskCreateViewModelProvider.notifier)
          .updateDescription(_descriptionController.text);
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final selectedDate = await DatePickerHelper.showDatePickerDialog(context);
    if (selectedDate != null) {
      ref.read(taskCreateViewModelProvider.notifier).updateDate(selectedDate);
    }
  }

  Future<void> _saveTask() async {
    final isFormValid = _formTaskCreateKey.currentState?.validate() ?? false;
    final notifier = ref.read(taskCreateViewModelProvider.notifier);
    final success = await notifier.saveTask(isFormValid: isFormValid);
    final state = ref.read(taskCreateViewModelProvider);

    if (!mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task prepared successfully.')),
      );
      return;
    }

    if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(taskCreateViewModelProvider);
    final viewModel = ref.read(taskCreateViewModelProvider.notifier);

    if (_dateController.text != state.dueDate) {
      _dateController.text = state.dueDate;
    }

    return Scaffold(
      appBar: AppBar(leading: CustomBackButton(), title: Text("Create Task")),
      body: SingleChildScrollView(
        padding: Config.defaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SubLabel(
              text:
                  "Create a new task and assign it to one or more roommates. Stay organized and ensure responsibilities are clearly distributed.",
            ),
            VerticalSpacer(24),
            TaskCreateForm(
              formKey: _formTaskCreateKey,
              titleController: _titleController,
              descriptionController: _descriptionController,
              dateController: _dateController,
              onTitleChanged: viewModel.updateTitle,
              onDescriptionChanged: viewModel.updateDescription,
              onDateTap: _pickDate,
            ),
            VerticalSpacer(28),
            TaskCreateUsers(
              availableUsers: state.availableUsers,
              selectedUserIds: state.selectedUserIds,
              onUsersSelected: viewModel.setSelectedUsers,
              onRemoveUser: viewModel.removeSelectedUser,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: Config.paddingBottom,
        child: PrimaryButton(
          text: "Save",
          isLoading: state.isSaving,
          onPressed: _saveTask,
        ),
      ),
    );
  }
}
