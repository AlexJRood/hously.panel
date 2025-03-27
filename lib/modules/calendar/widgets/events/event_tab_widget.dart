import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/theme/style.dart';
import 'package:hously_flutter/modules/calendar/enums/event/repeat_enum.dart';
import 'package:hously_flutter/utils/extensions/string_extension.dart';
import 'package:hously_flutter/modules/calendar/state/appointments_provider.dart';
import 'package:hously_flutter/modules/calendar/state/custom_recurrence_event_provider.dart';
import 'package:hously_flutter/modules/calendar/state/popup_calendar_provider.dart';
import 'package:hously_flutter/routing/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/modules/calendar/widgets/auto_location_field.dart';
import 'package:hously_flutter/modules/calendar/widgets/date_event_widget.dart';
import 'package:hously_flutter/modules/calendar/widgets/event_buttons_widget.dart';
import 'package:hously_flutter/modules/calendar/widgets/events/event_extra_widget.dart';
import 'package:hously_flutter/modules/calendar/widgets/events/event_web_option.dart';
import 'package:hously_flutter/modules/calendar/widgets/events/guest_widget.dart';
import 'package:hously_flutter/modules/calendar/widgets/text_form_field_widget.dart';
import 'package:hously_flutter/modules/calendar/widgets/time_zone_field_widget.dart';

class EventTabWidget extends ConsumerWidget {
  const EventTabWidget({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationController = TextEditingController();
    final popupCalendarWatch = ref.watch(popupCalendarProvider);
    final eventDetails = popupCalendarWatch.event;
    const widgetSpace = 10.0;
    final theme = ref.watch(themeColorsProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: widgetSpace),
        const DateEventWidget(),
        const SizedBox(height: widgetSpace),
        InkWell(
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Add guests',
              style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
            ),
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  backgroundColor: theme.fillColor,
                  content: SizedBox(
                    width: 400,
                    child: GuestSettingWidget(),
                  ),
                );
              },
            );
          },
        ),
        const SizedBox(height: widgetSpace),
        EventWebOption(
          iconData: Icons.video_camera_back_outlined,
          secondWidget: TextFormFieldWidget(
            style: TextStyle(color: theme.textFieldColor),
            text: eventDetails.onlineCallLink,
            autoValidationMode: AutovalidateMode.onUserInteraction,
            inputDecoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromRGBO(0, 0, 0, 0.2),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide.none),
                hintText: 'Add online call link',
                hintStyle: const TextStyle(
                    fontSize: 18, color: Color.fromRGBO(255, 255, 255, 1)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide.none)),
            validator: (url) {
              if (url == null || url.isEmpty) {
                return null;
              }
              if (!url.urlValidation()) {
                return 'Please enter a valid URL';
              }
              return null;
            },
          ),
        ),
        const SizedBox(height: widgetSpace),
        EventWebOption(
          iconData: Icons.location_on_outlined,
          secondWidget: AddLocationWidget(),
        ),
        const SizedBox(height: widgetSpace),
        EventWebOption(
          iconData: Icons.menu,
          secondWidget: TextFormFieldWidget(
            style: const TextStyle(color: Colors.white),
            text: eventDetails.description,
            inputDecoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromRGBO(0, 0, 0, 0.2),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide.none),
                hintText: 'Add description',
                hintStyle: const TextStyle(
                    fontSize: 18, color: Color.fromRGBO(255, 255, 255, 1)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide.none)),
            onChanged: (description) {
              final newEvent = eventDetails.copyWith(description: description);

              ref.read(popupCalendarProvider).event = newEvent;
            },
          ),
        ),
        const SizedBox(height: widgetSpace),
        const EventWebOption(
          iconData: Icons.my_location,
          secondWidget: TimeZoneFieldWidget(),
        ),
        const SizedBox(height: widgetSpace),
        const Divider(thickness: 0.3),
        const SizedBox(height: widgetSpace),
        const EventExtraWidget(inputDecoration: dropdownStyle),
        const SizedBox(height: widgetSpace),
        const Divider(thickness: 0.3),
        const SizedBox(height: widgetSpace),
        EventButtonsWidget(
          onSaved: () {
            if (ref.watch(appointmentsProvider).isEdit) {
              ref
                  .read(appointmentsProvider.notifier)
                  .editEvent(
                    eventDetails.id,
                    eventDetails.title,
                    eventDetails.description,
                    locationController.text,
                  )
                  .whenComplete(
                () {
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
              );
            } else {
              ref
                  .read(appointmentsProvider.notifier)
                  .addEvent(
                    eventDetails.title,
                    eventDetails.description,
                    locationController.text,
                  )
                  .whenComplete(
                () {
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
              );
            }
            var customRecurrence = '';

            if (eventDetails.repeat == RepeatEnum.custom) {
              customRecurrence = ref
                  .read(customRecurrenceEventProvider)
                  .generateRecurrenceRule();
            } else {
              customRecurrence =
                  eventDetails.repeat.recurrenceRule(eventDetails.from);
            }
            ref.read(appointmentsProvider).saveAppointment(
                  context: context,
                  event: eventDetails,
                  index: index,
                  customRecurrence: customRecurrence,
                );

            ref.read(navigationService).beamPop();
          },
        ),
        const SizedBox(height: widgetSpace),
      ],
    );
  }
}
