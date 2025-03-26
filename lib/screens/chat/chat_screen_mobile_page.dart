import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/widgets/appbar/hously/mobile/appbar_mobile_back.dart';
import 'package:hously_flutter/widgets/installpopup/install_popup.dart';

import 'package:web_socket_channel/web_socket_channel.dart';

class ChatScreenMobilePage extends ConsumerStatefulWidget {
  final WebSocketChannel channel;
  final String username;
  final String roomId;

  const ChatScreenMobilePage({
    super.key,
    required this.channel,
    required this.username,
    required this.roomId,
  });

  @override
  // ignore: library_private_types_in_public_api
  ChatScreenMobilePageState createState() => ChatScreenMobilePageState();
}

class ChatScreenMobilePageState extends ConsumerState<ChatScreenMobilePage> {
  final _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];

  @override
  void initState() {
    super.initState();
    widget.channel.stream.listen((data) {
      final messageData = jsonDecode(utf8.decode(data.codeUnits));
      setState(() {
        _messages.insert(0, {
          'message': messageData['message'],
          'username': messageData['username'],
          'timestamp': messageData['timestamp'],
        });
      });
    });
    fetchOldMessages(ref);
  }

  Future<void> fetchOldMessages(dynamic ref) async {
    final response = await ApiServices.get(
      ref: ref,
      URLs.getRoomMessages(widget.roomId),
      hasToken: true,
    );

    if (response != null && response.statusCode == 200) {
      List<dynamic> messagesJson = json.decode(utf8.decode(response.data));
      List<Map<String, dynamic>> messages = messagesJson.map((message) {
        return {
          'message': message['content'] ?? '',
          'username': message['username'],
          'timestamp': message['timestamp'] ?? DateTime.now().toIso8601String(),
        };
      }).toList();

      setState(() {
        _messages.addAll(messages.reversed);
      });
    } else {
      throw Exception('Nie można załadować starych wiadomości...'.tr);
    }
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      final messageJson = jsonEncode({
        'message': _controller.text,
        'username': widget.username,
      });
      widget.channel.sink.add(utf8.encode(messageJson));
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupListener(
        child: SafeArea(
          child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withOpacity(0.85),
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              Column(
                children: [
                  const AppBarMobileWithBack(),
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final message = _messages[index];
                        final messageText = message['message'];
                        final usernameText = message['username'];
                        final isMe = usernameText == widget.username;

                        return Align(
                          alignment:
                              isMe ? Alignment.centerRight : Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                              color: isMe ? Colors.blue : Colors.grey[300],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              messageText,
                              style: TextStyle(
                                color: isMe ? Colors.white : Colors.black87,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextField(
                              controller: _controller,
                              style: AppTextStyles.interMedium
                                  .copyWith(color: AppColors.dark, fontSize: 16.0),
                              decoration: InputDecoration(
                                hintText: 'Wyślij wiadomość...'.tr,
                                hintStyle: AppTextStyles.interMedium
                                    .copyWith(color: AppColors.dark),
                              ),
                              maxLines: 5,
                              minLines: 1,
                              onSubmitted: (value) {
                                _sendMessage();
                              },
                            ),
                          ),
                        ),
                        IconButton(
                          icon:  SvgPicture.asset(AppIcons.send, color: AppColors.light),
                          onPressed: _sendMessage,
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
    );
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }
}
