import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/constants/app_color.dart';
import '../../../shared/icones/dialog_avatar.dart';
import '../../../shared/spacer/spacer.dart';
import '../../../shared/text/dialog_description.dart';
import '../../../shared/text/dialog_title.dart';
import 'colocation_detail_add_member_form.dart';

class ColocationDetailAddMember extends StatelessWidget {
  const ColocationDetailAddMember({super.key});

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: DialogAvatar(
                icon: LucideIcons.plus,
                color: AppColor.success,
                radius: 28,
                iconSize: 28,
              ),
            ),
            VerticalSpacer(16),
            Center(child: DialogTitle(title: "Add Member to Darna Apartment")),
            DialogDescription(
              description:
                  "Send the invitation code to your roommate. Once they enter it, they will automatically join this colocation.",
            ),
            VerticalSpacer(16),
            ColocationDetailAddMemberForm(),
          ],
        ),
      ),
    );
  }
}
