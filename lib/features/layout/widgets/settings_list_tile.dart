import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';

class SettingsListTile extends StatelessWidget {
  const SettingsListTile({
    super.key,
    required this.title,
    this.color,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final Color? color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      minVerticalPadding: 0,
      minTileHeight: 50,
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColor.greyF9,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 20, color: color ?? AppColor.black21),
      ),
      title: Text(
        title,
        style: AppStyle.styleSemiBold14.copyWith(
          color: color ?? AppColor.black21,
        ),
      ),
      trailing: Icon(
        LucideIcons.chevronRight,
        size: 20,
        color: color ?? AppColor.black21,
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColor.greyF9),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
