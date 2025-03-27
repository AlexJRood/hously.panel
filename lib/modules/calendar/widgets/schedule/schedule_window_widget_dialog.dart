import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/theme/colors.dart';
import 'package:hously_flutter/widgets/language/values.dart';
import 'package:hously_flutter/modules/calendar/dialogs/calendar_popup.dart';
import 'package:hously_flutter/modules/calendar/state/schedule_appointment_provider.dart';
import 'package:hously_flutter/routing/navigation_service.dart';
import 'package:hously_flutter/modules/calendar/widgets/elevated_button.dart';
import 'package:hously_flutter/modules/calendar/widgets/text_form_field_widget.dart';

class ScheduleWindowWidgetDialog extends ConsumerWidget {
  final VoidCallback onCanceled;
  final VoidCallback onApproved;

  const ScheduleWindowWidgetDialog({
    required this.onCanceled,
    required this.onApproved,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleAppointmentState = ref.watch(scheduleAppointmentProvider);
    final scheduleData = scheduleAppointmentState.scheduleModel;
    final startDate = scheduleData.startScheduleDate;
    final endDate = scheduleData.endScheduleDate;

    return Container(
      padding: const EdgeInsets.all(16.0),
      width: 380,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Scheduling window start and end dates',
              style: TextStyle(color: Colors.black, fontSize: 17),
            ),
            const SizedBox(height: 15),
            const Text('Starts'),
            const SizedBox(height: 10),
            SizedBox(
              width: 160,
              child: InkWell(
                child: Row(
                  children: [
                    if (scheduleData.isScheduleNow)
                      const Icon(Icons.radio_button_checked, color: lightBlue)
                    else
                      const Icon(Icons.radio_button_off),
                    const SizedBox(width: 15),
                    const Text('Now'),
                  ],
                ),
                onTap: () {
                  final newScheduleData = scheduleData.copyWith(
                    isScheduleNow: true,
                  );

                  ref.read(scheduleAppointmentProvider).scheduleModel =
                      newScheduleData;
                },
              ),
            ),
            SizedBox(
              width: 170,
              child: InkWell(
                child: Row(
                  children: [
                    if (!scheduleData.isScheduleNow)
                      const Icon(Icons.radio_button_checked, color: lightBlue)
                    else
                      const Icon(Icons.radio_button_off),
                    const SizedBox(width: 15),
                    Expanded(
                      child: TextFormFieldWidget(
                        text:
                            '${CalendarConst.monthsName[startDate.month - 1].substring(0, 3)} ${startDate.day},${startDate.year}',
                        textInputType: TextInputType.number,
                        readOnly: true,
                        style: TextStyle(
                          color: !scheduleData.isScheduleNow
                              ? Colors.black
                              : Colors.grey,
                        ),
                        inputDecoration: InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          filled: true,
                          hoverColor: Colors.transparent,
                          fillColor: !scheduleData.isScheduleNow
                              ? const Color(0xFFEEEEEE)
                              : const Color(0xFFFAFAFA),
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  ],
                ),
                onTapDown: (event) {
                  final newScheduleData1 = scheduleData.copyWith(
                    isScheduleNow: false,
                  );
                  ref.read(scheduleAppointmentProvider).scheduleModel =
                      newScheduleData1;
                  showCalendarPopup(
                    context: context,
                    event: event,
                    minDate: DateTime.now(),
                    onSelectionChanged: (details) {
                      final detailsDate = details.date!;
                      debugPrint('Mahdi: test: 2: ${detailsDate}');
                      final newScheduleData2 = scheduleData.copyWith(
                        isScheduleNow: false,
                        startScheduleDate: DateTime(
                          detailsDate.year,
                          detailsDate.month,
                          detailsDate.day,
                        ),
                      );
                      debugPrint(
                          'Mahdi: test: 3: ${newScheduleData2.startScheduleDate}');

                      ref.read(scheduleAppointmentProvider).scheduleModel =
                          newScheduleData2;
                      debugPrint(
                          'Mahdi: test: 4: ${newScheduleData2.startScheduleDate}');

                      ref.read(navigationService).beamPop();
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
            const Text('Ends'),
            const SizedBox(height: 10),
            SizedBox(
              width: 160,
              child: InkWell(
                child: Row(
                  children: [
                    if (scheduleData.isScheduleNever)
                      const Icon(Icons.radio_button_checked, color: lightBlue)
                    else
                      const Icon(Icons.radio_button_off),
                    const SizedBox(width: 15),
                    const Text('Never'),
                  ],
                ),
                onTap: () {
                  final newScheduleData = scheduleData.copyWith(
                    isScheduleNever: true,
                  );

                  ref.read(scheduleAppointmentProvider).scheduleModel =
                      newScheduleData;
                },
              ),
            ),
            SizedBox(
              width: 170,
              child: InkWell(
                child: Row(
                  children: [
                    if (!scheduleData.isScheduleNever)
                      const Icon(Icons.radio_button_checked, color: lightBlue)
                    else
                      const Icon(Icons.radio_button_off),
                    const SizedBox(width: 15),
                    Expanded(
                      child: TextFormFieldWidget(
                        text:
                            '${CalendarConst.monthsName[endDate.month - 1].substring(0, 3)} ${endDate.day},${endDate.year}',
                        textInputType: TextInputType.number,
                        readOnly: true,
                        style: TextStyle(
                          color: !scheduleData.isScheduleNever
                              ? Colors.black
                              : Colors.grey,
                        ),
                        inputDecoration: InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          filled: true,
                          hoverColor: Colors.transparent,
                          fillColor: !scheduleData.isScheduleNever
                              ? const Color(0xFFEEEEEE)
                              : const Color(0xFFFAFAFA),
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  ],
                ),
                onTapDown: (event) {
                  final newScheduleData1 = scheduleData.copyWith(
                    isScheduleNever: false,
                  );

                  ref.read(scheduleAppointmentProvider).scheduleModel =
                      newScheduleData1;
                  showCalendarPopup(
                    context: context,
                    event: event,
                    minDate: scheduleData.startScheduleDate,
                    onSelectionChanged: (details) {
                      final detailsDate = details.date!;
                      final newScheduleData2 = newScheduleData1.copyWith(
                        endScheduleDate: DateTime(
                          detailsDate.year,
                          detailsDate.month,
                          detailsDate.day,
                        ),
                      );

                      ref.read(scheduleAppointmentProvider).scheduleModel =
                          newScheduleData2;
                      ref.read(navigationService).beamPop();
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                const Spacer(),
                ElevatedButtonWidget(
                  bgColor: Colors.transparent,
                  elevation: 0,
                  onTapped: onCanceled,
                  child: const Text('Cancel'),
                ),
                const SizedBox(width: 10),
                ElevatedButtonWidget(
                  onTapped: onApproved,
                  child: const Text(
                    'Done',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
