import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/colors.dart';
import 'package:hously_flutter/enums/decline_meeting_enum.dart';
import 'package:hously_flutter/state_managers/screen/calendar/out_office_provider.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/widgets/calendar/check_box_text.dart';
import 'package:hously_flutter/widgets/calendar/date_event_widget.dart';
import 'package:hously_flutter/widgets/calendar/event_buttons_widget.dart';
import 'package:hously_flutter/widgets/calendar/events/event_web_option.dart';
import 'package:hously_flutter/widgets/calendar/text_form_field_widget.dart';

class OutOfficeTabWidget extends ConsumerWidget {
  OutOfficeTabWidget({super.key});

  String? selectedOption = 'Option 1';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final outOfficeState = ref.watch(outOfficeProvider);
    final outOffice = outOfficeState.outOffice;
    const widgetSpace = 10.0;
    final theme = ref.watch(themeColorsProvider);
    return Column(
      children: [
        const SizedBox(height: widgetSpace),
        const DateEventWidget(),
        const SizedBox(height: widgetSpace),
        CheckBoxText(
          isActive: outOffice.autoCancel,
          title: 'Automatically decline meetings',
          fontSize: 15,
          onChanged: (isAuto) {
            final newOutOffice = outOffice.copyWith(autoCancel: isAuto);

            ref.read(outOfficeProvider).outOffice = newOutOffice;
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 23.0),
          child: RadioListTile<DeclineMeetingEnum>(
            title: Text(DeclineMeetingEnum.newMeetings.type),
            value: DeclineMeetingEnum.newMeetings,
            groupValue: outOffice.declineMeeting,
            dense: true,
            activeColor: Theme.of(context).primaryColor,
            onChanged: (value) {
              final newOutOffice = outOffice.copyWith(
                  declineMeeting: value as DeclineMeetingEnum);

              ref.read(outOfficeProvider).outOffice = newOutOffice;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 23.0),
          child: RadioListTile<DeclineMeetingEnum>(
            title: Text(DeclineMeetingEnum.allMeetings.type),
            value: DeclineMeetingEnum.allMeetings,
            groupValue: outOffice.declineMeeting,
            activeColor: Theme.of(context).primaryColor,
            dense: true,
            onChanged: (value) {
              final newOutOffice = outOffice.copyWith(
                  declineMeeting: value as DeclineMeetingEnum);

              ref.read(outOfficeProvider).outOffice = newOutOffice;
            },
          ),
        ),
        const SizedBox(height: widgetSpace),
        const Divider(thickness: 0.3),
        const SizedBox(height: widgetSpace),
        EventWebOption(
          iconData: Icons.message,
          secondWidget: TextFormFieldWidget(
            style: TextStyle(color: theme.textFieldColor),
            text: outOffice.message,
            inputDecoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: 'Message',
            ),
          ),
        ),
        const SizedBox(height: widgetSpace),
        const Divider(thickness: 0.3),
        const SizedBox(height: widgetSpace),
        EventButtonsWidget(
          onSaved: () {},
        ),
        const SizedBox(height: widgetSpace),
      ],
    );
  }
}
