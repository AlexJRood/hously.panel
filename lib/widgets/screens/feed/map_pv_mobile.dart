import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/models/ad/ad_list_view_model.dart';
import 'package:hously_flutter/screens/feed/map/map_page.dart';
import 'package:hously_flutter/widgets/appbar/hously/mobile/appbar_mobile.dart';

import '../../side_menu/side_menu_manager.dart';
import '../../side_menu/slide_rotate_menu.dart';

final filteredAdsProvider = StateProvider<List<AdsListViewModel>>((ref) {
  return [];
});

class MapPvMobile extends ConsumerStatefulWidget {
  const MapPvMobile({super.key, required this.pageController});

  final PageController pageController;

  @override
  _MapViewPageState createState() => _MapViewPageState();
}

class _MapViewPageState extends ConsumerState<MapPvMobile>
    with AutomaticKeepAliveClientMixin {
  void updateFilteredAds(List<AdsListViewModel> ads) {
    ref.read(filteredAdsProvider.notifier).state = ads;
  }

  @override
  Widget build(BuildContext context) {
    super.build(
        context); // Important to call super.build(context) for AutomaticKeepAliveClientMixin
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final sideMenuKey = GlobalKey<SideMenuState>();

    return SideMenuManager.sideMenuSettings(
      menuKey: sideMenuKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              height: double.infinity,
              decoration:  BoxDecoration(
                gradient: CustomBackgroundGradients.getMainMenuBackground(context,ref)
              ),
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: screenHeight,
                    child: MapPage(
                      onFilteredAdsListViewsChanged: updateFilteredAds,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: ShaderMask(
                      shaderCallback: (bounds) =>
                          BackgroundGradients.appBarGradient.createShader(bounds),
                      child:  AppBarMobile(sideMenuKey: sideMenuKey,),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: screenWidth * 0.25,
                      color: Colors.transparent,
                    ),

                  ),


                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true; // Keep the state alive
}
