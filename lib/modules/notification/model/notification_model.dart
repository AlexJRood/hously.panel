class NotificationModel {
  final int id;
  final String title;
  final String text;
  final String? image;
  final int objectId;
  final int user;
  final int fcmDevice;
  final int contentType;

  NotificationModel({
    required this.id,
    required this.title,
    required this.text,
    this.image,
    required this.objectId,
    required this.user,
    required this.fcmDevice,
    required this.contentType,
  });

  // Factory method to create an instance from JSON
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      text: json['text'],
      image: json['image'],
      objectId: json['object_id'],
      user: json['user'],
      fcmDevice: json['fcm_device'],
      contentType: json['content_type'],
    );
  }

  // Convert an instance to JSON (useful for POST requests)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'text': text,
      'image': image,
      'object_id': objectId,
      'user': user,
      'fcm_device': fcmDevice,
      'content_type': contentType,
    };
  }
}


class UserNotificationResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<NotificationModel> results;

  UserNotificationResponse({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  // Factory method to create an instance from JSON
  factory UserNotificationResponse.fromJson(Map<String, dynamic> json) {
    return UserNotificationResponse(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: List<NotificationModel>.from(
        json['results'].map((notification) => NotificationModel.fromJson(notification)),
      ),
    );
  }
}
