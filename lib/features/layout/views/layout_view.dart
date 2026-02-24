import 'package:flutter/material.dart';
import '../../../core/constants/app_color.dart';
import '../data/bottom_navigation_data.dart';
import '../widgets/bottom_navigation_item.dart';

class LayoutView extends StatelessWidget {
  const LayoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bottomNavigationData[0].view,
      bottomNavigationBar: Container(
        height: 80,
        decoration: BoxDecoration(
          color: AppColor.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              spreadRadius: 0,
              offset: Offset(0, -5),
              color: AppColor.black.withValues(alpha: .1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: bottomNavigationData
              .map(
                (e) => BottomNavigationItem(
                  item: e,
                  isSelected: e.isSelected ? true : false,
                  onTap: () {},
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
