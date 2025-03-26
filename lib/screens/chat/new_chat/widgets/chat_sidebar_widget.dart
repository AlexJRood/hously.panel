import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/data/design/design.dart';
import '../../../../utils/api_services.dart';
import '../provider/chat_message_provider.dart';
import '../provider/chat_room_provider.dart';
import 'package:hously_flutter/const/url.dart';
import '../provider/web_socket_provider.dart';

import 'package:hously_flutter/data/design/button_style.dart';
import 'dart:ui' as ui;
import 'package:hously_flutter/theme/apptheme.dart';

class ChatSideBar extends ConsumerWidget {
  ChatSideBar(
      {super.key,
      required this.rooms,
      this.dynamicContainerSize,
      required this.isMobile});
  final List<Room> rooms;
  final dynamicContainerSize;
  bool isMobile;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSelected = ref.watch(isChatSelected);
    final theme = ref.watch(themeColorsProvider);


    double screenWidth = MediaQuery.of(context).size.width;
    double maxWidth = 2000;
    double minWidth = 1500;
    double maxDynamicContainerSize = 500;
    double minDynamicContainerSize = 350;
    double dynamicContactListSize = (screenWidth - minWidth) /
            (maxWidth - minWidth) *
            (maxDynamicContainerSize - minDynamicContainerSize) +
        minDynamicContainerSize;
    dynamicContactListSize = dynamicContactListSize.clamp(
        minDynamicContainerSize, maxDynamicContainerSize);
    final nonSelectedContactListSize = screenWidth - dynamicContainerSize - 60;

    return Container(
      decoration: const BoxDecoration(
        color: Color.fromRGBO(34, 57, 62, 0.15),
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(0, 0, 0, 0.2),
            Color.fromRGBO(0, 0, 0, 0.2),
          ],
        ),
      ),
      height: double.infinity,
      width: isSelected
          ? dynamicContactListSize
          : (isMobile ? screenWidth : nonSelectedContactListSize),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 8),
        child: Column(
          children: [
            Row(
              children: [
                 if (isMobile)
                    SizedBox(
                      height: 50, width:50,
                      child: IconButton(
                        style: elevatedButtonStyleRounded10,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back_ios_new_rounded, 
                                        color: AppColors.light
                                        ),
                      ),
                    ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Stack(
                        children: [
                          BackdropFilter(
                            filter: ui.ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                            child: Container(
                              color: theme.fillColor.withOpacity(0.25),
                              width: double.infinity,
                              height: 50,
                            ),
                          ),
                            Padding( // change to production should be formfiled
                              padding:
                                  const EdgeInsets.only(right: 10.0, left: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                    const Icon(
                                      Icons.search,
                                      color: Color.fromRGBO(255, 255, 255, 1),
                                      size: 25,
                                    ),                                 
                                  Expanded(
                                    child: TextField(
                                      textAlign: TextAlign.start,
                                      showCursor: true,
                                      cursorColor: AppColors.light,
                                      style: const TextStyle( 
                                      color: AppColors.light),
                                      decoration: InputDecoration(
                                        floatingLabelStyle: TextStyle(
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            borderSide: BorderSide.none),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            borderSide: BorderSide.none),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            borderSide: BorderSide.none),
                                        filled: false,
                                        fillColor: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: rooms.length,
                itemBuilder: (context, index) {
                  final data = rooms[index];
                  final personalRoom = data.otherUser;
                  print('younis user avatar ${personalRoom?.avatar}');

                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      style: elevatedButtonStyleRounded10,
                      onPressed: () {
                        final webSocketNotifier =
                            ref.read(webSocketProvider.notifier);
                        final newChatId = data.id;
                        final chatWebSocketUrl = URLs.webSocketChat(
                            newChatId, ApiServices.token.toString());
                        webSocketNotifier.disconnect();
                        ref.read(isChatSelected.notifier).state = false;
                        ref.read(selectedChatId.notifier).state = newChatId;
                        ref.read(otherUserData.notifier).state =
                            data.otherUser!;

                        ref
                            .read(chatMessageRoomProvider.notifier)
                            .fetchRoomMessages(newChatId, ref)
                            .whenComplete(() {
                          ref.read(isChatSelected.notifier).state = true;
                          webSocketNotifier.connect(chatWebSocketUrl);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          height: 60,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                ),
                                child: ClipOval(
                                  child: (personalRoom != null &&
                                          personalRoom.avatar != null &&
                                          personalRoom.avatar!.isNotEmpty)
                                      ? Image.network(
                                          'https://www.hously.cloud/${personalRoom.avatar!}',
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return const Icon(
                                              Icons.person,
                                              color: Colors.white,
                                              size: 35,
                                            );
                                          },
                                        )
                                      : const Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: 35,
                                        ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  if (personalRoom != null)
                                    Text(
                                        overflow: TextOverflow.fade,
                                        '${personalRoom.firstName!} ${personalRoom.lastName!}',
                                        style: AppTextStyles.interLight18),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
