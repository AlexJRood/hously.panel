// ignore_for_file: use_build_context_synchronously, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/network_monitoring/browselist/widget/pc.dart';
import 'package:hously_flutter/network_monitoring/feed_page/widgets/grid_nm_pc_page.dart';
import 'package:hously_flutter/state_managers/data/Keyboardshortcuts.dart';
import 'package:hously_flutter/widgets/crm/appbar_crm.dart';
import 'package:hously_flutter/network_monitoring/filter_monitoring_widget.dart';
import 'package:hously_flutter/widgets/screens/autocompletion/provider/autocompletion_provider.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/sidebar/sidebar_network_monitoring.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';


class NMFeedPc extends ConsumerWidget {
  const NMFeedPc({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sideMenuKey = GlobalKey<SideMenuState>();
    
    final model =
        ref.watch(myTextFieldViewModelProvider.notifier); // Watch the provider

    return KeyboardListener(
      focusNode: FocusNode()..requestFocus(),
      onKeyEvent: (KeyEvent event) {
        // Check if the pressed key matches the stored pop key
        KeyBoardShortcuts().handleKeyNavigation(event, ref, context);
      },
      child: PieCanvas(
        theme: const PieTheme(
          rightClickShowsMenu: true,
          leftClickShowsMenu: false,
          buttonTheme: PieButtonTheme(
            backgroundColor: AppColors.buttonGradient1,
            iconColor: Colors.white,
          ),
          buttonThemeHovered: PieButtonTheme(
            backgroundColor: Color.fromARGB(96, 58, 58, 58),
            iconColor: Colors.white,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SideMenuManager.sideMenuSettings(
            menuKey: sideMenuKey,
            child:         
              GestureDetector(onTap: () {
                model.setLoading(false);
              }, child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: CustomBackgroundGradients.getMainMenuBackground(
                          context, ref),
                    ),
                    child: Row(
                      children: [
                        SidebarNetworkMonitoring(
                          sideMenuKey: sideMenuKey,
                        ),
                        const Expanded(
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: FilterMonitoringWidget(),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: GridNMPcPage(),
                                ),
              
                              ],
                            ),
                          ),
                        ),
                        BrowseListNetworkMonitoringPcWidget(isWhiteSpaceNeeded: true)
                      ],
                    ),
                  ),
                  const Positioned(
                    top:0,right:0,left:60,
                    child: TopAppBarCRM(routeName: Routes.networkMonitoring),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
