import 'package:flutter/widgets.dart';

class BottomNavigationModel {
  String title;
  IconData icon;
  bool isSelected;
  Widget view;

  BottomNavigationModel({
    required this.title,
    required this.icon,
    this.isSelected = false,
    required this.view,
  });
}
