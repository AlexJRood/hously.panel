import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/screens/network_monitoring/saved_search/saved_search_new_screens/widgets/network_monitoring_feed_bar_vertical.dart';
import 'package:hously_flutter/screens/network_monitoring/saved_search/saved_search_new_screens/widgets/saved_search_grid_view.dart';
import 'package:hously_flutter/state_managers/data/home_page/listing_provider.dart';
import 'package:hously_flutter/widgets/appbar/hously/mobile/appbar_mobile.dart';
import 'package:hously_flutter/widgets/bottom_bar_mobile/network_monitoring_bottom_bar.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';


class MonitoringSaveMobile extends ConsumerWidget {
  const MonitoringSaveMobile({super.key});

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
        child:Scaffold(
        backgroundColor: Colors.transparent,
        body: SideMenuManager.sideMenuSettings(
          menuKey: sideMenuKey,
          child: Stack(
            children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: CustomBackgroundGradients.getMainMenuBackground(
                        context, ref),
                  ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 12,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 12,
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                hintText: 'Search ...',
                                hintStyle: const TextStyle(color: Colors.grey),
                                prefixIcon:
                                    const Icon(Icons.search, color: Colors.grey),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 16),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.transparent),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.transparent),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.transparent),
                                ),
                                filled: true,
                                fillColor: Colors.transparent,
                              ),
                            ),
                            const Text(
                              'Name search like Affordable Options ',
                              style: TextStyle(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                             Text(
                              '$propertyLength properties',
                              style: const TextStyle(
                                  color: Color.fromRGBO(145, 145, 145, 1),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      const SavedSearchGridView()
                    ],
                  ),
                ),
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
    );
  }
}
