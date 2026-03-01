import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../models/bottom_navigation_model.dart';
import '../views/home_view.dart';
import '../views/settings_view.dart';

List<BottomNavigationModel> bottomNavigationData = [
  BottomNavigationModel(
    title: "Home",
    icon: LucideIcons.house,
    view: HomeView(),
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
    view: SettingsView(),
  ),
];
