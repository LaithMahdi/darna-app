import 'package:flutter/material.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_style.dart';
import '../models/bottom_navigation_model.dart';

class BottomNavigationItem extends StatelessWidget {
  const BottomNavigationItem({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  final BottomNavigationModel item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 5,
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            padding: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
            decoration: BoxDecoration(
              color: isSelected ? AppColor.primary.withValues(alpha: .2) : null,
              borderRadius: BorderRadius.circular(38),
            ),
            child: Icon(
              item.icon,
              size: 18,
              color: isSelected ? AppColor.primary : AppColor.black,
            ),
          ),
          Text(
            item.title,
            style: AppStyle.styleMedium12.copyWith(
              color: isSelected ? AppColor.primary : null,
            ),
          ),
        ],
      ),
    );
  }
}
