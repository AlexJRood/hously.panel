import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/modules/calendar/data/booking_form_data.dart';
import 'package:hously_flutter/modules/calendar/data/schedule_data.dart';
import 'package:hously_flutter/modules/calendar/enums/schedule/custom_duration_enum.dart';
import 'package:hously_flutter/modules/calendar/models/adjusted_dates_model.dart';
import 'package:hously_flutter/modules/calendar/models/availability_dates_model.dart';
import 'package:hously_flutter/modules/calendar/models/booking_form_model.dart';
import 'package:hously_flutter/modules/calendar/models/id_timeslots_model.dart';
import 'package:hously_flutter/modules/calendar/models/schedule_model.dart';
import 'package:hously_flutter/utils/toast_message.dart';
import 'package:uuid/uuid.dart';

final scheduleAppointmentProvider = ChangeNotifierProvider(
  (ref) => ScheduleAppointmentProvider(),
);

class ScheduleAppointmentProvider extends ChangeNotifier {
  var _scheduleModel = defaultSchedule;
  ScheduleModel get scheduleModel => _scheduleModel;
  set scheduleModel(ScheduleModel scheduleModel) {
    _scheduleModel = scheduleModel;
    notifyListeners();
  }

  var _isFirst = true;
  bool get isFirst => _isFirst;
  set isFirst(bool isFirst) {
    _isFirst = isFirst;
    notifyListeners();
  }

  CustomDurationEnum _customDurationEnum = CustomDurationEnum.minutes;
  CustomDurationEnum get customDurationEnum => _customDurationEnum;
  set customDurationEnum(CustomDurationEnum customDurationEnum) {
    _customDurationEnum = customDurationEnum;
    notifyListeners();
  }

  int _customDuration = 1;
  int get customDuration => _customDuration;
  set customDuration(int customDuration) {
    _customDuration = customDuration;
    notifyListeners();
  }

  void removeAvailability({
    required String uuidKey,
    required int index,
  }) {
    final availabilityDates = _scheduleModel.availabilityDates;
    final innerMap = availabilityDates[index];
    final childIndex =
        innerMap.timeSlots.map((timeSlot) => timeSlot.id).toList().indexWhere(
              (id) => id == uuidKey,
            );

    innerMap.timeSlots.removeAt(childIndex);
    if (innerMap.timeSlots.isEmpty) {
      availabilityDates.removeAt(index);
    } else {
      availabilityDates[index] = innerMap;
    }
    _scheduleModel =
        _scheduleModel.copyWith(availabilityDates: availabilityDates);

    notifyListeners();
  }

  void addAvailability({
    required String parentId,
    required DateTime dateTime,
  }) {
    final availabilityDates = _scheduleModel.availabilityDates;
    final uuidKey = const Uuid().v4();
    final listIds = availabilityDates
        .map((availabilityDate) => availabilityDate.id)
        .toList();
    final index = listIds.indexWhere((id) => id == parentId);

    List<IdTimeSlotsModel> timeSlots;
    if (index != -1) {
      timeSlots = availabilityDates[index].timeSlots;
    } else {
      timeSlots = [];
    }
    final startTime = timeSlots.isNotEmpty
        ? timeSlots.last.endTime
        : const TimeOfDay(hour: 0, minute: 0);

    if (startTime.hour > 23 ||
        (startTime.hour == 23 && startTime.minute == 0)) {
      toastMessage(message: 'You can\'t add more than 24.');

      return;
    }
    final endTime = TimeOfDay(
      hour: startTime.hour + 1,
      minute: startTime.minute,
    );

    timeSlots.add(
      IdTimeSlotsModel(
        id: uuidKey,
        startTime: startTime,
        endTime: endTime,
      ),
    );
    if (index != -1) {
      availabilityDates[index] =
          availabilityDates[index].copyWith(timeSlots: timeSlots);
    }
    _scheduleModel =
        _scheduleModel.copyWith(availabilityDates: availabilityDates);

    notifyListeners();
  }

  void addAvailabilityDate({required DateTime dateKey}) {
    final availabilityDates = _scheduleModel.availabilityDates;

    if (availabilityDates
        .map((availabilityDate) => availabilityDate.dateTime)
        .contains(DateTime(dateKey.year, dateKey.month, dateKey.day))) {
      toastMessage(message: 'Same dates are added more than once');
    } else {
      availabilityDates.add(
        AvailabilityDatesModel(
          id: const Uuid().v4(),
          dateTime: dateKey,
          timeSlots: [
            IdTimeSlotsModel(
              id: const Uuid().v4(),
              startTime: const TimeOfDay(hour: 9, minute: 0),
              endTime: const TimeOfDay(hour: 17, minute: 0),
            ),
          ],
        ),
      );
    }
    _scheduleModel =
        _scheduleModel.copyWith(availabilityDates: availabilityDates);

    notifyListeners();
  }

  void addWeeklyDate({required String parentId}) {
    final weeklyAvailability = _scheduleModel.weeklyAvailability;
    final index = _scheduleModel.weeklyAvailability
        .map((availability) => availability.id)
        .toList()
        .indexWhere((id) => id == parentId);

    List<IdTimeSlotsModel> timeSlots;
    if (index != -1) {
      timeSlots = weeklyAvailability[index].timeSlots;
    } else {
      timeSlots = [];
    }

    final startTime = timeSlots.isNotEmpty
        ? timeSlots.last.endTime
        : const TimeOfDay(hour: 0, minute: 0);
    if (startTime.hour > 23 ||
        (startTime.hour == 23 && startTime.minute == 0)) {
      toastMessage(message: 'You can\'t add more than 24.');

      return;
    }
    final endTime = TimeOfDay(
      hour: startTime.hour + 1,
      minute: startTime.minute,
    );
    final uuidKey = const Uuid().v4();

    timeSlots.add(
      IdTimeSlotsModel(
        id: uuidKey,
        startTime: startTime,
        endTime: endTime,
      ),
    );
    if (index != -1) {
      weeklyAvailability[index] =
          weeklyAvailability[index].copyWith(timeSlots: timeSlots);
    }

    _scheduleModel =
        _scheduleModel.copyWith(weeklyAvailability: weeklyAvailability);
    notifyListeners();
  }

  void removeWeeklyDate({
    required String parentId,
    required String childId,
  }) {
    final weeklyAvailability = _scheduleModel.weeklyAvailability;
    final index = _scheduleModel.weeklyAvailability
        .map((availability) => availability.id)
        .toList()
        .indexWhere((id) => id == parentId);
    final innerMap = weeklyAvailability[index];
    final slotIndex =
        innerMap.timeSlots.indexWhere((timeSlot) => timeSlot.id == childId);

    innerMap.timeSlots.removeAt(slotIndex);
    _scheduleModel =
        _scheduleModel.copyWith(weeklyAvailability: weeklyAvailability);

    notifyListeners();
  }

  void replaceWeeklyDate({required String parentId}) {
    final weeklyAvailability = _scheduleModel.weeklyAvailability.toList();
    final index = _scheduleModel.weeklyAvailability
        .map((availability) => availability.id)
        .toList()
        .indexWhere((id) => id == parentId);
    final innerMap = weeklyAvailability[index];

    for (int i = 0; i < weeklyAvailability.length; i++) {
      if (weeklyAvailability[i].timeSlots.isNotEmpty) {
        final newSlots = innerMap.timeSlots.toList();
        weeklyAvailability[i] =
            weeklyAvailability[i].copyWith(timeSlots: newSlots);
      }
    }
    _scheduleModel =
        _scheduleModel.copyWith(weeklyAvailability: weeklyAvailability);
    notifyListeners();
  }

  void addAdjustedDate({required DateTime dateKey}) {
    final availabilityDates = _scheduleModel.adjustedDates;
    if (availabilityDates
        .map((adjustedDate) => adjustedDate.dateTime)
        .toList()
        .contains(DateTime(dateKey.year, dateKey.month, dateKey.day))) {
      toastMessage(message: 'Same dates are added more than once');
    } else {
      availabilityDates.add(
        AdjustedDatesModel(
          id: const Uuid().v4(),
          dateTime: dateKey,
          timeSlots: [
            IdTimeSlotsModel(
              id: const Uuid().v4(),
              startTime: const TimeOfDay(hour: 9, minute: 0),
              endTime: const TimeOfDay(hour: 17, minute: 0),
            )
          ],
        ),
      );
    }
    _scheduleModel = _scheduleModel.copyWith(adjustedDates: availabilityDates);

    notifyListeners();
  }

  void addAdjustedTime({
    required String adjustedId,
    required DateTime adjustedDate,
  }) {
    final adjustedDates = _scheduleModel.adjustedDates;
    final listIds =
        adjustedDates.map((adjustedDate) => adjustedDate.id).toList();
    final index = listIds.indexWhere((id) => id == adjustedId);

    List<IdTimeSlotsModel> timeSlots;
    if (index != -1) {
      timeSlots = adjustedDates[index].timeSlots;
    } else {
      timeSlots = [];
    }

    final startTime = timeSlots.isNotEmpty
        ? timeSlots.last.endTime
        : const TimeOfDay(hour: 0, minute: 0);

    if (startTime.hour > 23 ||
        (startTime.hour == 23 && startTime.minute == 0)) {
      toastMessage(message: 'You can\'t add more than 24.');

      return;
    }

    final endTime = TimeOfDay(
      hour: startTime.hour + 1,
      minute: startTime.minute,
    );
    final uuidKey = const Uuid().v4();

    timeSlots.add(
      IdTimeSlotsModel(
        id: uuidKey,
        startTime: startTime,
        endTime: endTime,
      ),
    );
    if (index != -1) {
      adjustedDates[index] =
          adjustedDates[index].copyWith(timeSlots: timeSlots);
    } else {
      adjustedDates.add(
        AdjustedDatesModel(
          id: adjustedId,
          dateTime: adjustedDate,
          timeSlots: timeSlots,
        ),
      );
    }

    _scheduleModel = _scheduleModel.copyWith(adjustedDates: adjustedDates);
    notifyListeners();
  }

  void removeAdjustedTime({
    required String timeSlotId,
    required String adjustedId,
  }) {
    final adjustedDates = _scheduleModel.adjustedDates;
    final index = adjustedDates
        .indexWhere((adjustedDate) => adjustedDate.id == adjustedId);
    final innerMap = adjustedDates[index];
    final slotIndex =
        innerMap.timeSlots.indexWhere((timeSlot) => timeSlot.id == timeSlotId);

    innerMap.timeSlots.removeAt(slotIndex);
    if (innerMap.timeSlots.isEmpty) {
      adjustedDates.removeAt(index);
    } else {
      adjustedDates[index] = innerMap;
    }
    _scheduleModel = _scheduleModel.copyWith(adjustedDates: adjustedDates);

    notifyListeners();
  }

  void removeAdjustedDate({required String adjustedId}) {
    final adjustedDates = _scheduleModel.adjustedDates;
    final index = adjustedDates
        .map((adjustedDate) => adjustedDate.id)
        .toList()
        .indexWhere((id) => id == adjustedId);

    adjustedDates.removeAt(index);
    _scheduleModel = _scheduleModel.copyWith(adjustedDates: adjustedDates);

    notifyListeners();
  }

  void deleteBookingFormItem(BookingFormModel bookingFormModel) {
    final newFormItems = _scheduleModel.formItems.toList();
    final index = newFormItems
        .indexWhere((formItem) => formItem.id == bookingFormModel.id);

    newFormItems.removeAt(index);
    _scheduleModel = _scheduleModel.copyWith(
      formItems: newFormItems,
    );

    notifyListeners();
  }

  void editBookingFormItem({
    required BookingFormModel currentBooking,
    required BookingFormModel newBooking,
  }) {
    final newFormItems = _scheduleModel.formItems.toList();
    final index =
        newFormItems.indexWhere((formItem) => formItem.id == currentBooking.id);

    if (index != -1) {
      newFormItems[index] = newBooking;
      _scheduleModel = _scheduleModel.copyWith(formItems: newFormItems);
      notifyListeners();
    }
  }

  void addBookingFormItem(BookingFormModel newBooking) {
    final newFormItems = _scheduleModel.formItems.toList();

    newFormItems.add(newBooking);
    _scheduleModel = _scheduleModel.copyWith(formItems: newFormItems);
    notifyListeners();
  }

  void changePhoneNumberField(bool isAdding) {
    final newFormItems = _scheduleModel.formItems.toList();

    if (isAdding) {
      newFormItems.add(phoneBookingFormField);
    } else {
      final index =
          newFormItems.indexWhere((formItem) => formItem.id == phoneNumberId);
      newFormItems.removeAt(index);
    }
    _scheduleModel = _scheduleModel.copyWith(formItems: newFormItems);
    notifyListeners();
  }
}
