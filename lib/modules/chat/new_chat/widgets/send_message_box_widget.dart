import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hously_flutter/theme/icons.dart';
import 'package:hously_flutter/theme/design/button_style.dart';
import 'package:hously_flutter/theme/design/design.dart';
import '../chat_screen_pc.dart';
import '../provider/chat_message_provider.dart';
import '../provider/chat_room_provider.dart';
import 'dart:ui' as ui;
import 'package:hously_flutter/theme/apptheme.dart';

class SendMessageBox extends ConsumerStatefulWidget {
  const SendMessageBox({super.key});

  @override
  ConsumerState<SendMessageBox> createState() => _SendMessageBoxState();
}

class _SendMessageBoxState extends ConsumerState<SendMessageBox> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode(); // ✅ Keeps TextField focused

  void sendMessage() {
    final message = _controller.text.trim();
    if (message.isEmpty) return;
    _controller.clear();
    ref.read(chatMessageRoomProvider.notifier).sendMessage(
      message,
      ref.watch(selectedChatId),
    );

    _focusNode.requestFocus(); // ✅ Keep focus on TextField
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeColorsProvider);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 30, right: 30),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          width: double.infinity,
          color: theme.fillColor.withOpacity(0.25),
          child: Stack(
            children: [
              BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                child: Container(
                  color: theme.fillColor.withOpacity(0.15),
                  width: double.infinity,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    style: elevatedButtonStyleRounded10,
                    icon:  SvgPicture.asset(AppIcons.circlePlus,
                        height: 25,width: 25, color: AppColors.light),
                    onPressed: () {
                      ref
                          .read(chatMessageRoomProvider.notifier)
                          .pickFileAndSendMessage(ref);
                    },
                  ),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      focusNode: _focusNode, // ✅ Keeps focus after sending
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Write a message...',
                        hintStyle: AppTextStyles.interMedium,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide.none),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide.none),
                        filled: true,
                        fillColor: Colors.transparent,
                      ),
                      maxLines: 3,
                      minLines: 1,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => sendMessage(), // ✅ Sends on Enter
                    ),
                  ),

                  IconButton(
                    style: elevatedButtonStyleRounded10,
                    onPressed: sendMessage, // ✅ Keeps focus after clicking send
                    icon: Image.asset(
                      'assets/images/send.png',
                      height: 35,
                      width: 35,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
