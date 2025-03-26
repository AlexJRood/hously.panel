import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/data/Keyboardshortcuts.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/widgets/appbar/hously/pc/appbar.dart';
import 'package:hously_flutter/widgets/appbar/hously/pc/newappbar.dart';
import 'package:hously_flutter/widgets/article_module.dart';
import 'package:hously_flutter/widgets/landing_page/landing_page_pc/featured_news_widget.dart';
import 'package:hously_flutter/widgets/landing_page/landing_page_pc/footer_widget.dart';
import 'package:hously_flutter/widgets/screens/home_page/articles_module.dart';
import 'package:hously_flutter/widgets/screens/home_page/best_in.dart';
import 'package:hously_flutter/widgets/screens/home_page/best_in2.dart';
import 'package:hously_flutter/widgets/screens/home_page/bottom_feet.dart';
import 'package:hously_flutter/widgets/screens/home_page/help_bar.dart';
import 'package:hously_flutter/widgets/screens/home_page/hot_carousel.dart';
import 'package:hously_flutter/widgets/screens/home_page/recently_viewed_ads.dart';
import 'package:hously_flutter/widgets/screens/home_page/why_us.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/sidebar/sidebar.dart';
import 'package:pie_menu/pie_menu.dart';

import '../../widgets/side_menu/slide_rotate_menu.dart';

class HomePcPage extends ConsumerStatefulWidget {
  const HomePcPage({super.key});

  @override
  ConsumerState<HomePcPage> createState() => _HomePcPageState();
}

class _HomePcPageState extends ConsumerState<HomePcPage> {
  final sideMenuKey = GlobalKey<SideMenuState>();

  @override
  Widget build(BuildContext context) {
    final isUserLoggedIn = ApiServices.isUserLoggedIn();

    double screenWidth = MediaQuery.of(context).size.width;
    const double maxWidth = 1920;
    const double minWidth = 350;
    const double maxDynamicPadding = 40;
    const double minDynamicPadding = 5;

    double dynamicPadding = (screenWidth - minWidth) /
            (maxWidth - minWidth) *
            (maxDynamicPadding - minDynamicPadding) +
        minDynamicPadding;
    dynamicPadding = dynamicPadding.clamp(minDynamicPadding, maxDynamicPadding);
    ScrollController _scrollController = ScrollController();
    return KeyboardListener(
      focusNode: FocusNode()..requestFocus(),
      onKeyEvent: (KeyEvent event) {
        // Check if the pressed key matches the stored pop key
        KeyBoardShortcuts().filterpop(event, ref);
        KeyBoardShortcuts().sortpopup(event, ref, context);
        KeyBoardShortcuts().handleKeyNavigation(event, ref, context);
        KeyBoardShortcuts().handleKeyEvent(event, _scrollController, 200, 50);
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
          body: SideMenuManager.sideMenuSettings(
            menuKey: sideMenuKey,
            child: Stack(
              children: [
                Row(
                  children: [
                    Sidebar(
                      sideMenuKey: sideMenuKey,
                    ),
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                          gradient:
                              CustomBackgroundGradients.getMainMenuBackground(
                                  context, ref),
                        ),
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: dynamicPadding,
                                    right: dynamicPadding),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 65.0),
                                    const SizedBox(height: 5.0),
                                    // const HelpBar(),
                                    const SizedBox(height: 25.0),
                                    if (isUserLoggedIn) ...[
                                      // Użycie operatora spread do opcjonalnego włączenia widżetu
                                      const RecentlyViewedAds(),
                                      const SizedBox(height: 50),
                                    ],
                                    FeaturedNewsWidget(paddingDynamic: 0),
                                    const SizedBox(height: 50),
                                    const HotCarousel(),
                                    const SizedBox(height: 100.0),
                                    const SizedBox(height: 100.0),
                                    // const ArticlesModule(),
                                    // const SizedBox(height: 100.0),
                                    const BestIn(),
                                    // const SizedBox(
                                    //   height: 25,
                                    // ),
                                    // const BestIn2(),
                                    const SizedBox(height: 100.0),
                                    // const WhyUs(),
                                    // const SizedBox(height: 100.0),
                                  ],
                                ),
                              ),
                             FooterWidget(paddingDynamic: dynamicPadding),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const Positioned(
                  top: 0,
                  right: 0,
                  child:  TopAppBar()),




              ],
            ),
          ),
        ),
      ),
    );
  }
}
