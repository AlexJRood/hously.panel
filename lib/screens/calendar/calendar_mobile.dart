import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';

import 'package:hously_flutter/routes/navigation_history_provider.dart';
import 'package:hously_flutter/screens/calendar/google_calendar_page.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/widgets/appbar/hously/mobile/appbar_mobile.dart';

import 'package:hously_flutter/widgets/crm/apptour_crm_bottombar.dart';
import 'package:hously_flutter/widgets/crm/bottombar_crm.dart';
import 'package:hously_flutter/widgets/installpopup/install_popup.dart';

import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';

import '../../widgets/side_menu/slide_rotate_menu.dart';

class AgentCalendarMobile extends ConsumerStatefulWidget {
  AgentCalendarMobile({super.key});

  @override
  _AgentCalendarMobileState createState() => _AgentCalendarMobileState();
}

// Listy widgetów dla PageView

class _AgentCalendarMobileState extends ConsumerState<AgentCalendarMobile> {
  final sideMenuKey = GlobalKey<SideMenuState>();

  @override
  @override
  Widget build(BuildContext context) {
    return PopupListener(
        child: SafeArea(
          child: Scaffold(
          body: SideMenuManager.sideMenuSettings(
            menuKey: sideMenuKey,
            child: Container(
              decoration: BoxDecoration(
                gradient: CustomBackgroundGradients.customcrmright(context, ref),
              ),
              child:  Column(
                children: [
                  AppBarMobile(sideMenuKey: sideMenuKey,),
                  const SizedBox(
                    height: 20,
                  ),
                  const Expanded(
                      child: Padding(
                    padding: EdgeInsets.all(15),
                    child: GoogleCalendarPage(),
                  )),
                  const BottombarCrm(),
                ],
              ),
            ),
          ),
                ),
        ),
    );
  }
}
