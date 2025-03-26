import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/models/ad/ad_list_view_model.dart';
import 'package:hously_flutter/screens/feed/map/map_page.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/utils/pie_menu/feed.dart';
import 'package:hously_flutter/widgets/appbar/hously/mobile/appbar_mobile.dart';
import 'package:hously_flutter/widgets/bottom_bar_mobile/bottom_bar.dart';
import 'package:hously_flutter/widgets/bottom_bar_mobile/feed_bar.dart';
import 'package:hously_flutter/widgets/installpopup/install_popup.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:intl/intl.dart';
import 'package:pie_menu/pie_menu.dart';

import '../../../widgets/side_menu/slide_rotate_menu.dart';

class MapViewMobilePage extends ConsumerStatefulWidget {
  const MapViewMobilePage({super.key});

  @override
  MapViewPageState createState() => MapViewPageState();
}

class MapViewPageState extends ConsumerState<MapViewMobilePage> {
  List<AdsListViewModel> filteredAds = [];
  final sideMenuKey = GlobalKey<SideMenuState>();

  void updateFilteredAds(List<AdsListViewModel> ads) {
    setState(() {
      filteredAds = ads;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final ScrollController scrollController = ScrollController();
    double screenPadding = screenWidth / 430 * 15;

    final themecolors = ref.watch(themeColorsProvider);
    final textColor = themecolors.themeTextColor;
    final color = Theme.of(context).primaryColor;
    final isDefaultDarkSystem = ref.watch(isDefaultDarkSystemProvider);

    final textFieldColor = themecolors.textFieldColor;
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
      child: PopupListener(
        child: SafeArea(
          child: Scaffold(
            body: SideMenuManager.sideMenuSettings(
              menuKey: sideMenuKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                          gradient:
                              CustomBackgroundGradients.appBarGradientcustom(
                                  context, ref)),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              height: screenHeight * 0.4,
                              child: MapPage(
                                onFilteredAdsListViewsChanged:
                                    updateFilteredAds, // Pass the callback function to MapPage
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: ShaderMask(
                                shaderCallback: (bounds) => BackgroundGradients
                                    .appBarGradient
                                    .createShader(bounds),
                                child: AppBarMobile(
                                  sideMenuKey: sideMenuKey,
                                )),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: screenWidth,
                              height: screenHeight * 0.6,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                ),
                              ),
                              child: GestureDetector(
                                onVerticalDragUpdate: (details) {
                                  scrollController.jumpTo(
                                      scrollController.offset -
                                          details.delta.dy);
                                },
                                child: ListView.builder(
                                  controller: scrollController,
                                  itemCount: filteredAds.length,
                                  itemBuilder: (context, index) {
                                    final ad = filteredAds[index];
                                    final tag = 'mapViewMobile${ad.id}';
                                    final mainImageUrl = ad.images.isNotEmpty
                                        ? ad.images[0]
                                        : 'default_image_url';
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 5.0),
                                      child: AspectRatio(
                                        aspectRatio: 16 / 10,
                                        child: PieMenu(
                                            onPressedWithDevice: (kind) {
                                              if (kind ==
                                                      PointerDeviceKind.mouse ||
                                                  kind ==
                                                      PointerDeviceKind.touch) {
                                                handleDisplayedAction(
                                                    ref, ad.id, context);
                                                ref
                                                    .read(navigationService)
                                                    .pushNamedScreen(
                                                  '${Routes.mapView}/${ad.id}',
                                                  data: {'tag': tag, 'ad': ad},
                                                );
                                              }
                                            },
                                            actions: buildPieMenuActions(
                                                ref, ad, context),
                                            child: Hero(
                                              tag: tag,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: ad.isPro
                                                      ? Border.all(
                                                          color: Colors.white,
                                                          width: 5.0)
                                                      : null,
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Stack(
                                                    children: [
                                                      AspectRatio(
                                                        aspectRatio: 16 / 10,
                                                        child: FittedBox(
                                                          fit: BoxFit.cover,
                                                          child: Image.network(
                                                            mainImageUrl,
                                                            errorBuilder: (context,
                                                                    error,
                                                                    stackTrace) =>
                                                                Container(
                                                              color:
                                                                  Colors.grey,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                'Brak obrazu'
                                                                    .tr,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      // Sponsored badge for Pro ads
                                                      if (ad.isPro)
                                                        Positioned(
                                                          right: 8,
                                                          top: 8,
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 4,
                                                                    horizontal:
                                                                        10),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppColors
                                                                  .light,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                            ),
                                                            child: Text(
                                                              'Sponsored',
                                                              style: AppTextStyles
                                                                  .interMedium12dark,
                                                            ),
                                                          ),
                                                        ),
                                                      Positioned(
                                                        left: 2,
                                                        bottom: 2,
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 5,
                                                                  bottom: 5,
                                                                  right: 8,
                                                                  left: 8),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: isDefaultDarkSystem
                                                                ? textFieldColor
                                                                    .withOpacity(
                                                                        0.5)
                                                                : color
                                                                    .withOpacity(
                                                                        0.5),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                '${NumberFormat.decimalPattern().format(ad.price)} ${ad.currency}',
                                                                style: AppTextStyles
                                                                    .interBold
                                                                    .copyWith(
                                                                  fontSize: 18,
                                                                  color:
                                                                      textColor,
                                                                  shadows: [
                                                                    Shadow(
                                                                      offset: const Offset(
                                                                          5.0,
                                                                          5.0),
                                                                      blurRadius:
                                                                          10.0,
                                                                      color: isDefaultDarkSystem
                                                                          ? textFieldColor.withOpacity(
                                                                              0.5)
                                                                          : color
                                                                              .withOpacity(0.5),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Text(
                                                                ad.title,
                                                                style: AppTextStyles
                                                                    .interSemiBold
                                                                    .copyWith(
                                                                  color:
                                                                      textColor,
                                                                  fontSize: 14,
                                                                  shadows: [
                                                                    Shadow(
                                                                      offset: const Offset(
                                                                          5.0,
                                                                          5.0),
                                                                      blurRadius:
                                                                          10.0,
                                                                      color: isDefaultDarkSystem
                                                                          ? textFieldColor.withOpacity(
                                                                              0.5)
                                                                          : color
                                                                              .withOpacity(0.5),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Text(
                                                                '${ad.city}, ${ad.street}',
                                                                style: AppTextStyles
                                                                    .interRegular
                                                                    .copyWith(
                                                                  fontSize: 12,
                                                                  color:
                                                                      textColor,
                                                                  shadows: [
                                                                    Shadow(
                                                                      offset: const Offset(
                                                                          5.0,
                                                                          5.0),
                                                                      blurRadius:
                                                                          10.0,
                                                                      color: isDefaultDarkSystem
                                                                          ? textFieldColor.withOpacity(
                                                                              0.5)
                                                                          : color
                                                                              .withOpacity(0.5),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          if (ref.watch(bottomBarVisibilityProvider)) ...[
                            const Positioned(
                              bottom: 0,
                              child: BottomBarMobile(),
                            ),
                          ],
                          Positioned(
                              bottom: ref.watch(bottomBarVisibilityProvider)
                                  ? 50
                                  : 5,
                              left: screenPadding * 2,
                              right: screenPadding * 2,
                              child: FeedBarMobile(
                                  screenPadding: screenPadding, ref: ref)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
