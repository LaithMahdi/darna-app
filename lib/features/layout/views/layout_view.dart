import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_color.dart';
import '../data/bottom_navigation_data.dart';
import '../view_models/layout_view_model.dart';
import '../widgets/bottom_navigation_item.dart';

class LayoutView extends ConsumerWidget {
  const LayoutView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedNavigationIndexProvider);
    final viewModel = ref.read(layoutViewModelProvider);

    return Scaffold(
      body: PageTransitionSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation, secondAnimation) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondAnimation,
            child: child,
          );
        },
        child: bottomNavigationData[selectedIndex].view,
      ),
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
              .asMap()
              .entries
              .map(
                (entry) => BottomNavigationItem(
                  item: entry.value,
                  isSelected: selectedIndex == entry.key,
                  onTap: () => viewModel.selectNavigationItem(entry.key),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
