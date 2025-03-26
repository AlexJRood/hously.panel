import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/screens/calendar/google_calendar_page.dart';
import 'package:hously_flutter/state_managers/data/Keyboardshortcuts.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/widgets/crm/appbar_crm.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/sidebar/sidebar_crm.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../widgets/side_menu/slide_rotate_menu.dart';

class AgentCalendarPc extends ConsumerWidget {
  const AgentCalendarPc({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sideMenuKey = GlobalKey<SideMenuState>();

    return KeyboardListener(
      focusNode: FocusNode()..requestFocus(),
      onKeyEvent: (KeyEvent event) {
        // Check if the pressed key matches the stored pop key
        KeyBoardShortcuts().handleKeyNavigation(event, ref, context);
        final Set<LogicalKeyboardKey> pressedKeys =
            HardwareKeyboard.instance.logicalKeysPressed;
        final LogicalKeyboardKey? shiftKey = ref.watch(togglesidemenu1);
        if (pressedKeys.contains(ref.watch(adclientprovider)) &&
            !pressedKeys.contains(shiftKey)) {
          ref
              .read(navigationService)
              .pushNamedScreen(Routes.proFinanceRevenueAdd);
        }
        if (ref.read(navigationService).canBeamBack()) {
          KeyBoardShortcuts().handleBackspaceNavigation(event, ref);
        }
      },
      child: Scaffold(
        body: SideMenuManager.sideMenuSettings(
          menuKey: sideMenuKey,
          child: Container(
            decoration: BoxDecoration(
              gradient: CustomBackgroundGradients.customcrmright(context, ref),
            ),
            child: Row(
              children: [
                SidebarAgentCrm(
                  sideMenuKey: sideMenuKey,
                ),
                const Expanded(
                  child: Column(
                    children: [
                      TopAppBarCRM(routeName: Routes.proCalendar),
                      Expanded(
                        child: GoogleCalendarPage(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CalendarViewSwitcher extends ConsumerStatefulWidget {
  const CalendarViewSwitcher({super.key});

  @override
  _CalendarViewSwitcherState createState() => _CalendarViewSwitcherState();
}

class _CalendarViewSwitcherState extends ConsumerState<CalendarViewSwitcher> {
  int _selectedViewIndex = 0;

  final List<Widget> _views = [
    const MonthlyView(),
    const WeeklyView(),
    const DailyView(),
  ];

  @override
  Widget build(BuildContext context) {
    final themecolors = ref.watch(themeColorsProvider);
    return Column(
      children: [
        ToggleButtonsTheme(
          data: ToggleButtonsThemeData(
            borderColor: Theme.of(context).iconTheme.color,

            fillColor: Theme.of(context)
                .iconTheme
                .color, // Background of selected button

            borderRadius: BorderRadius.circular(50),
            color:
                themecolors.textFieldColor, // Text color for unselected buttons
          ),
          child: ToggleButtons(
            constraints: const BoxConstraints.tightFor(
              width: 60,
              height: 30,
            ),
            borderRadius: BorderRadius.circular(18),
            isSelected:
                List.generate(3, (index) => index == _selectedViewIndex),
            onPressed: (index) {
              setState(() {
                _selectedViewIndex = index;
              });
            },
            children: [
              Text(
                'Month',
                style:
                    TextStyle(color: themecolors.textFieldColor, fontSize: 13),
              ),
              Text('Week',
                  style: TextStyle(
                      color: themecolors.textFieldColor, fontSize: 13)),
              Text('Day',
                  style: TextStyle(
                      color: themecolors.textFieldColor, fontSize: 13)),
            ],
          ),
        ),
        Expanded(
          child: _views[_selectedViewIndex],
        ),
      ],
    );
  }
}

class MonthlyView extends ConsumerWidget {
  const MonthlyView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final currentThemeMode = ref.watch(themeProvider);
    final bool isLightTheme = currentThemeMode == ThemeMode.light;
    final bool isDarkTheme = currentThemeMode == ThemeMode.dark;
    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: DateTime.now(),
      daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(color: Theme.of(context).iconTheme.color)),
      calendarStyle: CalendarStyle(
        todayDecoration: const BoxDecoration(
          color: Colors.blueAccent,
          shape: BoxShape.circle,
        ),
        defaultTextStyle: TextStyle(
          color: isLightTheme
              ? Colors.white
              : isDarkTheme
                  ? Colors.black
                  : Colors.white,
        ),
        weekendTextStyle: const TextStyle(color: Colors.red),
        weekNumberTextStyle: TextStyle(
          color: isLightTheme
              ? Colors.white // Week numbers in light theme
              : isDarkTheme
                  ? Colors.black // Week numbers in dark theme
                  : Colors.white, // System theme fallback
        ),
        outsideTextStyle: TextStyle(
          color: isLightTheme
              ? Colors.white70
              : isDarkTheme
                  ? Colors.black54
                  : Colors.white,
        ),
      ),
      headerStyle: HeaderStyle(
        formatButtonVisible: true,
        formatButtonTextStyle: TextStyle(
          color: isLightTheme
              ? Colors.white70
              : isDarkTheme
                  ? Colors.black54
                  : Colors.white,
          fontWeight: FontWeight.bold,
        ),
        titleCentered: true,
        titleTextStyle: TextStyle(
          color: isLightTheme
              ? Colors.white
              : isDarkTheme
                  ? Colors.black
                  : Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        leftChevronIcon: Icon(
          Icons.chevron_left,
          color: isLightTheme
              ? Colors.white
              : isDarkTheme
                  ? Colors.black
                  : Colors.white,
        ),
        rightChevronIcon: Icon(
          Icons.chevron_right,
          color: isLightTheme
              ? Colors.white
              : isDarkTheme
                  ? Colors.black
                  : Colors.white,
        ),
      ),
      weekNumbersVisible: true,
    );
  }
}

class WeeklyView extends StatelessWidget {
  const WeeklyView({super.key});

  final List<String> daysOfWeek = const [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: daysOfWeek.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            daysOfWeek[index],
            style: TextStyle(color: Theme.of(context).iconTheme.color),
          ),
          subtitle: DragAndDropLists(
            children: [
              DragAndDropList(
                header: const Text('Events'),
                children: [
                  DragAndDropItem(child: const Text('Event 1')),
                  DragAndDropItem(child: const Text('Event 2')),
                ],
              ),
            ],
            onItemReorder:
                (oldItemIndex, oldListIndex, newItemIndex, newListIndex) {
              // Implement the item reorder logic here
            },
            onListReorder: (oldListIndex, newListIndex) {
              // Implement the list reorder logic here
            },
          ),
        );
      },
    );
  }
}

class DailyView extends StatelessWidget {
  const DailyView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        DragAndDropLists(
          children: [
            DragAndDropList(
              header: const Text('Morning'),
              children: [
                DragAndDropItem(child: const Text('Event 1')),
                DragAndDropItem(child: const Text('Event 2')),
              ],
            ),
            DragAndDropList(
              header: const Text('Afternoon'),
              children: [
                DragAndDropItem(child: const Text('Event 3')),
                DragAndDropItem(child: const Text('Event 4')),
              ],
            ),
            DragAndDropList(
              header: const Text('Evening'),
              children: [
                DragAndDropItem(child: const Text('Event 5')),
                DragAndDropItem(child: const Text('Event 6')),
              ],
            ),
          ],
          onItemReorder:
              (oldItemIndex, oldListIndex, newItemIndex, newListIndex) {
            // Implement the item reorder logic here
          },
          onListReorder: (oldListIndex, newListIndex) {
            // Implement the list reorder logic here
          },
        ),
      ],
    );
  }
}
