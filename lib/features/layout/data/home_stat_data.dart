import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/constants/app_color.dart';
import '../models/home_stat_model.dart';

List<HomeStatModel> homeStatsData = [
  HomeStatModel(
    title: "Pending Tasks",
    value: "3",
    icon: LucideIcons.clock,
    color: AppColor.gold,
  ),
  HomeStatModel(
    title: "Current Tasks",
    value: "12",
    icon: LucideIcons.clock,
    color: AppColor.success,
  ),
  HomeStatModel(
    title: "Reminders",
    value: "4",
    icon: LucideIcons.clock,
    color: AppColor.primary,
  ),
  HomeStatModel(
    title: "Your Balance",
    value: "-25€",
    icon: LucideIcons.clock,
    color: AppColor.blue02,
  ),
];
