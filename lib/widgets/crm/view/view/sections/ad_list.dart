import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/pie_menu/feed.dart';
import 'package:intl/intl.dart';
import 'package:pie_menu/pie_menu.dart';

import '../../../../../state_managers/data/crm/clients/ad_provider.dart';

class AdListClient extends ConsumerWidget {
  const AdListClient({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController scrollController = ScrollController();

    return Expanded(
      child: ref.watch(filterProvider).when(
            data: (filteredAdvertisements) {
              if (filteredAdvertisements.isEmpty) {
                return Center(
                  child: Text(
                      'Upss... brak wyników wyszukiwania. Poszerz kryteria wyszukiwania.'.tr,
                      style: AppTextStyles.interLight16),
                );
              }
              return SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:
                      List.generate(filteredAdvertisements.length, (index) {
                    final fullSizeAd = filteredAdvertisements[index];
                    final tag = 'fullSize${fullSizeAd.id}';
                    final mainImageUrl = fullSizeAd.images.isNotEmpty
                        ? fullSizeAd.images[0]
                        : 'default_image_url';

                    return AspectRatio(
                      aspectRatio: 16 / 9,
                      child: PieMenu(
                        onPressedWithDevice: (kind) {
                          if (kind == PointerDeviceKind.mouse ||
                              kind == PointerDeviceKind.touch) {
                            handleDisplayedAction(ref, fullSizeAd.id, context);
                            ref.read(navigationService).pushNamedScreen(
                              '${Routes.networkMonitoring}/${fullSizeAd.id}',
                              data: {'tag': tag, 'ad': fullSizeAd},
                            );
                          }
                        },
                        actions: buildPieMenuActions(ref, fullSizeAd, context),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Hero(
                            tag: tag,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Stack(
                                children: [
                                  AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: FittedBox(
                                      fit: BoxFit.cover,
                                      child: Image.network(
                                        mainImageUrl,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Container(
                                          color: Colors.grey,
                                          alignment: Alignment.center,
                                          child:  Text('Brak obrazu'.tr,
                                              style: const TextStyle(
                                                  color: Colors.white)),
                                        ),
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
                                        color: Colors.black.withOpacity(0.4),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Material(
                                            color: Colors.transparent,
                                            child: Text(
                                              '${NumberFormat.decimalPattern().format(fullSizeAd.price)} ${fullSizeAd.currency}',
                                              style: AppTextStyles.interBold
                                                  .copyWith(
                                                fontSize: 18,
                                                shadows: [
                                                  Shadow(
                                                    offset:
                                                        const Offset(5.0, 5.0),
                                                    blurRadius: 10.0,
                                                    color: Colors.black
                                                        .withOpacity(1),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Material(
                                            color: Colors.transparent,
                                            child: Text(
                                              fullSizeAd.title,
                                              style: AppTextStyles.interSemiBold
                                                  .copyWith(
                                                fontSize: 14,
                                                shadows: [
                                                  Shadow(
                                                    offset:
                                                        const Offset(5.0, 5.0),
                                                    blurRadius: 10.0,
                                                    color: Colors.black
                                                        .withOpacity(1),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Material(
                                            color: Colors.transparent,
                                            child: Text(
                                              '${fullSizeAd.address!.city}, ${fullSizeAd.address!.street}',
                                              style: AppTextStyles.interRegular
                                                  .copyWith(
                                                fontSize: 12,
                                                shadows: [
                                                  Shadow(
                                                    offset:
                                                        const Offset(5.0, 5.0),
                                                    blurRadius: 10.0,
                                                    color: Colors.black
                                                        .withOpacity(1),
                                                  ),
                                                ],
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
                      ),
                    );
                  }),
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) =>
                Center(child: Text('Wystąpił błąd: $error'.tr)),
          ),
    );
  }
}
