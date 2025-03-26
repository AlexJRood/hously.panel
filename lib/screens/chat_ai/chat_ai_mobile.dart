import 'package:flutter/material.dart';
import 'package:hously_flutter/screens/chat_ai/widgets/ai_appbar_widget.dart';
import 'package:hously_flutter/screens/chat_ai/widgets/ai_message_widget.dart';
import 'package:hously_flutter/screens/chat_ai/widgets/chat_ai_side_bar_widget.dart';
import 'package:hously_flutter/screens/chat_ai/widgets/send_message_box_widget.dart';
import '../../data/chat_ai/chat_ai_messages.dart';

class ChatAiMobile extends StatelessWidget {
  ChatAiMobile({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0.4),
        drawer: const Drawer(
          backgroundColor: Color.fromRGBO(0, 0, 0, 0.4),
          child: ChatAiSideBar(
            isMobile: true,
          ),
        ),
        body: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  AiAppBar(
                    isMobile: true,
                    scaffoldKey: _scaffoldKey,
                  ),
                  const Expanded(
                    child: Stack(
                      children: [
                        MessageListView(isMobile: true),
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
      ),
    );
  }
}
