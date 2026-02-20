import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/config.dart';
import '../../../core/constants/app_style.dart';
import '../../../shared/buttons/ghost_button.dart';
import '../../../shared/buttons/media_source_button.dart';
import '../../../shared/icones/custom_prefix_icon.dart';

class CompletProfileModalBottomSheet extends StatelessWidget {
  const CompletProfileModalBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Config.defaultPadding,
      child: Column(
        spacing: 10,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Upload Photo", style: AppStyle.styleBold18),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: CustomPrefixIcon(icon: LucideIcons.x),
              ),
            ],
          ),

          Expanded(
            child: Column(
              children: [
                MediaSourceButton(
                  title: "Take Photo",
                  description: "Use your camera",
                  icon: LucideIcons.camera,
                  onTap: () {},
                ),
                SizedBox(height: 15),
                MediaSourceButton(
                  title: "Choose from Gallery",
                  description: "Select a photo from your device",
                  icon: LucideIcons.image,
                  onTap: () {},
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: GhostButton(
              onPressed: () => Navigator.pop(context),
              text: "Cancel",
            ),
          ),
        ],
      ),
    );
  }
}
