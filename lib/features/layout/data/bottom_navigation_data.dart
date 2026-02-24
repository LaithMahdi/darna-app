import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../models/bottom_navigation_model.dart';

List<BottomNavigationModel> bottomNavigationData = [
  BottomNavigationModel(
    title: "Home",
    icon: LucideIcons.house,
    isSelected: true,
    view: Container(color: Colors.blue),
  ),
  BottomNavigationModel(
    title: "Tasks",
    icon: LucideIcons.folderCheck,
    view: Container(color: Colors.green),
  ),
  BottomNavigationModel(
    title: "Messages",
    icon: LucideIcons.messageCircle,
    view: Container(color: Colors.orange),
  ),
  BottomNavigationModel(
    title: "Settings",
    icon: LucideIcons.settings,
    view: Container(color: Colors.purple),
  ),
];
