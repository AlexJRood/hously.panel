import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/style.dart';
import 'package:hously_flutter/dialogs/calendar_popup.dart';
import 'package:hously_flutter/enums/event/repeat_enum.dart';
import 'package:hously_flutter/state_managers/screen/calendar/popup_calendar_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/widgets/calendar/dropdown_field_widget.dart';
import 'package:hously_flutter/widgets/calendar/events/custom_recurrence_event_widget.dart';
import 'package:hously_flutter/widgets/calendar/events/event_web_option.dart';

class DateEventWidget extends ConsumerWidget {
  const DateEventWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventDetails = ref.watch(popupCalendarProvider).event;
    final fromDate = eventDetails.from;
    final fromText = '${fromDate.day}/${fromDate.month}/${fromDate.year}';
    final fromHour = '${fromDate.hour}:${fromDate.minute}';
    final toDate = eventDetails.to;
    final toText = '${toDate.day}/${toDate.month}/${toDate.year}';
    final toHour = '${toDate.hour}:${toDate.minute}';
    final theme = ref.watch(themeColorsProvider);
    
    return EventWebOption(
      crossAxisAlignment: CrossAxisAlignment.start,
      iconData: Icons.watch_later_outlined,
      secondWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                child: Text(
                  fromText,
                  style: TextStyle(color: theme.textFieldColor),
                ),
                onTapDown: (event) => showCalendarPopup(
                  context: context,
                  event: event,
                  minDate: DateTime.now(),
                  onSelectionChanged: (details) {
                    final detailsDate = details.date!;
                    final newEvent = eventDetails.copyWith(
                        from: DateTime(
                      detailsDate.year,
                      detailsDate.month,
                      detailsDate.day,
                    ));

                    ref.read(popupCalendarProvider).event = newEvent;
                    ref.read(navigationService).beamPop();
                  },
                ),
              ),
              const Text(' '),
              InkWell(
                child: Text(
                  fromHour,
                  style: TextStyle(color: theme.textFieldColor),
                ),
                onTap: () async {
                  final selectedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      ) ??
                      TimeOfDay.now();
                  final newEvent = eventDetails.copyWith(
                      from: DateTime(
                    eventDetails.from.year,
                    eventDetails.from.month,
                    eventDetails.from.day,
                    selectedTime.hour,
                    selectedTime.minute,
                  ));

                  ref.read(popupCalendarProvider).event = newEvent;
                },
              ),
              const Text(' - '),
              InkWell(
                child: Text(
                  toText,
                  style: TextStyle(color: theme.textFieldColor),
                ),
                onTapDown: (event) => showCalendarPopup(
                  context: context,
                  event: event,
                  minDate: eventDetails.from,
                  onSelectionChanged: (details) {
                    final detailsDate = details.date!;
                    final newEvent = eventDetails.copyWith(
                        to: DateTime(
                      detailsDate.year,
                      detailsDate.month,
                      detailsDate.day,
                    ));

                    ref.read(popupCalendarProvider).event = newEvent;
                    ref.read(navigationService).beamPop();
                  },
                ),
              ),
              const Text(' '),
              InkWell(
                child: Text(toHour,style: TextStyle(color: theme.textFieldColor),),
                onTap: () async {
                  final selectedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      ) ??
                      TimeOfDay.now();
                  final newEvent = eventDetails.copyWith(
                      to: DateTime(
                    eventDetails.to.year,
                    eventDetails.to.month,
                    eventDetails.to.day,
                    selectedTime.hour,
                    selectedTime.minute,
                  ));

                  ref.read(popupCalendarProvider).event = newEvent;
                },
              ),
            ],
          ),
          DropDownWidget<RepeatEnum>(
            texts: RepeatEnum.values.map((value) => value.name).toList(),
            values: RepeatEnum.values,
            isExpanded: false,
            hasUnderLine: true,
            decoration: dropdownStyle,
            currentValue: eventDetails.repeat,
            onChanged: (repeatType) {
              final newEvent = eventDetails.copyWith(repeat: repeatType);

              ref.read(popupCalendarProvider).event = newEvent;
              if (repeatType == RepeatEnum.custom) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(backgroundColor: theme.fillColor,
                      child: CustomRecurrenceEventWidget(
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
        ],
      ),
    );
  }
}
