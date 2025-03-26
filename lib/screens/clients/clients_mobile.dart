// ignore_for_file: use_build_context_synchronously, prefer_const_constructors_in_immutables

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/routes/navigation_history_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/widgets/appbar/hously/mobile/appbar_mobile.dart';
import 'package:hously_flutter/widgets/bottom_bar_mobile/bottom_bar.dart';
import 'package:hously_flutter/widgets/crm/bottombar_crm.dart';
import 'package:hously_flutter/widgets/crm/clients/clients_list.dart';
import 'package:hously_flutter/widgets/crm/clients/search_buttons.dart';
import 'package:hously_flutter/widgets/crm/clients/search_buttons_mobile.dart';
import 'package:hously_flutter/widgets/installpopup/install_popup.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';

import '../../widgets/side_menu/slide_rotate_menu.dart';

class ClientsMobile extends ConsumerWidget {
  ClientsMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //   _checkForToken(context, ref);

    final sideMenuKey = GlobalKey<SideMenuState>();

    return PopupListener(
      child: SafeArea(
        child: Scaffold(
          body: SideMenuManager.sideMenuSettings(
            menuKey: sideMenuKey,
            child: Container(
              decoration: BoxDecoration(
                gradient: CustomBackgroundGradients.customcrmright(context, ref),
              ),
              child: Column(
                children: [
                  AppBarMobile(
                    sideMenuKey: sideMenuKey,
                  ),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(child: StatusFilterWidgetmobile()),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Flexible(
                                  child: ClientList(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const BottombarCrm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _checkForToken(BuildContext context, WidgetRef ref) async {
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
