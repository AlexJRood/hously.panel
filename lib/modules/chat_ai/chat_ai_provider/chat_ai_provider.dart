import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/api_services/url.dart';
import 'package:hously_flutter/api_services/api_services.dart';

class ChatRoom {
  final int id;
  final String? name;
  final String? createdAt;

 const ChatRoom({
    required this.id,
    required this.name,
    required this.createdAt,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) {
    return ChatRoom(
      id: json['id'] as int,
      name: json['name'] as String?, // Safely handle null
      createdAt: json['created_at'] as String?,
    );
  }
}

class MessageListResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<Message> results;

 const MessageListResponse({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory MessageListResponse.fromJson(Map<String, dynamic> json) {
    return MessageListResponse(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results:
          List<Message>.from(json['results'].map((x) => Message.fromJson(x))),
    );
  }
}

class Message {
  final int id;
  final String userMessage;
  final String? aiResponse;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int thread;
  final int user;

 const Message({
    required this.id,
    required this.userMessage,
    required this.aiResponse,
    required this.createdAt,
    required this.updatedAt,
    required this.thread,
    required this.user,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      userMessage: json['user_message'],
      aiResponse: json['ai_response'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      thread: json['thread'],
      user: json['user'],
    );
  }
}

class ChatAiMessagesState {
  final List<Message> messages;
  final bool isLoading;

  const ChatAiMessagesState({required this.messages, this.isLoading = false});

  ChatAiMessagesState copyWith({
    List<Message>? messages,
    bool? isLoading,
  }) {
    return ChatAiMessagesState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ChatAiRoomsProvider extends StateNotifier<List<ChatRoom>> {
  final Ref ref;

  ChatAiRoomsProvider({required this.ref}) : super(const[]);

  Future<void> getRooms() async {
    try {
      final response =
          await ApiServices.get(URLs.getAiRooms, ref: ref, hasToken: true);

      if (response != null && response.statusCode == 200) {
        final decodedData = jsonDecode(utf8.decode(response.data));
        if (decodedData is List) {
          final List<ChatRoom> rooms = decodedData
              .whereType<Map<String, dynamic>>() // Ensure it's a valid Map
              .map((room) => ChatRoom.fromJson(room))
              .toList();

          state = rooms;
        } else {
          print('Unexpected data format: $decodedData');
        }
      } else {
        print(
            'Failed to fetch rooms: ${response?.statusCode ?? 'Unknown status'}');
      }
    } catch (e) {
      print('Error fetching rooms: $e');
    }
  }

  Future<void> createRoom() async {
    try {
      final response = await ApiServices.post(URLs.createAiRoom,
          hasToken: true, data: {"name": "New chat"});

      if (response != null && response.statusCode == 201) {
        print('Room created successfully');
      } else {
        print('Failed to create room');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> removeRoom(String id) async {
    try {
      final response = await ApiServices.delete(
        URLs.removeAiRoom(id),
        hasToken: true,
      );

      if (response != null && response.statusCode == 200) {
        print('Ai room deleted successfully');
      } else {
        print('Ai room deleting failed');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getAiMessages() async {
    try {
      final response = await ApiServices.get(
        URLs.getAiMessages,
        hasToken: true,
        ref: ref,
      );

      if (response != null && response.statusCode == 200) {
        print('Get Ai room messages successfully');
      } else {
        print('Get Ai room messages failed');
      }
    } catch (e) {
      print(e);
    }
  }
}

final chatAiRoomsProvider =
    StateNotifierProvider<ChatAiRoomsProvider, List<ChatRoom>>((ref) {
  return ChatAiRoomsProvider(ref: ref);
});

class ChatAiMessagesNotifier extends StateNotifier<ChatAiMessagesState> {
  final Ref ref;
  ChatAiMessagesNotifier({required this.ref})
      : super(const ChatAiMessagesState(messages: []));

  Future<void> messageListInRoom(String id) async {
    state = state.copyWith(isLoading: true); // Start loading
    try {
      final response = await ApiServices.get(
        URLs.messageListInRoomAi(id),
        hasToken: true,
        ref: ref,
      );

      if (response != null && response.statusCode == 200) {
        print('Get message List In Room successfully');

        final decodedData = jsonDecode(utf8.decode(response.data));
        final messageListResponse = MessageListResponse.fromJson(decodedData);

        state = state.copyWith(
          messages: messageListResponse.results,
          isLoading: false, // Stop loading after success
        );

        print("Last Message: ${messageListResponse.results.last.userMessage}");
        print("All Messages: ${state.messages.map((e) => e.userMessage).toList()}");
      } else {
        print('Get message List In Room failed');
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      print('Error fetching messages: $e');
      state = state.copyWith(isLoading: false); // Stop loading on error
    }
  }

  Future<void> addMessageToRoomAi(String id, String message) async {
    state = state.copyWith(isLoading: true);
    try {
      final response = await ApiServices.post(
        URLs.addMessageToRoomAi(id),
        hasToken: true,
        data: {'user_message': message},
      );

      if (response != null && response.statusCode == 200) {
        print('add Message To Room Ai successfully');
        await messageListInRoom(id); // Refresh messages after adding
      } else {
        print('add Message To Room Ai failed');
      }
    } catch (e) {
      print(e);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> queryUserChatBot(String message) async {
    state = state.copyWith(isLoading: true);
    try {
      final response = await ApiServices.post(
        URLs.queryUserChatBot,
        hasToken: true,
        data: {'user_query': message},
      );

      if (response != null && response.statusCode == 201) {
        print('AI message sent successfully');
      } else {
        print('AI message failed to send');
      }
    } catch (e) {
      print(e);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> editMessage(String roomId, String messageId, String newMessage) async {
    state = state.copyWith(isLoading: true);
    try {
      final response = await ApiServices.put(
        URLs.editAiMessage(roomId, messageId),
        hasToken: true,
        data: {'user_message': newMessage},
      );

      if (response != null && response.statusCode == 200) {
        print('Message edited successfully');
        await messageListInRoom(roomId); // Refresh messages after editing
      } else {
        print('Message edit failed: ${response?.statusCode}, ${response?.data}');
      }
    } catch (e) {
      print('Error editing message: $e');
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}

// Updated provider
final chatAiMessageProvider = StateNotifierProvider<ChatAiMessagesNotifier, ChatAiMessagesState>((ref) {
  return ChatAiMessagesNotifier(ref: ref);
});
final selectedAiRoomProvider = StateProvider((ref) => '');
