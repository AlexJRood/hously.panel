import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/screens/chat_ai/chat_ai_provider/chat_ai_provider.dart';
import 'action_icons_widget.dart';
import 'avatar_widget.dart';

class MessageEditingNotifier extends StateNotifier<bool> {
  MessageEditingNotifier() : super(false);

  void startEditing() => state = true;
  void stopEditing() => state = false;
}

final messageEditingProvider =
    StateNotifierProvider.family<MessageEditingNotifier, bool, String>(
        (ref, messageId) {
  return MessageEditingNotifier();
});

class MessageBubble extends ConsumerWidget {
  final String content;
  final DateTime timestamp;
  final bool isUser;
  final String messageId;
  final bool isMobile;

  const MessageBubble(
      {super.key,
      required this.content,
      required this.timestamp,
      required this.isUser,
      required this.messageId,
      this.isMobile = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditing = ref.watch(messageEditingProvider(messageId));
    final roomId = ref.watch(selectedAiRoomProvider);
    final controller = TextEditingController(text: content);

    return Row(
      mainAxisAlignment:
          isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isUser) ...[
          const SizedBox(width: 8),
          const Avatar(),
        ],
        if (isUser && !isEditing) ...[
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white, size: 20),
            onPressed: () => ref
                .read(messageEditingProvider(messageId).notifier)
                .startEditing(),
          ),
          const SizedBox(width: 8),
        ],
        Container(
          width: isMobile
              ? MediaQuery.of(context).size.width / 2
              : MediaQuery.of(context).size.width / 3,
          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: isUser
                ? const Color.fromRGBO(255, 255, 255, 0.1)
                : Colors.grey[800],
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: isEditing
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: controller,
                      style: const TextStyle(color: Colors.white),
                      maxLines: null,
                      decoration: InputDecoration(
                        hintText: "Edit your message...",
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            ref
                                .read(
                                    messageEditingProvider(messageId).notifier)
                                .stopEditing();
                            controller.text = content; // Reset changes
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            ref
                                .read(
                                    messageEditingProvider(messageId).notifier)
                                .stopEditing();
                            await ref
                                .read(chatAiMessageProvider.notifier)
                                .editMessage(roomId, messageId, controller.text)
                                .whenComplete(
                                  () => ref
                                      .read(chatAiMessageProvider.notifier)
                                      .messageListInRoom(roomId),
                                );
                          },
                          child: const Text(
                            'Save',
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : Text(
                  controller.text,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
        ),
        if (!isUser) const ActionIcons(),
      ],
    );
  }
}
