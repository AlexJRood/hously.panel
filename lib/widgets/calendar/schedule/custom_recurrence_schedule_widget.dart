import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/colors.dart';
import 'package:hously_flutter/const/values.dart';
import 'package:hously_flutter/dialogs/calendar_popup.dart';
import 'package:hously_flutter/state_managers/screen/calendar/custom_recurrence_schedule_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/widgets/calendar/elevated_button.dart';
import 'package:hously_flutter/widgets/calendar/text_form_field_widget.dart';

class CustomRecurrenceScheduleWidget extends ConsumerWidget {
  final VoidCallback onCanceled;
  final VoidCallback onApproved;

  const CustomRecurrenceScheduleWidget({
    required this.onCanceled,
    required this.onApproved,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customRecurrenceState = ref.watch(customRecurrenceScheduleProvider);

    return Container(
      padding: const EdgeInsets.all(16.0),
      width: 210,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Custom Recurrence',
              style: TextStyle(color: Colors.black, fontSize: 17),
            ),
            const SizedBox(height: 15),
            SizedBox(
              width: 200,
              height: 60,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormFieldWidget(
                      text: '1',
                      textInputType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      inputDecoration: const InputDecoration(
                        labelText: 'Repeat every',
                      ),
                      onChanged: (value) => customRecurrenceState.interval =
                          int.tryParse(value) ?? 1,
                    ),
                  ),
                  const SizedBox(width: 20),
                  const Text('weeks'),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text('Ends'),
            RadioListTile<bool>(
              title: Text(
                'Never',
                style: TextStyle(
                  color: customRecurrenceState.hasEnd ? null : Colors.grey,
                ),
              ),
              value: true,
              groupValue: customRecurrenceState.hasEnd,
              dense: true,
              contentPadding: EdgeInsets.zero,
              activeColor: lightBlue,
              onChanged: (value) => customRecurrenceState.hasEnd = true,
            ),
            RadioListTile<bool>(
              title: InkWell(
                child: Text(
                  '${CalendarConst.monthsName[customRecurrenceState.endDate.month - 1]} ${customRecurrenceState.endDate.day},${customRecurrenceState.endDate.year}',
                  style: TextStyle(
                    color: customRecurrenceState.hasEnd ? Colors.grey : null,
                  ),
                ),
                onTapDown: (event) => showCalendarPopup(
                  context: context,
                  event: event,
                  minDate: DateTime.now(),
                  onSelectionChanged: (details) {
                    if (details.date != null) {
                      customRecurrenceState.endDate = details.date!;
                    }
                    ref.read(navigationService).beamPop();
                  },
                ),
              ),
              value: false,
              groupValue: customRecurrenceState.hasEnd,
              activeColor: lightBlue,
              contentPadding: EdgeInsets.zero,
              dense: true,
              onChanged: (value) => customRecurrenceState.hasEnd = false,
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
