import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/functions/valid_input.dart';
import '../../../shared/buttons/primary_button.dart';
import '../../../shared/forms/input.dart';
import '../../../shared/icones/custom_prefix_icon.dart';
import '../../../shared/spacer/spacer.dart';
import '../../../shared/text/label.dart';

class ColocationDetailAddMemberForm extends StatefulWidget {
  const ColocationDetailAddMemberForm({super.key});

  @override
  State<ColocationDetailAddMemberForm> createState() =>
      _ColocationDetailAddMemberFormState();
}

class _ColocationDetailAddMemberFormState
    extends State<ColocationDetailAddMemberForm> {
  final GlobalKey<FormState> _formAddMemberColocationDetailKey =
      GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formAddMemberColocationDetailKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Label(label: "Email Address"),
          Input(
            hintText: "E.g: example@gmail.com",
            controller: _emailController,
            prefixIcon: CustomPrefixIcon(icon: LucideIcons.mail),
            keyboardType: TextInputType.emailAddress,
            validator: (value) =>
                validateInput(value, type: InputType.email, min: 8, max: 150),
          ),
          VerticalSpacer(20),
          PrimaryButton(
            text: "Add Member",
            onPressed: () {
              if (_formAddMemberColocationDetailKey.currentState!.validate()) {
                // TODO: Add member to colocation
              }
            },
          ),
        ],
      ),
    );
  }
}
