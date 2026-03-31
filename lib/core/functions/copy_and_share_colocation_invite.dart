import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import 'show_toast.dart';

Future<void> copyAndShareColocationInvite({
  required BuildContext context,
  required String inviteCode,
  required String colocationName,
}) async {
  final code = inviteCode.trim();
  if (code.isEmpty) {
    showToast(context, 'Invite code is empty.', isError: true);
    return;
  }

  final title = colocationName.trim().isEmpty
      ? 'our colocation'
      : colocationName.trim();
  final message =
      'Hey! Join me on Darna.\n\n'
      'Colocation: $title\n'
      'Invitation code: $code\n\n'
      'Open the app, enter this code, and join our shared home.';

  await Clipboard.setData(ClipboardData(text: code));
  await SharePlus.instance.share(
    ShareParams(text: message, subject: 'Join my colocation on Darna'),
  );

  if (!context.mounted) return;
  showToast(context, 'Code copied and ready to share.');
}
