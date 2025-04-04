import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/modules/notification/widgets/notification_card.dart';
import 'package:hously_flutter/routing/navigation_service.dart';
import 'package:hously_flutter/utils/drad_scroll_widget.dart';
import 'package:hously_flutter/utils/loading_widgets.dart';
import 'package:hously_flutter/modules/notification/notification_service.dart';
import 'dart:ui' as ui;
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';
import 'package:hously_flutter/widgets/bars/sidebar.dart';

class NotificationPcScreen extends ConsumerWidget {
  NotificationPcScreen({super.key});
  
  final sideMenuKey = GlobalKey<SideMenuState>();


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationState = ref.watch(notificationProvider);
    final notifications = notificationState.notifications;
    final theme = ref.watch(themeColorsProvider);
    final _scrollController = ScrollController();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: theme.adPopBackground.withOpacity(0.15),
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          GestureDetector(onTap: () {
            ref.read(navigationService).beamPop();
          }),
          Row(
            children: [
              Sidebar(sideMenuKey: sideMenuKey,),
              Expanded(
                flex: 2,
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                    child: Container(
                      color: theme.adPopBackground.withOpacity(0.35),
                      width: double.infinity,
                      height: double.infinity,
                      child: notifications.isEmpty
                          ? ListView.builder(
                              padding: const EdgeInsets.all(25),
                              itemCount: 15,
                              itemBuilder: (context, index) =>
                                  const NotificationCardShimmer(),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.all(25),
                              itemCount: notifications.length,
                              itemBuilder: (context, index) {
                                final notification = notifications[index];
                                return InkWell(
                                    onTap: () {
                                      ref
                                          .read(notificationProvider.notifier)
                                          .makeNotificationSeen(
                                              notification.id);
                                    },
                                    child: NotificationCard(
                                        notification: notification));
                              },
                            ),
                    ),
                  ),
                ),
              ),
              Expanded(flex: 3, child: Container()),
            ],
          ),
        ],
      ),
    );
  }
}
