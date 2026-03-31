import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../../../shared/buttons/custom_filled_icon_button.dart';
import '../../../shared/icones/custom_prefix_icon.dart';
import 'colocation_detail_add_member.dart';

class ColocationDetailMemberCard extends StatelessWidget {
  const ColocationDetailMemberCard({
    super.key,
    required this.membersCount,
    required this.colocationId,
    required this.colocationName,
  });

  final int membersCount;
  final String? colocationId;
  final String colocationName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColor.greyF0)),
      ),
      child: Row(
        spacing: 15,
        children: [
          CustomPrefixIcon(
            icon: LucideIcons.users,
            color: AppColor.black,
            size: 20,
          ),
          Expanded(
            child: Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Members", style: AppStyle.styleSemiBold14),
                Text(
                  "$membersCount colocataires",
                  style: AppStyle.styleMedium12.copyWith(
                    color: AppColor.grey9A,
                  ),
                ),
              ],
            ),
          ),
          CustomFilledIconButton(
            icon: LucideIcons.plus,
            onPressed: () {
              if (colocationId == null || colocationId!.isEmpty) {
                return;
              }

              showDialog(
                context: context,
                builder: (context) => ColocationDetailAddMember(
                  colocationId: colocationId!,
                  colocationName: colocationName,
                ),
              );
            },
            color: AppColor.greyF0,
            foregroundColor: AppColor.grey9A,
          ),
        ],
      ),
    );
  }
}
