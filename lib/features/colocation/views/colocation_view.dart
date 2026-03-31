import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/config.dart';
import '../../../routes/routes.dart';
import '../../../shared/buttons/custom_back_button.dart';
import '../../../shared/spacer/spacer.dart';
import '../view_models/colocation_view_model.dart';
import '../widgets/colocation_item.dart';

class ColocationView extends ConsumerWidget {
  const ColocationView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(colocationViewModelProvider);

    return Scaffold(
      appBar: AppBar(leading: CustomBackButton(), title: Text("Colocations")),
      body: state.colocations.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: Config.defaultPadding,
            child: Text('Error loading colocations: $error'),
          ),
        ),
        data: (colocations) {
          if (colocations.isEmpty) {
            return const Center(
              child: Text('No colocations yet. Create your first one.'),
            );
          }

          return ListView.separated(
            padding: Config.defaultPadding,
            itemCount: colocations.length,
            itemBuilder: (context, index) {
              final colocation = colocations[index];
              return ColocationItem(
                name: colocation.name,
                membersCount: colocation.membersCount,
                onTap: () => GoRouter.of(
                  context,
                ).push(Routes.colocationDetail, extra: colocation),
              );
            },
            separatorBuilder: (context, index) => VerticalSpacer(15),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => GoRouter.of(context).push(Routes.createColocation),
        child: Icon(LucideIcons.plus),
      ),
    );
  }
}
