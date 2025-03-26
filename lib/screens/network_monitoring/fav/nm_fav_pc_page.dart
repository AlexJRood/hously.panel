import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/data/network_monitoring/fav/provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/pie_menu/feed.dart';
import 'package:hously_flutter/widgets/appbar/hously/pc/appbar.dart';
import 'package:hously_flutter/widgets/appbar/hously/pc/newappbar.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/sidebar/sidebar_network_monitoring.dart';
import 'package:intl/intl.dart';
import 'package:pie_menu/pie_menu.dart';

import '../../../widgets/side_menu/slide_rotate_menu.dart';

class NMFavPcPage extends ConsumerWidget {
  const NMFavPcPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sideMenuKey = GlobalKey<SideMenuState>();

    final ScrollController scrollController = ScrollController();
    double screenWidth = MediaQuery.of(context).size.width;
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

    const double maxWidth = 1920;
    const double minWidth = 1080;

    const double maxDynamicPadding = 40;
    const double minDynamicPadding = 15;

    double dynamicPadding = (screenWidth - minWidth) /
            (maxWidth - minWidth) *
            (maxDynamicPadding - minDynamicPadding) +
        minDynamicPadding;
    dynamicPadding = dynamicPadding.clamp(minDynamicPadding, maxDynamicPadding);

    const double minBaseTextSize = 5;
    const double maxBaseTextSize = 15;
    double baseTextSize = (screenWidth - minWidth) /
            (maxWidth - minWidth) *
            (maxBaseTextSize - minBaseTextSize) +
        minBaseTextSize;
    baseTextSize = baseTextSize.clamp(minBaseTextSize, maxBaseTextSize);

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
               SidebarNetworkMonitoring(
                 sideMenuKey: sideMenuKey,
               ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      gradient: CustomBackgroundGradients.getMainMenuBackground(
                          context, ref)),
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: dynamicPadding, right: dynamicPadding),
                        child: CustomScrollView(
                          controller: scrollController,
                          slivers: [
                            const SliverToBoxAdapter(
                              child: SizedBox(
                                  height: 70), // Przestrzeń dla TopAppBar
                            ),
                            ref.watch(nMFavAdsProvider).when(
                                  data: (filteredAdvertisements) {
                                    if (filteredAdvertisements.isEmpty) {
                                      return SliverToBoxAdapter(
                                        child: Column(children: [
                                          const Spacer(),
                                          Text(
                                              'Upss... brak polubionych ogłoszeń.'
                                                  .tr,
                                              style:
                                                  AppTextStyles.interLight16),
                                          const Spacer(),
                                        ]),
                                      );
                                    }
                                    return SliverGrid(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: grid,
                                        childAspectRatio: 1.0,
                                        mainAxisSpacing: 1,
                                        crossAxisSpacing: 1,
                                      ),
                                      delegate: SliverChildBuilderDelegate(
                                        (context, index) {
                                          final feedAd =
                                              filteredAdvertisements[index];
                                          final keyTag =
                                              'feedAdKey${feedAd.id}-${UniqueKey().toString()}';
                                          String formattedPrice =
                                              customFormat.format(feedAd.price);

                                          final mainImageUrl =
                                              feedAd.images.isNotEmpty
                                                  ? feedAd.images[0]
                                                  : 'default_image_url';

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
                                                  handleDisplayedAction(
                                                      ref, feedAd.id, context);
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
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8.0),
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
                                                                child: Text(
                                                                    'Brak obrazu'
                                                                        .tr,
                                                                    style: TextStyle(
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
                                                                                18),
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
                                                                                14),
                                                                  ),
                                                                ),
                                                                Material(
                                                                  color: Colors
                                                                      .transparent,
                                                                  child: Text(
                                                                    '${feedAd.address!.city}, ${feedAd.address!.street}',
                                                                    style: AppTextStyles
                                                                        .interRegular
                                                                        .copyWith(
                                                                            fontSize:
                                                                                12),
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
                                            ),
                                          );
                                        },
                                        childCount:
                                            filteredAdvertisements.length,
                                      ),
                                    );
                                  },
                                  loading: () => const SliverFillRemaining(
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  ),
                                  error: (error, stack) => SliverFillRemaining(
                                    child: Center(
                                      child: Text('Wystąpił błąd: $error'.tr,
                                          style: AppTextStyles.interLight),
                                    ),
                                  ),
                                ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                                sigmaX: 4,
                                sigmaY: 4), // Adjust the blur intensity
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: CustomBackgroundGradients
                                    .backgroundGradientRight35(context, ref),
                              ), // Semi-transparent overlay to enhance the blur effect
                              child: const Padding(
                                padding: EdgeInsets.only(right: 20.0),
                                child: TopAppBar(),
                              ),
                            ),
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
    );
  }
}
