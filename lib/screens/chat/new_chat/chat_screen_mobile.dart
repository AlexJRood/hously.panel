import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/screens/chat/new_chat/provider/chat_room_provider.dart';
import 'package:hously_flutter/screens/chat/new_chat/widgets/chat_appbar_widget.dart';
import 'package:hously_flutter/screens/chat/new_chat/widgets/chat_messages_widget.dart';
import 'package:hously_flutter/screens/chat/new_chat/widgets/chat_sidebar_widget.dart';
import 'package:hously_flutter/screens/chat/new_chat/widgets/send_message_box_widget.dart';

class ChatScreenMobile extends ConsumerStatefulWidget {
  const ChatScreenMobile({super.key});

  @override
  ConsumerState<ChatScreenMobile> createState() => _ChatScreenMobileState();
}

class _ChatScreenMobileState extends ConsumerState<ChatScreenMobile> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Fetch chat rooms when the screen initializes
      ref.read(fetchRoomsProvider.notifier).fetchRooms();
    });
  }


  @override
  Widget build(BuildContext context) {
    final rooms = ref.watch(fetchRoomsProvider);
    final isSelected = ref.watch(isChatSelected);

    return Container(
      color: const Color.fromRGBO(0, 0, 0, 0.7),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                if (!isSelected)
                ChatSideBar(rooms: rooms, dynamicContainerSize: 0, isMobile: true),
                if (isSelected)
                  Expanded(
                    child: Column(
                      children: [
                        ChatAppBar(ref: ref,isMobile: true,),
                        const Expanded(
                          child: Stack(
                            children: [
                              ChatMessagesWidget(
                                isMobile: true,
                              ),
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
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
