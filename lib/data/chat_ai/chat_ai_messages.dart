import '../../screens/chat_ai/model/chat_ai_model.dart';

final chatGroups = [
  ChatGroup(
    groupTitle: "Today",
    chats: [
      Chat(chatTitle: "Chat 1"),
      Chat(chatTitle: "Chat 2"),
    ],
  ),
  ChatGroup(
    groupTitle: "Yesterday",
    chats: [
      Chat(chatTitle: "Chat 1"),
      Chat(chatTitle: "Chat 2"),
      Chat(chatTitle: "Chat 3"),
      Chat(chatTitle: "Chat 4"),
      Chat(chatTitle: "Chat 5"),
      Chat(chatTitle: "Chat 6"),
    ],
  ),
  ChatGroup(
    groupTitle: "Previous 7 days",
    chats: [
      Chat(chatTitle: "Chat 1"),
      Chat(chatTitle: "Chat 2"),
      Chat(chatTitle: "Chat 3"),
      Chat(chatTitle: "Chat 4"),
      Chat(chatTitle: "Chat 5"),
      Chat(chatTitle: "Chat 6"),
    ],
  ),
  ChatGroup(
    groupTitle: "Today",
    chats: [
      Chat(chatTitle: "Chat 1"),
      Chat(chatTitle: "Chat 2"),
    ],
  ),
  ChatGroup(
    groupTitle: "Yesterday",
    chats: [
      Chat(chatTitle: "Chat 1"),
      Chat(chatTitle: "Chat 2"),
      Chat(chatTitle: "Chat 3"),
      Chat(chatTitle: "Chat 4"),
      Chat(chatTitle: "Chat 5"),
      Chat(chatTitle: "Chat 6"),
    ],
  ),
  ChatGroup(
    groupTitle: "Previous 7 days",
    chats: [
      Chat(chatTitle: "Chat 1"),
      Chat(chatTitle: "Chat 2"),
      Chat(chatTitle: "Chat 3"),
      Chat(chatTitle: "Chat 4"),
      Chat(chatTitle: "Chat 5"),
      Chat(chatTitle: "Chat 6"),
    ],
  ),
];
List<ChatMessage> messages = [
  ChatMessage(
    id: '1',
    content: 'Hi, how are you?',
    timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
    sender: Sender.user,
  ),
  ChatMessage(
    id: '2',
    content: 'I am fine, thank you! How can I assist you today?',
    timestamp: DateTime.now().subtract(const Duration(minutes: 9)),
    sender: Sender.ai,
  ),
  ChatMessage(
    id: '3',
    content: 'Can you tell me about Flutter?',
    timestamp: DateTime.now().subtract(const Duration(minutes: 8)),
    sender: Sender.user,
  ),
  ChatMessage(
    id: '4',
    content:
    'Sure! Flutter is a UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.',
    timestamp: DateTime.now().subtract(const Duration(minutes: 7)),
    sender: Sender.ai,
  ),
  ChatMessage(
    id: '5',
    content: 'That’s awesome! How can I get started?',
    timestamp: DateTime.now().subtract(const Duration(minutes: 6)),
    sender: Sender.user,
  ),
  ChatMessage(
    id: '6',
    content:
    'You can visit the official Flutter documentation at flutter.dev. It has everything you need to get started.',
    timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
    sender: Sender.ai,
  ),
  ChatMessage(
    id: '1',
    content: 'Hi, how are you?',
    timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
    sender: Sender.user,
  ),
  ChatMessage(
    id: '2',
    content: 'I am fine, thank you! How can I assist you today?',
    timestamp: DateTime.now().subtract(const Duration(minutes: 9)),
    sender: Sender.ai,
  ),
  ChatMessage(
    id: '3',
    content: 'Can you tell me about Flutter?',
    timestamp: DateTime.now().subtract(const Duration(minutes: 8)),
    sender: Sender.user,
  ),
  ChatMessage(
    id: '4',
    content:
    'Sure! Flutter is a UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.',
    timestamp: DateTime.now().subtract(const Duration(minutes: 7)),
    sender: Sender.ai,
  ),
  ChatMessage(
    id: '5',
    content: 'That’s awesome! How can I get started?',
    timestamp: DateTime.now().subtract(const Duration(minutes: 6)),
    sender: Sender.user,
  ),
  ChatMessage(
    id: '6',
    content:
    'You can visit the official Flutter documentation at flutter.dev. It has everything you need to get started.',
    timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
    sender: Sender.ai,
  ),
];
