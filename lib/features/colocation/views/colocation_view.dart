import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/config.dart';
import '../../../routes/routes.dart';
import '../../../shared/buttons/custom_back_button.dart';
import '../../../shared/loading/custom_error_widget.dart';
import '../../../shared/spacer/spacer.dart';
import '../../chat/widgets/chat_empty_state.dart';
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
        error: (error, stackTrace) =>
            CustomErrorWidget(message: "Error loading colocations"),
        data: (colocations) {
          return colocations.isEmpty
              ? ChatEmptyState(
                  icon: LucideIcons.messageCircleOff600,
                  title: "No colocations yet",
                  subtitle:
                      "Create your first one to start sharing expenses with your friends.",
                )
              : ListView.separated(
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
