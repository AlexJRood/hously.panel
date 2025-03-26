import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/colors.dart';
import 'package:hously_flutter/enums/schedule/custom_duration_enum.dart';
import 'package:hously_flutter/state_managers/screen/calendar/schedule_appointment_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/widgets/calendar/dropdown_field_widget.dart';
import 'package:hously_flutter/widgets/calendar/elevated_button.dart';
import 'package:hously_flutter/widgets/calendar/text_form_field_widget.dart';

class CustomDurationWidget extends ConsumerWidget {
  const CustomDurationWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleAppointmentState = ref.watch(scheduleAppointmentProvider);
    final scheduleData = scheduleAppointmentState.scheduleModel;

    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Custom Duration',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 60,
                  child: TextFormFieldWidget(
                    text: '${scheduleAppointmentState.customDuration}',
                    textInputType: TextInputType.number,
                    textAlign: TextAlign.center,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    inputDecoration: const InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      filled: true,
                      fillColor: Color(0xFFEEEEEE),
                    ),
                    onChanged: (duration) {
                      if (duration.isEmpty) return;
                      scheduleAppointmentState.customDuration =
                          int.parse(duration);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 140,
                  child: DropDownWidget(
                    isDense: false,
                    values: CustomDurationEnum.values,
                    texts: CustomDurationEnum.values
                        .map((value) => value.name)
                        .toList(),
                    currentValue: scheduleAppointmentState.customDurationEnum,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      filled: true,
                      fillColor: Color(0xFFEEEEEE),
                      isDense: true,
                    ),
                    onChanged: (durationType) {
                      if (durationType == null) return;
                      scheduleAppointmentState.customDurationEnum =
                          durationType;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButtonWidget(
                  bgColor: Colors.transparent,
                  elevation: 0,
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTapped: () => ref.read(navigationService).beamPop(),
                ),
                ElevatedButtonWidget(
                  bgColor: Colors.transparent,
                  elevation: 0,
                  child: const Text(
                    'Done',
                    style: TextStyle(color: lightBlue),
                  ),
                  onTapped: () {
                    var newDuration = scheduleAppointmentState.customDuration;

                    if (scheduleAppointmentState.customDurationEnum ==
                        CustomDurationEnum.hours) {
                      newDuration = newDuration * 60;
                    }
                    final newScheduleData = scheduleData.copyWith(
                      appointmentDuration: newDuration,
                    );
                    ref.read(scheduleAppointmentProvider).scheduleModel =
                        newScheduleData;
                    ref.read(navigationService).beamPop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
