import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../api_services/url.dart';
import '../../../../api_services/auth.dart';
import '../../../../api_services/api_services.dart';
import '../provider/chat_message_provider.dart';
import '../provider/chat_room_provider.dart';
import '../provider/web_socket_provider.dart';
import 'dart:convert';

class ChatMessagesWidget extends ConsumerStatefulWidget {
  final bool isMobile;

  const ChatMessagesWidget({
    super.key,
    this.isMobile = false,
  });

  @override
  ConsumerState<ChatMessagesWidget> createState() => _ChatMessagesWidgetState();
}

class _ChatMessagesWidgetState extends ConsumerState<ChatMessagesWidget> {
  late final WebSocketNotifier _webSocketNotifier;
  StreamSubscription<dynamic>? _webSocketSubscription;
  String? _currentChatId;

  @override
  void initState() {
    super.initState();
    _webSocketNotifier = ref.read(webSocketProvider.notifier);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeWebSocket();
    });
  }

  void _initializeWebSocket() {
    _currentChatId = ref.read(selectedChatId);
    final url =
        URLs.webSocketChat(_currentChatId!, ApiServices.token.toString());
    _webSocketNotifier.connect(url);

    final webSocketStream = ref.read(webSocketProvider);
    if (webSocketStream != null) {
      _webSocketSubscription = webSocketStream.listen(
        (event) {
          if (!mounted) return;
          final data = jsonDecode(event);
          if (data != null &&
              data['content'] != null &&
              data['timestamp'] != null) {
            ref
                .read(chatMessageRoomProvider.notifier)
                .addMessageFromWebSocket(data);
          }
        },
        onDone: () => print('WebSocket connection closed.'),
        onError: (error) => print('WebSocket error: $error'),
      );
    }
  }

  @override
  void didUpdateWidget(covariant ChatMessagesWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newChatId = ref.read(selectedChatId);
    if (newChatId != _currentChatId) {
      _webSocketSubscription?.cancel();
      _initializeWebSocket();
    }
  }

  @override
  void dispose() {
    Future.microtask(() {
    _webSocketSubscription?.cancel();
    _webSocketNotifier.disconnect();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(chatMessageRoomProvider);

    return ListView.builder(
      reverse: true,
      shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: 20),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[messages.length - 1 - index];
        return MessageBubble(
          chatMessage: message,
          content: message.content,
          timestamp: DateTime.parse(message.timestamp),
          isMobile: widget.isMobile,
        );
      },
    );
  }
}

class MessageBubble extends ConsumerWidget {
  final String content;
  final DateTime timestamp;
  final ChatMessage chatMessage;
  final bool isMobile;


  const MessageBubble({
    super.key,
    required this.content,
    required this.timestamp,
    required this.chatMessage,
    this.isMobile = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(userProvider);

    return userAsyncValue.when(
      data: (user) {
        final userFuture =
            ref.watch(userProviderFamily(int.parse(user!.userId)));
        return userFuture.when(
          data: (fetchedUser) {
            final isMe = fetchedUser?.username == chatMessage.user.username;
            final hasFiles = chatMessage.chatFiles.isNotEmpty;

            return Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Stack(
                  children: [
                    Container(
                      constraints: BoxConstraints(
                          maxWidth: isMobile?MediaQuery.of(context).size.width / 1.5:MediaQuery.of(context).size.width / 3,
                          minWidth: 100),
                      margin: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 8.0),
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(255, 255, 255, 0.1),
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              content,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 8),
                            if (hasFiles)
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: chatMessage.chatFiles.length,
                                itemBuilder: (context, index) {
                                  final file = chatMessage.chatFiles[index];
                                  if (file.extension == '.png' ||
                                      file.extension == '.jpg' ||
                                      file.extension == '.jpeg') {
                                    return Center(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          file.file,
                                          height: 300,
                                          fit: BoxFit.fill,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return const Icon(
                                              Icons.broken_image,
                                              color: Colors.white,
                                              size: 50,
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  }
                                  return const SizedBox();
                                },
                              ),
                            const SizedBox(height: 15),
                            // Message timestamp
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 25,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')} ${timestamp.hour >= 12 ? 'PM' : 'AM'}",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
          loading: () => const SizedBox(),
          error: (error, stackTrace) => const Center(
            child: Text(
              'Error fetching user details',
              style: TextStyle(color: Colors.red),
            ),
          ),
        );
      },
      loading: () => const SizedBox(),
      error: (error, stackTrace) => const Center(
        child: Text(
          'Error fetching user',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
