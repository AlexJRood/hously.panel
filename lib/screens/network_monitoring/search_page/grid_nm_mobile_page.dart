//lib/Pages/feed/feed_pc.dart

import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/route_constant.dart';

import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/data/filter_provider.dart'; // Make sure the path is correct
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/pie_menu/feed.dart';
import 'package:hously_flutter/widgets/appbar/hously/mobile/appbar_mobile.dart';
import 'package:hously_flutter/widgets/bottom_bar_mobile/bottom_bar.dart';
import 'package:hously_flutter/widgets/bottom_bar_mobile/feed_bar.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:intl/intl.dart';
import 'package:pie_menu/pie_menu.dart';

import '../../../widgets/side_menu/slide_rotate_menu.dart';

class GridNMMobilePage extends ConsumerWidget {
  const GridNMMobilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController scrollController = ScrollController();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenPadding = screenWidth / 430 * 15;
    NumberFormat customFormat = NumberFormat.decimalPattern('fr');

    int grid;
    if (screenWidth >= 1440) {
      grid = math.max(1, (screenWidth / 500).ceil());
    } else if (screenWidth >= 1080) {
      grid = 3;
    } else if (screenWidth >= 600) {
      grid = 2;
    } else {
      grid = 1;
    }
    final sideMenuKey = GlobalKey<SideMenuState>();


    const double maxWidth = 1080;
    const double minWidth = 350;
    // Ustawienie maksymalnego i minimalnego rozmiaru czcionki
    const double maxDynamicPadding = 15;
    const double minDynamicPadding = 5;
    // Obliczenie odpowiedniego rozmiaru czcionki
    double dynamicPadding = (screenWidth - minWidth) /
            (maxWidth - minWidth) *
            (maxDynamicPadding - minDynamicPadding) +
        minDynamicPadding;
    // Ograniczenie rozmiaru czcionki do zdefiniowanych minimum i maksimum
    dynamicPadding = dynamicPadding.clamp(minDynamicPadding, maxDynamicPadding);
    // Oblicz proporcję szerokości
     
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
          body: SideMenuManager.sideMenuSettings(
            menuKey: sideMenuKey,
            child: Stack(
              children: [
                Container(
                  decoration:  BoxDecoration(
                    gradient: CustomBackgroundGradients.getMainMenuBackground(context,ref)
                  ),
                  child: Column(
                    children: [
                       AppBarMobile(sideMenuKey: sideMenuKey,),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: dynamicPadding,
                            right: dynamicPadding,
                          ),
                          child: GestureDetector(
                            onPanUpdate: (details) {
                              // Handling drag for scrolling
                              // _scrollController.jumpTo(
                              //   _scrollController.offset - details.delta.dy,
                              // );
                            },
                            child: ref.watch(filterProvider).when(
                                  data: (filteredAdvertisements) {
                                    if (filteredAdvertisements.isEmpty) {
                                      return Center(
                                        child: Text(
                                            'Upss... brak wyników wyszukiwania. Poszerz kryteria wyszukiwania.'.tr,
                                            style: AppTextStyles.interLight16),
                                      );
                                    }
                                    return CustomScrollView(
                                      controller: scrollController,
                                      slivers: [
                                        SliverGrid(
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: grid,
                                            childAspectRatio: 1.0,
                                            mainAxisSpacing: 5.0,
                                            crossAxisSpacing: 5.0,
                                          ),
                                          delegate: SliverChildBuilderDelegate(
                                            (context, index) {
                                              final feedAd =
                                                  filteredAdvertisements[index];
                                              final keyTag =
                                                  'feedAdKey${feedAd.id}-${UniqueKey().toString()}';

                                              final mainImageUrl =
                                                  feedAd.images.isNotEmpty
                                                      ? feedAd.images[0]
                                                      : 'default_image_url';
                                              String formattedPrice = customFormat
                                                  .format(feedAd.price);

                                              return AspectRatio(
                                                aspectRatio: 1,
                                                child: PieMenu(
                                                  onPressedWithDevice: (kind) {
                                                    if (kind ==
                                                            PointerDeviceKind
                                                                .mouse ||
                                                        kind ==
                                                            PointerDeviceKind
                                                                .touch) {
                                                      handleDisplayedAction(ref,
                                                          feedAd.id, context);
                                                      ref
                                                          .read(navigationService)
                                                          .pushNamedScreen(
                                                        '${Routes.networkMonitoring}/${feedAd.id}',
                                                        data: {
                                                          'tag': keyTag,
                                                          'ad': feedAd
                                                        },
                                                      );
                                                    }
                                                  },
                                                  actions: buildPieMenuActions(
                                                      ref, feedAd, context),
                                                  child: Hero(
                                                    tag: keyTag,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      child: Stack(
                                                        children: [
                                                          AspectRatio(
                                                            aspectRatio: 1,
                                                            child: FittedBox(
                                                              fit: BoxFit.cover,
                                                              child:
                                                                  Image.network(
                                                                mainImageUrl,
                                                                errorBuilder:
                                                                    (context,
                                                                            error,
                                                                            stackTrace) =>
                                                                        Container(
                                                                  color:
                                                                      Colors.grey,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child:  Text(
                                                                      'Brak obrazu'.tr,
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .white)),
                                                                ),
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
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.4),
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
                                                                  Material(
                                                                    color: Colors
                                                                        .transparent,
                                                                    child: Text(
                                                                      '$formattedPrice ${feedAd.currency}',
                                                                      style: AppTextStyles
                                                                          .interBold
                                                                          .copyWith(
                                                                        fontSize:
                                                                            18,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Material(
                                                                    color: Colors
                                                                        .transparent,
                                                                    child: Text(
                                                                      feedAd
                                                                          .title,
                                                                      style: AppTextStyles
                                                                          .interSemiBold
                                                                          .copyWith(
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Material(
                                                                    color: Colors
                                                                        .transparent,
                                                                    child: Text(
                                                                      '${feedAd.city}, ${feedAd.street}',
                                                                      style: AppTextStyles
                                                                          .interRegular
                                                                          .copyWith(
                                                                        fontSize:
                                                                            12,
                                                                      ),
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
                                                ),
                                              );
                                            },
                                            childCount:
                                                filteredAdvertisements.length,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                  loading: () => const Center(
                                      child: CircularProgressIndicator()),
                                  error: (error, stack) => Center(
                                      child: Text('Wystąpił błąd: $error'.tr)),
                                ),
                          ),
                        ),
                      ),
                      if (ref.watch(bottomBarVisibilityProvider)) ...[
                        const BottomBarMobile(),
                      ],
                    ],
                  ),
                ),
                Positioned(
                    bottom: ref.watch(bottomBarVisibilityProvider) ? 50 : 5,
                    left: screenPadding * 2,
                    right: screenPadding * 2,
                    child: FeedBarMobile(screenPadding: screenPadding, ref: ref)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
