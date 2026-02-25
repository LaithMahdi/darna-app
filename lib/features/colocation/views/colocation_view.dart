import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/config.dart';
import '../../../routes/routes.dart';
import '../../../shared/buttons/custom_back_button.dart';
import '../../../shared/spacer/spacer.dart';
import '../widgets/colocation_item.dart';

class ColocationView extends StatelessWidget {
  const ColocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: CustomBackButton(), title: Text("Colocations")),
      body: ListView.separated(
        padding: Config.defaultPadding,
        itemCount: 10,
        itemBuilder: (context, index) => ColocationItem(),
        separatorBuilder: (context, index) => VerticalSpacer(15),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => GoRouter.of(context).push(Routes.createColocation),
        child: Icon(LucideIcons.plus),
      ),
    );
  }
}
