import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/config.dart';
import '../../../core/functions/show_toast.dart';
import '../../../shared/buttons/custom_back_button.dart';
import '../../../shared/buttons/primary_button.dart';
import '../../../shared/spacer/spacer.dart';
import '../../../shared/text/sub_label.dart';
import '../models/colocation_model.dart';
import '../view_models/colocation_view_model.dart';
import '../widgets/colocation_detail_has_colocation.dart';
import '../widgets/colocation_detail_list_item_card.dart';

class ColocationDetailView extends ConsumerWidget {
  const ColocationDetailView({super.key, this.colocation});

  final ColocationModel? colocation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final service = ref.watch(colocationServiceProvider);
    final currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';

    return Scaffold(
      appBar: AppBar(
        leading: CustomBackButton(),
        title: Text("Colocation Invitation"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: Config.defaultPadding,
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SubLabel(
                    text:
                        "You’ve received an invitation to join this colocation. Join your roommates and start managing your shared home together.",
                  ),
                  VerticalSpacer(21),
                  ColocationDetailHasColocation(
                    service: service,
                    colocation: colocation,
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 25),
            sliver: StreamBuilder<ColocationModel?>(
              stream: service.watchColocationById(colocationId: colocation!.id),
              builder: (context, snapshot) {
                final currentColocation = snapshot.data ?? colocation!;
                final isCurrentUserAdmin =
                    currentColocation.createdBy == currentUserId;

                return StreamBuilder(
                  stream: service.watchColocationMembers(
                    colocationId: colocation!.id,
                  ),
                  builder: (context, membersSnapshot) {
                    final members = membersSnapshot.data ?? const [];
                    return members.isEmpty
                        ? SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(
                                'No members found for this colocation.',
                              ),
                            ),
                          )
                        : SliverList.separated(
                            itemCount: members.length,
                            itemBuilder: (context, index) {
                              final colocator = members[index];
                              final canRemove =
                                  isCurrentUserAdmin && !colocator.isAdmin;

                              return ColocationDetailListItemCard(
                                colocator: colocator,
                                canRemove: canRemove,
                                onConfirmRemove: canRemove
                                    ? () async {
                                        await ref
                                            .read(
                                              colocationViewModelProvider
                                                  .notifier,
                                            )
                                            .removeMember(
                                              colocationId:
                                                  currentColocation.id,
                                              memberUserId: colocator.userId,
                                            );
                                        showToast(
                                          context,
                                          '${colocator.fullName} removed successfully.',
                                        );
                                        return true;
                                      }
                                    : null,
                              );
                            },
                            separatorBuilder: (context, index) =>
                                VerticalSpacer(15),
                          );
                  },
                );
              },
            ),
          ),
          SliverToBoxAdapter(child: VerticalSpacer(21)),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: Config.paddingBottom,
        child: PrimaryButton(text: "Save", onPressed: () {}),
      ),
    );
  }
}
