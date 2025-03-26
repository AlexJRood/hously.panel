import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/screens/chat/new_chat/provider/chat_room_provider.dart';
import 'package:hously_flutter/screens/chat/new_chat/widgets/chat_appbar_widget.dart';
import 'package:hously_flutter/screens/chat/new_chat/widgets/chat_messages_widget.dart';
import 'package:hously_flutter/screens/chat/new_chat/widgets/chat_sidebar_widget.dart';
import 'package:hously_flutter/screens/chat/new_chat/widgets/send_message_box_widget.dart';
import 'package:hously_flutter/widgets/sidebar/sidebar_chat.dart';
import 'dart:ui' as ui;
import 'package:hously_flutter/theme/apptheme.dart';

// WebSocket provider for managing the WebSocket connection

class ChatScreenPc extends ConsumerStatefulWidget {
  const ChatScreenPc({super.key});

  @override
  ConsumerState<ChatScreenPc> createState() => _ChatScreenPcState();
}

class _ChatScreenPcState extends ConsumerState<ChatScreenPc> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ref.read(fetchRoomsProvider.notifier).fetchRooms();
    });
  }

  @override
  Widget build(BuildContext context) {
    final rooms = ref.watch(fetchRoomsProvider);
    final isSelected = ref.watch(isChatSelected);
    final theme = ref.watch(themeColorsProvider);

    double screenWidth = MediaQuery.of(context).size.width;
    double maxWidth = 2500;
    double minWidth = 1500;
    double maxDynamicContainerSize = 800;
    double minDynamicContainerSize = 0;
    double dynamicContainerSize = (screenWidth - minWidth) /
            (maxWidth - minWidth) *
            (maxDynamicContainerSize - minDynamicContainerSize) +
        minDynamicContainerSize;
    dynamicContainerSize = dynamicContainerSize.clamp(
        minDynamicContainerSize, maxDynamicContainerSize);

    return Stack(
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
          Navigator.of(context).pop();
        }),
        Row(
          children: [
            const SidebarChat(),
            Expanded(
              child: ClipRRect(
                child: Stack(
                  children: [
                          BackdropFilter(
                            filter: ui.ImageFilter.blur(sigmaX: 35, sigmaY: 35),
                            child: Container(
                              color: theme.adPopBackground.withOpacity(0.35),
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                    Row(
                      children: [
                        ChatSideBar(
                          rooms: rooms,
                          dynamicContainerSize: dynamicContainerSize,
                          isMobile: false,
                        ),
                          if (isSelected)
                            Expanded(
                              child: Column(
                                children: [
                                  ChatAppBar(ref: ref),
                                  const Expanded(
                                    child: ChatMessagesWidget(),
                                  ),
                                  const SendMessageBox(),
                                ],
                              ),
                            ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: dynamicContainerSize),
          ],
        ),
      ],
    );
  }
}
