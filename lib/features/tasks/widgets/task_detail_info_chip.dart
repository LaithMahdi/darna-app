import 'package:flutter/material.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../../../shared/icones/custom_prefix_icon.dart';
import '../../../shared/spacer/spacer.dart';

class TaskDetailInfoChip extends StatelessWidget {
  const TaskDetailInfoChip({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.greyF9,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          CustomPrefixIcon(icon: icon, color: AppColor.grey9A, size: 15),
          HorizontalSpacer(8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppStyle.styleMedium12.copyWith(
                    color: AppColor.grey9A,
                  ),
                ),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyle.styleSemiBold12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
