import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/theme/backgroundgradient.dart';
import 'package:hously_flutter/theme/icons.dart';
import 'package:hously_flutter/routing/route_constant.dart';
import 'package:hously_flutter/modules/calendar/enums/calendar_type_enum.dart';

import 'package:hously_flutter/routing/navigation_history_provider.dart';
import 'package:hously_flutter/modules/calendar/google_calendar_page.dart';
import 'package:hously_flutter/utils/Keyboardshortcuts.dart';
import 'package:hously_flutter/routing/navigation_service.dart';
import 'package:hously_flutter/api_services/api_services.dart';
import 'package:hously_flutter/widgets/appbar/appbar_mobile.dart';
import 'package:hously_flutter/widgets/bars/bottom_bar.dart';
import 'package:hously_flutter/modules/calendar/widgets/calendar_widget.dart';

import 'package:hously_flutter/utils/install_popup.dart';

import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../widgets/side_menu/slide_rotate_menu.dart';

class AgentCalendarMobile extends ConsumerStatefulWidget {
  const AgentCalendarMobile({super.key});

  @override
  AgentCalendarMobileState createState() => AgentCalendarMobileState();
}

// Listy widgetów dla PageView

class AgentCalendarMobileState extends ConsumerState<AgentCalendarMobile> {
  final sideMenuKey = GlobalKey<SideMenuState>();
  final calendarController = CalendarController();

  @override
  Widget build(BuildContext context) {
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
        if (ref.read(navigationService).canBeamBack()) {
          KeyBoardShortcuts().handleBackspaceNavigation(event, ref);
        }
      },
      child: Scaffold(
        body: SideMenuManager.sideMenuSettings(
          menuKey: sideMenuKey,
          child: Stack(
            children: [
              Container(
                color: const Color.fromRGBO(19, 19, 19, 1),
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      color: const Color.fromRGBO(41, 41, 41, 1),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                SideMenuManager.toggleMenu(
                                    ref: ref, menuKey: sideMenuKey);
                              },
                              icon: SvgPicture.asset(AppIcons.menu)),
                          const Expanded(child: SizedBox()),
                          Row(
                            spacing: 20,
                            children: [
                               IconButton(onPressed: () {
                                ref.read(navigationService)
                                    .pushNamedScreen(Routes.calendarSearchScreen);
                              }, icon: SvgPicture.asset(AppIcons.search)),
                              PopupMenuButton<CalendarView>(
                                child: SvgPicture.asset(AppIcons.moreVertical),
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
                                  print(viewValue);
                                },
                              ),
                            ],
                          )

                        ],
                      ),
                    ),
                    if(calendarController.view == CalendarView.day)
                    const Expanded(
                        child: GoogleCalendarPage(
                      isMobile: true,
                    )),
                    Expanded(
                      child: Stack(
                        children: [
                          CalendarHoursWidget(
                            calendarController: calendarController,
                            isMobile: true,
                          ),
                        ],
                      ),
                    ),
                    const BottomBarMobile(),
                  ],
                ),
              ),
              Positioned(
                bottom: 80,
                right: 15,
                child: InkWell(
                  onTap: () {
                    ref.read(navigationService).pushNamedScreen(
                          Routes.eventWidget,
                        );
                  },
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(200, 200, 200, 1),
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    child: SvgPicture.asset(
                      AppIcons.add,
                      color: Color.fromRGBO(35, 35, 35, 1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
