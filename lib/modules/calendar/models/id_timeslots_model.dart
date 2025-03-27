import 'package:flutter/material.dart';

class IdTimeSlotsModel {
  final String id;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  IdTimeSlotsModel({
    required this.id,
    required this.startTime,
    required this.endTime,
  });

  // fromJson method
  factory IdTimeSlotsModel.fromJson(Map<String, dynamic> json) {
    return IdTimeSlotsModel(
      id: json['id'] as String,
      startTime: _timeOfDayFromString(json['startTime'] as String),
      endTime: _timeOfDayFromString(json['endTime'] as String),
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'startTime': _timeOfDayToString(startTime),
      'endTime': _timeOfDayToString(endTime),
    };
  }

  // copyWith method
  IdTimeSlotsModel copyWith({
    String? id,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
  }) {
    return IdTimeSlotsModel(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  // Helper method to convert TimeOfDay to String
  static String _timeOfDayToString(TimeOfDay time) {
    return '${time.hour}:${time.minute}';
  }

  // Helper method to convert String to TimeOfDay
  static TimeOfDay _timeOfDayFromString(String timeString) {
    final parts = timeString.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }
}
