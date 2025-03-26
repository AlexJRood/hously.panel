import 'package:flutter/material.dart';

class DateUtil {
  static DateTime addOneMonth(DateTime date) {
    var newMonth = date.month + 1;
    var newYear = date.year;

    if (newMonth > 12) {
      newMonth = 1;
      newYear++;
    }

    final lastDayOfNewMonth = DateTime(newYear, newMonth + 1, 0).day;
    final day = date.day > lastDayOfNewMonth ? lastDayOfNewMonth : date.day;

    return DateTime(newYear, newMonth, day);
  }

  static List<dynamic> timerChanged({
    required String fieldId,
    required String time,
    required bool isStart,
    required List<dynamic> dates,
  }) {
    final index = dates.indexWhere(
      (adjustedDate) => adjustedDate.id == adjustedDate.id,
    );
    var innerMap = dates[index];
    final slotIndex = innerMap.timeSlots.indexWhere(
      (newTimeSlot) => newTimeSlot.id == fieldId,
    );
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    late var newSlot;

    if (isStart) {
      newSlot = innerMap.timeSlots[slotIndex].copyWith(
        startTime: TimeOfDay(hour: hour, minute: minute),
      );
    } else {
      newSlot = innerMap.timeSlots[slotIndex].copyWith(
        endTime: TimeOfDay(hour: hour, minute: minute),
      );
    }
    innerMap.timeSlots[slotIndex] = newSlot;
    innerMap = innerMap.copyWith(timeSlots: innerMap.timeSlots);
    dates[index] = innerMap;

    return dates;
  }
}
