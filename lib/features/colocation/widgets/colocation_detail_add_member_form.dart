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

final _addMemberSubmittingProvider = StateProvider.autoDispose
    .family<bool, String>((ref, colocationId) => false);

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

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _addMember() async {
    final isValid =
        _formAddMemberColocationDetailKey.currentState?.validate() ?? false;
    final isSubmitting = ref.read(
      _addMemberSubmittingProvider(widget.colocationId),
    );

    if (!isValid || isSubmitting) return;

    ref.read(_addMemberSubmittingProvider(widget.colocationId).notifier).state =
        true;

    final error = await ref
        .read(colocationViewModelProvider.notifier)
        .addMemberByEmail(
          colocationId: widget.colocationId,
          email: _emailController.text.trim(),
        );

    if (!mounted) return;

    ref.read(_addMemberSubmittingProvider(widget.colocationId).notifier).state =
        false;

    if (error != null) {
      showToast(context, error, isError: true);
      return;
    }

    showToast(context, 'Member added successfully!');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isSubmitting = ref.watch(
      _addMemberSubmittingProvider(widget.colocationId),
    );

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
            isLoading: isSubmitting,
            onPressed: _addMember,
          ),
        ],
      ),
    );
  }
}
