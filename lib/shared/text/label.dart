import 'package:flutter/material.dart';
import '../../core/constants/app_style.dart';

class Label extends StatelessWidget {
  const Label({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Text(label, style: AppStyle.styleSemiBold13),
    );
  }
}
