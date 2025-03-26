import 'package:hously_flutter/extensions/string_extension.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

enum CalendarTypeEnum {
  schedule,
  day,
  week,
  month,
  year;

  String get type => switch (this) {
        schedule => name.capitalize(),
        day => name.capitalize(),
        week => name.capitalize(),
        month => name.capitalize(),
        year => name.capitalize(),
      };

  CalendarView get calendarView => switch (this) {
        schedule => CalendarView.schedule,
        day => CalendarView.day,
        week => CalendarView.week,
        month => CalendarView.month,
        year => CalendarView.timelineMonth,
      };

  static CalendarTypeEnum fromString(String input) =>
      CalendarTypeEnum.values.firstWhere(
        (e) => e.name.toLowerCase() == input.toLowerCase(),
        orElse: () => schedule,
      );
}
