import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/dialogs/calendar_popup.dart';
import 'package:hously_flutter/enums/calendar_type_enum.dart';
import 'package:hously_flutter/state_managers/screen/calendar/yearly_calendar_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/widgets/calendar/calendar_widget.dart';
import 'package:hously_flutter/widgets/calendar/month_calendar_widget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class GoogleCalendarPage extends ConsumerStatefulWidget {
  const GoogleCalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<GoogleCalendarPage> {
  final calendarController = CalendarController();

  @override
  Widget build(BuildContext context) {
    final yearlyState = ref.watch(yearlyCalendarProvider);
    final theme = ref.watch(themeColorsProvider);
    final double maxHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => ref.read(navigationService).pushNamedScreen(
          Routes.eventWidget,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (calendarController.view == CalendarView.timelineMonth)
              Expanded(
                child: Column(
                  children: [
                    Container(
                      color: theme.textFieldColor,
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios_outlined,
                                size: 15,
                                color: Theme.of(context).iconTheme.color),
                            onPressed: () => setState(() {
                              yearlyState.year -= 1;
                            }),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_forward_ios_outlined,
                                size: 15,
                                color: Theme.of(context).iconTheme.color),
                            onPressed: () => setState(() {
                              yearlyState.year += 1;
                            }),
                          ),
                          InkWell(
                            child: Row(
                              children: [
                                Text(
                                  '${yearlyState.year}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Theme.of(context).iconTheme.color),
                                ),
                                const SizedBox(width: 5),
                                Icon(
                                  Icons.arrow_drop_down,
                                  size: 17,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                              ],
                            ),
                            onTapDown: (event) {
                              showCalendarPopup(
                                event: event,
                                context: context,
                                minDate: DateTime.now(),
                                onSelectionChanged: (details) {},
                              );
                            },
                          ),
                          const Spacer(),
                          PopupMenuButton<CalendarView>(
                            icon: Icon(
                              Icons.calendar_today,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            itemBuilder: (context) => List.generate(
                              CalendarTypeEnum.values.length,
                                  (index) => PopupMenuItem(
                                value:
                                CalendarTypeEnum.values[index].calendarView,
                                child:
                                Text(CalendarTypeEnum.values[index].type),
                              ),
                            ),
                            onSelected: (viewValue) {
                              setState(() {
                                calendarController.view = viewValue;
                              });
                            },
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: Colors.grey.withOpacity(0.5), // ✅ Reduced border visibility
                                  width: 0.8, // ✅ Smaller border thickness
                                ),
                              ),
                              child: Text(
                                'Today',
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context).iconTheme.color),
                              ),
                            ),
                            onTap: () => setState(() {
                              yearlyState.year = DateTime.now().year;
                            }),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemCount: 12,
                        itemBuilder: (context, index) => MonthCalendarWidget(
                          month: index + 1,
                        ),
                      ),
                    )
                  ],
                ),
              )
            else
              Expanded( // ✅ Ensures CalendarWidget takes full screen height
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CalendarWidget(calendarController: calendarController),
                    ),
                    Positioned(
                      right: 60,
                      top: 0,
                      child: PopupMenuButton<CalendarView>(
                        color: theme.fillColor,
                        icon: Icon(
                          Icons.calendar_today,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        itemBuilder: (context) => List.generate(
                          CalendarTypeEnum.values.length,
                              (index) => PopupMenuItem(
                            value: CalendarTypeEnum.values[index].calendarView,
                            child: Text(
                              CalendarTypeEnum.values[index].type,
                              style: TextStyle(color: theme.textFieldColor),
                            ),
                          ),
                        ),
                        onSelected: (viewValue) {
                          setState(() {
                            calendarController.view = viewValue;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
