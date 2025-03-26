import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/colors.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/data/feed/feed_pop/providers/nearby_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/utils/pie_menu/feed.dart';
import 'package:hously_flutter/widgets/loading/loading_widgets.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class NearbyAds extends ConsumerWidget {
  final String offerId;

  const NearbyAds({super.key, required this.offerId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nearbyAdsAsyncValue = ref.watch(nearbyadsProvider(offerId));
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

// Reduce itemWidth and itemHeight by 25%
    double itemWidth = screenWidth / 1920 * 240 * 0.50;
    double itemheight = itemWidth * 3.59 * 0.50;

// Constrain itemWidth between 150 and 300, reduced by 25%
    itemWidth = max(150.0 * 0.50, min(itemWidth, 300.0 * 0.50));

    double minBaseTextSize = 14 * 0.50; // Reduce by 25%
    double maxBaseTextSize = 18 * 0.50; // Reduce by 25%

// Adjust baseTextSize calculation
    double baseTextSize = minBaseTextSize +
        (itemWidth - 150 * 0.50) /
            (240 * 0.50 - 150 * 0.50) *
            (maxBaseTextSize - minBaseTextSize);

// Clamp baseTextSize to the new min and max
    baseTextSize = max(minBaseTextSize, min(baseTextSize, maxBaseTextSize));

// NumberFormat remains unchanged
    NumberFormat customFormat = NumberFormat.decimalPattern('fr');

// Use themecolors as before
    final themecolors = ref.watch(themeColorsProvider);

    final textFieldColor = themecolors.textFieldColor;
    final textColor = themecolors.themeTextColor;
    final colorscheme = Theme.of(context).primaryColor;
    final isDefaultDarkSystem = ref.watch(isDefaultDarkSystemProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text('Ogłoszenia w pobliżu'.tr,
              style: AppTextStyles.interSemiBold18
                  .copyWith(color: themecolors.popUpIconColor)),
        ),
        const SizedBox(height: 20),
        nearbyAdsAsyncValue.when(
          data: (adsnearme) => CarouselSlider.builder(
            itemCount: adsnearme.length,
            options: CarouselOptions(
              enlargeCenterPage: true,
              aspectRatio: 2.2,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
            ),
            itemBuilder: (context, index, realIndex) {
              if (adsnearme.isEmpty) {
                return const SizedBox.shrink();
              }
              final ad = adsnearme[index];
              final tag = 'adsnearme${ad.id}-${UniqueKey().toString()}';
              String formattedPrice = customFormat.format(ad.price);
              String mainImageUrl =
                  ad.images.isNotEmpty ? ad.images[0] : 'default_image_url';

              return GestureDetector(
                onTap: () {
                  handleDisplayedAction(ref, ad.id, context);
                  ref.read(navigationService).pushNamedScreen(
                    '${Routes.feedView}/${ad.id}',
                    data: {'tag': tag, 'ad': ad},
                  );
                },
                child: Hero(
                  tag: tag,
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: mainImageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Shimmer.fromColors(
                           baseColor:ShimmerColors.base(context),
                                 
                              highlightColor: ShimmerColors.highlight(context),
                          child: Container(
                            decoration: BoxDecoration(
                               color:ShimmerColors.background(context),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
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
                            color: isDefaultDarkSystem
                                ? textFieldColor.withOpacity(0.5)
                                : colorscheme.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$formattedPrice ${ad.currency}',
                                style: AppTextStyles.interBold.copyWith(
                                    fontSize: baseTextSize + 2,
                                    color: textColor),
                              ),
                              Text(
                                ad.title,
                                style: AppTextStyles.interSemiBold.copyWith(
                                    fontSize: baseTextSize, color: textColor),
                              ),
                              Text(
                                '${ad.city}, ${ad.street}',
                                style: AppTextStyles.interRegular.copyWith(
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
              );
            },
          ),
          loading: () => Carouselloading(
            height: itemheight,
          ),
          error: (error, stackTrace) => Text('Wystąpił błąd: $error'.tr,
              style: AppTextStyles.interMedium.copyWith(color: textColor)),
        ),
      ],
    );
  }

  ImageConfiguration createImageConfiguration(BuildContext context) {
    return ImageConfiguration(
      bundle: DefaultAssetBundle.of(context),
      devicePixelRatio: MediaQuery.of(context).devicePixelRatio,
      locale: Localizations.localeOf(context),
      textDirection: Directionality.of(context),
      size: MediaQuery.of(context).size,
      platform: Theme.of(context).platform,
    );
  }
}
