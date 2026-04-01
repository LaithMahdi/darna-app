import 'package:flutter/material.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../../../shared/spacer/spacer.dart';

class TaskDetailTimeLineTile extends StatelessWidget {
  const TaskDetailTimeLineTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.isFirst,
    required this.isLast,
  });

  final String title;
  final String subtitle;
  final Color color;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 22,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: 2,
                    color: isFirst ? AppColor.transparent : AppColor.greyF0,
                  ),
                ),
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                    border: Border.all(color: AppColor.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: color.withValues(alpha: .28),
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 2,
                    color: isLast ? AppColor.transparent : AppColor.greyF0,
                  ),
                ),
              ],
            ),
          ),
          HorizontalSpacer(10),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColor.greyF9,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppStyle.styleSemiBold13),
                  VerticalSpacer(2),
                  Text(
                    subtitle,
                    style: AppStyle.styleMedium12.copyWith(
                      color: AppColor.grey9A,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
