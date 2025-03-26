import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';

import 'package:hously_flutter/routes/navigation_history_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/widgets/appbar/hously/mobile/appbar_mobile.dart';

import 'package:hously_flutter/widgets/crm/apptour_crm_bottombar.dart';
import 'package:hously_flutter/widgets/crm/bottombar_crm.dart';
import 'package:hously_flutter/widgets/installpopup/install_popup.dart';

import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';

import '../../widgets/side_menu/slide_rotate_menu.dart';

class AgentFinancialPlansMobile extends ConsumerStatefulWidget {
  AgentFinancialPlansMobile({super.key});

  @override
  _AgentFinancialPlansMobileState createState() =>
      _AgentFinancialPlansMobileState();
}

// Listy widgetów dla PageView

class _AgentFinancialPlansMobileState
    extends ConsumerState<AgentFinancialPlansMobile> {
  final sideMenuKey = GlobalKey<SideMenuState>();

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
                  SizedBox(
                    height: 20,
                  ),
                  BottombarCrm(),
                ],
              ),
            ),
          ),
                ),
        ),
    );
  }

  Future<void> _checkForToken() async {
    if (ApiServices.token != null) {
      // Usunięcie stron logowania i rejestracji z historii nawigacji
      ref
          .read(navigationHistoryProvider.notifier)
          .removeSpecificPages(['/login', '/register']);

      // Przekierowanie na ostatnią stronę w historii nawigacji
      final lastPage = ref.read(navigationHistoryProvider.notifier).lastPage;
      ref.read(navigationService).pushNamedReplacementScreen(lastPage);
    }
  }
}
