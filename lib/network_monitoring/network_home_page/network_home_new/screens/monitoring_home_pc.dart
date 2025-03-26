import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/network_monitoring/network_home_page/network_home_new/screens/widgets/monitoring_custom_map.dart';
import 'package:hously_flutter/network_monitoring/network_home_page/network_home_new/screens/widgets/monitoring_custom_text_field.dart';
import 'package:hously_flutter/network_monitoring/network_home_page/network_home_new/screens/widgets/network_home_filter_pop_widget.dart';
import 'package:hously_flutter/network_monitoring/network_home_page/network_home_new/screens/widgets/network_monitoring_header_widget.dart';
import 'package:hously_flutter/network_monitoring/network_home_page/network_home_new/screens/widgets/real_state_and_home_for_sale_grid_view.dart';
import 'package:hously_flutter/network_monitoring/network_home_page/network_home_new/screens/widgets/recently_trending_widget.dart';
import 'package:hously_flutter/widgets/crm/appbar_crm.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';
import 'package:hously_flutter/widgets/sidebar/sidebar_network_monitoring.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';

class SelectedTabNotifier extends StateNotifier<bool> {
  SelectedTabNotifier() : super(true);

  void toggleTab(bool isRecentlyViewed) {
    state = isRecentlyViewed;
  }
}

final monitoringSelectedTabProvider =
    StateNotifierProvider<SelectedTabNotifier, bool>(
  (ref) => SelectedTabNotifier(),
);

class MonitoringHomePc extends ConsumerWidget {
  const MonitoringHomePc({super.key});

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
        backgroundColor: Colors.transparent,
        body: SideMenuManager.sideMenuSettings(
          menuKey: sideMenuKey,
          child: Container(
            decoration: BoxDecoration(
                gradient: CustomBackgroundGradients.getMainMenuBackground(
                    context, ref)),
            child: Stack(
              children: [
                Row(
                  children: [
                    SidebarNetworkMonitoring(
                      sideMenuKey: sideMenuKey,
                    ),
                     Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 60,
                          children: [
                            const Column(
                              children: [
                                TopAppBarCRM(
                                  routeName: Routes.networkMonitoring,
                                ),
                                NetworkMonitoringHeaderWidget(),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                spacing: 60,
                                children: [
                                  Column(
                                    spacing: 12,
                                    children: [
                                      const Row(
                                        spacing: 10,
                                        children: [
                                          Text(
                                            'Saved Searches:',
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    200, 200, 200, 1),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            'Affordable Options',
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    166, 215, 227, 1),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            'Affordable Options 2',
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    166, 215, 227, 1),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            'Affordable Options 33',
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    166, 215, 227, 1),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      InkWell(
                                          onTap: () {
                                            print('younis');
                                            Navigator.of(context).push(
                                              PageRouteBuilder(
                                                opaque: false,
                                                pageBuilder: (_, __, ___) => const NetworkHomeFilterPopWidget(),
                                                transitionsBuilder: (_, anim, __, child) {
                                                  return FadeTransition(opacity: anim, child: child);
                                                },
                                              ),
                                            );
                                          },
                                          child: const MonitoringCustomTextField(enabled: false,))
                                    ],
                                  ),
                                  const RecentlyTrendingWidget(isMobile: false)
                                ],
                              ),
                            ),
                            const MonitoringCustomMap(),
                            const RealStateAndHomeForSaleGridView(
                              isMobile: false,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 10,
                  right: 30,
                  child: Column(
                    spacing: 12,
                    children: [
                      Container(
                        height: 66,
                        width: 100,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(33, 32, 32, 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_box_outlined,
                                size: 20,
                                color: Color.fromRGBO(233, 233, 233, 1),
                              ),
                              Text('Publish',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(233, 233, 233, 1))),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 66,
                        width: 100,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(33, 32, 32, 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_box_outlined,
                                size: 20,
                                color: Color.fromRGBO(233, 233, 233, 1),
                              ),
                              Text('Edit',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(233, 233, 233, 1))),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 66,
                        width: 100,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(33, 32, 32, 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_box_outlined,
                                size: 20,
                                color: Color.fromRGBO(233, 233, 233, 1),
                              ),
                              Text('data',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(233, 233, 233, 1))),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 66,
                        width: 100,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(33, 32, 32, 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_box_outlined,
                                size: 20,
                                color: Color.fromRGBO(233, 233, 233, 1),
                              ),
                              Text('data',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(233, 233, 233, 1))),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 66,
                        width: 100,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(33, 32, 32, 1),
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_box_outlined,
                                size: 20,
                                color: Color.fromRGBO(233, 233, 233, 1),
                              ),
                              Text('data',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(233, 233, 233, 1))),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
