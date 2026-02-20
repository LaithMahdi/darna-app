import 'package:flutter/material.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/app_style.dart';

class MediaSourceButton extends StatelessWidget {
  const MediaSourceButton({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.greyF0),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          spacing: 10,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: AppColor.greyF0,
              child: Icon(icon, size: 20, color: AppColor.black),
            ),
            Column(
              spacing: 2,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppStyle.styleSemiBold14),
                Text(
                  description,
                  style: AppStyle.styleMedium12.copyWith(color: AppColor.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
