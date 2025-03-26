import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/colors.dart';
import 'package:hously_flutter/state_managers/screen/calendar/schedule_appointment_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/widgets/calendar/check_box_text.dart';
import 'package:hously_flutter/widgets/calendar/schedule/schedule_window_widget_dialog.dart';
import 'package:hously_flutter/widgets/calendar/text_form_field_widget.dart';

class SchedulingWindowWidget extends ConsumerWidget {
  const SchedulingWindowWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const widgetSpace = 10.0;
    final scheduleAppointmentState = ref.watch(scheduleAppointmentProvider);
    final scheduleData = scheduleAppointmentState.scheduleModel;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Icon(Icons.swap_horiz),
        ),
        Expanded(
          child: ExpansionTile(
            title: const Text('Scheduling window'),
            subtitle: const Text(
              'Limit the time range that appointments can be booked',
            ),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RadioListTile<bool>(
                title: const Text('Available now'),
                value: true,
                groupValue: scheduleData.isNowAvailable,
                dense: true,
                contentPadding: EdgeInsets.zero,
                activeColor: lightBlue,
                onChanged: (value) {
                  final newScheduleData = scheduleData.copyWith(
                    isNowAvailable: true,
                  );

                  ref.read(scheduleAppointmentProvider).scheduleModel =
                      newScheduleData;
                },
              ),
              RadioListTile<bool>(
                title: const InkWell(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Start and end dates'),
                      Text(
                        'Starts on OCT 15 . Ends on OCT 29',
                        style: TextStyle(
                          color: Color(0xFF424242),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                value: false,
                groupValue: scheduleData.isNowAvailable,
                activeColor: lightBlue,
                contentPadding: EdgeInsets.zero,
                dense: true,
                onChanged: (value) {
                  final newScheduleData = scheduleData.copyWith(
                    isNowAvailable: false,
                  );

                  ref.read(scheduleAppointmentProvider).scheduleModel =
                      newScheduleData;
                },
              ),
              if (!scheduleData.isNowAvailable)
                const SizedBox(height: widgetSpace),
              if (!scheduleData.isNowAvailable)
                InkWell(
                  child: const Text(
                    'Change dates',
                    style: TextStyle(color: lightBlue),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: ScheduleWindowWidgetDialog(
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
                  },
                ),
              const SizedBox(height: 20),
              const Text(
                'Maximum time in advance that an appointment can be booked',
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(height: widgetSpace),
              CheckBoxText(
                isActive: scheduleData.hasDays,
                title: 'Test',
                titleWidget: SizedBox(
                  width: 200,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: TextFormFieldWidget(
                          text: '${scheduleData.maxDays}',
                          textInputType: TextInputType.number,
                          readOnly: !scheduleData.hasDays,
                          style: TextStyle(
                            color: scheduleData.hasDays
                                ? Colors.black
                                : Colors.grey,
                          ),
                          inputDecoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            filled: true,
                            fillColor: scheduleData.hasDays
                                ? const Color(0xFFEEEEEE)
                                : const Color(0xFFFAFAFA),
                          ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (maxDays) {
                            if (maxDays.isEmpty) return;

                            final newScheduleData = scheduleData.copyWith(
                              maxDays: int.parse(maxDays),
                            );

                            ref
                                .read(scheduleAppointmentProvider)
                                .scheduleModel = newScheduleData;
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text('days'),
                    ],
                  ),
                ),
                onChanged: (hasDays) {
                  final newScheduleData =
                      scheduleData.copyWith(hasDays: hasDays);

                  ref.read(scheduleAppointmentProvider).scheduleModel =
                      newScheduleData;
                },
              ),
              const SizedBox(height: widgetSpace),
              const Text(
                'Minimum time before the appointment start that it can be booked',
                style: TextStyle(fontSize: 13),
              ),
              const SizedBox(height: widgetSpace),
              CheckBoxText(
                isActive: scheduleData.hasHours,
                title: 'Test',
                titleWidget: SizedBox(
                  width: 200,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: TextFormFieldWidget(
                          text: '${scheduleData.minHours}',
                          textInputType: TextInputType.number,
                          readOnly: !scheduleData.hasHours,
                          style: TextStyle(
                            color: scheduleData.hasHours
                                ? Colors.black
                                : Colors.grey,
                          ),
                          inputDecoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            filled: true,
                            fillColor: scheduleData.hasHours
                                ? const Color(0xFFEEEEEE)
                                : const Color(0xFFFAFAFA),
                          ),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (minHours) {
                            if (minHours.isEmpty) return;

                            final newScheduleData = scheduleData.copyWith(
                              minHours: int.parse(minHours),
                            );

                            ref
                                .read(scheduleAppointmentProvider)
                                .scheduleModel = newScheduleData;
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text('hours'),
                    ],
                  ),
                ),
                onChanged: (hasHours) {
                  final newScheduleData =
                      scheduleData.copyWith(hasHours: hasHours);

                  ref.read(scheduleAppointmentProvider).scheduleModel =
                      newScheduleData;
                },
              ),
              const SizedBox(height: widgetSpace),
            ],
          ),
        ),
      ],
    );
  }
}
