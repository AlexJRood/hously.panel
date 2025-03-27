import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/routing/navigation_service.dart';

import 'chat_screen_mobile.dart';
import 'chat_screen_pc.dart';

class ChatPage extends ConsumerWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;

    Widget chatWidget;

    // Logika sprawdzająca, czy urządzenie jest webem, czy mobilem
    if (screenWidth > 800) {
      chatWidget = const ChatScreenPc();
    } else {
      chatWidget = const ChatScreenMobile(); // Załóżmy, że masz klasę ChatMobile
    }

    return SafeArea(child: Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0.35),
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
    ));
  }
}
