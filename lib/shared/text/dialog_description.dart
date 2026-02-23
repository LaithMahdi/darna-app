import 'package:flutter/material.dart';
import '../../core/constants/app_color.dart';
import '../../core/constants/app_style.dart';

class DialogDescription extends StatelessWidget {
  const DialogDescription({super.key, required this.description});

  final String description;

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: AppStyle.styleRegular12.copyWith(
        color: AppColor.grey9A,
        height: 2.2,
      ),
    );
  }
}
