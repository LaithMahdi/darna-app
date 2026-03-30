import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/functions/format_date.dart';
import '../../../core/functions/valid_input.dart';
import '../../../core/helper/date_picker_helper.dart';
import '../../../shared/forms/input.dart';
import '../../../shared/icones/custom_prefix_icon.dart';
import '../../../shared/spacer/spacer.dart';
import '../../../shared/text/label.dart';

class TaskCreateForm extends StatefulWidget {
  const TaskCreateForm({super.key});

  @override
  State<TaskCreateForm> createState() => _TaskCreateFormState();
}

class _TaskCreateFormState extends State<TaskCreateForm> {
  final GlobalKey<FormState> _formTaskCreateKey = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _date = TextEditingController();

  @override
  void initState() {
    _date.text = FormatDate.formatToDayMonthYear(DateTime.now());
    super.initState();
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    _date.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formTaskCreateKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Label(label: "Title"),
          Input(
            hintText: "e.g:Take out the trash",
            controller: _title,
            validator: (value) => validateInput(value, min: 2, max: 100),
          ),
          VerticalSpacer(20),
          Label(label: "Description"),
          Input(
            hintText: "e.g: Make sure to take out the trash every week",
            controller: _description,
            maxLines: 4,
            validator: (value) => validateInput(value, min: 10, max: 2000),
          ),
          VerticalSpacer(20),
          Label(label: "Date"),
          Input(
            hintText: "e.g: 2023-10-10",
            controller: _date,
            readOnly: true,
            onTap: () async {
              final selectedDate = await DatePickerHelper.showDatePickerDialog(
                context,
              );

              if (selectedDate != null) {
                _date.text = selectedDate;
              }
            },
            prefixIcon: CustomPrefixIcon(icon: LucideIcons.calendar),
            validator: (value) => validateInput(value, min: 10, max: 16),
          ),
        ],
      ),
    );
  }
}
