import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/modules/calendar/data/event_data.dart';
import 'package:hously_flutter/utils/extensions/context_extension.dart';
import 'package:hously_flutter/modules/calendar/state/appointments_provider.dart';
import 'package:hously_flutter/modules/calendar/state/popup_calendar_provider.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/modules/calendar/widgets/save_event_widget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarWidget extends ConsumerStatefulWidget {
  final CalendarController calendarController;
  final bool isMobile;

  const CalendarWidget(
      {super.key, required this.calendarController, this.isMobile = false});

  @override
  CalendarWidgetState createState() => CalendarWidgetState();
}

class CalendarWidgetState extends ConsumerState<CalendarWidget> {
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

    return Theme(
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
        color: widget.isMobile
            ? const Color.fromRGBO(41, 41, 41, 1)
            : Colors.black,
        child: SfCalendar(
          todayHighlightColor: const Color.fromRGBO(87, 148, 221, 0.4),
          cellBorderColor: theme.textFieldColor.withOpacity(0.5),
          allowAppointmentResize: true,
          backgroundColor: widget.isMobile
              ? const Color.fromRGBO(41, 41, 41, 1)
              : const Color.fromRGBO(19, 19, 19, 1),
          controller: widget.calendarController,
          showDatePickerButton: true,
          view: CalendarView.month,
          allowViewNavigation: false,
          allowDragAndDrop: true,
          showNavigationArrow: widget.isMobile ? false : true,
          viewNavigationMode: ViewNavigationMode.snap,
          showTodayButton: widget.isMobile ? true : false,
          todayTextStyle:
              const TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
          headerStyle: const CalendarHeaderStyle(
            backgroundColor: Colors.transparent,
            textStyle: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1), fontSize: 16),
          ),
          weekNumberStyle: WeekNumberStyle(
              textStyle: TextStyle(color: theme.popupcontainertextcolor)),
          timeSlotViewSettings: TimeSlotViewSettings(
              timeTextStyle: TextStyle(color: theme.popupcontainertextcolor)),
          viewHeaderStyle: const ViewHeaderStyle(
            dayTextStyle: TextStyle(
              color: Color.fromRGBO(145, 145, 145, 1),
              fontWeight: FontWeight.bold,
            ),
          ),
          monthViewSettings: MonthViewSettings(
            monthCellStyle: MonthCellStyle(
              leadingDatesTextStyle: TextStyle(
                color: theme.popupcontainertextcolor.withOpacity(0.7),
                fontSize: 14,
              ),
              textStyle: TextStyle(
                color: theme.popupcontainertextcolor,
                fontSize: 14,
              ),
            ),
          ),
          dataSource: MeetingDataSource(appointmentState.appointments),
          onDragEnd: (details) => appointmentState.onDragEnded(details),
          onTap: (details) {},
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

class CalendarHoursWidget extends ConsumerStatefulWidget {
  final CalendarController calendarController;
  final bool isMobile;

  const CalendarHoursWidget({
    super.key,
    required this.calendarController,
    this.isMobile = false,
  });

  @override
  CalendarHoursWidgetState createState() => CalendarHoursWidgetState();
}

class CalendarHoursWidgetState extends ConsumerState<CalendarHoursWidget> {
  Offset? popUpPosition;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = ref.read(appointmentsProvider);
      provider.init(context);
      await provider.fetchEvents(ref);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appointmentState = ref.watch(appointmentsProvider);

    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        // Save the tap position for the popup
        setState(() {
          popUpPosition = details.globalPosition;
        });
      },
      child: Container(
        color: widget.isMobile
            ? const Color.fromRGBO(33, 32, 32, 1)
            : const Color.fromRGBO(35, 35, 35, 1),
        child: SfCalendar(
          controller: widget.calendarController,
          view: CalendarView.day,
          timeSlotViewSettings: const TimeSlotViewSettings(
            timeInterval: Duration(hours: 1),
            timeFormat: 'h a',
            timeTextStyle: TextStyle(
              color: Color.fromRGBO(233, 233, 233, 1),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          todayHighlightColor: const Color.fromRGBO(87, 148, 221, 0.4),
          backgroundColor: const Color.fromRGBO(35, 35, 35, 1),
          cellBorderColor: const Color.fromRGBO(79, 79, 79, 1),
          showNavigationArrow: widget.isMobile ? false : true,
          allowAppointmentResize: widget.isMobile ? false : true,
          showDatePickerButton: widget.isMobile ? false : true,
          showCurrentTimeIndicator: widget.isMobile ? false : true,
          allowViewNavigation: true,
          allowDragAndDrop: true,
          showTodayButton: widget.isMobile ? false : true,
          headerHeight: widget.isMobile ? 0 : 40,
          headerStyle: CalendarHeaderStyle(
            backgroundColor: widget.isMobile
                ? Colors.transparent
                : const Color.fromRGBO(19, 19, 19, 1),
            textStyle: TextStyle(
                color: widget.isMobile ? Colors.transparent : Colors.white,
                fontSize: 18),
          ),
          viewHeaderStyle: const ViewHeaderStyle(
            dayTextStyle: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          onDragEnd: (details) => appointmentState.onDragEnded(details),
          dataSource: MeetingDataSource(appointmentState.appointments),
            onTap: (details) {
              popUpPosition ??= const Offset(200, 200);

              if (details.targetElement == CalendarElement.calendarCell) {
                if (details.date == null) {
                  return;
                }

                ref.read(popupCalendarProvider).event =
                    defaultEvent.copyWith(from: details.date, to: details.date);
                appointmentState.isEdit = false;

                if (widget.isMobile) {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: const Color.fromRGBO(35, 35, 35, 1),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                    ),
                    builder: (context) => const SaveEventWidget(
                      index: 0,
                      isMobile: true,
                    ),
                  );
                } else {
                  context.showPopupMenu(
                    color: const Color.fromRGBO(35, 35, 35, 1),
                    relativeRect: RelativeRect.fromLTRB(
                      popUpPosition!.dx,
                      popUpPosition!.dy,
                      popUpPosition!.dx,
                      popUpPosition!.dy,
                    ),
                    boxConstraints: const BoxConstraints.expand(
                      width: 550,
                      height: 550,
                    ),
                    items: [
                      const PopupMenuItem(
                        enabled: false,
                        padding: EdgeInsets.zero,
                        child: SaveEventWidget(index: 0),
                      ),
                    ],
                  );
                }
              } else if (details.targetElement == CalendarElement.appointment) {
                if (details.appointments == null || details.appointments!.isEmpty) {
                  return;
                }

                // ✅ Convert appointmentId to String
                final String appointmentId = details.appointments!.first.id.toString();

                final indexAppointment = appointmentState.appointments.indexWhere(
                      (appointment) => appointment.id.toString() == appointmentId,
                );

                final indexEvent = appointmentState.events.indexWhere(
                      (event) => event.id.toString() == appointmentId,
                );

                if (indexEvent == -1) {
                  return;
                }

                appointmentState.isEdit = true;
                ref.read(popupCalendarProvider).event = appointmentState.events[indexEvent];

                if (widget.isMobile) {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: const Color.fromRGBO(35, 35, 35, 1),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                    ),
                    builder: (context) => SaveEventWidget(
                      index: indexAppointment,
                      isMobile: true,
                    ),
                  );
                } else {
                  context.showPopupMenu(
                    color: const Color.fromRGBO(35, 35, 35, 1),
                    relativeRect: RelativeRect.fromLTRB(
                      popUpPosition!.dx,
                      popUpPosition!.dy,
                      popUpPosition!.dx,
                      popUpPosition!.dy,
                    ),
                    boxConstraints: const BoxConstraints.expand(
                      width: 550,
                      height: 800,
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
            }
        ),
      ),
    );
  }
}
