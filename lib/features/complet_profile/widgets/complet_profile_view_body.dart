import 'package:flutter/material.dart';
import '../../../core/config.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../../../shared/forms/image_uploader.dart';
import '../../../shared/spacer/spacer.dart';
import 'complet_profile_button.dart';
import 'complet_profile_modal_bottom_sheet.dart';

class CompletProfileViewBody extends StatelessWidget {
  const CompletProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Config.defaultPadding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageUploader(imagePath: null, onDelete: () {}),
          VerticalSpacer(20),
          Text("Add Your Photo", style: AppStyle.styleBold18),
          VerticalSpacer(5),
          Text(
            "Upload a professional photo to complete\nyour profile",
            textAlign: TextAlign.center,
            style: AppStyle.styleMedium13.copyWith(
              color: AppColor.grey9A,
              height: 2,
            ),
          ),
          VerticalSpacer(20),
          CompleteProfileButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.45,
                ),
                builder: (context) => CompletProfileModalBottomSheet(),
              );
            },
          ),
        ],
      ),
    );
  }
}
