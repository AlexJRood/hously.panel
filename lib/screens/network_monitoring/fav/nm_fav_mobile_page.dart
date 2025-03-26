//lib/Pages/feed/feed_pc.dart

import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/route_constant.dart';

import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/data/network_monitoring/fav/provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/pie_menu/feed.dart';
import 'package:hously_flutter/widgets/appbar/hously/mobile/appbar_mobile.dart';
import 'package:hously_flutter/widgets/bottom_bar_mobile/bottom_bar.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:intl/intl.dart';
// Make sure the path is correct
import 'package:pie_menu/pie_menu.dart';

import '../../../widgets/side_menu/slide_rotate_menu.dart';

class NMFavMobilePage extends ConsumerWidget {
  const NMFavMobilePage({super.key});

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
      grid = 2;
    }

    const double maxWidth = 1920;
    const double minWidth = 480;
    // Ustawienie maksymalnego i minimalnego rozmiaru czcionki
    const double maxDynamicPadding = 40;
    const double minDynamicPadding = 10;
    // Obliczenie odpowiedniego rozmiaru czcionki
    double dynamicPadding = (screenWidth - minWidth) / (maxWidth - minWidth) * (maxDynamicPadding - minDynamicPadding) + minDynamicPadding;
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
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          child: GestureDetector(
                            onPanUpdate: (details) {
                              // Handling drag for scrolling
                              scrollController.jumpTo(scrollController.offset - details.delta.dy,);
                            },
                            child: ref.watch(nMFavAdsProvider).when(
                                  data: (filteredAdvertisements) =>
                                    CustomScrollView(controller: scrollController,
                                    slivers: [
                                      SliverGrid(
                                        gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: grid,
                                            childAspectRatio: 1.0,
                                            mainAxisSpacing: 0.0,
                                            crossAxisSpacing: 0.0,
                                        ),
                                        delegate: SliverChildBuilderDelegate(
                                          (context, index) {
                                            final feedAd = filteredAdvertisements[index];
                                            final keyTag = 'feedAdKey${feedAd.id}-${UniqueKey().toString()}';

                                            final mainImageUrl =feedAd.images.isNotEmpty
                                                    ? feedAd.images[0]
                                                    : 'default_image_url';
                                            String formattedPrice = customFormat.format(feedAd.price);

                                            return AspectRatio(
                                              aspectRatio: 1,
                                              child: PieMenu(
                                                onPressedWithDevice: (kind) {
                                                  if (kind == PointerDeviceKind.touch) {
                                                    handleDisplayedAction(
                                                        ref, feedAd.id, context);
                                                        ref.read(navigationService).pushNamedScreen(
                                                          '${Routes.networkMonitoring}/${feedAd.id}',
                                                      data: {'tag': keyTag, 'ad': feedAd},
                                                    );
                                                  }
                                                },
                                                actions: buildPieMenuActions(ref, feedAd, context),
                                                child: Hero(
                                                  tag: keyTag,
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(0),
                                                    child: Stack(
                                                      children: [
                                                        AspectRatio(
                                                          aspectRatio: 1,
                                                          child: FittedBox(
                                                            fit: BoxFit.cover,
                                                            child: Image.network(
                                                              mainImageUrl,
                                                              errorBuilder: (context, error, stackTrace) =>
                                                              Container(
                                                                color: Colors.grey,
                                                                alignment: Alignment.center,
                                                                child:  Text('Brak obrazu'.tr,
                                                                    style: TextStyle(color: Colors.white)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          left: 2,
                                                          bottom: 2,
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets.only(
                                                                    top: 5,
                                                                    bottom: 5,
                                                                    right: 8,
                                                                    left: 8),
                                                            decoration: BoxDecoration(
                                                              color: Colors.black.withOpacity(0.4),
                                                              borderRadius: BorderRadius.circular(8),
                                                            ),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  '$formattedPrice ${feedAd.currency}',
                                                                  style: AppTextStyles.interBold.copyWith(
                                                                    fontSize: 14,
                                                                    shadows: [
                                                                      Shadow(
                                                                        offset: const Offset(5.0, 5.0),
                                                                        blurRadius: 10.0,
                                                                        color: Colors.black.withOpacity(1),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Text(
                                                                  feedAd.title,
                                                                  style: AppTextStyles.interSemiBold.copyWith(
                                                                    fontSize: 12,
                                                                    shadows: [
                                                                      Shadow(
                                                                        offset: const Offset(5.0, 5.0),
                                                                        blurRadius: 10.0,
                                                                        color: Colors.black.withOpacity(1),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Text(
                                                                  '${feedAd.address!.city}, ${feedAd.address!.street}',
                                                                  style: AppTextStyles.interRegular.copyWith(
                                                                    fontSize: 10,
                                                                    shadows: [
                                                                      Shadow(
                                                                        offset: const Offset(5.0, 5.0),
                                                                        blurRadius:10.0,
                                                                        color: Colors.black.withOpacity(1),
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
                                              ),
                                            );
                                          },
                                          childCount: filteredAdvertisements.length,
                                        ),
                                      ),
                                    ],
                                  ),
                                  loading: () => const Center(
                                      child: CircularProgressIndicator()),
                                  error: (error, stack) => Center(
                                      child: Text('Wystąpił błąd: $error'.tr)),
                                ),
                          ),
                        ),
                      ),
                      const BottomBarMobile(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
