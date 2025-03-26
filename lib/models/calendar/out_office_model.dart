import 'package:equatable/equatable.dart';
import 'package:hously_flutter/enums/decline_meeting_enum.dart';
import 'package:hously_flutter/enums/event/repeat_enum.dart';

class OutOfficeModel extends Equatable {
  final String id;
  final String title;
  final DateTime from;
  final DateTime to;
  final RepeatEnum repeat;
  final bool autoCancel;
  final DeclineMeetingEnum declineMeeting;
  final String message;

  const OutOfficeModel({
    required this.id,
    required this.title,
    required this.from,
    required this.to,
    required this.repeat,
    required this.autoCancel,
    required this.declineMeeting,
    required this.message,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'from': from.toIso8601String(),
      'to': to.toIso8601String(),
      'repeat': repeat.name,
      'autoCancel': autoCancel,
      'declineMeeting': declineMeeting.name,
      'message': message,
    };
  }

  factory OutOfficeModel.fromJson(Map<String, dynamic> json) {
    return OutOfficeModel(
      id: json['id'],
      title: json['title'],
      from: DateTime.parse(json['from']),
      to: DateTime.parse(json['to']),
      repeat: RepeatEnum.values.firstWhere((e) => e.name == json['repeat']),
      autoCancel: json['autoCancel'],
      declineMeeting: DeclineMeetingEnum.values
          .firstWhere((e) => e.name == json['declineMeeting']),
      message: json['message'],
    );
  }

  OutOfficeModel copyWith({
    String? id,
    String? title,
    DateTime? from,
    DateTime? to,
    RepeatEnum? repeat,
    bool? autoCancel,
    DeclineMeetingEnum? declineMeeting,
    String? message,
  }) {
    return OutOfficeModel(
      id: id ?? this.id,
      title: title ?? this.title,
      from: from ?? this.from,
      to: to ?? this.to,
      repeat: repeat ?? this.repeat,
      autoCancel: autoCancel ?? this.autoCancel,
      declineMeeting: declineMeeting ?? this.declineMeeting,
      message: message ?? this.message,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OutOfficeModel &&
        other.id == id &&
        other.title == title &&
        other.from == from &&
        other.to == to &&
        other.repeat == repeat &&
        other.autoCancel == autoCancel &&
        other.declineMeeting == declineMeeting &&
        other.message == message;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        from.hashCode ^
        to.hashCode ^
        repeat.hashCode ^
        autoCancel.hashCode ^
        declineMeeting.hashCode ^
        message.hashCode;
  }

  @override
  List<Object?> get props =>
      [id, title, from, to, repeat, autoCancel, declineMeeting, message];
}
