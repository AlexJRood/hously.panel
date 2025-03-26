import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/const/icons.dart';
import '../../chat_ai/model/chat_ai_model.dart';
import '../chat_ai_provider/chat_ai_provider.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/data/design/design.dart';
// import 'package:hously_flutter/language/language_provider.dart';


class ChatAiSideBar extends ConsumerStatefulWidget {
  const ChatAiSideBar({
    super.key,
    this.isMobile = false,
    this.scaffoldKey,
  });

  final bool isMobile;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  ConsumerState<ChatAiSideBar> createState() => _ChatAiSideBarState();
}

class _ChatAiSideBarState extends ConsumerState<ChatAiSideBar> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(chatAiRoomsProvider.notifier).getRooms();
    });
  }

  @override
  Widget build(BuildContext context) {
    final rooms = ref.watch(chatAiRoomsProvider);
    final selectedRoom = ref.watch(selectedAiRoomProvider);

    double screenWidth = MediaQuery.of(context).size.width;
    double maxWidth = 1500;
    double minWidth = 1000;
    double maxDynamicContainerSize = 400;
    double minDynamicContainerSize = 300;
 
    double dynamicContainerSize = (screenWidth - minWidth) / (maxWidth - minWidth) * 
                                  (maxDynamicContainerSize - minDynamicContainerSize) + minDynamicContainerSize;
    dynamicContainerSize = dynamicContainerSize.clamp(minDynamicContainerSize, maxDynamicContainerSize);



    return Container(
      decoration: BoxDecoration(
        color: const Color.fromRGBO(34, 57, 62, 0.15),
        gradient: LinearGradient(
          colors: widget.isMobile
              ? [
                  const Color.fromRGBO(22, 25, 32, 0.8),
                  const Color.fromRGBO(34, 57, 62, 0.8),
                ]
              : [
                  const Color.fromRGBO(0, 0, 0, 0.2),
                  const Color.fromRGBO(0, 0, 0, 0.2),
                ],
        ),
      ),
      height: double.infinity,
      width: dynamicContainerSize,
      child: Column(
        children: [
          // Header Section
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: widget.isMobile
                    ? [
                        const Color.fromRGBO(22, 25, 32, 1),
                        const Color.fromRGBO(34, 57, 62, 1),
                      ]
                    : [
                        const Color.fromARGB(0, 22, 25, 32),
                        const Color.fromARGB(0, 34, 57, 62),
                      ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: const Color.fromARGB(21, 255, 255, 255),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            AppIcons.search,
                            height: 25,
                            width: 25,
                            color: const Color.fromRGBO(200, 200, 200, 1),
                          ),
                          Expanded(
                            child: TextField(
                              cursorColor: Colors.white,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'Search message',
                                hintStyle: const TextStyle(
                                  color: Color.fromRGBO(200, 200, 200, 1),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: BorderSide.none,
                                ),
                                filled: false,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Room List Section
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: widget.isMobile
                        ? 
                        [
                            const Color.fromRGBO(22, 25, 32, 1),
                            const Color.fromRGBO(34, 57, 62, 1),
                          ]
                        : [
                            const Color.fromARGB(0, 0, 0, 0),
                            const Color.fromARGB(0, 0, 0, 0),
                          ],
                  ),
                ),
                child: rooms.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : ListView(
                        children: groupRoomsByDate(rooms).entries.map((entry) {
                          final sectionTitle = entry.key;
                          final sectionRooms = entry.value;

                          // Skip the section if there are no rooms in it
                          if (sectionRooms.isEmpty) {
                            return const SizedBox
                                .shrink(); // Return an empty widget
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                child: Text(
                                  sectionTitle,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              ...sectionRooms.map((room) {
                                final isSelected =
                                    selectedRoom == room.id.toString();

                                return InkWell(
                                  onTap: () {
                                    if (widget.isMobile) {
                                      Navigator.of(context).pop();
                                    }
                                    ref.read(chatAiMessageProvider.notifier)
                                        .messageListInRoom(room.id.toString());
                                    ref.read(selectedAiRoomProvider.notifier)
                                        .state = room.id.toString();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? Colors.white.withOpacity(0.1)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        '${room.name}',
                                        style: const TextStyle(
                                          color:
                                              Color.fromRGBO(200, 200, 200, 1),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                        ),
                                      ),
                                      trailing: PopupMenuButton<String>(
                                        icon: SvgPicture.asset(
                                          AppIcons.moreVertical,
                                          color: Colors.white,
                                          height: 20,
                                          width: 20,
                                        ),
                                        onSelected: (value) {
                                          if (value == 'delete') {
                                            // Call the delete method with the room ID
                                            ref
                                                .read(chatAiRoomsProvider
                                                    .notifier)
                                                .removeRoom(room.id.toString())
                                                .whenComplete(
                                              () {
                                                ref
                                                    .read(chatAiRoomsProvider
                                                        .notifier)
                                                    .getRooms();
                                              },
                                            );
                                          }
                                        },
                                        color: Colors.black.withOpacity(0.6),
                                        itemBuilder: (BuildContext context) => [
                                          const PopupMenuItem<String>(
                                            value: 'delete',
                                            child: Text(
                                              'Delete',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                              
                            ],
                          );
                        }).toList(),
                      )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ElevatedButton(
                style: elevatedButtonStyleRounded10,
                onPressed: () {
                    ref.read(chatAiRoomsProvider.notifier)
                    .createRoom()
                    .whenComplete(
                  () {
                    ref.read(chatAiRoomsProvider.notifier).getRooms();
                  },
                );
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Text('Utwórz nowy chat', style: AppTextStyles.interSemiBold16), //add translation change to production                             
                      const Spacer(),
                      SvgPicture.asset(AppIcons.newChat, height: 25,width: 25, color: AppColors.light),
                    ],
                  ),
                ),
            ),
          ),
            //   Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
            //   child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             const Text(
            //               'Create new chat',
            //               style: TextStyle(
            //                 fontSize: 18,
            //                 color: Colors.white,
            //                 fontWeight: FontWeight.bold,
            //               ),
            //             ),
            //             IconButton(
            //               icon: const Icon(Icons.note_alt_outlined,
            //                   color: Colors.white, size: 24),
            //               onPressed: () {
            //                 ref.read(chatAiRoomsProvider.notifier)
            //                     .createRoom()
            //                     .whenComplete(
            //                   () {
            //                     ref.read(chatAiRoomsProvider.notifier).getRooms();
            //                   },
            //                 );
            //               },
            //             ),
            //           ],
            //         ),
            // ),
        
                  const SizedBox(height: 10),
        ],
      ),
    );
  }
}


