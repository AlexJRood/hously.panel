import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/enums/appointment_type_enum.dart';

final appointmentTypeProvider =
    ChangeNotifierProvider((ref) => AppointmentTypeProvider());

class AppointmentTypeProvider extends ChangeNotifier {
  AppointmentTypeEnum _appointmentTypeEnum = AppointmentTypeEnum.event;
  AppointmentTypeEnum get appointmentTypeEnum => _appointmentTypeEnum;
  set appointmentTypeEnum(AppointmentTypeEnum appointmentTypeEnum) {
    _appointmentTypeEnum = appointmentTypeEnum;
    notifyListeners();
  }
}
