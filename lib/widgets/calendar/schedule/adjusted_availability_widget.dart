import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/const/colors.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/const/values.dart';
import 'package:hously_flutter/dialogs/calendar_popup.dart';
import 'package:hously_flutter/extensions/string_extension.dart';
import 'package:hously_flutter/models/calendar/adjusted_dates_model.dart';
import 'package:hously_flutter/state_managers/screen/calendar/schedule_appointment_provider.dart';
import 'package:hously_flutter/state_managers/screen/calendar/timer_validation_provider.dart';
import 'package:hously_flutter/utils/calendar/date_util.dart';
import 'package:hously_flutter/widgets/calendar/events/event_web_option.dart';
import 'package:hously_flutter/widgets/calendar/schedule/timer_fields_widget.dart';
import 'package:hously_flutter/widgets/calendar/text_form_field_widget.dart';

import '../../../state_managers/services/navigation_service.dart';

class AdjustedAvailabilityWidget extends ConsumerWidget {
  const AdjustedAvailabilityWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleAppointmentState = ref.watch(scheduleAppointmentProvider);
    final scheduleData = scheduleAppointmentState.scheduleModel;

    return EventWebOption(
      crossAxisAlignment: CrossAxisAlignment.start,
      iconData: Icons.av_timer_sharp,
      secondWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Adjusted availability',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          const Text('Indicate times you\'re available for specific dates'),
          const SizedBox(height: 10),
          Column(
            children: scheduleData.adjustedDates.map((adjustedDate) {
              final date = adjustedDate.dateTime;

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100,
                    child: TextFormFieldWidget(
                      text:
                          '${CalendarConst.monthsName[date.month - 1].substring(0, 3)} ${date.day}, ${date.year}',
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
                    children: adjustedDate.timeSlots.map((timeSlot) {
                      final startTime = timeSlot.startTime;
                      final endTime = timeSlot.endTime;
                      final index = adjustedDate.timeSlots.indexWhere(
                          (currentIndex) => currentIndex.id == timeSlot.id);

                      return SizedBox(
                        width: 300,
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
                                  final adjustedDates = DateUtil.timerChanged(
                                    fieldId: timeSlot.id,
                                    time: time1,
                                    dates: scheduleData.adjustedDates,
                                    isStart: true,
                                  );

                                  ref
                                      .read(scheduleAppointmentProvider)
                                      .scheduleModel = scheduleData.copyWith(
                                    adjustedDates: (adjustedDates
                                        as List<AdjustedDatesModel>),
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
                                  final adjustedDates = DateUtil.timerChanged(
                                    fieldId: timeSlot.id,
                                    time: time2,
                                    dates: scheduleData.adjustedDates,
                                    isStart: false,
                                  );

                                  ref
                                      .read(scheduleAppointmentProvider)
                                      .scheduleModel = scheduleData.copyWith(
                                    adjustedDates: (adjustedDates
                                        as List<AdjustedDatesModel>),
                                  );
                                } else {
                                  ref
                                      .read(scheduleAppointmentProvider)
                                      .scheduleModel = scheduleData;
                                }
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.block),
                              onPressed: () => ref
                                  .read(scheduleAppointmentProvider)
                                  .removeAdjustedTime(
                                    adjustedId: adjustedDate.id,
                                    timeSlotId: timeSlot.id,
                                  ),
                            ),
                            if (index == 0)
                              IconButton(
                                icon: SvgPicture.asset(AppIcons.circlePlus),
                                onPressed: () => ref
                                    .read(scheduleAppointmentProvider)
                                    .addAdjustedTime(
                                      adjustedId: adjustedDate.id,
                                      adjustedDate: adjustedDate.dateTime,
                                    ),
                              ),
                            if (index == 0)
                              IconButton(
                                icon: SvgPicture.asset(AppIcons.close),
                                onPressed: () => ref
                                    .read(scheduleAppointmentProvider)
                                    .removeAdjustedDate(
                                      adjustedId: adjustedDate.id,
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
          const SizedBox(height: 10),
          InkWell(
            child: const Text(
              'Change a date\'s availability',
              style: TextStyle(color: lightBlue),
            ),
            onTapDown: (event) => showCalendarPopup(
              event: event,
              minDate: DateTime.now(),
              context: context,
              onSelectionChanged: (details) {
                if (details.date != null) {
                  ref.read(scheduleAppointmentProvider).addAdjustedDate(
                        dateKey: details.date!,
                      );
                }
                ref.read(navigationService).beamPop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
