// ignore_for_file: use_build_context_synchronously, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/routes/navigation_history_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/widgets/appbar/hously/pc/appbar_logo.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/sidebar/sidebar.dart';

import '../../widgets/side_menu/slide_rotate_menu.dart';
// Zaimportuj provider historii nawigacji

class LearnCenterPcPage extends ConsumerWidget {
  const LearnCenterPcPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // _checkForToken(context, ref);

    // double screenWidth = MediaQuery.of(context).size.width;
    // // double screenHeight = MediaQuery.of(context).size.height;
    // double smallBoxWidth = screenWidth * 0.20;
    // double smallBoxHeight = smallBoxWidth *1.5;
    // double bigBoxHeight = smallBoxHeight *1.25;
    // double bigBoxWidth = smallBoxWidth *1.25;
    // double spaceBoxWidth = math.max(screenWidth * 0.023, 10);
    final sideMenuKey = GlobalKey<SideMenuState>();

    return Scaffold(
      body: SideMenuManager.sideMenuSettings(
        menuKey: sideMenuKey,
        child: Container(
          decoration: BoxDecoration(
            gradient:
               CustomBackgroundGradients.getMainMenuBackground(context,ref)
          ),
          child: Row(
            children: [
              Sidebar(
                sideMenuKey: sideMenuKey,
              ),
              Expanded(
                child: Column(
                  children: [
                    TopAppBarLogoRegisterPage(),
                    Expanded(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Learn center',
                                style: AppTextStyles.interMedium14.copyWith(
                                    color: Theme.of(context).iconTheme.color!))
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
