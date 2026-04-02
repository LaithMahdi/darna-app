import 'package:flutter/material.dart';
import '../../../shared/spacer/spacer.dart';
import '../models/colocation_model.dart';
import '../service/colocation_service.dart';
import 'colocation_detail_item_card.dart';
import 'colocation_detail_member_card.dart';

class ColocationDetailHasColocation extends StatelessWidget {
  const ColocationDetailHasColocation({
    super.key,
    required this.service,
    required this.colocation,
  });

  final ColocationService service;
  final ColocationModel? colocation;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ColocationModel?>(
      stream: service.watchColocationById(colocationId: colocation!.id),
      builder: (context, snapshot) {
        final currentColocation = snapshot.data ?? colocation!;
        return Column(
          children: [
            ColocationDetailItemCard(
              name: currentColocation.name,
              inviteCode: currentColocation.inviteCode,
            ),
            VerticalSpacer(23),
            ColocationDetailMemberCard(
              membersCount: currentColocation.membersCount,
              colocationId: currentColocation.id,
              colocationName: currentColocation.name,
            ),
          ],
        );
      },
    );
  }
}
