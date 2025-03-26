import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/style.dart';
import 'package:hously_flutter/enums/event/repeat_enum.dart';
import 'package:hously_flutter/extensions/string_extension.dart';
import 'package:hously_flutter/state_managers/screen/calendar/appointments_provider.dart';
import 'package:hously_flutter/state_managers/screen/calendar/custom_recurrence_event_provider.dart';
import 'package:hously_flutter/state_managers/screen/calendar/popup_calendar_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/widgets/calendar/auto_location_field.dart';
import 'package:hously_flutter/widgets/calendar/date_event_widget.dart';
import 'package:hously_flutter/widgets/calendar/event_buttons_widget.dart';
import 'package:hously_flutter/widgets/calendar/events/event_extra_widget.dart';
import 'package:hously_flutter/widgets/calendar/events/event_web_option.dart';
import 'package:hously_flutter/widgets/calendar/events/guest_widget.dart';
import 'package:hously_flutter/widgets/calendar/text_form_field_widget.dart';
import 'package:hously_flutter/widgets/calendar/time_zone_field_widget.dart';

class EventTabWidget extends ConsumerWidget {
  const EventTabWidget({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final popupCalendarWatch = ref.watch(popupCalendarProvider);
    final eventDetails = popupCalendarWatch.event;
    const widgetSpace = 10.0;
    final theme = ref.watch(themeColorsProvider);
    return Column(
      children: [
        const SizedBox(height: widgetSpace),
        const DateEventWidget(),
        const SizedBox(height: widgetSpace),
        EventWebOption(
          iconData: Icons.group_outlined,
          secondWidget: InkWell(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Add guests',
                style: TextStyle(color: theme.textFieldColor),
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
        ),
        const SizedBox(height: widgetSpace),
        EventWebOption(
          iconData: Icons.video_camera_back_outlined,
          secondWidget: TextFormFieldWidget(
            style: TextStyle(color: theme.textFieldColor),
            text: eventDetails.onlineCallLink,
            autoValidationMode: AutovalidateMode.onUserInteraction,
            inputDecoration: InputDecoration(
              border: UnderlineInputBorder(),
              hintText: 'Add online call link',
              hintStyle: TextStyle(color: theme.textFieldColor),
            ),
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
            style: TextStyle(color: theme.textFieldColor),
            text: eventDetails.description,
            inputDecoration: InputDecoration(
              border: UnderlineInputBorder(),
              hintText: 'Add description',
              hintStyle: TextStyle(color: theme.textFieldColor),
            ),
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
