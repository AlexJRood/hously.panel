import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/network_monitoring/network_home_page/network_home_new/screens/widgets/monitoring_custom_map.dart';
import 'package:hously_flutter/network_monitoring/network_home_page/network_home_new/screens/widgets/monitoring_custom_text_field.dart';
import 'package:hously_flutter/network_monitoring/network_home_page/network_home_new/screens/widgets/network_monitoring_header_widget.dart';
import 'package:hously_flutter/network_monitoring/network_home_page/network_home_new/screens/widgets/real_state_and_home_for_sale_grid_view.dart';
import 'package:hously_flutter/network_monitoring/network_home_page/network_home_new/screens/widgets/recently_trending_widget.dart';
import 'package:hously_flutter/widgets/appbar/hously/mobile/appbar_mobile.dart';
import 'package:hously_flutter/widgets/bottom_bar_mobile/network_monitoring_bottom_bar.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';
import 'package:pie_menu/pie_menu.dart';

class MonitoringHomeMobile extends ConsumerWidget { // ✅ Zmieniono na ConsumerWidget
  const MonitoringHomeMobile({super.key});

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
          backgroundColor: Colors.transparent,
          body: SideMenuManager.sideMenuSettings(
            menuKey: sideMenuKey,
            child: Container(
              decoration: BoxDecoration(
                gradient: CustomBackgroundGradients.getMainMenuBackground(context, ref), // ✅ ref jest teraz dostępny
              ),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      spacing: 30,
                      children: [
                        const SizedBox(),
                        const NetworkMonitoringHeaderWidget(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            spacing: 30,
                            children: [
                              Row(
                                spacing: 12,
                                children: [
                                  const Expanded(child: MonitoringCustomTextField()),
                                  Container(
                                    height: 48,
                                    width: 48,
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: const Color.fromRGBO(166, 215, 227, 1),
                                      ),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(AppIcons.folder, color: Color.fromRGBO(166, 215, 227, 1)),
                                    ),
                                  ),
                                ],
                              ),
                              const RecentlyTrendingWidget(isMobile: true),
                            ],
                          ),
                        ),
                        const MonitoringCustomMap(isMobile: true),
                        const RealStateAndHomeForSaleGridView(isMobile: true),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    child: AppBarMobile(sideMenuKey: sideMenuKey),
                  ),
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
