import 'package:flutter/material.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/screens/network_monitoring/list_with_save_searches/widget/save_search_list_view_widget.dart';
import 'package:hously_flutter/widgets/crm/appbar_crm.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';
import 'package:hously_flutter/widgets/sidebar/sidebar_network_monitoring.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ListWithSaveSearchesPc  extends ConsumerWidget {
  const ListWithSaveSearchesPc({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      child: Scaffold(
        // backgroundColor: Colors.transparent,
        body: SideMenuManager.sideMenuSettings(
          menuKey: sideMenuKey,
          child: Container(    
             decoration: BoxDecoration(
                gradient: CustomBackgroundGradients.getMainMenuBackground(
                    context, ref)),
            child: Row(
              children: [
                SidebarNetworkMonitoring(
                  sideMenuKey: sideMenuKey,
                ),
                Expanded(
                  child: Column(
                    spacing: 34,
                    children: [
                      const TopAppBarCRM(
                        routeName: Routes.homeNetworkMonitoring,
                      ),
                      Stack(
                        children: [
                          Image.asset(
                            'assets/images/top-content.jpg',
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.cover,
                            height: 130,
                          ),
                          const Positioned(
                            bottom: 10,
                            top: 10,
                            left: 20,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Network Monitoring',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const Expanded(child: SaveSearchListViewWidget())
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
