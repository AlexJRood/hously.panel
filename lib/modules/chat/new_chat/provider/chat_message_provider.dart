import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../api_services/url.dart';
import '../../../../api_services/api_services.dart';
import 'chat_room_provider.dart';

class ChatMessage {
  final String id;
  final String room;
  final ChatUser user;
  final List<ChatFile> chatFiles;
  final String content;
  final String? seenAt;
  final String timestamp;
  final String? lastUpdated;
  final bool isMe;

 const ChatMessage({
    required this.id,
    required this.room,
    required this.user,
    required this.chatFiles,
    required this.content,
    this.seenAt,
    required this.timestamp,
    this.lastUpdated,
    this.isMe = false,
  });

  /// Factory constructor to create a ChatMessage from JSON
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'],
      room: json['room'],
      user: ChatUser.fromJson(json['user']),
      chatFiles: (json['chat_files'] as List<dynamic>)
          .map((file) => ChatFile.fromJson(file))
          .toList(),
      content: json['content'],
      seenAt: json['seen_at'],
      timestamp: json['timestamp'],
      lastUpdated: json['last_updated'],
      isMe: json['is_me'] ?? false,
    );
  }

  /// Convert ChatMessage to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'room': room,
      'user': user.toJson(),
      'chat_files': chatFiles.map((file) => file.toJson()).toList(),
      'content': content,
      'seen_at': seenAt,
      'timestamp': timestamp,
      'last_updated': lastUpdated,
      'is_me': isMe,
    };
  }
}

class ChatUser {
  final String username;
  final String email;
  final String firstName;
  final String lastName;

  const ChatUser({
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  /// Factory constructor to create a ChatUser from JSON
  factory ChatUser.fromJson(Map<String, dynamic> json) {
    return ChatUser(
      username: json['username'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }

  /// Convert ChatUser to JSON
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
    };
  }
}

class ChatFile {
  final String id;
  final String name;
  final String extension;
  final String file;
  final String createdAt;
  final String updatedAt;

  const ChatFile({
    required this.id,
    required this.name,
    required this.extension,
    required this.file,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Factory constructor to create a ChatFile from JSON
  factory ChatFile.fromJson(Map<String, dynamic> json) {
    return ChatFile(
      id: json['id'],
      name: json['name'],
      extension: json['extension'],
      file: json['file'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  /// Convert ChatFile to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'extension': extension,
      'file': file,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class ChatMessagesResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<ChatMessage> results;

  const ChatMessagesResponse({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory ChatMessagesResponse.fromJson(Map<String, dynamic> json) {
    return ChatMessagesResponse(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: (json['results'] as List<dynamic>)
          .map((message) => ChatMessage.fromJson(message))
          .toList(),
    );
  }
}

class ChatMessageNotifier extends StateNotifier<List<ChatMessage>> {
  ChatMessageNotifier() : super([]);

  Future<void> fetchRoomMessages(String roomId, dynamic ref) async {
    try {
      final response = await ApiServices.get(
        ref: ref,
        URLs.getRoomMessages(roomId),
        hasToken: true,
      );

      if (response != null && response.statusCode == 200) {
        final jsonResponse = jsonDecode(utf8.decode(response.data));
        final chatMessagesResponse =
        ChatMessagesResponse.fromJson(jsonResponse);
        state = chatMessagesResponse.results;
      } else {
        print('Messages fetching failed');
      }
    } catch (e) {
      print('Error fetching room messages: $e');
    }
  }

  void addMessageFromWebSocket(Map<String, dynamic> messageJson) {
    try {
      final newMessage = ChatMessage.fromJson(messageJson);
      state = [...state, newMessage];
    } catch (e) {
      print('Error adding message from WebSocket: $e');
    }
  }
  Future<void> sendMessage(String content,String roomId)async{
    try{
      final data = {
        "content": content
      };
      final response = await ApiServices.post(URLs.sendRoomMessages(roomId),
          hasToken: true,
          data: data);
      if(response != null && response.statusCode == 201){
        print('Message sent successfully');
      }else{
        print('Message sent failed');

      }

    }catch(e){
      print(e);
    }
  }

  //
  Future<void> pickFileAndSendMessage(WidgetRef ref) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        final Uint8List? fileBytes = result.files.single.bytes;
        final String fileName = result.files.single.name;

        if (fileBytes != null) {
          print('File selected: $fileName');
          await sendFileMessage(fileBytes, fileName, ref.watch(selectedChatId));
        } else {
          print('File content is empty or invalid.');
        }
      } else {
        print('No file selected.');
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }


  Future<void> sendFileMessage(Uint8List fileBytes, String fileName, String roomId) async {
    try {
      final formData = FormData.fromMap({
        "files": MultipartFile.fromBytes(fileBytes, filename: fileName), // Attach file
        "content": 'Image',
      });

      // Send API request
      final response = await ApiServices.post(
        URLs.sendRoomMessages(roomId),
        hasToken: true,
        formData: formData,
      );

      if (response != null && response.statusCode == 201) {
        print('Message sent successfully.');
      } else {
        print('Message sending failed: ${response?.statusCode}');
      }
    } catch (e) {
      print('Error sending file: $e');
    }
  }
}

final chatMessageRoomProvider =
StateNotifierProvider<ChatMessageNotifier, List<ChatMessage>>(
      (ref) => ChatMessageNotifier(),
);
