import 'package:flutter/material.dart';
import '../data/home_stat_data.dart';
import 'home_stat_icon_card.dart';

class HomeSliverGrid extends StatelessWidget {
  const HomeSliverGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      itemCount: homeStatsData.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 4,
        childAspectRatio: 140 / 68,
      ),
      itemBuilder: (context, index) {
        final stat = homeStatsData[index];
        return HomeStatIconCard(stat: stat);
      },
    );
  }
}
