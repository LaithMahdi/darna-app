import 'package:flutter/material.dart';
import '../../../core/config.dart';
import '../../../shared/buttons/custom_back_button.dart';
import '../../../shared/buttons/primary_button.dart';
import '../../../shared/spacer/spacer.dart';
import '../../../shared/text/sub_label.dart';
import '../widgets/task_create_form.dart';

class TaskCreateView extends StatelessWidget {
  const TaskCreateView({super.key});

  @override
  Widget build(BuildContext context) {
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
            TaskCreateForm(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: Config.paddingBottom,
        child: PrimaryButton(text: "Save", onPressed: () {}),
      ),
    );
  }
}
