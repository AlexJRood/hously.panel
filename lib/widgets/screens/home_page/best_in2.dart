import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/data/home_page/listing_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/utils/pie_menu/feed.dart';
import 'package:hously_flutter/widgets/drad_scroll_widget.dart';
import 'package:hously_flutter/widgets/loading/loading_widgets.dart';
import 'package:intl/intl.dart';
import 'package:pie_menu/pie_menu.dart';

class BestIn2 extends ConsumerStatefulWidget {
  const BestIn2({super.key});

  @override
  ConsumerState<BestIn2> createState() => _BestIn2State();
}

class _BestIn2State extends ConsumerState<BestIn2> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recentlyViewedAdsAsyncValue = ref.watch(listingsProvider);

    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = screenWidth / 1500 * 350;
    itemWidth = max(150.0, min(itemWidth, 350.0));
    double itemHeight = itemWidth;

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(
              width: 8,
            ),
            Text('Best in',
                style: AppTextStyles.interSemiBold
                    .copyWith(fontSize: baseTextSize + 6, color: textColor)),
          ],
        ),
        const SizedBox(height: 20.0),
        recentlyViewedAdsAsyncValue.when(
          data: (displayedAds) => DragScrollView(
            controller: _scrollController,
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: displayedAds.asMap().entries.map((entry) {
                  final index = entry.key;
                  final bestin = entry.value;
                  final tag = 'bestin2_${bestin.id}_$index-${UniqueKey().toString()}';
                  String formattedPrice = customFormat.format(bestin.price);
                  final mainImageUrl =
                      bestin.images.isNotEmpty ? bestin.images[0] : '';
                  return PieMenu(
                    onPressedWithDevice: (kind) {
                      if (kind == PointerDeviceKind.mouse ||
                          kind == PointerDeviceKind.touch) {
                        ref.read(navigationService).pushNamedScreen(
                          '${Routes.homepage}/${bestin.id}',
                          data: {'tag': tag, 'ad': bestin},
                        );
                      }
                    },
                    actions: buildPieMenuActions(ref, bestin, context),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '$formattedPrice ${bestin.currency}',
                                      style: AppTextStyles.interBold.copyWith(
                                          fontSize: baseTextSize,
                                          color: textColor),
                                    ),
                                    Text(
                                      '${bestin.city}, ${bestin.street}',
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
          loading: () => ShimmerLoadingRow(
            itemWidth: itemWidth,
            itemHeight: itemHeight,
            placeholderwidget:
                ShimmerPlaceholder(width: itemWidth, height: itemHeight),
          ),
          error: (error, stack) => Center(
            child: Text(
              'Wystąpił błąd: $error'.tr,
              style: AppTextStyles.interRegular
                  .copyWith(fontSize: 16, color: textColor),
            ),
          ),
        ),
      ],
    );
  }
}
