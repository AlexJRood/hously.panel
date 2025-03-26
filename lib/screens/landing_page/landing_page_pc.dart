import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/widgets/drad_scroll_widget.dart';
import 'package:hously_flutter/widgets/landing_page/landing_page_pc/appbar_landingpage.dart';
import 'package:hously_flutter/widgets/landing_page/landing_page_pc/header_widget.dart';
import 'package:hously_flutter/widgets/screens/home_page/recently_viewed_ads.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';
import 'package:hously_flutter/widgets/sidebar/apptour_sidebar.dart';
import 'package:pie_menu/pie_menu.dart';

import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/widgets/landing_page/landing_page_pc/ai_precision_widget.dart';
import 'package:hously_flutter/widgets/landing_page/landing_page_pc/ask_user_widget.dart';
import 'package:hously_flutter/widgets/landing_page/landing_page_pc/exclusive_offers_widget.dart';
import 'package:hously_flutter/widgets/landing_page/landing_page_pc/featured_news_widget.dart';
import 'package:hously_flutter/widgets/landing_page/landing_page_pc/featured_properties_widget.dart';
import 'package:hously_flutter/widgets/landing_page/landing_page_pc/footer_widget.dart';
import 'package:hously_flutter/widgets/landing_page/landing_page_pc/get_home_recommendations_widget.dart';
import 'package:hously_flutter/widgets/landing_page/landing_page_pc/here_to_help_widget.dart';
import 'package:hously_flutter/widgets/landing_page/landing_page_pc/map_widget.dart';
import 'package:hously_flutter/widgets/landing_page/landing_page_pc/over_mission_widget.dart';
import 'package:hously_flutter/widgets/landing_page/landing_page_pc/popular_searches_widget.dart';

class LandingPagePc extends ConsumerWidget {
  final bool isUserLoggedIn;
  const LandingPagePc({super.key, required this.isUserLoggedIn});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _scrollcontroller = ScrollController();
    final sideMenuKey = GlobalKey<SideMenuState>();
    double dynamicPadding = MediaQuery.of(context).size.width / 6;

    
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
        body: SideMenuManager.sideMenuSettings(
          menuKey: sideMenuKey,
          child: Row(
            children: [
              Newsidebar(
                sideMenuKey: sideMenuKey,
              ),
              Expanded(
                child: Container(
                  height: double.infinity,
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(232, 235, 242, 1)),
                  child: DragScrollView(
                    scrollDirection: Axis.vertical,
                    controller: _scrollcontroller,
                    child: SingleChildScrollView(
                      controller: _scrollcontroller,
                      child: Column(
                        children: [
                          HeaderWidget(paddingDynamic: dynamicPadding),

                          if (isUserLoggedIn)
                              RecentlyViewedAds(paddingDynamic: dynamicPadding),


                          ExclusiveOffersWidget(paddingDynamic: dynamicPadding),   
                          OverMissionWidget(paddingDynamic: dynamicPadding),

                          if(!isUserLoggedIn)
                              AiPrecisionWidget(paddingDynamic: dynamicPadding),

                          if(!isUserLoggedIn)
                             HereToHelpWidget(paddingDynamic: dynamicPadding),

                          FeaturedPropertiesWidget(
                              paddingDynamic: dynamicPadding),
                              
                          if(!isUserLoggedIn)
                             GetHomeRecommendationsWidget(paddingDynamic: dynamicPadding),

                          if(!isUserLoggedIn)
                          FeaturedNewsWidget(paddingDynamic: dynamicPadding),
                         // PopularSearchesWidget(paddingDynamic: dynamicPadding),
                         
                          if(!isUserLoggedIn)
                          const MapWidget(),
                          
                          if(!isUserLoggedIn)
                          AskUserWidget(paddingDynamic: dynamicPadding),
                          FooterWidget(paddingDynamic: dynamicPadding),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
