import 'package:flutter/material.dart';
import 'package:hously_flutter/modules/calendar/enums/schedule/availability_enum.dart';
import 'package:hously_flutter/modules/calendar/enums/schedule/meeting_location_enum.dart';
import 'package:hously_flutter/modules/calendar/models/availability_dates_model.dart';
import 'package:hously_flutter/modules/calendar/models/booking_form_model.dart';
import 'package:hously_flutter/modules/calendar/models/id_timeslots_model.dart';
import 'package:hously_flutter/modules/calendar/models/schedule_model.dart';
import 'package:hously_flutter/modules/calendar/models/weekly_dates_model.dart';
import 'package:hously_flutter/modules/calendar/calendar/date_util.dart';
import 'package:uuid/uuid.dart';

final defaultSchedule = ScheduleModel(
  id: '',
  title: '',
  availabilityEnum: AvailabilityEnum.doesNotRepeat,
  appointmentDuration: 60,
  availabilityDates: [
    AvailabilityDatesModel(
      id: const Uuid().v4(),

      /// If you use just DateTime.now() what will be happen
      dateTime: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ),
      timeSlots: [
        IdTimeSlotsModel(
          id: const Uuid().v4(),
          startTime: const TimeOfDay(hour: 9, minute: 0),
          endTime: const TimeOfDay(hour: 17, minute: 0),
        ),
      ],
    )
  ],
  weeklyAvailability: [
    WeeklyDatesModel(
      id: const Uuid().v4(),
      weekName: 'Sat',
      timeSlots: [],
    ),
    WeeklyDatesModel(
      id: const Uuid().v4(),
      weekName: 'Sun',
      timeSlots: [],
    ),
    WeeklyDatesModel(
      id: const Uuid().v4(),
      weekName: 'Mon',
      timeSlots: [
        IdTimeSlotsModel(
          id: const Uuid().v4(),
          startTime: const TimeOfDay(hour: 9, minute: 0),
          endTime: const TimeOfDay(hour: 17, minute: 0),
        ),
      ],
    ),
    WeeklyDatesModel(
      id: const Uuid().v4(),
      weekName: 'Tue',
      timeSlots: [
        IdTimeSlotsModel(
          id: const Uuid().v4(),
          startTime: const TimeOfDay(hour: 9, minute: 0),
          endTime: const TimeOfDay(hour: 17, minute: 0),
        ),
      ],
    ),
    WeeklyDatesModel(
      id: const Uuid().v4(),
      weekName: 'Wed',
      timeSlots: [
        IdTimeSlotsModel(
          id: const Uuid().v4(),
          startTime: const TimeOfDay(hour: 9, minute: 0),
          endTime: const TimeOfDay(hour: 17, minute: 0),
        ),
      ],
    ),
    WeeklyDatesModel(
      id: const Uuid().v4(),
      weekName: 'Thu',
      timeSlots: [
        IdTimeSlotsModel(
          id: const Uuid().v4(),
          startTime: const TimeOfDay(hour: 9, minute: 0),
          endTime: const TimeOfDay(hour: 17, minute: 0),
        ),
      ],
    ),
    WeeklyDatesModel(
      id: const Uuid().v4(),
      weekName: 'Fri',
      timeSlots: [
        IdTimeSlotsModel(
          id: const Uuid().v4(),
          startTime: const TimeOfDay(hour: 9, minute: 0),
          endTime: const TimeOfDay(hour: 17, minute: 0),
        ),
      ],
    ),
  ],
  weeklyRepeat: 0,
  startDate: DateTime.now(),
  hasEnd: false,
  endDate: DateTime.now(),
  timeZone: '',
  isNowAvailable: false,
  startAvailable: DateTime.now(),
  endAvailable: DateTime.now(),
  hasHours: true,
  hasDays: true,
  maxDays: 0,
  minHours: 0,
  isScheduleNow: true,
  startScheduleDate: DateTime.now(),
  isScheduleNever: true,
  endScheduleDate: DateUtil.addOneMonth(DateTime.now()),
  adjustedDates: [],
  hasLimit: false,
  limitNumber: 0,
  invitePermission: false,
  meetingLocation: MeetingLocationEnum.googleMeet,
  meetingLink: '',
  lat: 0,
  lng: 0,
  description: '',
  formItems: [
    BookingFormModel(
      id: const Uuid().v4(),
      fieldName: 'First name',
      isRequired: true,
      isDeletable: false,
      isEditable: false,
    ),
    BookingFormModel(
      id: const Uuid().v4(),
      fieldName: 'Last name',
      isRequired: true,
      isDeletable: false,
      isEditable: false,
    ),
    BookingFormModel(
      id: const Uuid().v4(),
      fieldName: 'Email address',
      isRequired: true,
      isDeletable: false,
      isEditable: false,
    ),
  ],
);
