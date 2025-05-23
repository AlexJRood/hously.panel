import 'package:hously_flutter/modules/calendar/models/id_timeslots_model.dart';

class AdjustedDatesModel {
  final String id;
  final DateTime dateTime;
  final List<IdTimeSlotsModel> timeSlots;

  AdjustedDatesModel({
    required this.id,
    required this.dateTime,
    required this.timeSlots,
  });

  // fromJson method
  factory AdjustedDatesModel.fromJson(Map<String, dynamic> json) {
    return AdjustedDatesModel(
      id: json['id'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      timeSlots: (json['timeSlots'] as List<dynamic>)
          .map(
              (item) => IdTimeSlotsModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dateTime': dateTime.toIso8601String(),
      'timeSlots': timeSlots.map((slot) => slot.toJson()).toList(),
    };
  }

  // copyWith method
  AdjustedDatesModel copyWith({
    String? id,
    DateTime? dateTime,
    List<IdTimeSlotsModel>? timeSlots,
  }) {
    return AdjustedDatesModel(
      id: id ?? this.id,
      dateTime: dateTime ?? this.dateTime,
      timeSlots: timeSlots ?? this.timeSlots,
    );
  }
}
