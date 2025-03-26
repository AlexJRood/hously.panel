import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/state_managers/screen/calendar/yearly_calendar_provider.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/widgets/calendar/calendar_widget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class GoogleCalendarPage extends ConsumerStatefulWidget {
  final bool isMobile;
  const GoogleCalendarPage({super.key,this.isMobile = false});

  @override
  CalendarPageState createState() => CalendarPageState();
}

class CalendarPageState extends ConsumerState<GoogleCalendarPage> {
  final calendarController = CalendarController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SizedBox(
            height:widget.isMobile?MediaQuery.of(context).size.height:430,
            child: CalendarWidget(calendarController: calendarController,
            isMobile: widget.isMobile,)),
      ),
    );
  }
}
