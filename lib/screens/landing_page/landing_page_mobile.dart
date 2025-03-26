import 'package:flutter/material.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/widgets/appbar/hously/mobile/appbar_mobile.dart';
import 'package:hously_flutter/widgets/bottom_bar_mobile/bottom_bar.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:pie_menu/pie_menu.dart';
import '../../widgets/landing_page/landing_page_mobile/ai_precision_widget.dart';
import '../../widgets/landing_page/landing_page_mobile/ask_user_widget.dart';
import '../../widgets/landing_page/landing_page_mobile/exclusive_offer_widget.dart';
import '../../widgets/landing_page/landing_page_mobile/footer_widget.dart';
import '../../widgets/landing_page/landing_page_mobile/get_home_recomendation_widget.dart';
import '../../widgets/landing_page/landing_page_mobile/header_widget.dart';
import '../../widgets/landing_page/landing_page_mobile/here_to_help_widget.dart';
import '../../widgets/landing_page/landing_page_mobile/over_mission_widget.dart';
import '../../widgets/landing_page/landing_page_pc/featured_news_widget.dart';
import '../../widgets/landing_page/landing_page_pc/featured_properties_widget.dart';
import '../../widgets/side_menu/slide_rotate_menu.dart';

class LandingPageMobile extends StatelessWidget {
  const LandingPageMobile({super.key});

  @override
  Widget build(BuildContext context) {
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
        backgroundColor: const Color.fromRGBO(232, 235, 242, 1),
        body: SideMenuManager.sideMenuSettings(
          menuKey: sideMenuKey,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(232, 235, 242, 1)),
                  child: Column(
                    spacing: 20,
                    children: [
                      HeaderWidget(
                        sideMenuKey: sideMenuKey,
                      ),
                      const ExclusiveOffersWidget(),
                      const OverMissionWidget(),
                      const AiPrecisionWidget(),
                      const HereToHelpWidget(),
                      const FeaturedPropertiesWidget(
                        paddingDynamic: 16,
                        isMobile: true,
                      ),
                      const GetHomeRecommendation(),
                      const FeaturedNewsWidget(
                        paddingDynamic: 16,
                        isMobile: true,
                      ),
                      Column(
                        children: [
                          Container(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 50),
                              child: FeaturedPropertiesWidget(
                                paddingDynamic: 16,
                                isMobile: true,
                              ),
                            ),
                          ),
                          Image.asset(
                            'assets/images/mapa.png',
                            height: 430,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                      const AskUserWidget(),
                      const FooterWidget()
                    ],
                  ),
                ),
              ),

                  const Positioned(
                    bottom:0,
                    right: 0,
                    child: BottomBarMobile(),),


                  Positioned(
                    top: 0,
                    right: 0,
                    child: AppBarMobile(sideMenuKey: sideMenuKey,),),
            ],
          ),
        ),
      ),
    );
  }
}
