import 'package:flutter/material.dart';

import '../../../core/constants/app_style.dart';

class HomeTitle extends StatelessWidget {
  const HomeTitle({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Text(text, style: AppStyle.styleBold16.copyWith(height: 2.7)),
    );
  }
}
