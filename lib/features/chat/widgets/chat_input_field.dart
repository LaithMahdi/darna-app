import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../view_models/chat_view_model.dart';
import '../../../core/constants/app_color.dart';
import '../../../shared/spacer/spacer.dart';

class ChatInputField extends ConsumerStatefulWidget {
  final String roomId;
  final AsyncValue<void> sendingState;
  final Function(String) onSend;
  final VoidCallback? onAttachmentTap;

  const ChatInputField({
    super.key,
    required this.roomId,
    required this.sendingState,
    required this.onSend,
    this.onAttachmentTap,
  });

  @override
  ConsumerState<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends ConsumerState<ChatInputField> {
  late TextEditingController _controller;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(ChatInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.sendingState.maybeWhen(
      data: (_) {
        if (mounted) {
          _controller.clear();
          setState(() {
            _isLoading = false;
          });
        }
      },
      orElse: () {},
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen to sending state changes
    ref.listen(sendingMessageStateProvider(widget.roomId), (previous, next) {
      next.maybeWhen(
        data: (_) {
          if (mounted && _isLoading) {
            setState(() {
              _isLoading = false;
            });
          }
        },
        error: (error, stack) {
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
          }
        },
        orElse: () {},
      );
    });

    final isLoading = widget.sendingState.maybeWhen(
      loading: () => true,
      orElse: () => _isLoading,
    );

    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border(top: BorderSide(color: AppColor.greyF0)),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: isLoading ? null : widget.onAttachmentTap,
            child: Icon(
              LucideIcons.plus,
              color: isLoading ? AppColor.grey9A : AppColor.primary,
              size: 24,
            ),
          ),
          HorizontalSpacer(12),
          Expanded(
            child: TextField(
              controller: _controller,
              maxLines: null,
              enabled: !isLoading,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: AppColor.greyF0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: AppColor.greyF0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: AppColor.primary),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),
          HorizontalSpacer(12),
          GestureDetector(
            onTap: isLoading || _controller.text.isEmpty
                ? null
                : () {
                    setState(() {
                      _isLoading = true;
                    });
                    widget.onSend(_controller.text);
                  },
            child: Container(
              decoration: BoxDecoration(
                color: isLoading || _controller.text.isEmpty
                    ? AppColor.grey9A
                    : AppColor.primary,
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
          ),
        ],
      ),
    );
  }
}
