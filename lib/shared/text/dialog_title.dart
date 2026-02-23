import 'package:flutter/material.dart';
import '../../core/constants/app_style.dart';

class DialogTitle extends StatelessWidget {
  const DialogTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: AppStyle.styleSemiBold18,
      ),
    );
  }
}
