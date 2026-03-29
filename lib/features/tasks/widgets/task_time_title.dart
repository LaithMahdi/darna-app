import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';

class TaskTimeTitle extends StatelessWidget {
  const TaskTimeTitle({super.key, required this.date, required this.onTap});

  final DateTime date;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Text(
            DateFormat.yMMMM().format(date),
            style: AppStyle.styleSemiBold14,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 14,
              color: AppColor.grey9A,
            ),
          ),
        ],
      ),
    );
  }
}
