import 'package:flutter/material.dart';
import 'package:hously_flutter/extensions/context_extension.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void showCalendarPopup({
  required TapDownDetails event,
  required BuildContext context,
  required DateTime minDate,
  required CalendarSelectionChangedCallback onSelectionChanged,
}) {
  final position = event.globalPosition;
  const calendarWidth = 300.0;
  const calendarHeight = 300.0;

  context.showPopupMenu(
    relativeRect: RelativeRect.fromLTRB(
      position.dx,
      position.dy,
      position.dx,
      position.dy,
    ),
    boxConstraints: const BoxConstraints.expand(
      width: calendarWidth,
      height: calendarHeight,
    ),
    items: [
      PopupMenuItem(
        enabled: false,
        padding: EdgeInsets.zero,
        child: SizedBox(
          width: calendarWidth,
          height: calendarHeight,
          child: SfCalendar(
            cellEndPadding: 0,
            showTodayButton: true,
            view: CalendarView.month,
            showDatePickerButton: true,
            showNavigationArrow: true,
            initialDisplayDate: minDate,
            minDate: minDate,
            onSelectionChanged: onSelectionChanged,
          ),
        ),
      ),
    ],
  );
}
