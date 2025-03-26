// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/screens/chat/new_chat/chat_screen_pc.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/widgets/sidebar/sidebar_chat.dart';
import 'package:web_socket_channel/html.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


void openChatPage(
    BuildContext context, String? roomId, WebSocketChannel? initialChannel) {
  showGeneralDialog(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) =>
        ChatPc(roomId: roomId, initialChannel: initialChannel),
    barrierDismissible: true,
    barrierLabel: 'Dismiss',
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 300),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

class ChatPc extends ConsumerStatefulWidget {
  final String? roomId;
  final WebSocketChannel? initialChannel;

  const ChatPc({super.key, this.roomId, this.initialChannel});

  @override
  ChatPcState createState() => ChatPcState();
}

class ChatPcState extends ConsumerState<ChatPc> {
  void createRoom(int sellerId, int userId, BuildContext context) async {
    final token = ApiServices.token;
    final requestData = {
      'seller_id': sellerId,
      'buyer_id': userId,
    };
    final response = await ApiServices.post(
      URLs.roomsCreate,
      headers: {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
      },
      data: requestData,
    );

    if (response != null &&
        (response.statusCode == 201 || response.statusCode == 200)) {
      final roomData = jsonDecode(response.data);
      final roomId = roomData['name'];

      ref.read(navigationService).pushNamedScreen(
        Routes.chatWrapper,
        data: {
          'initialChannel': kIsWeb
              ? HtmlWebSocketChannel.connect(
                  URLs.webSocketChat(roomId, token!),
                )
              : IOWebSocketChannel.connect(
                  URLs.webSocketChat(roomId, token!),
                ),
          'roomId': roomId,
        },
      );
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        Row(
          children: [
            SidebarChat(),
            Expanded(child: ChatScreenPc()),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class ConversationPartner {
  final int id;
  final String name;
  final List<dynamic> participants;
  final Map<String, dynamic>? lastMessage;
  final Map<String, dynamic>? conversationPartner;

  const ConversationPartner({
    required this.id,
    required this.name,
    required this.participants,
    this.lastMessage,
    this.conversationPartner,
  });

  factory ConversationPartner.fromJson(Map<String, dynamic> json) {
    return ConversationPartner(
      id: json['id'],
      name: json['name'],
      participants: json['participants'],
      lastMessage: json['last_message'],
      conversationPartner: json['conversation_partner'],
    );
  }
}
