import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/network_monitoring/saved_search/saved_search_new_screens/widgets/network_monitoring_feed_bar_vertical.dart';
import 'package:hously_flutter/network_monitoring/feed_page/widgets/nm_grid_mobile.dart';
import 'package:hously_flutter/state_managers/data/home_page/listing_provider.dart';
import 'package:hously_flutter/widgets/appbar/hously/mobile/appbar_mobile.dart';
import 'package:hously_flutter/widgets/bottom_bar_mobile/network_monitoring_bottom_bar.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';


class NMFeedMobile extends ConsumerWidget {
  const NMFeedMobile({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final listingProvider = ref.watch(listingsProvider);
    final sideMenuKey = GlobalKey<SideMenuState>();
    final propertyLength = listingProvider.value?.length ?? 0;

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
        child:SafeArea(
          child: Scaffold(
          body: SideMenuManager.sideMenuSettings(
            menuKey: sideMenuKey,
            child: Stack(
              children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: CustomBackgroundGradients.getMainMenuBackground(
                          context, ref),
                    ),
                    child: 
                        const NMGridViewMobile(),
                ),
                Positioned(
                    top: 0,
                    child: AppBarMobile(
                      sideMenuKey: sideMenuKey,
                    )),
                const Positioned(bottom: 0, child: NetworkMonitoringBottomBarMobile()),
                Positioned(
                  bottom: 55,
                  right: 5,
                  child: NetworkMonitoringFeedBarVerticalMobile(ref: ref),
                )
              ],
            ),
          ),
                ),
        ),
    );
  }
}
