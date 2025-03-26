import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/portal/browselist/widget/pc.dart';
import 'package:hously_flutter/screens/feed/components/cards/selected_card.dart';

import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/models/ad/ad_list_view_model.dart';
import 'package:hously_flutter/screens/feed/map/map_page.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/utils/pie_menu/feed.dart';
import 'package:hously_flutter/widgets/appbar/hously/pc/appbar_map.dart';
import 'package:hously_flutter/widgets/loading/loading_widgets.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/sidebar/sidebar.dart';
import 'package:intl/intl.dart';
import 'package:pie_menu/pie_menu.dart';

import '../../../state_managers/data/filter_provider.dart';
import '../../../widgets/side_menu/slide_rotate_menu.dart';

class MapViewPcPage extends ConsumerStatefulWidget {
  const MapViewPcPage({super.key});

  @override
  MapViewPageState createState() => MapViewPageState();
}

class MapViewPageState extends ConsumerState<MapViewPcPage> {
  List<AdsListViewModel> filteredAds = [];
  final sideMenuKey = GlobalKey<SideMenuState>();

  void updateFilteredAds(List<AdsListViewModel> ads) {
    setState(() {
      filteredAds = ads;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final ScrollController scrollController = ScrollController();

    final themecolors = ref.watch(themeColorsProvider);
    final textColor = themecolors.themeTextColor;

    final textFieldColor = themecolors.textFieldColor;
    final color = Theme.of(context).primaryColor;
    final isDefaultDarkSystem = ref.watch(isDefaultDarkSystemProvider);

    
    final cardType = ref.read(selectedCardProvider);




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
          iconColor: Colors.red,
        ),
      ),
      child: Scaffold(
        body: SideMenuManager.sideMenuSettings(
          menuKey: sideMenuKey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Sidebar(
                sideMenuKey: sideMenuKey,
              ),
              Expanded(
                child: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                      gradient:
                          CustomBackgroundGradients.backgroundGradientRight1(
                              context, ref)),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        child: SizedBox(
                          width: screenWidth * 0.625,
                          height: double.infinity,
                          child: MapPage(
                            onFilteredAdsListViewsChanged: updateFilteredAds,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 10,
                        child: ShaderMask(
                          shaderCallback: (bounds) =>
                              CustomBackgroundGradients.appBarGradientcustom(
                                      context, ref)
                                  .createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                          ),
                          child: Text(
                            'HOUSLY.AI',
                            style: AppTextStyles.houslyAiLogo30.copyWith(
                                color: isDefaultDarkSystem ? textColor : color),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: screenWidth * 0.35,
                        child: const TopAppBarMap(),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: screenWidth * 0.35,
                          height: MediaQuery.of(context).size.height,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                            ),
                          ),
                          child: GestureDetector(
                            onVerticalDragUpdate: (details) {
                              scrollController.jumpTo(
                                  scrollController.offset - details.delta.dy);
                            },
                            child: ListView.builder(
                              controller: scrollController,
                              itemCount: filteredAds.length,
                              itemBuilder: (context, index) {
                                final ad = filteredAds[index];
                                final tag = 'mapViewPc${ad.id}${UniqueKey().toString()}';

                                final mainImageUrl = ad.images.isNotEmpty ? ad.images[0] : 'default_image_url';
                                final isPro = ad.isPro;


                                return  Container(
                                          margin: const EdgeInsets.only(bottom: 8),
                                    child: SelectedCardWidget(
                                    isMobile: false,
                                    aspectRatio: cardType.mapAspectRatio,
                                    ad: ad, 
                                    tag: tag, 
                                    mainImageUrl: mainImageUrl, 
                                    isPro: isPro, 
                                    isDefaultDarkSystem: isDefaultDarkSystem, 
                                    color: color, 
                                    textColor: textColor, 
                                    textFieldColor: textFieldColor, 
                                    buildShimmerPlaceholder: ShimmerPlaceholder(
                                                      width: screenWidth * 0.4,
                                                      height: (screenWidth * 0.4) *(16 / 9),
                                                    ),
                                    buildPieMenuActions: buildPieMenuActions(ref, ad, context),
                                    ),
                                  
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              BrowseListPcWidget(isWhiteSpaceNeeded: false)
            ],
          ),
        ),
      ),
    );
  }
}
