import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/functions/show_toast.dart';
import '../../../core/functions/valid_input.dart';
import '../../../features/colocation/models/colocation_model.dart';
import '../../../features/colocation/view_models/colocation_view_model.dart';
import '../../../shared/buttons/primary_button.dart';
import '../../../shared/forms/input.dart';
import '../../../shared/icones/custom_prefix_icon.dart';
import '../../../shared/spacer/spacer.dart';
import '../../../shared/text/dialog_description.dart';
import '../../../shared/text/dialog_title.dart';
import '../../../shared/text/label.dart';

class JoinColocationDialog extends ConsumerStatefulWidget {
  const JoinColocationDialog({super.key});

  @override
  ConsumerState<JoinColocationDialog> createState() =>
      _JoinColocationDialogState();
}

class _JoinColocationDialogState extends ConsumerState<JoinColocationDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _joinColocation() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid || _isLoading) return;

    setState(() {
      _isLoading = true;
    });

    final result = await ref
        .read(colocationViewModelProvider.notifier)
        .joinColocationByInviteCode(inviteCode: _codeController.text.trim());

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    result.fold((error) => showToast(context, error, isError: true), (
      colocation,
    ) {
      showToast(context, 'Joined ${colocation.name} successfully!');
      Navigator.of(context).pop<ColocationModel>(colocation);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DialogTitle(title: 'Join Colocation'),
              const VerticalSpacer(8),
              const DialogDescription(
                description:
                    'Enter the invitation code shared by your roommate to join a colocation.',
              ),
              const VerticalSpacer(16),
              Label(label: 'Invitation Code'),
              Input(
                hintText: 'E.g: 4555502',
                controller: _codeController,
                keyboardType: TextInputType.number,
                validator: (value) => validateInput(
                  value,
                  type: InputType.number,
                  min: 7,
                  max: 7,
                ),
                prefixIcon: CustomPrefixIcon(icon: LucideIcons.ticket),
              ),
              const VerticalSpacer(18),
              PrimaryButton(
                text: 'Join Now',
                isLoading: _isLoading,
                onPressed: _joinColocation,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
