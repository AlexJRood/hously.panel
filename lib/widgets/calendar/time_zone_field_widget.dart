import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hously_flutter/state_managers/screen/calendar/popup_calendar_provider.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class TimeZoneFieldWidget extends ConsumerStatefulWidget {
  const TimeZoneFieldWidget({super.key});

  @override
  _TimeZoneFieldWidgetState createState() => _TimeZoneFieldWidgetState();
}

class _TimeZoneFieldWidgetState extends ConsumerState<TimeZoneFieldWidget> {
  final controller = TextEditingController();
  var availableTimeZones = <String>[];
  final suggestionCtrl = SuggestionsController();

  @override
  void initState() {
    super.initState();
    _initializeTimeZones();
    controller.text = ref.read(popupCalendarProvider).event.timeZone;
  }

  void _initializeTimeZones() {
    tz.initializeTimeZones();
    availableTimeZones = tz.timeZoneDatabase.locations.keys.toList();
  }

  @override
  Widget build(BuildContext context) {
    final popupCalendarWatch = ref.watch(popupCalendarProvider);
    final eventDetails = popupCalendarWatch.event;
    final theme = ref.watch(themeColorsProvider);
    return TypeAheadField<String>(
      decorationBuilder: (context, child) {
        return Material(
          color: theme.fillColor, // Background color of the suggestion box
          borderRadius: BorderRadius.circular(8),
          elevation: 4,
          child: child, // The child will contain the suggestion list
        );
      },
      controller: controller,
      builder: (context, controller, focusNode) => TextField(
        controller: controller,
        focusNode: focusNode,
        style: DefaultTextStyle.of(context)
            .style
            .copyWith(fontStyle: FontStyle.italic, color: theme.textFieldColor),
        decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromRGBO(0, 0, 0, 0.2),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide:  BorderSide.none),
            hintText: 'Time zone',
            hintStyle: const TextStyle(
                fontSize: 18,
                color: Color.fromRGBO(255, 255, 255, 1)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide.none)),
      ),
      suggestionsCallback: (pattern) => availableTimeZones
          .where(
            (timeZone) =>
                timeZone.toLowerCase().contains(pattern.toLowerCase()),
          )
          .toList(),
      itemBuilder: (context, String suggestion) => ListTile(
          title: Text(
        suggestion,
        style: TextStyle(color: theme.textFieldColor),
      )),
      onSelected: (suggestion) {
        final newEvent = eventDetails.copyWith(timeZone: suggestion);

        ref.read(popupCalendarProvider).event = newEvent;
      },
      emptyBuilder: (context) => Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'No matching time zones found',
          style: TextStyle(color: theme.textFieldColor),
        ),
      ),
    );
  }
}
