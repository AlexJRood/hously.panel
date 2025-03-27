import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/modules/calendar/enums/schedule/availability_enum.dart';
import 'package:hously_flutter/modules/calendar/state/schedule_appointment_provider.dart';
import 'package:hously_flutter/routing/navigation_service.dart';
import 'package:hously_flutter/modules/calendar/widgets/dropdown_field_widget.dart';
import 'package:hously_flutter/modules/calendar/widgets/events/event_web_option.dart';
import 'package:hously_flutter/modules/calendar/widgets/schedule/custom_recurrence_schedule_widget.dart';
import 'package:hously_flutter/modules/calendar/widgets/schedule/no_repeat_widget.dart';
import 'package:hously_flutter/modules/calendar/widgets/schedule/repeat_weekly_widget.dart';
import 'package:hously_flutter/modules/calendar/widgets/time_zone_field_widget.dart';

class GeneralAvailabilityWidget extends ConsumerWidget {
  const GeneralAvailabilityWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleAppointmentState = ref.watch(scheduleAppointmentProvider);
    final scheduleData = scheduleAppointmentState.scheduleModel;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EventWebOption(
          crossAxisAlignment: CrossAxisAlignment.start,
          iconData: Icons.watch_later_outlined,
          secondWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'General availability',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              const Text(
                'Set when you\'r regularly available for appointments',
              ),
              SizedBox(
                width: 200,
                child: DropDownWidget(
                  values: AvailabilityEnum.values,
                  currentValue: scheduleData.availabilityEnum,
                  isDense: true,
                  texts: AvailabilityEnum.values
                      .map((value) => value.type)
                      .toList(),
                  onChanged: (availability) {
                    if (availability == null) return;

                    final newScheduleData = scheduleData.copyWith(
                      availabilityEnum: availability,
                    );
                    ref.read(scheduleAppointmentProvider).scheduleModel =
                        newScheduleData;

                    if (availability == AvailabilityEnum.custom) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: CustomRecurrenceScheduleWidget(
                              onCanceled: () {
                                ref.read(navigationService).beamPop();
                              },
                              onApproved: () {
                                ref.read(navigationService).beamPop();
                              },
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
        switch (scheduleData.availabilityEnum) {
          AvailabilityEnum.doesNotRepeat => const NoRepeatWidget(),
          AvailabilityEnum.repeatWeekly => const RepeatWeeklyWidget(),
          AvailabilityEnum.custom => const RepeatWeeklyWidget(),
        },
        const TimeZoneFieldWidget(),
      ],
    );
  }
}
