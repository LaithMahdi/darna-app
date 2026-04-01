import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../colocation/service/colocation_service.dart';
import '../../../core/config.dart';
import '../../../core/constants/app_style.dart';
import '../../../routes/routes.dart';
import '../../../shared/forms/input.dart';
import '../../../shared/icones/custom_prefix_icon.dart';
import '../../../shared/loading/loading_indicator.dart';
import '../../../shared/loading/custom_error_widget.dart';
import '../../../shared/spacer/spacer.dart';
import '../view_models/chat_view_model.dart';
import '../widgets/chat_card.dart';
import '../widgets/chat_empty_state.dart';

final userColocationsProvider = StreamProvider.family((ref, String userId) {
  final service = ColocationService();
  return service.watchUserColocations(userId: userId);
});

class ChatView extends ConsumerStatefulWidget {
  const ChatView({super.key});

  @override
  ConsumerState<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends ConsumerState<ChatView> {
  final TextEditingController _search = TextEditingController();

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final userId = currentUser?.uid ?? '';

    if (userId.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Messages')),
        body: Center(child: Text('Please log in to view messages')),
      );
    }

    final chatViewModel = ref.watch(chatViewModelProvider);

    // Trigger colocation chat room creation when colocations load
    ref.listen(userColocationsProvider(userId), (previous, next) {
      next.whenData((colocations) {
        chatViewModel.ensureUserColocationChatRooms(userId, colocations);
      });
    });

    final chatRoomsAsync = ref.watch(
      chatViewModel.userChatRoomsProvider(userId),
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("Messages", style: AppStyle.styleSemiBold18),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Input(
                  hintText: "Search ...",
                  controller: _search,
                  prefixIcon: CustomPrefixIcon(icon: LucideIcons.search500),
                ),
              ),
            ),
          ),
          chatRoomsAsync.when(
            loading: () => SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(40),
                child: LoadingIndicator(),
              ),
            ),
            error: (error, stack) => SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: CustomErrorWidget(
                  title: 'Failed to load chats',
                  message: error.toString(),
                  onRetry: () =>
                      ref.refresh(chatViewModel.userChatRoomsProvider(userId)),
                ),
              ),
            ),
            data: (chatRooms) {
              return chatRooms.isEmpty
                  ? SliverFillRemaining(
                      child: ChatEmptyState(
                        title: 'No chats yet',
                        subtitle: 'Start a conversation',
                      ),
                    )
                  : SliverPadding(
                      padding: Config.defaultPadding,
                      sliver: SliverList.separated(
                        itemCount: chatRooms.length,
                        itemBuilder: (context, index) {
                          final room = chatRooms[index];
                          return ChatCard(
                            chatRoom: room,
                            onTap: () {
                              GoRouter.of(
                                context,
                              ).push(Routes.chatRoom, extra: room);
                            },
                          );
                        },
                        separatorBuilder: (context, index) =>
                            VerticalSpacer(14),
                      ),
                    );
            },
          ),
        ],
      ),
    );
  }
}
