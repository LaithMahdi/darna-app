import 'package:flutter/material.dart';
import '../../../shared/buttons/custom_back_button.dart';
import '../widgets/chat_room_appbar.dart';

class ChatRoomView extends StatelessWidget {
  const ChatRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(leading: CustomBackButton(), title: ChatRoomAppbar()),
        ],
      ),
    );
  }
}
