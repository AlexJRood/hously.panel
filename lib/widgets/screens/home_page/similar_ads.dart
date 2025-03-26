import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/data/feed/feed_pop/providers/similarads_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/utils/pie_menu/feed.dart';
import 'package:hously_flutter/widgets/drad_scroll_widget.dart';
import 'package:hously_flutter/widgets/loading/loading_widgets.dart';
import 'package:intl/intl.dart';
import 'package:pie_menu/pie_menu.dart';

class SimilarAds extends ConsumerStatefulWidget {
  final String offerid;

  const SimilarAds({super.key, required this.offerid});

  @override
  ConsumerState<SimilarAds> createState() => _SimilarAdsState();
}

class _SimilarAdsState extends ConsumerState<SimilarAds> {
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
    final similaradProvider = ref.watch(similarProvider(widget.offerid));

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
            Text('Podobne ogłoszenia'.tr,
                style: AppTextStyles.interSemiBold.copyWith(
                    fontSize: baseTextSize + 6,
                    color: themecolors.popUpIconColor)),
          ],
        ),
        const SizedBox(height: 20.0),
        similaradProvider.when(
          data: (similarOffers) => DragScrollView(
            controller: _scrollController,
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: similarOffers.map((similarOffers) {
                  String formattedPrice =
                      customFormat.format(similarOffers.price);
                  final tag = 'SimilarAds${similarOffers.id}-${UniqueKey().toString()}';
                  final mainImageUrl = similarOffers.images.isNotEmpty
                      ? similarOffers.images[0]
                      : '';

                  return PieMenu(
                    onPressedWithDevice: (kind) {
                      if (kind == PointerDeviceKind.mouse ||
                          kind == PointerDeviceKind.touch) {
                        ref.read(navigationService).pushNamedScreen(
                            '${Routes.feedView}/${similarOffers.id}',
                            data: {'tag': tag, 'ad': similarOffers});
                      }
                    },
                    actions: buildPieMenuActions(ref, similarOffers, context),
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
                                      '$formattedPrice ${similarOffers.currency}',
                                      style: AppTextStyles.interBold.copyWith(
                                          fontSize: baseTextSize,
                                          color: textColor),
                                    ),
                                    Text(
                                      '${similarOffers.city}, ${similarOffers.street}',
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
