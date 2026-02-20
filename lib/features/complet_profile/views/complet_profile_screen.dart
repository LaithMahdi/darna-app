import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/constants/app_color.dart';
import '../widgets/complet_profile_appbar.dart';
import '../widgets/complet_profile_view_body.dart';

class CompletProfileScreen extends StatelessWidget {
  const CompletProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CompletProfileAppbar(),
        backgroundColor: AppColor.primary,
        toolbarHeight: 100,
      ),
      body: CompletProfileViewBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(LucideIcons.arrowRight),
      ),
    );
  }
}
