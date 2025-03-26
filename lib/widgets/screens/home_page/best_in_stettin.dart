import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/design.dart'; // Załóżmy, że jest dostępny;
import 'package:hously_flutter/state_managers/data/home_page/listing_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/widgets/loading/loading_widgets.dart';
import 'package:intl/intl.dart';

class BestInStettin extends ConsumerWidget {
  const BestInStettin({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listingsAsyncValue = ref.watch(listingsProvider); // Używamy providera

    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = screenWidth / 1920 * 400;
    itemWidth = max(250.0, min(itemWidth, 500.0));
    double itemHeight = itemWidth * (222 / 400);

    double minBaseTextSize = 10;
    double maxBaseTextSize = 14;
    double baseTextSize = minBaseTextSize +
        (itemWidth - 200) / (400 - 200) * (maxBaseTextSize - minBaseTextSize);
    baseTextSize = max(minBaseTextSize, min(baseTextSize, maxBaseTextSize));
    final themecolors = ref.watch(themeColorsProvider);
    final textColor = themecolors.themeTextColor;
    final colorscheme = Theme.of(context).primaryColor;
    final textFieldColor = themecolors.textFieldColor;
    final isDefaultDarkSystem = ref.watch(isDefaultDarkSystemProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Wybrane dla Ciebie'.tr,
          style: AppTextStyles.interRegular
              .copyWith(fontSize: 24, color: textColor),
        ),
        const SizedBox(height: 10.0),
        listingsAsyncValue.when(
          data: (listings) => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: listings.map((bestIn) {
                final tag = 'bestIn3${bestIn.id}-${UniqueKey().toString()}'; // Unikalny tag dla każdego elementu
                // Wybieramy pierwszy obraz z listy jako główne zdjęcie, zakładamy, że lista nie jest pusta
                final mainImageUrl =
                    bestIn.images.isNotEmpty ? bestIn.images[0] : '';
                return Listener(
                  onPointerDown: (PointerDownEvent event) {
                    if (event.kind == PointerDeviceKind.mouse) {
                      if (event.buttons == kPrimaryMouseButton) {
                        // Lewy przycisk myszy
                        ref.read(navigationService).pushNamedScreen(
                          '${Routes.homepage}/${bestIn.id}',
                          data: {'tag': tag, 'ad': bestIn},
                        );
                      } else if (event.kind == PointerDeviceKind.mouse &&
                          event.buttons == kSecondaryMouseButton) {
                        final RenderBox overlay = Overlay.of(context)
                            .context
                            .findRenderObject() as RenderBox;
                        final Offset tapPosition =
                            overlay.globalToLocal(event.position);

                        showMenu(
                          context: context,
                          position: RelativeRect.fromLTRB(tapPosition.dx,
                              tapPosition.dy, tapPosition.dx, tapPosition.dy),
                          items: <PopupMenuEntry>[
                            PopupMenuItem(
                              child: Text('Dodaj do ulubionych'.tr),
                              onTap: () {
                                // Logika dodawania do ulubionych
                              },
                            ),
                            PopupMenuItem(
                              child: Text('Udostępnij'.tr),
                              onTap: () {
                                // Logika udostępniania
                              },
                            ),
                            PopupMenuItem(
                              child: Text('Ukryj ogłoszenie'.tr),
                              onTap: () {
                                // Logika ukrywania ogłoszenia
                              },
                            ),
                          ],
                        );
                      }
                    }
                  },
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
                                    '${NumberFormat.decimalPattern().format(bestIn.price)} ${bestIn.currency}',
                                    style: AppTextStyles.interBold.copyWith(
                                      fontSize: 18,
                                      color: textColor,
                                      shadows: [
                                        Shadow(
                                          offset: const Offset(5.0, 5.0),
                                          blurRadius: 10.0,
                                          color: isDefaultDarkSystem
                                              ? textFieldColor.withOpacity(1)
                                              : colorscheme.withOpacity(1),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '${bestIn.city}, ${bestIn.street}',
                                    style: AppTextStyles.interSemiBold.copyWith(
                                      fontSize: 14,
                                      color: textColor,
                                      shadows: [
                                        Shadow(
                                          offset: const Offset(5.0, 5.0),
                                          blurRadius: 10.0,
                                          color: isDefaultDarkSystem
                                              ? textFieldColor.withOpacity(1)
                                              : colorscheme.withOpacity(1),
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
                );
              }).toList(),
            ),
          ),
          loading: () => ShimmerLoadingRow(
              itemWidth: itemWidth,
              itemHeight: itemHeight,
              placeholderwidget:
                  ShimmerPlaceholder(width: itemWidth, height: itemHeight)),
          error: (error, stack) => Center(
              child: Text(
            'Wystąpił błąd: $error'.tr,
            style: AppTextStyles.interRegular
                .copyWith(fontSize: 16, color: textColor),
          )),
        ),
      ],
    );
  }
}
