import 'package:flutter/material.dart';
import '../../../core/functions/valid_input.dart';
import '../../../shared/buttons/primary_button.dart';
import '../../../shared/forms/input.dart';
import '../../../shared/spacer/spacer.dart';
import '../../../shared/text/label.dart';
import 'create_colocation_dialog.dart';

class CreateColocationForm extends StatefulWidget {
  const CreateColocationForm({super.key});

  @override
  State<CreateColocationForm> createState() => _CreateColocationFormState();
}

class _CreateColocationFormState extends State<CreateColocationForm> {
  final GlobalKey<FormState> _createColocationFormKey = GlobalKey<FormState>();
  final TextEditingController _colocationNameController =
      TextEditingController();
  final TextEditingController _maxMembersController = TextEditingController(
    text: "4",
  );

  @override
  void dispose() {
    _colocationNameController.dispose();
    _maxMembersController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _createColocationFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Label(label: "Colocation Name"),
          Input(
            hintText: "E.g: Darna Colocation",
            controller: _colocationNameController,
            validator: (value) => validateInput(value, max: 150),
          ),
          VerticalSpacer(20),
          Label(label: "Maximum Members"),
          Input(
            hintText: "E.g: 4",
            controller: _maxMembersController,
            keyboardType: TextInputType.number,
            validator: (value) =>
                validateInput(value, min: 1, max: 2, isRequired: false),
          ),
          VerticalSpacer(20),
          PrimaryButton(
            text: "Save",
            onPressed: () {
              if (_createColocationFormKey.currentState!.validate()) {
                showDialog(
                  context: context,
                  builder: (context) => const CreateColocationDialog(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
