import 'package:hously_flutter/models/calendar/id_timeslots_model.dart';

class WeeklyDatesModel {
  final String id;
  final String weekName;
  final List<IdTimeSlotsModel> timeSlots;

  WeeklyDatesModel({
    required this.id,
    required this.weekName,
    required this.timeSlots,
  });

  // fromJson method
  factory WeeklyDatesModel.fromJson(Map<String, dynamic> json) {
    return WeeklyDatesModel(
      id: json['id'] as String,
      weekName: json['weekName'],
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
      'dateTime': weekName,
      'timeSlots': timeSlots.map((slot) => slot.toJson()).toList(),
    };
  }

  // copyWith method
  WeeklyDatesModel copyWith({
    String? id,
    String? weekName,
    List<IdTimeSlotsModel>? timeSlots,
  }) {
    return WeeklyDatesModel(
      id: id ?? this.id,
      weekName: weekName ?? this.weekName,
      timeSlots: timeSlots ?? this.timeSlots,
    );
  }
}
