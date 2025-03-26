import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/enums/schedule/duration_type_enum.dart';
import 'package:hously_flutter/state_managers/screen/calendar/schedule_appointment_provider.dart';
import 'package:hously_flutter/widgets/calendar/dropdown_field_widget.dart';
import 'package:hously_flutter/widgets/calendar/events/event_web_option.dart';
import 'package:hously_flutter/widgets/calendar/schedule/custom_duration_widget.dart';

class ScheduleSubjectWidget extends ConsumerWidget {
  const ScheduleSubjectWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleAppointmentState = ref.watch(scheduleAppointmentProvider);
    final scheduleData = scheduleAppointmentState.scheduleModel;

    return EventWebOption(
      crossAxisAlignment: CrossAxisAlignment.start,
      iconData: Icons.timelapse_rounded,
      secondWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Appointment duration',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          const Text('How long should each appointment last?'),
          SizedBox(
            width: 200,
            child: DropDownWidget(
              values: DurationType.values,
              currentValue: DurationType.intToEnum(
                scheduleData.appointmentDuration,
              ),
              isDense: true,
              texts: DurationType.values.map((value) => value.type).toList(),
              onChanged: (value) {
                if (value == null) return;

                if (value != DurationType.custom) {
                  final newScheduleData = scheduleData.copyWith(
                    appointmentDuration: DurationType.enumToInt(value),
                  );
                  ref.read(scheduleAppointmentProvider).scheduleModel =
                      newScheduleData;
                } else {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        content: SizedBox(
                          width: 240,
                          child: CustomDurationWidget(),
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
    );
  }
}
