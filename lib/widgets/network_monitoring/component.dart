import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/network_monitoring/state_managers/displayed/provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/pie_menu/network_monitoring.dart';
import 'package:hously_flutter/widgets/loading/loading_widgets.dart';
import 'package:intl/intl.dart';
import 'package:pie_menu/pie_menu.dart';

class NMRecentlyViewedAds extends ConsumerWidget {
  NMRecentlyViewedAds({super.key});

  String? selectedTag;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentlyViewedAdsAsyncValue = ref.watch(nMDisplayedAdsProvider);

    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = screenWidth / 1500 * 240;
    itemWidth = max(150.0, min(itemWidth, 250.0));
    double itemHeight = itemWidth * (300 / 260);

    double minBaseTextSize = 12;
    double maxBaseTextSize = 16;
    double baseTextSize = minBaseTextSize +
        (itemWidth - 150) / (240 - 150) * (maxBaseTextSize - minBaseTextSize);
    baseTextSize = max(minBaseTextSize, min(baseTextSize, maxBaseTextSize));
    NumberFormat customFormat = NumberFormat.decimalPattern('fr');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Ostatnio Oglądane'.tr,
            style: AppTextStyles.interSemiBold
                .copyWith(fontSize: baseTextSize + 6)),
        const SizedBox(height: 10.0),
        recentlyViewedAdsAsyncValue.when(
          data: (displayedAds) => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: displayedAds.map((displayedAd) {
                String formattedPrice = customFormat.format(displayedAd.price);
                final tag = 'recentlyViewed5-${displayedAd.id}-${UniqueKey().toString()}';
                final mainImageUrl =
                    displayedAd.images.isNotEmpty ? displayedAd.images[0] : '';
                return PieMenu(
                  onPressedWithDevice: (kind) {
                    if (kind == PointerDeviceKind.mouse ||
                        kind == PointerDeviceKind.touch) {
                      ref.read(navigationService).pushNamedScreen(
                        '${Routes.networkMonitoring}/offer/${displayedAd.id}',
                        data: {'tag': tag, 'ad': displayedAd},
                      );
                    }
                  },
                  actions: buildPieMenuActionsNM(ref, displayedAd, context),
                  child: Hero(
                    tag: tag,
                    child: Container(
                      width: itemWidth,
                      height: itemHeight,
                      margin: EdgeInsets.only(right: baseTextSize),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            imageUrl: mainImageUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => ShimmerPlaceholder(
                                width: itemWidth, height: itemHeight),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 2,
                            bottom: 2,
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 5, bottom: 5, right: 8, left: 8),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.25),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '$formattedPrice ${displayedAd.currency}',
                                    style: AppTextStyles.interBold.copyWith(
                                      fontSize: baseTextSize,
                                    ),
                                  ),
                                  Text(
                                    '${displayedAd.address!.city}, ${displayedAd.address!.street}',
                                    style: AppTextStyles.interRegular.copyWith(
                                      fontSize: baseTextSize - 2,
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
              }).toList(),
            ),
          ),
          loading: () => ShimmerLoadingRow(
              itemWidth: itemWidth,
              itemHeight: itemHeight,
              placeholderwidget:
                  ShimmerPlaceholder(width: itemWidth, height: itemHeight)),
          error: (error, stackTrace) => Text(
            'Wystąpił błąd: $error'.tr,
            style: AppTextStyles.interRegular.copyWith(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
