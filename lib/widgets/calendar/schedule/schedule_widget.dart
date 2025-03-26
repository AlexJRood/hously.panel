import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/state_managers/screen/calendar/schedule_appointment_provider.dart';
import 'package:hously_flutter/widgets/calendar/elevated_button.dart';
import 'package:hously_flutter/widgets/calendar/schedule/adjusted_availability_widget.dart';
import 'package:hously_flutter/widgets/calendar/schedule/booked_appointment_widget.dart';
import 'package:hously_flutter/widgets/calendar/schedule/booking_form_widget.dart';
import 'package:hously_flutter/widgets/calendar/schedule/divider_widget.dart';
import 'package:hously_flutter/widgets/calendar/schedule/general_availability_widget.dart';
import 'package:hously_flutter/widgets/calendar/schedule/schedule_location_widget.dart';
import 'package:hously_flutter/widgets/calendar/schedule/schedule_subject_widget.dart';
import 'package:hously_flutter/widgets/calendar/schedule/scheduling_window_widget.dart';
import 'package:hously_flutter/widgets/calendar/text_form_field_widget.dart';

class ScheduleWidget extends ConsumerWidget {
  const ScheduleWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const widgetSpace = 10.0;
    final scheduleAppointmentState = ref.watch(scheduleAppointmentProvider);
    final scheduleData = scheduleAppointmentState.scheduleModel;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: 500,
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('BOOKABLE APPOIONTMENT SCHEDULE'),
              TextFormFieldWidget(
                text: scheduleData.title,
                inputDecoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  hintText: 'Add title',
                ),
                onChanged: (title) {
                  final newScheduleData = scheduleData.copyWith(title: title);

                  ref.read(scheduleAppointmentProvider).scheduleModel =
                      newScheduleData;
                },
              ),
              const SizedBox(height: 40),
              if (scheduleAppointmentState.isFirst)
                Column(
                  children: [
                    const ScheduleSubjectWidget(),
                    const SizedBox(height: widgetSpace),
                    const DividerWidget(),
                    const SizedBox(height: widgetSpace),
                    const GeneralAvailabilityWidget(),
                    const SizedBox(height: widgetSpace),
                    const DividerWidget(),
                    const SizedBox(height: widgetSpace),
                    const SchedulingWindowWidget(),
                    const SizedBox(height: widgetSpace),
                    const DividerWidget(),
                    const SizedBox(height: widgetSpace),
                    const AdjustedAvailabilityWidget(),
                    const SizedBox(height: widgetSpace),
                    const DividerWidget(),
                    const SizedBox(height: widgetSpace),
                    const BookedAppointmentWidget(),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButtonWidget(
                        child: const Text(
                          'Next',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTapped: () => ref
                            .read(scheduleAppointmentProvider)
                            .isFirst = false,
                      ),
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    const ScheduleLocationWidget(),
                    const BookingFormWidget(),
                    const SizedBox(height: 20),
                    Row(children: [
                      ElevatedButtonWidget(
                        bgColor: Colors.transparent,
                        elevation: 0,
                        child: const Text('Back'),
                        onTapped: () => ref
                            .read(scheduleAppointmentProvider)
                            .isFirst = true,
                      ),
                      const Spacer(),
                      ElevatedButtonWidget(
                        child: const Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTapped: () {},
                      ),
                    ]),
                  ],
                ),
              const SizedBox(height: widgetSpace),
            ],
          ),
        ),
      ),
    );
  }
}
