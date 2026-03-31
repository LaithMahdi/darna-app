import 'package:flutter/material.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../../../shared/icones/dialog_avatar.dart';

class HomeHistoryCard extends StatelessWidget {
  const HomeHistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border.all(color: AppColor.greyF9),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        spacing: 10,
        children: [
          DialogAvatar(
            icon: Icons.one_x_mobiledata,
            text: "SM",
            radius: 22,
            backgroundColor: AppColor.primary.withValues(alpha: .2),
            textStyle: AppStyle.styleBold14.copyWith(color: AppColor.primary),
          ),
          Expanded(
            child: Column(
              spacing: 6,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Sophie Martin",
                    style: AppStyle.styleBold12.copyWith(
                      color: AppColor.black21,
                    ),
                    children: [
                      TextSpan(
                        text: " uploaded a document.",
                        style: AppStyle.styleMedium12.copyWith(
                          color: AppColor.black21,
                        ),
                      ),
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: "Facture électricité",
                    style: AppStyle.styleRegular12.copyWith(
                      color: AppColor.black21,
                    ),
                    children: [
                      TextSpan(
                        text: " Il y a 2 jours",
                        style: AppStyle.styleMedium12.copyWith(
                          color: AppColor.grey9A,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
