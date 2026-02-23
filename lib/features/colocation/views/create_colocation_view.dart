import 'package:flutter/material.dart';
import '../../../core/config.dart';
import '../../../shared/buttons/custom_back_button.dart';
import '../../../shared/text/sub_label.dart';
import '../widgets/create_colocation_form.dart';

class CreateColocationView extends StatelessWidget {
  const CreateColocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Navigator.canPop(context) ? CustomBackButton() : null,
        title: Text("Create Colocation"),
      ),
      body: ListView(
        padding: Config.defaultPadding,
        children: [
          SubLabel(
            text:
                "Create your colocation, invite your roommates, and make everyday living organized and stress-free.",
          ),
          CreateColocationForm(),
        ],
      ),
    );
  }
}
// 