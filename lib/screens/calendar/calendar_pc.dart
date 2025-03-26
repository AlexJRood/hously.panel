import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/enums/calendar_type_enum.dart';
import 'package:hously_flutter/screens/calendar/google_calendar_page.dart';
import 'package:hously_flutter/state_managers/data/Keyboardshortcuts.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/widgets/calendar/calendar_widget.dart';
import 'package:hously_flutter/widgets/crm/appbar_crm.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';
import 'package:hously_flutter/widgets/sidebar/sidebar_crm.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

class AgentCalendarPc extends ConsumerStatefulWidget {
  const AgentCalendarPc({super.key});

  @override
  ConsumerState<AgentCalendarPc> createState() => _AgentCalendarPcState();
}

class _AgentCalendarPcState extends ConsumerState<AgentCalendarPc> {
  final calendarController = CalendarController();
  @override
  Widget build(BuildContext context) {
    final calendarViewValue = calendarController.view?.name.toUpperCase();
    final sideMenuKey = GlobalKey<SideMenuState>();
    return KeyboardListener(
      focusNode: FocusNode()..requestFocus(),
      onKeyEvent: (KeyEvent event) {
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
        
      },
      child: Scaffold(
        body: SideMenuManager.sideMenuSettings(
          menuKey: sideMenuKey,
          child: Container(
            color: const Color.fromRGBO(19, 19, 19, 1),
            child: Row(
              children: [
                SidebarAgentCrm(
                  sideMenuKey: sideMenuKey,
                ),
                Expanded(
                  child: Column(
                    children: [
                      const TopAppBarCRM(routeName: Routes.proCalendar),
                      Container(
                        height: 50,
                        color: Colors.transparent,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                ref.read(navigationService).pushNamedScreen(
                                      Routes.eventWidget,
                                    );
                              },
                              child: Container(
                                height: 48,
                                width: 114,
                                decoration: const BoxDecoration(
                                    color: Color.fromRGBO(200, 200, 200, 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      AppIcons.add,
                                      color: Color.fromRGBO(35, 35, 35, 1),
                                    ),
                                    const Text(
                                      'Create',
                                      style: TextStyle(
                                          color: Color.fromRGBO(35, 35, 35, 1)),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            const Expanded(child: GoogleCalendarPage()),
                            Expanded(
                              flex: 3,
                              child: Stack(
                                children: [
                                  CalendarHoursWidget(
                                      calendarController: calendarController),
                                  Positioned(
                                    top: 6,
                                    right: 60,
                                    child: PopupMenuButton<CalendarView>(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 3),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color.fromRGBO(
                                                  79, 79, 79, 1)),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: Colors.transparent,
                                        ),
                                        child: Text(
                                          calendarViewValue ?? 'DAY',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                      ),
                                      itemBuilder: (context) => List.generate(
                                        CalendarTypeEnum.values.length,
                                        (index) => PopupMenuItem(
                                          value: CalendarTypeEnum
                                              .values[index].calendarView,
                                          child: Text(CalendarTypeEnum
                                              .values[index].type),
                                        ),
                                      ),
                                      onSelected: (viewValue) {
                                        setState(() {
                                          calendarController.view = viewValue;
                                        });
                                      },
                                    ),
                                  ),
                                  Positioned(
                                    top: 6,
                                    right: calendarViewValue == 'SCHEDULE'
                                        ? 170
                                        : calendarViewValue == 'WEEK'
                                            ? 135:
                                    calendarViewValue == 'TIMELINEMONTH'?220
                                            : 120,
                                    child: SizedBox(
                                      width: 500,
                                      height: 28,
                                      child: TextField(
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        style: const TextStyle(
                                          color:
                                              Color.fromRGBO(233, 233, 233, 1),
                                          fontSize: 14,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: 'Search...',
                                          hintStyle: const TextStyle(
                                            color: Color.fromRGBO(
                                                233, 233, 233, 1),
                                          ),
                                          filled: true,
                                          fillColor:
                                              const Color.fromRGBO(35, 35, 35, 1),
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.only(right: 8),
                                            child: SvgPicture.asset(
                                              AppIcons.search,
                                              color: Color.fromRGBO(
                                                  233, 233, 233, 1),
                                              height: 16,
                                              width: 16,
                                            ),
                                          ),
                                          suffixIconConstraints: const BoxConstraints(
                                            minHeight: 20,
                                            minWidth: 20,
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(
                                              vertical: 4, horizontal: 12),
                                          border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(6)),
                                            borderSide: BorderSide.none,
                                          ),
                                          enabledBorder: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(6)),
                                            borderSide: BorderSide.none,
                                          ),
                                          focusedBorder: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(6)),
                                            borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  87, 148, 221, 1),
                                              width: 1.5,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
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
