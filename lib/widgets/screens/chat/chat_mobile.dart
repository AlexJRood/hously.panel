// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/widgets/appbar/hously/mobile/appbar_mobile_back.dart';
import 'package:web_socket_channel/html.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void openChatPage(
    BuildContext context, String? roomId, WebSocketChannel? initialChannel) {
  showGeneralDialog(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) =>
        ChatMobile(roomId: roomId, initialChannel: initialChannel),
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

class ChatMobile extends ConsumerStatefulWidget {
  final String? roomId;
  final WebSocketChannel? initialChannel;

  const ChatMobile({super.key, this.roomId, this.initialChannel});

  @override
  ChatMobileState createState() => ChatMobileState();
}

class ChatMobileState extends ConsumerState<ChatMobile> {
  WebSocketChannel? channel;
  List<ConversationPartner> rooms = [];
  String? selectedRoomId;

  @override
  void initState() {
    super.initState();
    selectedRoomId = widget.roomId;
    channel = widget.initialChannel;
    fetchRooms().then((_) {
      if (rooms.isNotEmpty) {
        // Znajdź najnowszą konwersację
        final latestConversation = rooms.reduce((a, b) {
          final aTimestamp = a.lastMessage?['timestamp'];
          final bTimestamp = b.lastMessage?['timestamp'];
          if (aTimestamp == null && bTimestamp == null) return a;
          if (aTimestamp == null) return b;
          if (bTimestamp == null) return a;
          return aTimestamp.compareTo(bTimestamp) > 0 ? a : b;
        });
        // Otwórz najnowszą konwersację
        openRoom(latestConversation.id.toString());
      }
    });
  }

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
        Routes.chatMobile,
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

  Future<void> fetchRooms() async {
    final response = await ApiServices.get(
      ref: ref,
      URLs.rooms,
      hasToken: true,
    );
    if (response != null && response.statusCode == 200) {
      final List<dynamic> jsonRooms = json.decode(response.data);
      setState(() {
        rooms = jsonRooms
            .map((room) => ConversationPartner.fromJson(room))
            .toList();
      });
    } else {
      throw Exception('Failed to load rooms');
    }
  }

  void _closeCurrentChannel() {
    if (channel != null) {
      channel!.sink.close();
    }
  }

  void openRoom(String roomId) async {
    _closeCurrentChannel();
    final token = ApiServices.token;

    setState(() {
      selectedRoomId = roomId;
      channel = kIsWeb
          ? HtmlWebSocketChannel.connect(URLs.webSocketChat(roomId, token!))
          : IOWebSocketChannel.connect(URLs.webSocketChat(roomId, token!));
    });
    ref.read(navigationService).pushNamedScreen(Routes.chatScreenMobile);
  }

  @override
  Widget build(BuildContext context) {
    // Sortowanie listy konwersacji na podstawie znaczników czasu ostatnich wiadomości
    rooms.sort((a, b) {
      final aTimestamp = a.lastMessage?['timestamp'];
      final bTimestamp = b.lastMessage?['timestamp'];
      if (aTimestamp == null && bTimestamp == null) return 0;
      if (aTimestamp == null) return 1;
      if (bTimestamp == null) return -1;
      return bTimestamp.compareTo(aTimestamp);
    });

    return Stack(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Column(
            children: [
              const AppBarMobileWithBack(),
              Expanded(
                flex: 1,
                child: ListView.builder(
                  itemCount: rooms.length,
                  itemBuilder: (context, index) {
                    final ConversationPartner room = rooms[index];
                    final lastMessage = room.lastMessage;
                    final lastMessageContent =
                        lastMessage != null ? lastMessage['content'] : '';
                    final conversationPartner = room.conversationPartner;

                    return Padding(
                      padding: const EdgeInsets.only(left: 5.0, top: 10),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 50, // Zwiększony rozmiar avatara
                          backgroundImage: conversationPartner != null &&
                                  conversationPartner['avatar'] != null
                              ? NetworkImage(
                                  '${URLs.baseUrl}${conversationPartner['avatar']}',
                                )
                              : null,
                          child: conversationPartner == null ||
                                  conversationPartner['avatar'] == null
                              ? SvgPicture.asset(AppIcons.person)
                              : null,
                        ),
                        title: Text(
                          conversationPartner != null
                              ? '${conversationPartner['first_name']} ${conversationPartner['last_name']}'
                              : 'No conversation partner',
                          style:
                              AppTextStyles.interMedium.copyWith(fontSize: 18),
                        ),
                        subtitle: Text(lastMessageContent,
                            style: AppTextStyles.interLight
                                .copyWith(fontSize: 16)),
                        onTap: () => openRoom(room.id.toString()),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _closeCurrentChannel();
    super.dispose();
  }
}

class ConversationPartner {
  final int id;
  final String name;
  final List<dynamic> participants;
  final Map<String, dynamic>? lastMessage;
  final Map<String, dynamic>? conversationPartner;

  ConversationPartner({
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
