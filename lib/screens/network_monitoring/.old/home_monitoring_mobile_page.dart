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
import 'package:hously_flutter/widgets/installpopup/install_popup.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';

import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';
// Zaimportuj provider historii nawigacji

class HomeMonitoringMobilePage extends ConsumerWidget {
  const HomeMonitoringMobilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _checkForToken(context, ref);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double inputWidth = math.max(screenWidth * 0.33, 350);
    final sideMenuKey = GlobalKey<SideMenuState>();

    return PopupListener(
        child: SafeArea(
          child: Scaffold(
          body: SideMenuManager.sideMenuSettings(
          menuKey: sideMenuKey,
            child: Container(
              decoration:  BoxDecoration(
                gradient: CustomBackgroundGradients.getMainMenuBackground(context,ref)
              ),
              child: Column(
                children: [
                   AppBarMobile(sideMenuKey: sideMenuKey,),
                  Expanded(
                    child: SizedBox(
                      width: inputWidth,
                      child: Row(
                        children: [
                          Container(
                            width: screenWidth / 5,
                            height: screenHeight / 3,
                            color: AppColors.light,
                          ),
                          const SizedBox(width: 25),
                          Container(
                            width: screenWidth / 5,
                            height: screenHeight / 3,
                            color: AppColors.light,
                          ),
                          const SizedBox(width: 25),
                          Container(
                            width: screenWidth / 5,
                            height: screenHeight / 3,
                            color: AppColors.light,
                          ),
                          const SizedBox(width: 25),
                        ],
                      ),
                    ),
                  ),
                  const BottomBarMobile(),
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
