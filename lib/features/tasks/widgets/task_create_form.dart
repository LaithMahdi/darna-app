import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/functions/valid_input.dart';
import '../../../shared/forms/input.dart';
import '../../../shared/icones/custom_prefix_icon.dart';
import '../../../shared/spacer/spacer.dart';
import '../../../shared/text/label.dart';

class TaskCreateForm extends StatelessWidget {
  const TaskCreateForm({
    super.key,
    required this.formKey,
    required this.titleController,
    required this.descriptionController,
    required this.dateController,
    required this.onTitleChanged,
    required this.onDescriptionChanged,
    required this.onDateTap,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController dateController;
  final ValueChanged<String> onTitleChanged;
  final ValueChanged<String> onDescriptionChanged;
  final VoidCallback onDateTap;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Label(label: "Title"),
          Input(
            hintText: "e.g:Take out the trash",
            controller: titleController,
            onChanged: onTitleChanged,
            validator: (value) => validateInput(value, min: 2, max: 100),
          ),
          VerticalSpacer(20),
          Label(label: "Description"),
          Input(
            hintText: "e.g: Make sure to take out the trash every week",
            controller: descriptionController,
            onChanged: onDescriptionChanged,
            maxLines: 4,
            validator: (value) => validateInput(value, min: 10, max: 2000),
          ),
          VerticalSpacer(20),
          Label(label: "Date"),
          Input(
            hintText: "e.g: 2023-10-10",
            controller: dateController,
            readOnly: true,
            onTap: onDateTap,
            prefixIcon: CustomPrefixIcon(icon: LucideIcons.calendar),
            validator: (value) => validateInput(value, min: 10, max: 16),
          ),
        ],
      ),
    );
  }
}
