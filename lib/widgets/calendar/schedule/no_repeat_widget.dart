import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/const/colors.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/const/values.dart';
import 'package:hously_flutter/dialogs/calendar_popup.dart';
import 'package:hously_flutter/extensions/string_extension.dart';
import 'package:hously_flutter/models/calendar/availability_dates_model.dart';
import 'package:hously_flutter/state_managers/screen/calendar/schedule_appointment_provider.dart';
import 'package:hously_flutter/state_managers/screen/calendar/timer_validation_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/calendar/date_util.dart';
import 'package:hously_flutter/widgets/calendar/schedule/timer_fields_widget.dart';
import 'package:hously_flutter/widgets/calendar/text_form_field_widget.dart';

class NoRepeatWidget extends ConsumerWidget {
  const NoRepeatWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleAppointmentState = ref.watch(scheduleAppointmentProvider);
    final scheduleData = scheduleAppointmentState.scheduleModel;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: scheduleData.availabilityDates.map((availabilityDate) {
            final dateTime = availabilityDate.dateTime;
            final parentIndex = scheduleData.availabilityDates.indexWhere(
                (currentDate) => availabilityDate.id == currentDate.id);

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 150,
                  child: TextFormFieldWidget(
                    text:
                        '${CalendarConst.monthsName[dateTime.month - 1].substring(0, 3)} ${dateTime.day}, ${dateTime.year}',
                    readOnly: true,
                    inputDecoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      filled: true,
                      fillColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                    ),
                    onTapped: () {},
                  ),
                ),
                Column(
                  children: availabilityDate.timeSlots.map((timeSlot) {
                    final startTime = timeSlot.startTime;
                    final endTime = timeSlot.endTime;
                    final childIndex = availabilityDate.timeSlots
                        .indexWhere((newTime) => newTime.id == timeSlot.id);

                    return SizedBox(
                      width: 260,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
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
                                  dates: scheduleData.availabilityDates,
                                  isStart: true,
                                );

                                ref
                                    .read(scheduleAppointmentProvider)
                                    .scheduleModel = scheduleData.copyWith(
                                  availabilityDates: (availabilityDates
                                      as List<AvailabilityDatesModel>),
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
                                  dates: scheduleData.availabilityDates,
                                  isStart: false,
                                );

                                ref
                                    .read(scheduleAppointmentProvider)
                                    .scheduleModel = scheduleData.copyWith(
                                  availabilityDates: (availabilityDates
                                      as List<AvailabilityDatesModel>),
                                );
                              } else {
                                ref
                                    .read(scheduleAppointmentProvider)
                                    .scheduleModel = scheduleData;
                              }
                            },
                          ),
                          const SizedBox(width: 10),
                          if (childIndex == 0)
                            IconButton(
                              icon: SvgPicture.asset(AppIcons.circlePlus),
                              onPressed: () => ref
                                  .read(scheduleAppointmentProvider)
                                  .addAvailability(
                                    dateTime: dateTime,
                                    parentId: availabilityDate.id,
                                  ),
                            ),
                          const Spacer(),
                          if (availabilityDate.timeSlots.length > 1 ||
                              scheduleData.availabilityDates.length > 1)
                            IconButton(
                              icon: SvgPicture.asset(AppIcons.close),
                              onPressed: () => ref
                                  .read(scheduleAppointmentProvider)
                                  .removeAvailability(
                                    uuidKey: timeSlot.id,
                                    index: parentIndex,
                                  ),
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            );
          }).toList(),
        ),
        InkWell(
          child: const Text(
            'Add a date',
            style: TextStyle(color: lightBlue),
          ),
          onTapDown: (event) => showCalendarPopup(
            event: event,
            minDate: DateTime.now(),
            context: context,
            onSelectionChanged: (details) {
              if (details.date != null) {
                ref.read(scheduleAppointmentProvider).addAvailabilityDate(
                      dateKey: details.date!,
                    );
              }
              ref.read(navigationService).beamPop();
            },
          ),
        ),
      ],
    );
  }
}
