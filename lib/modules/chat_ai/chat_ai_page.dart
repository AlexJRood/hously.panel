import 'package:flutter/material.dart';
import 'package:hously_flutter/modules/chat_ai/chat_ai_mobile.dart';
import 'package:hously_flutter/modules/chat_ai/chat_ai_pc.dart';

class ChatAiPage extends StatelessWidget {
  const ChatAiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > 1080) {
          return const ChatAiPc();
        } else {
          return  ChatAiMobile();
        }
      },
    );
  }
}
