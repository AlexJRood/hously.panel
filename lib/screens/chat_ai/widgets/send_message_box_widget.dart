import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/screens/chat_ai/chat_ai_provider/chat_ai_provider.dart';

class SendMessageBox extends ConsumerWidget {
  const SendMessageBox({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController();
    final selectedRoomId = ref.watch(selectedAiRoomProvider);
    final aiMessages = ref.watch(chatAiMessageProvider);
    return Padding(
      padding: const EdgeInsets.only(right: 40, left: 40, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: const Color.fromRGBO(19, 22, 28, 1)),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              Image.asset('assets/images/button_attachment.png'),
              Expanded(
                child: TextField(
                  controller: controller,
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Write a message...',
                    hintStyle: const TextStyle(
                        color: Color.fromRGBO(145, 145, 145, 1)),
                    floatingLabelStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: Colors.transparent,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () async {
                    final message = controller.text;
                    controller.clear();
                    await ref
                        .read(chatAiMessageProvider.notifier)
                        .queryUserChatBot(message)
                        .whenComplete(
                      () {
                        ref
                            .read(chatAiMessageProvider.notifier)
                            .messageListInRoom(selectedRoomId);
                      },
                    );
                  },
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        color: Colors.white),
                    child: aiMessages.isLoading
                        ? const SizedBox(
                            height: 15,
                            width: 15,
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          )
                        : SvgPicture.asset(
                            AppIcons.arrowUp,
                            color: Colors.black,
                          ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
