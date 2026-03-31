import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../../core/config.dart';
import '../../../core/constants/app_style.dart';
import '../../../shared/forms/input.dart';
import '../../../shared/icones/custom_prefix_icon.dart';
import '../../../shared/spacer/spacer.dart';
import '../widgets/chat_card.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _search = TextEditingController();

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          SliverPadding(
            padding: Config.defaultPadding,
            sliver: SliverList.separated(
              itemCount: 15,
              itemBuilder: (context, index) => ChatCard(),
              separatorBuilder: (context, index) => VerticalSpacer(14),
            ),
          ),
        ],
      ),
    );
  }
}
