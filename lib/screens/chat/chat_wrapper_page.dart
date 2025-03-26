import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/widgets/screens/chat/chat_mobile.dart'; // Upewnij się, że masz tę stronę
import 'package:hously_flutter/widgets/screens/chat/chat_pc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatWrapperPage extends ConsumerWidget {
  final String? roomId;
  final WebSocketChannel? initialChannel;

  const ChatWrapperPage({super.key, this.roomId, this.initialChannel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;

    Widget chatWidget;

    // Logika sprawdzająca, czy urządzenie jest webem, czy mobilem
    if (screenWidth > 800) {
      chatWidget = ChatPc(roomId: roomId, initialChannel: initialChannel);
    } else {
      chatWidget = ChatMobile(
          roomId: roomId,
          initialChannel: initialChannel); // Załóżmy, że masz klasę ChatMobile
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.7),
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            GestureDetector(
              onTap: () => ref.read(navigationService).beamPop(),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors
                    .transparent, // Kontener reagujący na dotknięcia z przezroczystym tłem
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child:
                  chatWidget, // Używamy wybranej klasy w zależności od platformy
            ),
          ],
        ),
      ),
    );
  }
}
