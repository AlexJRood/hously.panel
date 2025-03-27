import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/widgets/language/values.dart';
import 'package:hously_flutter/modules/calendar/state/yearly_calendar_provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MonthCalendarWidget extends ConsumerWidget {
  final int month;

  const MonthCalendarWidget({
    super.key,
    required this.month,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final year = ref.watch(yearlyCalendarProvider).year;
    final calendarCtrl = CalendarController();

    calendarCtrl.selectedDate = DateTime(year);

    return Container(color: Colors.red,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              CalendarConst.monthsName[month - 1],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: SfCalendar(
                controller: calendarCtrl,
                view: CalendarView.month,
                initialDisplayDate: DateTime(year, month),
                headerHeight: 0,
                viewHeaderHeight: 0,
                todayHighlightColor: Theme.of(context).primaryColor,
                cellBorderColor: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
