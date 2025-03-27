import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/theme/style.dart';
import 'package:hously_flutter/modules/calendar/dialogs/calendar_popup.dart';
import 'package:hously_flutter/modules/calendar/enums/event/repeat_enum.dart';
import 'package:hously_flutter/modules/calendar/state/popup_calendar_provider.dart';
import 'package:hously_flutter/routing/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/modules/calendar/widgets/dropdown_field_widget.dart';
import 'package:hously_flutter/modules/calendar/widgets/events/custom_recurrence_event_widget.dart';
import 'package:hously_flutter/modules/calendar/widgets/events/event_web_option.dart';

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
    
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Starts",
              style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontSize: 14,
                  fontWeight: FontWeight.w700
              ),),
            Row(
              children: [
                InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 12),
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.2),
                        borderRadius: BorderRadius.all(Radius.circular(6))
                    ),
                    child: Row(
                      spacing: 20,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          fromText,
                          style: const TextStyle(color: Color.fromRGBO(145, 145, 145, 1)),
                        ),
                        const Icon(Icons.date_range,
                            size: 15,
                            color:  Color.fromRGBO(145, 145, 145, 1)
                        )
                      ],
                    ),
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
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 12),
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.2),
                        borderRadius: BorderRadius.all(Radius.circular(6))
                    ),
                    child: Row(
                      spacing: 20,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          fromHour,
                          style: const TextStyle(color: Color.fromRGBO(145, 145, 145, 1)),
                        ),
                        const Icon(Icons.watch_later_outlined,
                            size: 15,
                            color:  Color.fromRGBO(145, 145, 145, 1)
                        )
                      ],
                    ),
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
              ],
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Ends",
              style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontSize: 14,
                  fontWeight: FontWeight.w700
              ),),
            Row(
              children: [
                InkWell(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 12),
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.2),
                        borderRadius: BorderRadius.all(Radius.circular(6))
                    ),
                    child: Row(
                      spacing: 20,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          toText,
                          style: const TextStyle(color: Color.fromRGBO(145, 145, 145, 1)),
                        ),
                        const Icon(Icons.date_range,
                            size: 15,
                            color:  Color.fromRGBO(145, 145, 145, 1)
                        )
                      ],
                    ),
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
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 12),
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.2),
                        borderRadius: BorderRadius.all(Radius.circular(6))
                    ),
                    child: Row(
                      spacing: 20,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          toHour,
                          style: const TextStyle(color: Color.fromRGBO(145, 145, 145, 1)),
                        ),
                        const Icon(Icons.watch_later_outlined,
                            size: 15,
                            color:  Color.fromRGBO(145, 145, 145, 1)
                        )
                      ],
                    ),
                  ),
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
            )
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
    );
  }
}
