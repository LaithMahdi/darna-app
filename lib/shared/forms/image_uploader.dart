import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../core/constants/app_color.dart';

class ImageUploader extends StatelessWidget {
  const ImageUploader({super.key, this.imagePath, required this.onDelete});

  final String? imagePath;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: AppColor.greyF0,
        border: Border.all(color: AppColor.white, width: 4),
      ),
      child: imagePath != null
          ? Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(9),
                  child: Image.file(
                    File(imagePath!),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Positioned(
                  top: -15,
                  right: -15,
                  child: IconButton.filled(
                    onPressed: onDelete,
                    icon: Icon(
                      LucideIcons.circleX,
                      size: 20,
                      color: AppColor.white,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColor.error,
                    ),
                  ),
                ),
              ],
            )
          : Icon(LucideIcons.briefcase, color: AppColor.grey9A, size: 36),
    );
  }
}
