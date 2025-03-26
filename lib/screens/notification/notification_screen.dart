import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/screens/notification/notification_mobile_screen.dart';
import 'package:hously_flutter/screens/notification/notification_pc_screen.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/state_managers/services/notification_service.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(notificationProvider.notifier).getUserNotifications(ref);
    });
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    Widget chatWidget;

    // Logika sprawdzająca, czy urządzenie jest webem, czy mobilem
    if (screenWidth > 800) {
      chatWidget = const NotificationPcScreen();
    } else {
      chatWidget = const NotificationMobileScreen(); // Załóżmy, że masz klasę ChatMobile
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
          Align(
            alignment: Alignment.topLeft,
            child:
            chatWidget, // Używamy wybranej klasy w zależności od platformy
          ),
        ],
      ),
    );
  }
}
