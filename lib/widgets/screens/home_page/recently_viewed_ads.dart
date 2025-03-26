import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/data/profile/displayed/displayed_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/utils/pie_menu/feed.dart';
import 'package:hously_flutter/widgets/drad_scroll_widget.dart';
import 'package:hously_flutter/widgets/loading/loading_widgets.dart';
import 'package:intl/intl.dart';
import 'package:pie_menu/pie_menu.dart';

class RecentlyViewedAds extends ConsumerWidget {
  final double paddingDynamic;

  const RecentlyViewedAds({super.key,
    required this.paddingDynamic,
    });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentlyViewedAdsAsyncValue = ref.watch(displayedAdsProvider);

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
    final themecolors = ref.watch(themeColorsProvider);
    final textFieldColor = themecolors.textFieldColor;
    final textColor = themecolors.themeTextColor;
    final colorscheme = Theme.of(context).primaryColor;
    final isDefaultDarkSystem = ref.watch(isDefaultDarkSystemProvider);
    ScrollController _scrollController = ScrollController();
    final dynamicVerticalPadding = paddingDynamic / 6;


    return Padding(
      padding: EdgeInsets.symmetric(vertical: dynamicVerticalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left:paddingDynamic ),
            child: Text('Ostatnio Oglądane'.tr,
                style: AppTextStyles.libreCaslonHeading.copyWith(
                    fontSize: baseTextSize + 6,
                    color: Colors.black
                    //Theme.of(context).iconTheme.color
                    )),
          ),
          const SizedBox(height: 10.0),
          recentlyViewedAdsAsyncValue.when(
            data: (displayedAds) => DragScrollView(
              controller: _scrollController,
              child: SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: paddingDynamic),
                  child: Row(
                    children: displayedAds.map((displayedAd) {
                      String formattedPrice =
                          customFormat.format(displayedAd.price);
                     final tag = 'recentlyViewed6-${displayedAd.id}${UniqueKey().toString()}';
                      final mainImageUrl = displayedAd.images.isNotEmpty
                          ? displayedAd.images[0]
                          : '';
                      return PieMenu(
                        onPressedWithDevice: (kind) {
                          if (kind == PointerDeviceKind.mouse ||
                              kind == PointerDeviceKind.touch) {
                            ref.read(navigationService).pushNamedScreen(
                              '${Routes.homepage}/${displayedAd.id}',
                              data: {'tag': tag, 'ad': displayedAd},
                            );
                          }
                        },
                        actions: buildPieMenuActions(ref, displayedAd, context),
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
                                  placeholder: (context, url) =>
                                      ShimmerPlaceholder(
                                          width: itemWidth, height: itemHeight),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
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
                                      color: isDefaultDarkSystem
                                          ? textFieldColor.withOpacity(0.5)
                                          : colorscheme.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '$formattedPrice ${displayedAd.currency}',
                                          style: AppTextStyles.interBold.copyWith(
                                              fontSize: baseTextSize,
                                              color: textColor),
                                        ),
                                        Text(
                                          '${displayedAd.city}, ${displayedAd.street}',
                                          style: AppTextStyles.interRegular
                                              .copyWith(
                                                  fontSize: baseTextSize - 2,
                                                  color: textColor),
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
      ),
    );
  }
}
