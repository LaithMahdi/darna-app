import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/functions/show_toast.dart';
import '../../../core/functions/valid_input.dart';
import '../../../routes/routes.dart';
import '../../../shared/buttons/primary_button.dart';
import '../../../shared/forms/input.dart';
import '../../../shared/spacer/spacer.dart';
import '../../../shared/text/label.dart';
import '../view_models/colocation_view_model.dart';
import 'create_colocation_dialog.dart';

class CreateColocationForm extends ConsumerStatefulWidget {
  const CreateColocationForm({super.key});

  @override
  ConsumerState<CreateColocationForm> createState() =>
      _CreateColocationFormState();
}

class _CreateColocationFormState extends ConsumerState<CreateColocationForm> {
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

  Future<void> _saveColocation() async {
    final isValid = _createColocationFormKey.currentState?.validate() ?? false;
    if (!isValid) return;

    final maxMembers = int.tryParse(_maxMembersController.text.trim()) ?? 4;
    final notifier = ref.read(colocationViewModelProvider.notifier);

    final created = await notifier.createColocation(
      name: _colocationNameController.text,
      maxMembers: maxMembers,
    );

    final state = ref.read(colocationViewModelProvider);

    if (!mounted) return;

    if (!created) {
      showToast(
        context,
        state.createError ?? 'Error while creating colocation.',
        isError: true,
      );
      return;
    }

    await showDialog<void>(
      context: context,
      builder: (context) => CreateColocationDialog(
        inviteCode: state.generatedInviteCode ?? '',
        colocationName: _colocationNameController.text.trim(),
      ),
    );

    if (!mounted) return;
    context.go(Routes.colocation);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(colocationViewModelProvider);

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
            isLoading: state.isCreating,
            onPressed: _saveColocation,
          ),
        ],
      ),
    );
  }
}
