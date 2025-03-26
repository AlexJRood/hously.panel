import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/data/calendar/event_data.dart';
import 'package:hously_flutter/extensions/context_extension.dart';
import 'package:hously_flutter/state_managers/screen/calendar/appointments_provider.dart';
import 'package:hously_flutter/state_managers/screen/calendar/popup_calendar_provider.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/widgets/calendar/save_event_widget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWidget extends ConsumerStatefulWidget {
  final CalendarController calendarController;

  const CalendarWidget({super.key, required this.calendarController});

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends ConsumerState<CalendarWidget> {
  Offset? downPosition;
  Offset? popUpPosition;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(appointmentsProvider).init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appointmentState = ref.watch(appointmentsProvider);
    final theme = ref.watch(themeColorsProvider);
    final currentthememode = ref.watch(themeProvider);
    final mode = ref.watch(isDefaultDarkSystemProvider);

    return Listener(
      onPointerDown: (event) {
        final position = event.localPosition;

        downPosition = position;
      },
      onPointerUp: (event) => popUpPosition = event.localPosition,
      child: Theme(
        data: (currentthememode == ThemeMode.system ||
                currentthememode == ThemeMode.light)
            ? ThemeData.light().copyWith(
                colorScheme: Theme.of(context).colorScheme,
              )
            : mode
                ? ThemeData.dark()
                : ThemeData.dark().copyWith(
                    colorScheme: Theme.of(context).colorScheme,
                  ),
        child: Container(
          color: theme.popupcontainercolor,
          child: SfCalendar(
            cellBorderColor: theme.textFieldColor.withOpacity(0.5),
            allowAppointmentResize: true,
            controller: widget.calendarController,
            showDatePickerButton: true,
            view: CalendarView.month,
            allowViewNavigation: true,
            allowDragAndDrop: true,
            showNavigationArrow: true,
            viewNavigationMode: ViewNavigationMode.snap,
            showTodayButton: true,
            headerStyle: CalendarHeaderStyle(
              backgroundColor: theme.textFieldColor,
              textStyle: TextStyle(color: theme!.popupcontainertextcolor),
            ),
            weekNumberStyle: WeekNumberStyle(
                textStyle: TextStyle(color: theme!.popupcontainertextcolor)),
            timeSlotViewSettings: TimeSlotViewSettings(
                timeTextStyle:
                    TextStyle(color: theme!.popupcontainertextcolor)),
            viewHeaderStyle: ViewHeaderStyle(
              dayTextStyle: TextStyle(
                color: theme!.popupcontainertextcolor,
                fontWeight: FontWeight.bold,
              ),
            ),
            monthViewSettings: MonthViewSettings(
              monthCellStyle: MonthCellStyle(
                leadingDatesTextStyle: TextStyle(
                  color: theme!.popupcontainertextcolor.withOpacity(0.7),
                  fontSize: 14,
                ),
                textStyle: TextStyle(
                  color: theme!.popupcontainertextcolor,
                  fontSize: 14,
                ),
              ),
            ),
            dataSource: MeetingDataSource(appointmentState.appointments),
            onDragEnd: (details) => appointmentState.onDragEnded(details),
            onTap: (details) {
              if (downPosition != null && downPosition == popUpPosition) {
                if (details.targetElement == CalendarElement.calendarCell) {
                  ref.read(popupCalendarProvider).event = defaultEvent.copyWith(
                      from: details.date, to: details.date);
                  appointmentState.isEdit = false;

                  context.showPopupMenu(
                    relativeRect: RelativeRect.fromLTRB(
                      popUpPosition!.dx,
                      popUpPosition!.dy,
                      popUpPosition!.dx,
                      popUpPosition!.dy,
                    ),
                    boxConstraints: const BoxConstraints.expand(
                      width: 400,
                      height: 450,
                    ),
                    items: [
                      const PopupMenuItem(
                        enabled: false,
                        padding: EdgeInsets.zero,
                        child: SaveEventWidget(index: 0),
                      ),
                    ],
                  );
                } else if (details.targetElement ==
                    CalendarElement.appointment) {
                  final indexAppointment =
                      appointmentState.appointments.indexWhere(
                    (appointment) =>
                        appointment.id == details.appointments!.first.id,
                  );
                  final indexEvent = appointmentState.appointments.indexWhere(
                    (appointment) =>
                        appointment.id == details.appointments!.first.id,
                  );

                  appointmentState.isEdit = true;
                  ref.read(popupCalendarProvider).event =
                      appointmentState.events[indexEvent];
                  context.showPopupMenu(
                    relativeRect: RelativeRect.fromLTRB(
                      popUpPosition!.dx,
                      popUpPosition!.dy,
                      popUpPosition!.dx,
                      popUpPosition!.dy,
                    ),
                    boxConstraints: const BoxConstraints.expand(
                      width: 400,
                      height: 450,
                    ),
                    items: [
                      PopupMenuItem(
                        enabled: false,
                        padding: EdgeInsets.zero,
                        child: SaveEventWidget(index: indexAppointment),
                      ),
                    ],
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
