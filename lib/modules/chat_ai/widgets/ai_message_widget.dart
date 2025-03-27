import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/modules/chat_ai/chat_ai_provider/chat_ai_provider.dart';
import 'message_bubble_widget.dart';

class MessageListView extends ConsumerWidget {
  final bool isMobile;
  const MessageListView({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aiMessages = ref.watch(chatAiMessageProvider);
    if (aiMessages.messages.isEmpty) {
      return const Center(
        child: Text(
          'There are no messages',
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
      );
    }
    return ListView.builder(
      reverse: true,
      shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: 90),
      itemCount: aiMessages.messages.length,
      itemBuilder: (context, index) {
        final message = aiMessages.messages[index];

        return Column(
          children: [
            MessageBubble(
              content: message.userMessage,
              timestamp: message.createdAt,
              isUser: true,
              messageId: message.id.toString(),
              isMobile: isMobile,
            ),
            if (message.aiResponse != null)
              MessageBubble(
                content: message.aiResponse!,
                timestamp: message.createdAt,
                isUser: false,
                messageId: '',
                isMobile: isMobile,
              ),
          ],
        );
      },
    );
  }
}
