import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hously_flutter/routing/route_constant.dart';
import 'package:hously_flutter/modules/calendar/event_option.dart';
import 'package:hously_flutter/routing/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/modules/calendar/calendar/bottom_sheet_date_picker.dart';
import 'package:hously_flutter/modules/calendar/widgets/dropdown_field_widget.dart';
import 'package:hously_flutter/modules/calendar/widgets/event_input_decoration.dart';
import 'package:hously_flutter/modules/calendar/widgets/list_tile_option.dart';
import 'package:hously_flutter/modules/calendar/widgets/text_form_field_widget.dart';

class EventWidget extends ConsumerWidget {
  const EventWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeColorsProvider);
    final detailsTextStyle = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 17, color: theme.textFieldColor);

    return EventOption(
      title: 'Event',
      pageWidget: Column(
        children: [
          const Divider(thickness: 0.3),
          const SizedBox(height: 10),
          TextFormFieldWidget(
            style: TextStyle(color: theme.textFieldColor),
            text: '',
            inputDecoration: eventInputDecoration('Event name', theme),
          ),
          const SizedBox(height: 10),
          ListTile(
            title: Text('All day', style: detailsTextStyle),
            onTap: () {},
            contentPadding: EdgeInsets.zero,
            trailing: SizedBox(
              width: 40,
              child: FlutterSwitch(
                activeColor: Theme.of(context).primaryColor,
                height: 20,
                width: 40,
                padding: 1,
                toggleSize: 20,
                valueFontSize: 0,
                value: true,
                borderRadius: 30.0,
                showOnOff: true,
                onToggle: (pricingChanged) {},
              ),
            ),
            minLeadingWidth: 20,
          ),
          ListTileOption(
            title: 'From',
            details: 'Wed, October 09, 2024 10:49 AM',
            onTapped: () {
              showDateModal(
                title: 'From',
                context: context,
                onDateTimeChanged: (datetime) {},
                initialDate: DateTime.now(),
              );
            },
          ),
          ListTileOption(
            title: 'To',
            details: 'Wed, October 09, 2024 10:49 AM',
            onTapped: () {
              showDateModal(
                title: 'To',
                context: context,
                onDateTimeChanged: (datetime) {},
                initialDate: DateTime.now(),
              );
            },
          ),
          ListTileOption(
            title: 'Repeat',
            details: 'One-time event',
            onTapped: () => ref.read(navigationService).pushNamedScreen(
                  Routes.repeatWidget,
                ),
          ),
          const SizedBox(height: 10),
          const Divider(thickness: 0.3),
          const SizedBox(height: 10),
          ListTileOption(
            title: 'Reminders',
            details: '5 minutes before',
            onTapped: () {},
          ),
          const SizedBox(height: 10),
          const Divider(thickness: 0.3),
          const SizedBox(height: 10),
          ListTileOption(
            title: 'Account',
            details: 'Mobile',
            onTapped: () {},
          ),
          ListTileOption(
            title: 'Time zone',
            details: '(GMT+4:30) Kabul',
            onTapped: () {},
          ),
          const SizedBox(height: 10),
          const Divider(thickness: 0.3),
          const SizedBox(height: 10),
          ListTileOption(
            title: 'Add guests',
            details: '1 person',
            onTapped: () => ref.read(navigationService).pushNamedScreen(
                  Routes.repeatWidget,
                ),
          ),
          const SizedBox(height: 10),
          const Divider(thickness: 0.3),
          const SizedBox(height: 10),
          TextFormFieldWidget(
            text: '',
            inputDecoration: eventInputDecoration('Online call link', theme),
          ),
          const SizedBox(height: 15),
          TextFormFieldWidget(
            text: '',
            inputDecoration: eventInputDecoration('Location', theme),
          ),
          const SizedBox(height: 15),
          TextFormFieldWidget(
            text: '',
            inputDecoration: eventInputDecoration('Descripiton', theme),
          ),
          const SizedBox(height: 10),
          const Divider(thickness: 0.3),
          const SizedBox(height: 10),
          DropDownWidget<String>(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: theme.textFieldColor, width: 2)),
              border: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: theme.textFieldColor, width: 2)),
              disabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: theme.textFieldColor, width: 2)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: theme.textFieldColor, width: 2)),
              filled: true,
              fillColor: theme.fillColor.withOpacity(0.1),
            ),
            currentValue: 'Free',
            texts: const ['Free', 'Busy'],
            values: const ['Free', 'Busy'],
            onChanged: (type) {},
          ),
          const SizedBox(height: 15),
          DropDownWidget<String>(
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: theme.textFieldColor, width: 2)),
              border: InputBorder.none,
              disabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              filled: true,
              fillColor: theme.fillColor,
            ),
            currentValue: 'Default visibility',
            texts: const ['Default visibility', 'Public', 'Private'],
            values: const ['Default visibility', 'Public', 'Private'],
            onChanged: (type) {},
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
    // Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     const SizedBox(height: 8),
    //     Row(
    //       children: [
    //         IconButton(
    //           onPressed: () {
    //             Navigator.pop(context);
    //           },
    //           icon: const Icon(Icons.close),
    //         ),
    //         const Spacer(),
    //         IconButton(
    //           onPressed: () {},
    //           icon: const Icon(Icons.check),
    //         ),
    //       ],
    //     ),
    //     Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 12),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           const SizedBox(height: 10),
    //           const Text('Event', style: TextStyle(fontSize: 20)),
    //           const SizedBox(height: 10),
    //
    //         ],
    //       ),
    //     ),
    //   ],
    // );
  }
}
// Automatic property / transaction assignment on agent's side
//   Link to the offer
//   Preview of the offer with key metrics and the main photo
