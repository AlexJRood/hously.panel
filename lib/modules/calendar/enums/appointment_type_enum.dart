
import 'package:hously_flutter/utils/extensions/string_extension.dart';

enum AppointmentTypeEnum {
  event,
  outOfOffice,
  task,
  appointmentScheduling;

  String get type => switch (this) {
        event => name.capitalize(),
        outOfOffice => 'Out of office',
        task => name.capitalize(),
        appointmentScheduling => 'Appointment scheduling',
      };

  AppointmentTypeEnum get calendarView => switch (this) {
        event => AppointmentTypeEnum.event,
        outOfOffice => AppointmentTypeEnum.outOfOffice,
        task => AppointmentTypeEnum.task,
        appointmentScheduling => AppointmentTypeEnum.appointmentScheduling,
      };

  static AppointmentTypeEnum fromString(String input) =>
      AppointmentTypeEnum.values.firstWhere(
        (e) => e.name.toLowerCase() == input.toLowerCase(),
        orElse: () => event,
      );
}
