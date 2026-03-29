import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';

class TaskTimeLine extends StatelessWidget {
  const TaskTimeLine({
    super.key,
    required this.date,
    required this.isSelected,
    required this.onTap,
  });

  final DateTime date;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(13),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primary : AppColor.white,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(color: AppColor.greyF9),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 3,
          children: [
            Text(
              DateFormat('MMM').format(date),
              style: AppStyle.styleMedium12.copyWith(
                color: isSelected ? AppColor.white : AppColor.black,
              ),
            ),
            Text(
              DateFormat.d().format(date),
              style: AppStyle.styleMedium24.copyWith(
                color: isSelected ? AppColor.white : AppColor.black,
              ),
            ),
            Text(
              DateFormat.E().format(date),
              style: AppStyle.styleMedium12.copyWith(
                color: isSelected ? AppColor.white : AppColor.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
