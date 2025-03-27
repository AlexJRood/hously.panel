import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/theme/icons.dart';
import 'package:hously_flutter/theme/style.dart';
import 'package:hously_flutter/modules/calendar/enums/event/notification_period_enum.dart';
import 'package:hously_flutter/modules/calendar/state/popup_calendar_provider.dart';
import 'package:hously_flutter/modules/calendar/widgets/dropdown_field_widget.dart';
import 'package:hously_flutter/modules/calendar/widgets/events/event_web_option.dart';
import 'package:hously_flutter/modules/calendar/widgets/text_form_field_widget.dart';

class AddNotificationWidget extends ConsumerWidget {
  const AddNotificationWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final popupCalendarWatch = ref.watch(popupCalendarProvider);
    final eventDetail = popupCalendarWatch.event;

    return EventWebOption(
      iconData: Icons.notifications_outlined,
      crossAxisAlignment: CrossAxisAlignment.start,
      secondWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: eventDetail.reminders.map((reminder) {
              final index = eventDetail.reminders
                  .indexWhere((newReminder) => newReminder.id == reminder.id);

              return Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: TextFormFieldWidget(
                      style: const TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                      text: '${reminder.counter}',
                      textInputType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      inputDecoration: const InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        filled: true,
                        fillColor: Colors.transparent,
                      ),
                      onChanged: (counter) {
                        final newCounter = counter.isEmpty ? '0' : counter;
                        final newReminders = eventDetail.reminders.toList();
                        final newReminder =
                            eventDetail.reminders[index].copyWith(
                          counter: int.parse(newCounter),
                        );

                        newReminders[index] = newReminder;

                        final newEvents = eventDetail.copyWith(
                          reminders: newReminders,
                        );
                        ref.read(popupCalendarProvider).event = newEvents;
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      child: DropDownWidget(
                        texts: NotificationPeriodEnum.values
                            .map((value) => value.name)
                            .toList(),
                        values: NotificationPeriodEnum.values,
                        isExpanded: false,
                        isDense: true,
                        hasUnderLine: true,
                        decoration: dropdownStyle.copyWith(),
                        currentValue: reminder.periodEnum,
                        onChanged: (repeatType) {
                          final newReminders = eventDetail.reminders.toList();
                          final newReminder =
                              eventDetail.reminders[index].copyWith(
                            periodEnum: repeatType,
                          );

                          newReminders[index] = newReminder;

                          final newEvents = eventDetail.copyWith(
                            reminders: newReminders,
                          );
                          ref.read(popupCalendarProvider).event = newEvents;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    child:  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: SvgPicture.asset(AppIcons.close, height: 18,width: 18,),
                    ),
                    onTap: () =>
                        ref.read(popupCalendarProvider).removeAtReminder(index),
                  ),
                ],
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              child: const Text('Add notification',
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
              ),),
              onTap: () => ref.read(popupCalendarProvider).addReminder(),
            ),
          ),
        ],
      ),
    );
  }
}
