import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/widgets/landing_page/landing_page_pc/appbar_landingpage.dart';
import 'package:hously_flutter/widgets/landing_page/landing_page_pc/header_widget.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';
import 'package:hously_flutter/widgets/sidebar/apptour_sidebar.dart';
import 'package:pie_menu/pie_menu.dart';

import 'package:hously_flutter/const/backgroundgradient.dart';
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
  const LandingPagePc({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sideMenuKey = GlobalKey<SideMenuState>();
    double dynamicPadding = MediaQuery.of(context).size.width/6;
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
                    color: Color.fromRGBO(232, 235, 242, 1)
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        HeaderWidget(paddingDynamic: dynamicPadding),
                        ExclusiveOffersWidget(paddingDynamic: dynamicPadding),
                        OverMissionWidget(paddingDynamic: dynamicPadding),
                        AiPrecisionWidget(paddingDynamic: dynamicPadding),
                        HereToHelpWidget(paddingDynamic: dynamicPadding),
                        FeaturedPropertiesWidget(paddingDynamic: dynamicPadding),                        
                        GetHomeRecommendationsWidget(paddingDynamic: dynamicPadding),
                        FeaturedNewsWidget(paddingDynamic: dynamicPadding),
                        PopularSearchesWidget(paddingDynamic: dynamicPadding),
                        const MapWidget(),
                        AskUserWidget(paddingDynamic: dynamicPadding),
                        FooterWidget(paddingDynamic: dynamicPadding),
                      ],
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