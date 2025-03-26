import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/screens/notification/widgets/notification_card.dart';
import 'package:hously_flutter/state_managers/services/notification_service.dart';
import 'package:hously_flutter/widgets/appbar/hously/mobile/appbar_mobile_back.dart';
import 'package:hously_flutter/widgets/loading/loading_widgets.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'dart:ui' as ui;

class NotificationMobileScreen extends ConsumerWidget {
  const NotificationMobileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifications = ref.watch(notificationProvider).notifications;
    final theme = ref.watch(themeColorsProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Stack(
            children: [
              BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  color: theme.adPopBackground.withOpacity(0.5),
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              notifications.isEmpty
                  ? ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: 10 + 1, // Zwiększamy itemCount o 1
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return const SizedBox(height: 60); // Pusty kontener na górze
                      }
                      return const NotificationCardShimmer();
                    },
                  )

                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: notifications.length + 1, // Zwiększamy itemCount o 1
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return const SizedBox(height: 60); // Pusty kontener na górze
                        }
                        final notification = notifications[index - 1]; // Przesuwamy indeks
                        return InkWell(
                          onTap: () {
                            ref.read(notificationProvider.notifier)
                                .makeNotificationSeen(notification.id);
                          },
                          child: NotificationCard(notification: notification),
                        );
                      },
                    ),
            ],
          ),
          const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBarMobileWithBack(),
              ),
        ],
      ),
    );
  }
}
