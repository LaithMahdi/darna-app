import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../view_models/chat_view_model.dart';
import '../../../core/constants/app_color.dart';
import '../../../shared/forms/input.dart';
import '../../../shared/spacer/spacer.dart';

class ChatInputField extends ConsumerStatefulWidget {
  final String roomId;
  final AsyncValue<void> sendingState;
  final Function(String) onSend;

  const ChatInputField({
    super.key,
    required this.roomId,
    required this.sendingState,
    required this.onSend,
  });

  @override
  ConsumerState<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends ConsumerState<ChatInputField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(sendingMessageStateProvider(widget.roomId), (previous, next) {
      final wasLoading = previous?.isLoading ?? false;
      next.maybeWhen(
        data: (_) {
          if (wasLoading) {
            _controller.clear();
          }
        },
        orElse: () {},
      );
    });

    final isLoading = widget.sendingState.isLoading;

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border(top: BorderSide(color: AppColor.greyF0)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Input(
              hintText: 'Type a message...',
              controller: _controller,
              maxLines: null,
              readOnly: isLoading,
            ),
          ),
          HorizontalSpacer(12),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _controller,
            builder: (context, value, child) {
              final message = value.text.trim();
              final canSend = !isLoading && message.isNotEmpty;

              return GestureDetector(
                onTap: canSend ? () => widget.onSend(message) : null,
                child: Container(
                  decoration: BoxDecoration(
                    color: canSend ? AppColor.primary : AppColor.grey9A,
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(8),
                  child: isLoading
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColor.white,
                            ),
                          ),
                        )
                      : Icon(LucideIcons.send, color: AppColor.white, size: 20),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
