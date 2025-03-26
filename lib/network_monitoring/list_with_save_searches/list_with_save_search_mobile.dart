import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/network_monitoring/list_with_save_searches/widget/save_search_list_view_widget.dart';
import 'package:hously_flutter/widgets/appbar/hously/mobile/appbar_mobile.dart';
import 'package:hously_flutter/widgets/bottom_bar_mobile/network_monitoring_bottom_bar.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';
import 'package:pie_menu/pie_menu.dart';

class ListWithSaveSearchMobile extends ConsumerWidget { // ✅ Zmieniono na ConsumerWidget
  const ListWithSaveSearchMobile ({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) { // ✅ Teraz mamy poprawny 'ref'
    final sideMenuKey = GlobalKey<SideMenuState>();
    return PieCanvas(
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
      child: SafeArea(
        child: Scaffold(
          body: SideMenuManager.sideMenuSettings(
            menuKey: sideMenuKey,
            child: Container(
                  decoration:  BoxDecoration(
                    gradient: CustomBackgroundGradients.getMainMenuBackground(context,ref)
                  ),
              child: Stack(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 50.0),
                    child: SaveSearchListViewWidget(),
                  ),                  
                  Positioned(
                      top: 0,
                      child: AppBarMobile(
                        sideMenuKey: sideMenuKey,
                      )),
                  const Positioned(bottom: 0, child: NetworkMonitoringBottomBarMobile()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  }

