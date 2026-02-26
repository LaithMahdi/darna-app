import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/app_style.dart';
import '../icones/custom_prefix_icon.dart';

class DismissibleCard extends StatelessWidget {
  const DismissibleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: AppColor.error,
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.centerRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 5,
        children: [
          CustomPrefixIcon(
            icon: LucideIcons.trash,
            color: AppColor.whiteFB,
            size: 18,
          ),
          Text(
            "Delete",
            style: AppStyle.styleMedium12.copyWith(color: AppColor.white),
          ),
        ],
      ),
    );
  }
}
