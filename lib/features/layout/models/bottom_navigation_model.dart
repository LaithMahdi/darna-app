import 'package:flutter/widgets.dart';

class BottomNavigationModel {
  String title;
  IconData icon;
  Widget view;

  BottomNavigationModel({
    required this.title,
    required this.icon,
    required this.view,
  });
}
