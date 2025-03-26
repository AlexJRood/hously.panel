import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/extensions/string_extension.dart';
import 'package:hously_flutter/models/calendar/weekly_dates_model.dart';
import 'package:hously_flutter/state_managers/screen/calendar/schedule_appointment_provider.dart';
import 'package:hously_flutter/state_managers/screen/calendar/timer_validation_provider.dart';
import 'package:hously_flutter/utils/calendar/date_util.dart';
import 'package:hously_flutter/widgets/calendar/schedule/timer_fields_widget.dart';

class RepeatWeeklyWidget extends ConsumerWidget {
  const RepeatWeeklyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleAppointmentState = ref.watch(scheduleAppointmentProvider);
    final scheduleData = scheduleAppointmentState.scheduleModel;

    return Column(
      children: scheduleData.weeklyAvailability.map((availability) {
        final timeSlots = availability.timeSlots;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 15),
              width: 35,
              child: Text(availability.weekName),
            ),
            const SizedBox(width: 20),
            if (timeSlots.isEmpty)
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 160,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 10),
                    child: const Text(
                      'Unavailable',
                      style: TextStyle(color: Color(0xFF303030)),
                    ),
                  ),
                  const SizedBox(width: 58),
                ],
              ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: availability.timeSlots.map((timeSlot) {
                final startTime = timeSlot.startTime;
                final endTime = timeSlot.endTime;

                return SizedBox(
                  width: 218,
                  child: Row(
                    children: [
                      if (timeSlots.isNotEmpty)
                        TimerFieldsWidget(
                          fieldId: timeSlot.id,
                          text1:
                              '${'${startTime.hour}'.formatTimeOfDay()}:${'${startTime.minute}'.formatTimeOfDay()}',
                          text2:
                              '${'${endTime.hour}'.formatTimeOfDay()}:${'${endTime.minute}'.formatTimeOfDay()}',
                          onChanged1: (time1) {
                            ref.read(timerValidationProvider).fieldId =
                                timeSlot.id;

                            if (time1.timeValidation()) {
                              final availabilityDates = DateUtil.timerChanged(
                                fieldId: timeSlot.id,
                                time: time1,
                                dates: scheduleData.weeklyAvailability,
                                isStart: true,
                              );

                              ref
                                  .read(scheduleAppointmentProvider)
                                  .scheduleModel = scheduleData.copyWith(
                                weeklyAvailability: (availabilityDates
                                    as List<WeeklyDatesModel>),
                              );
                            } else {
                              ref
                                  .read(scheduleAppointmentProvider)
                                  .scheduleModel = scheduleData;
                            }
                          },
                          onChanged2: (time2) {
                            ref.read(timerValidationProvider).fieldId =
                                timeSlot.id;

                            if (time2.timeValidation()) {
                              final availabilityDates = DateUtil.timerChanged(
                                fieldId: timeSlot.id,
                                time: time2,
                                dates: scheduleData.weeklyAvailability,
                                isStart: false,
                              );

                              ref
                                  .read(scheduleAppointmentProvider)
                                  .scheduleModel = scheduleData.copyWith(
                                weeklyAvailability: (availabilityDates
                                    as List<WeeklyDatesModel>),
                              );
                            } else {
                              ref
                                  .read(scheduleAppointmentProvider)
                                  .scheduleModel = scheduleData;
                            }
                          },
                        ),
                      const SizedBox(width: 20),
                      if (timeSlots.isEmpty)
                        const SizedBox(width: 38)
                      else
                        SizedBox(
                          width: 38,
                          child: IconButton(
                            icon: const Icon(Icons.block),
                            onPressed: () {
                              ref
                                  .read(scheduleAppointmentProvider)
                                  .removeWeeklyDate(
                                    childId: timeSlot.id,
                                    parentId: availability.id,
                                  );
                            },
                          ),
                        ),
                    ],
                  ),
                );
              }).toList(),
            ),
            Container(
              width: 38,
              padding: const EdgeInsets.only(top: 4),
              child: IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: () =>
                    ref.read(scheduleAppointmentProvider).addWeeklyDate(
                          parentId: availability.id,
                        ),
              ),
            ),
            if (timeSlots.isEmpty)
              const SizedBox(width: 38)
            else
              Container(
                width: 38,
                padding: const EdgeInsets.only(top: 4),
                child: IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: () {
                    ref.read(scheduleAppointmentProvider).replaceWeeklyDate(
                          parentId: availability.id,
                        );
                  },
                ),
              ),
          ],
        );
      }).toList(),
    );
  }
}
