import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/functions/show_toast.dart';
import '../../../core/functions/valid_input.dart';
import '../../../shared/buttons/primary_button.dart';
import '../../../shared/forms/input.dart';
import '../../../shared/icones/custom_prefix_icon.dart';
import '../../../shared/spacer/spacer.dart';
import '../../../shared/text/label.dart';
import '../view_models/colocation_view_model.dart';

class ColocationDetailAddMemberForm extends ConsumerStatefulWidget {
  const ColocationDetailAddMemberForm({super.key, required this.colocationId});

  final String colocationId;

  @override
  ConsumerState<ColocationDetailAddMemberForm> createState() =>
      _ColocationDetailAddMemberFormState();
}

class _ColocationDetailAddMemberFormState
    extends ConsumerState<ColocationDetailAddMemberForm> {
  final GlobalKey<FormState> _formAddMemberColocationDetailKey =
      GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _addMember() async {
    final isValid =
        _formAddMemberColocationDetailKey.currentState?.validate() ?? false;
    if (!isValid || _isSubmitting) return;

    setState(() {
      _isSubmitting = true;
    });

    final error = await ref
        .read(colocationViewModelProvider.notifier)
        .addMemberByEmail(
          colocationId: widget.colocationId,
          email: _emailController.text.trim(),
        );

    if (!mounted) return;

    setState(() {
      _isSubmitting = false;
    });

    if (error != null) {
      showToast(context, error, isError: true);
      return;
    }

    showToast(context, 'Member added successfully!');
    Navigator.of(context).pop();
  }

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
            isLoading: _isSubmitting,
            onPressed: _addMember,
          ),
        ],
      ),
    );
  }
}
