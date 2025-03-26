import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final WebSocketChannel channel;
  final String username;
  final String roomId;
  final String partnerAvatar;
  final String partnerName;

  const ChatScreen({
    super.key,
    required this.channel,
    required this.username,
    required this.roomId,
    required this.partnerAvatar,
    required this.partnerName,
  });

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends ConsumerState<ChatScreen> {
  final _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  bool _isUserDataLoaded = false;

  @override
  void initState() {
    super.initState();
    fetchUserData().then((_) {
      setState(() {
        _isUserDataLoaded = true;
      });
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
    });
    fetchOldMessages(ref);
  }

  Future<void> fetchUserData() async {
    // Simulate fetching user data if necessary
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> fetchOldMessages(WidgetRef ref) async {
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
      setState(() {
        _messages.insert(0, {
          'message': _controller.text,
          'username': widget.username,
          'timestamp': DateTime.now().toIso8601String(),
        });
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Column(
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  gradient: BackgroundGradients.sideMenuBackground,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.partnerName,
                        style: AppTextStyles.interMedium.copyWith(fontSize: 18),
                      ),
                      const SizedBox(width: 20),
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: widget.partnerAvatar.isNotEmpty
                            ? NetworkImage(widget.partnerAvatar)
                            : null,
                        child: widget.partnerAvatar.isEmpty
                            ? SvgPicture.asset(AppIcons.person)
                            : null,
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: _isUserDataLoaded
                    ? ListView.builder(
                        reverse: true,
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          final message = _messages[index];
                          final messageText = message['message'];
                          final usernameText = message['username'];
                          final isMe = usernameText == widget.username;

                          return Align(
                            alignment: isMe
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
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
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
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
                          maxLines: 9,
                          minLines: 1,
                          onSubmitted: (value) {
                            _sendMessage();
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Transform.rotate(
                        angle: -30 * 3.141592653589793238 / 180,
                        child: IconButton(
                          icon: SvgPicture.asset(AppIcons.send, color: AppColors.light),
                          onPressed: _sendMessage,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }
}
