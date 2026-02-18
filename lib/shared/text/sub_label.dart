import 'package:flutter/material.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/app_style.dart';

class SubLabel extends StatelessWidget {
  const SubLabel({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 21),
      child: Text(
        text,
        style: AppStyle.styleRegular14.copyWith(
          color: AppColor.grey9A,
          height: 2.2,
        ),
      ),
    );
  }
}
