import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/url.dart';
import 'package:hously_flutter/utils/api_services.dart';

import 'chat_message_provider.dart';

final isChatSelected = StateProvider<bool>((ref) => false);
final selectedChatId = StateProvider<String>((ref) => '');
final otherUserData = StateProvider<OtherUser>(
  (ref) => OtherUser(username: ''),
);

class Room {
  final String id;
  final PersonalRoom? personalRoom;
  final OtherUser? otherUser;
  final Advertisement? advertisement;
  final List<Tag>? tags;

  const Room({
    required this.id,
    this.personalRoom,
    this.otherUser,
    this.advertisement,
    this.tags,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'] ?? '', // Handle null for `id`
      personalRoom: json['personal_room'] != null
          ? PersonalRoom.fromJson(json['personal_room'])
          : null,
      otherUser: json['other_user'] != null
          ? OtherUser.fromJson(json['other_user'])
          : null,
      advertisement: json['advertisement'] != null
          ? Advertisement.fromJson(json['advertisement'])
          : null,
      tags: json['tags'] != null
          ? (json['tags'] as List).map((tag) => Tag.fromJson(tag)).toList()
          : [],
    );
  }
}

class PersonalRoom {
  final String id;
  final String timestamp;
  final int? user1;
  final int? user2;

  const PersonalRoom({
    required this.id,
    required this.timestamp,
    this.user1,
    this.user2,
  });

  factory PersonalRoom.fromJson(Map<String, dynamic> json) {
    return PersonalRoom(
      id: json['id'] ?? '',
      timestamp: json['timestamp'] ?? '',
      user1: json['user1'],
      user2: json['user2'],
    );
  }
}

class OtherUser {
  final String? avatar;
  final String username;
  final String? email;
  final String? firstName;
  final String? lastName;

  const OtherUser({
    this.avatar,
    required this.username,
    this.email,
    this.firstName,
    this.lastName,
  });

  factory OtherUser.fromJson(Map<String, dynamic> json) {
    return OtherUser(
      avatar: json['avatar'],
      username: json['username'] ?? 'Unknown', // Default to 'Unknown' if null
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }
}

class Advertisement {
  final String title;
  final double price;

  const Advertisement({
    required this.title,
    required this.price,
  });

  factory Advertisement.fromJson(Map<String, dynamic> json) {
    return Advertisement(
      title: json['title'] ?? '',
      price: json['price']?.toDouble() ?? 0.0, // Handle null and cast to double
    );
  }
}

class Tag {
  final String id;
  final String name;

  const Tag({
    required this.id,
    required this.name,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}

class RoomsNotifier extends StateNotifier<List<Room>> {
  RoomsNotifier(this.ref) : super([]);
  final Ref ref;

  /// Fetch all rooms and update state
  Future<void> fetchRooms() async {
    try {
      final response =
          await ApiServices.get(ref: ref, URLs.rooms, hasToken: true);

      if (response != null && response.statusCode == 200) {
        final responseBody = utf8.decode(response.data as Uint8List);
        final data = json.decode(responseBody);
        final results = data['results'] as List;

        final rooms = await Future.wait(results.map((roomJson) async {
          final room = Room.fromJson(roomJson);
          return room;
        }));

        state = rooms;
      } else {
        print('Fetch rooms failed with status code: ${response?.statusCode}');
      }
    } catch (e) {
      print('Error fetching rooms: $e');
    }
  }

  /// Create a new room
  Future<void> createRoom(int advertisementId) async {
    try {
      final data = {
        "is_group": false,
        "advertisement": advertisementId,
        "content": "Can I know more aboout the advertisement?"
      };

      final response = await ApiServices.post(
        URLs.rooms,
        hasToken: true,
        data: data,
      );

      if (response != null && response.statusCode == 201) {
        print(
            'Room added successfully with status code: ${response.statusCode}');
        await fetchRooms();
      } else {
        print('Room creation failed with status code: ${response?.statusCode}');
        print('Response data: ${response?.data}');
      }
    } catch (e) {
      print('Error creating room: $e');
    }
  }
}

/// Provider for `RoomsNotifier`
final fetchRoomsProvider = StateNotifierProvider<RoomsNotifier, List<Room>>(
  (ref) => RoomsNotifier(ref),
);
