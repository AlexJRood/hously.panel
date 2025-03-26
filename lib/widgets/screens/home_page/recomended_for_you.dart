import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/design.dart'; // Assume this is available
import 'package:hously_flutter/state_managers/data/home_page/listing_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/utils/pie_menu/feed.dart';
import 'package:hously_flutter/widgets/loading/loading_widgets.dart';
import 'package:intl/intl.dart';
import 'package:pie_menu/pie_menu.dart';

class RecomendedForYou extends ConsumerStatefulWidget {
  const RecomendedForYou({super.key});

  @override
  ConsumerState<RecomendedForYou> createState() => _RecomendedForYouState();
}

class _RecomendedForYouState extends ConsumerState<RecomendedForYou> {
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
    final listingsAsyncValue = ref.watch(listingsProvider); // Use provider

    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = screenWidth / 1500 * 400;
    itemWidth = max(250.0, min(itemWidth, 500.0));
    double itemHeight = itemWidth * (222 / 400);

    double minBaseTextSize = 10;
    double maxBaseTextSize = 14;
    double baseTextSize = minBaseTextSize +
        (itemWidth - 200) / (400 - 200) * (maxBaseTextSize - minBaseTextSize);
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
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            'Wybrane dla Ciebie'.tr,
            style: AppTextStyles.interSemiBold
                .copyWith(fontSize: baseTextSize + 8, color: textColor),
          ),
        ),
        const SizedBox(height: 20.0),
        listingsAsyncValue.when(
          data: (listings) => GestureDetector(
            onHorizontalDragUpdate: (details) {
              // Manually scroll by dragging
              _scrollController.jumpTo(
                _scrollController.offset - details.primaryDelta!,
              );
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              child: Row(
                children: listings.map((recommended) {
                  final tag =
                      'recommended${recommended.id}'; // Unique tag for each item
                  final formattedPrice = customFormat.format(recommended.price);
                  final mainImageUrl = recommended.images.isNotEmpty
                      ? recommended.images[0]
                      : '';

                  return PieMenu(
                    onPressedWithDevice: (kind) {
                      if (kind == PointerDeviceKind.mouse ||
                          kind == PointerDeviceKind.touch) {
                        ref.read(navigationService).pushNamedScreen(
                          '${Routes.homepage}/${recommended.id}',
                          data: {'tag': tag, 'ad': recommended},
                        );
                      }
                    },
                    actions: buildPieMenuActions(ref, recommended, context),
                    child: Hero(
                      tag: tag,
                      child: Container(
                        width: itemWidth,
                        height: itemHeight,
                        margin: const EdgeInsets.only(right: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: mainImageUrl,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => ShimmerPlaceholder(
                                width: itemWidth,
                                height: itemHeight,
                              ),
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
                              left: 2.0,
                              bottom: 2.0,
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
                                      '$formattedPrice ${recommended.currency}',
                                      style: AppTextStyles.interBold.copyWith(
                                          fontSize: baseTextSize + 2,
                                          color: textColor),
                                    ),
                                    Text(
                                      '${recommended.city}, ${recommended.street}',
                                      style: AppTextStyles.interSemiBold
                                          .copyWith(
                                              fontSize: baseTextSize,
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
