import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../chat/views/chat_view.dart';
import '../../tasks/views/task_view.dart';
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
    view: TaskView(),
  ),
  BottomNavigationModel(
    title: "Messages",
    icon: LucideIcons.messageCircle,
    view: ChatView(),
  ),
  BottomNavigationModel(
    title: "Settings",
    icon: LucideIcons.settings,
    view: SettingsView(),
  ),
];
