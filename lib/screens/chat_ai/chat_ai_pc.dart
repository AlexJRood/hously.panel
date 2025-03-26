import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/screens/chat_ai/widgets/ai_appbar_widget.dart';
import 'package:hously_flutter/screens/chat_ai/widgets/ai_message_widget.dart';
import 'package:hously_flutter/screens/chat_ai/widgets/chat_ai_side_bar_widget.dart';
import 'package:hously_flutter/screens/chat_ai/widgets/send_message_box_widget.dart';
import 'package:hously_flutter/widgets/sidebar/sidebar_chat.dart';
import 'dart:ui' as ui;
import 'package:hously_flutter/theme/apptheme.dart';

class ChatAiPc extends ConsumerWidget {
  const ChatAiPc({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeColorsProvider);

    double screenWidth = MediaQuery.of(context).size.width;
    double maxWidth = 1500;
    double minWidth = 1000;
    double maxDynamicContainerSize = 400;
    double minDynamicContainerSize = 0;
    double dynamicContainerSize = (screenWidth - minWidth) /
            (maxWidth - minWidth) *
            (maxDynamicContainerSize - minDynamicContainerSize) +
        minDynamicContainerSize;
    dynamicContainerSize = dynamicContainerSize.clamp(
        minDynamicContainerSize, maxDynamicContainerSize);

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
            Navigator.of(context).pop();
          }),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
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
                          const Row(
                              children: [
                                SidebarChat(),
                                ChatAiSideBar(),
                                Expanded(
                                  child: Column(
                                    children: [
                                      AiAppBar(),
                                      Expanded(
                                        child: Stack(
                                          children: [
                                            MessageListView(),
                                            Positioned(
                                              bottom: 0,
                                              left: 0,
                                              right: 0,
                                              child: SendMessageBox(),
                                            ),
                                          ],
                                        ),
                                      ),
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
              )
            ],
          ),
        ],
      ),
    );
  }
}
