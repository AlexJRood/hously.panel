import 'package:equatable/equatable.dart';
import 'package:hously_flutter/enums/event/repeat_enum.dart';
import 'package:hously_flutter/enums/event/visibility_type_enum.dart';
import 'package:hously_flutter/models/calendar/guest_model.dart';
import 'package:hously_flutter/models/calendar/offer_preview_model.dart';
import 'package:hously_flutter/models/calendar/reminder_model.dart';

class EventModel extends Equatable {
  final String id;
  final String title;
  final DateTime from;
  final DateTime to;
  final RepeatEnum repeat;
  final String timeZone;
  final String location;
  final String onlineCallLink;
  final List<Reminder> reminders;
  final List<Guest> guests;
  final bool busy;
  final VisibilityTypeEnum visibility;
  final String description;
  final String offerLink;
  final OfferPreview offerPreview;

  const EventModel({
    required this.id,
    required this.title,
    required this.from,
    required this.to,
    required this.repeat,
    required this.timeZone,
    required this.location,
    required this.onlineCallLink,
    required this.reminders,
    required this.guests,
    required this.busy,
    required this.visibility,
    required this.description,
    required this.offerLink,
    required this.offerPreview,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'from': from.toIso8601String(),
      'to': to.toIso8601String(),
      'repeat': repeat.name,
      'timeZone': timeZone,
      'location': location,
      'onlineCallLink': onlineCallLink,
      'reminders': reminders.map((reminder) => reminder.toJson()).toList(),
      'guests': guests.map((guest) => guest.toJson()).toList(),
      'busy': busy,
      'visibility': visibility.type,
      'description': description,
      'offerLink': offerLink,
      'offerPreview': offerPreview.toJson(),
    };
  }

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
        id: json['id'],
        title: json['title'],
        from: DateTime.parse(json['from']),
        to: DateTime.parse(json['to']),
        repeat: RepeatEnum.fromString(json['repeat']),
        timeZone: json['timeZone'],
        location: json['location'],
        onlineCallLink: json['onlineCallLink'],
        reminders: (json['reminders'] as List)
            .map((reminder) => Reminder.fromJson(reminder))
            .toList(),
        guests: (json['guests'] as List)
            .map((guest) => Guest.fromJson(guest))
            .toList(),
        busy: json['busy'],
        visibility: VisibilityTypeEnum.fromString(json['visibility']),
        description: json['description'],
        offerLink: json['offerLink'],
        offerPreview: OfferPreview.fromJson(json['offerPreview']),
      );

  EventModel copyWith({
    String? id,
    String? title,
    Duration? duration,
    DateTime? from,
    DateTime? to,
    RepeatEnum? repeat,
    String? timeZone,
    String? repeatType,
    String? location,
    String? onlineCallLink,
    List<Reminder>? reminders,
    List<Guest>? guests,
    bool? busy,
    VisibilityTypeEnum? visibility,
    String? description,
    String? offerLink,
    OfferPreview? offerPreview,
  }) {
    return EventModel(
      id: id ?? this.id,
      title: title ?? this.title,
      from: from ?? this.from,
      to: to ?? this.to,
      repeat: repeat ?? this.repeat,
      timeZone: timeZone ?? this.timeZone,
      location: location ?? this.location,
      onlineCallLink: onlineCallLink ?? this.onlineCallLink,
      reminders: reminders ?? this.reminders,
      guests: guests ?? this.guests,
      busy: busy ?? this.busy,
      visibility: visibility ?? this.visibility,
      description: description ?? this.description,
      offerLink: offerLink ?? this.offerLink,
      offerPreview: offerPreview ?? this.offerPreview,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EventModel &&
        other.id == id &&
        other.title == title &&
        other.from == from &&
        other.to == to &&
        other.repeat == repeat &&
        other.timeZone == timeZone &&
        other.location == location &&
        other.onlineCallLink == onlineCallLink &&
        other.reminders == reminders &&
        other.guests == guests &&
        other.busy == busy &&
        other.visibility == visibility &&
        other.description == description &&
        other.offerLink == offerLink &&
        other.offerPreview == offerPreview;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        from.hashCode ^
        to.hashCode ^
        repeat.hashCode ^
        timeZone.hashCode ^
        location.hashCode ^
        onlineCallLink.hashCode ^
        reminders.hashCode ^
        guests.hashCode ^
        busy.hashCode ^
        visibility.hashCode ^
        description.hashCode ^
        offerLink.hashCode ^
        offerPreview.hashCode;
  }

  @override
  List<Object?> get props => [
        id,
        title,
        from,
        to,
        repeat,
        timeZone,
        location,
        onlineCallLink,
        reminders,
        guests,
        busy,
        visibility,
        description,
        offerLink,
        offerPreview,
      ];
}
