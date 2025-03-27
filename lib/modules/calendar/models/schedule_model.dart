import 'package:equatable/equatable.dart';
import 'package:hously_flutter/modules/calendar/enums/schedule/availability_enum.dart';
import 'package:hously_flutter/modules/calendar/enums/schedule/meeting_location_enum.dart';
import 'package:hously_flutter/modules/calendar/models/adjusted_dates_model.dart';
import 'package:hously_flutter/modules/calendar/models/availability_dates_model.dart';
import 'package:hously_flutter/modules/calendar/models/booking_form_model.dart';
import 'package:hously_flutter/modules/calendar/models/weekly_dates_model.dart';

class ScheduleModel extends Equatable {
  /// First Part
  final String id;
  final String title;
  final int appointmentDuration;

  /// General availability is left
  final AvailabilityEnum availabilityEnum;
  final List<AvailabilityDatesModel> availabilityDates;
  final List<WeeklyDatesModel> weeklyAvailability;
  final int weeklyRepeat;
  final DateTime startDate;
  final bool hasEnd;
  final DateTime endDate;
  final String timeZone;

  /// Scheduling window
  final bool isNowAvailable;
  final DateTime startAvailable;
  final DateTime endAvailable;
  final bool hasDays;
  final bool hasHours;
  final int maxDays;
  final int minHours;

  /// Scheduling window dialog
  final bool isScheduleNow;
  final DateTime startScheduleDate;
  final bool isScheduleNever;
  final DateTime endScheduleDate;

  /// Adjusted availability
  /// Maybe you can change these things to a model
  final List<AdjustedDatesModel> adjustedDates;

  /// Booked appointment
  final bool hasLimit;
  final int limitNumber;
  final bool invitePermission;

  /// Location
  final MeetingLocationEnum meetingLocation;
  final String meetingLink;
  final double lat;
  final double lng;

  /// Location
  final String description;

  /// Booking form
  final List<BookingFormModel> formItems;

  const ScheduleModel({
    required this.id,
    required this.title,
    required this.availabilityEnum,
    required this.appointmentDuration,
    required this.availabilityDates,
    required this.weeklyAvailability,
    required this.weeklyRepeat,
    required this.startDate,
    required this.hasEnd,
    required this.endDate,
    required this.timeZone,
    required this.isNowAvailable,
    required this.startAvailable,
    required this.endAvailable,
    required this.hasDays,
    required this.hasHours,
    required this.maxDays,
    required this.minHours,
    required this.isScheduleNow,
    required this.startScheduleDate,
    required this.isScheduleNever,
    required this.endScheduleDate,
    required this.adjustedDates,
    required this.hasLimit,
    required this.limitNumber,
    required this.invitePermission,
    required this.meetingLocation,
    required this.meetingLink,
    required this.lat,
    required this.lng,
    required this.description,
    required this.formItems,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'availabilityEnum': availabilityEnum.toString(),
        'appointmentDuration': appointmentDuration,
        'availabilityDates': availabilityDates,
        'weeklyAvailability': weeklyAvailability,
        'weeklyRepeat': weeklyRepeat,
        'startDate': startDate.toIso8601String(),
        'hasEnd': hasEnd,
        'endDate': endDate.toIso8601String(),
        'timeZone': timeZone,
        'isNowAvailable': isNowAvailable,
        'startAvailable': startAvailable.toIso8601String(),
        'endAvailable': endAvailable.toIso8601String(),
        'maxDays': maxDays,
        'minHours': minHours,
        'isScheduleNow': isScheduleNow,
        'startScheduleDate': startScheduleDate,
        'isScheduleNever': isScheduleNever,
        'endScheduleDate': endScheduleDate,
        'adjustedDates': adjustedDates,
        'hasLimit': hasLimit,
        'limitNumber': limitNumber,
        'invitePermission': invitePermission,
        'meetingLocation': meetingLocation.toString(),
        'meetingLink': meetingLink,
        'lat': lat,
        'lng': lng,
        'description': description,
        'formItems': formItems.map((item) => item.toJson()).toList(),
      };

  factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
        id: json['id'],
        title: json['title'],
        availabilityEnum: AvailabilityEnum.values
            .firstWhere((e) => e.toString() == json['availabilityEnum']),
        appointmentDuration: json['appointmentDuration'],
        availabilityDates: (json['availabilityDates'] as List<dynamic>)
            .map((item) => AvailabilityDatesModel.fromJson(item))
            .toList(),
        weeklyAvailability: (json['weeklyAvailability'] as List<dynamic>)
            .map((item) => WeeklyDatesModel.fromJson(item))
            .toList(),
        weeklyRepeat: json['weeklyRepeat'],
        startDate: DateTime.parse(json['startDate']),
        hasEnd: json['hasEnd'],
        endDate: DateTime.parse(json['endDate']),
        timeZone: json['timeZone'],
        isNowAvailable: json['isNowAvailable'],
        startAvailable: DateTime.parse(json['startAvailable']),
        endAvailable: DateTime.parse(json['endAvailable']),
        hasDays: json['hasDays'],
        hasHours: json['hasHours'],
        maxDays: json['maxDays'],
        minHours: json['minHours'],
        isScheduleNow: json['isScheduleNow'],
        startScheduleDate: json['startScheduleDate'],
        isScheduleNever: json['isScheduleNever'],
        endScheduleDate: json['endScheduleDate'],
        adjustedDates: (json['adjustedDates'] as List<dynamic>)
            .map((item) => AdjustedDatesModel.fromJson(item))
            .toList(),
        hasLimit: json['hasLimit'],
        limitNumber: json['limitNumber'],
        invitePermission: json['invitePermission'],
        meetingLocation: MeetingLocationEnum.values
            .firstWhere((e) => e.toString() == json['meetingLocation']),
        meetingLink: json['meetingLink'],
        lat: json['lat'],
        lng: json['lng'],
        description: json['description'],
        formItems: (json['formItems'] as List<dynamic>)
            .map((item) =>
                BookingFormModel.fromJson(item as Map<String, dynamic>))
            .toList(),
      );

  ScheduleModel copyWith({
    String? id,
    String? title,
    AvailabilityEnum? availabilityEnum,
    int? appointmentDuration,
    List<AvailabilityDatesModel>? availabilityDates,
    List<WeeklyDatesModel>? weeklyAvailability,
    int? weeklyRepeat,
    DateTime? startDate,
    bool? hasEnd,
    DateTime? endDate,
    String? timeZone,
    bool? isNowAvailable,
    DateTime? startAvailable,
    DateTime? endAvailable,
    bool? hasDays,
    bool? hasHours,
    int? maxDays,
    int? minHours,
    bool? isScheduleNow,
    DateTime? startScheduleDate,
    bool? isScheduleNever,
    DateTime? endScheduleDate,
    List<AdjustedDatesModel>? adjustedDates,
    bool? hasLimit,
    int? limitNumber,
    bool? invitePermission,
    MeetingLocationEnum? meetingLocation,
    String? meetingLink,
    double? lat,
    double? lng,
    String? phoneNumber,
    String? description,
    List<BookingFormModel>? formItems,
  }) =>
      ScheduleModel(
        id: id ?? this.id,
        title: title ?? this.title,
        availabilityEnum: availabilityEnum ?? this.availabilityEnum,
        appointmentDuration: appointmentDuration ?? this.appointmentDuration,
        availabilityDates: availabilityDates ?? this.availabilityDates,
        weeklyAvailability: weeklyAvailability ?? this.weeklyAvailability,
        weeklyRepeat: weeklyRepeat ?? this.weeklyRepeat,
        startDate: startDate ?? this.startDate,
        hasEnd: hasEnd ?? this.hasEnd,
        endDate: endDate ?? this.endDate,
        timeZone: timeZone ?? this.timeZone,
        isNowAvailable: isNowAvailable ?? this.isNowAvailable,
        startAvailable: startAvailable ?? this.startAvailable,
        endAvailable: endAvailable ?? this.endAvailable,
        hasDays: hasDays ?? this.hasDays,
        hasHours: hasHours ?? this.hasHours,
        maxDays: maxDays ?? this.maxDays,
        minHours: minHours ?? this.minHours,
        isScheduleNow: isScheduleNow ?? this.isScheduleNow,
        startScheduleDate: startScheduleDate ?? this.startScheduleDate,
        isScheduleNever: isScheduleNever ?? this.isScheduleNever,
        endScheduleDate: endScheduleDate ?? this.endScheduleDate,
        adjustedDates: adjustedDates ?? this.adjustedDates,
        hasLimit: hasLimit ?? this.hasLimit,
        limitNumber: limitNumber ?? this.limitNumber,
        invitePermission: invitePermission ?? this.invitePermission,
        meetingLocation: meetingLocation ?? this.meetingLocation,
        meetingLink: meetingLink ?? this.meetingLink,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        description: description ?? this.description,
        formItems: formItems ?? this.formItems,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is ScheduleModel &&
        other.id == id &&
        other.title == title &&
        other.availabilityEnum == availabilityEnum &&
        other.appointmentDuration == appointmentDuration &&
        other.availabilityDates == availabilityDates &&
        other.weeklyAvailability == weeklyAvailability &&
        other.weeklyRepeat == weeklyRepeat &&
        other.startDate == startDate &&
        other.hasEnd == hasEnd &&
        other.endDate == endDate &&
        other.timeZone == timeZone &&
        other.isNowAvailable == isNowAvailable &&
        other.startAvailable == startAvailable &&
        other.endAvailable == endAvailable &&
        other.hasDays == hasDays &&
        other.hasHours == hasHours &&
        other.maxDays == maxDays &&
        other.minHours == minHours &&
        other.isScheduleNow == isScheduleNow &&
        other.startScheduleDate == startScheduleDate &&
        other.isScheduleNever == isScheduleNever &&
        other.endScheduleDate == endScheduleDate &&
        other.adjustedDates == adjustedDates &&
        other.hasLimit == hasLimit &&
        other.limitNumber == limitNumber &&
        other.invitePermission == invitePermission &&
        other.meetingLocation == meetingLocation &&
        other.meetingLink == meetingLink &&
        other.lat == lat &&
        other.lng == lng &&
        other.description == description &&
        other.formItems == formItems;
  }

  @override
  List<Object?> get props => [
        id,
        title,
        availabilityEnum,
        appointmentDuration,
        availabilityDates,
        weeklyAvailability,
        weeklyRepeat,
        startDate,
        hasEnd,
        endDate,
        timeZone,
        isNowAvailable,
        startAvailable,
        endAvailable,
        hasDays,
        hasHours,
        maxDays,
        minHours,
        isScheduleNow,
        startScheduleDate,
        isScheduleNever,
        endScheduleDate,
        adjustedDates,
        hasLimit,
        limitNumber,
        invitePermission,
        meetingLocation,
        meetingLink,
        lat,
        lng,
        description,
        formItems,
      ];

  // Convert DateTime to JSON-compatible format (ISO8601 string)
  static String _dateTimeToJson(DateTime dateTime) =>
      dateTime.toIso8601String();

  // Convert JSON string back to DateTime
  static DateTime _dateTimeFromJson(String dateTimeString) =>
      DateTime.parse(dateTimeString);
}
