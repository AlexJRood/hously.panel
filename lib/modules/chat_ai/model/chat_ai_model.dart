import 'package:intl/intl.dart';

import '../chat_ai_provider/chat_ai_provider.dart';

class ChatGroup {
  final String groupTitle; // E.g., "Today", "Yesterday"
  final List<Chat> chats; // List of chat items in this group

  ChatGroup({
    required this.groupTitle,
    required this.chats,
  });
}

class Chat {
  final String chatTitle; // E.g., "Chat 1", "Chat 2"

  Chat({
    required this.chatTitle,
  });
}


class ChatMessage {
  final String id; // Unique ID for the message
  final String content; // Content of the message
  final DateTime timestamp; // Time the message was sent
  final Sender sender; // Sender of the message (User or AI)

  ChatMessage({
    required this.id,
    required this.content,
    required this.timestamp,
    required this.sender,
  });

  // Factory constructor to create from JSON
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'],
      content: json['content'],
      timestamp: DateTime.parse(json['timestamp']),
      sender: Sender.values.firstWhere((e) => e.toString() == json['sender']),
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'sender': sender.toString(),
    };
  }
}

// Enum for the sender type
enum Sender {
  user,
  ai,
}

// Function to group rooms by date categories
Map<String, List<ChatRoom>> groupRoomsByDate(List<ChatRoom> rooms) {
  final now = DateTime.now();
  final today = DateFormat('yyyy-MM-dd').format(now);

  Map<String, List<ChatRoom>> groupedRooms = {
    'Today': [],
    'Yesterday': [],
    'Previous 7 Days': [],
    'Previous 30 Days': [],
  };

  for (final room in rooms) {
    if (room.createdAt == null) continue;

    final createdAtDate = DateTime.tryParse(room.createdAt!);
    if (createdAtDate == null) continue;

    final createdDate = DateFormat('yyyy-MM-dd').format(createdAtDate);

    if (createdDate == today) {
      groupedRooms['Today']!.add(room);
    } else if (createdDate ==
        DateFormat('yyyy-MM-dd').format(now.subtract(const Duration(days: 1)))) {
      groupedRooms['Yesterday']!.add(room);
    } else if (createdAtDate.isAfter(now.subtract(const Duration(days: 7)))) {
      groupedRooms['Previous 7 Days']!.add(room);
    } else if (createdAtDate.isAfter(now.subtract(const Duration(days: 30)))) {
      groupedRooms['Previous 30 Days']!.add(room);
    }
  }

  return groupedRooms;
}
