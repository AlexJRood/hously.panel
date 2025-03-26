import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/screens/chat_ai/chat_ai_page.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/widgets/screens/ai/ai_mobile.dart';
import 'package:hously_flutter/widgets/screens/ai/ai_pc.dart';

class AiPage extends ConsumerWidget {
  const AiPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;

    Widget chatWidget;

    // Logika sprawdzająca, czy urządzenie jest webem, czy mobilem
    if (screenWidth > 800) {
      chatWidget = const AiPc();
    } else {
      chatWidget = const AiMobile(); // Załóżmy, że masz klasę ChatMobile
    }

    return Scaffold(
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
          const Align(
            alignment: Alignment.topLeft,
            child:
                ChatAiPage(), // Używamy wybranej klasy w zależności od platformy
          ),
        ],
      ),
    );
  }
}
