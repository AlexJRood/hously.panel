import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/portal/browselist/utils/api.dart';
import 'package:hously_flutter/portal/browselist/components/card.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class BrowseListWidget extends ConsumerWidget {
  final bool isWhiteSpaceNeeded;
  final bool isHidden;
  const BrowseListWidget({super.key, required this.isWhiteSpaceNeeded, required this.isHidden});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController scrollController = ScrollController();
    double screenWidth = MediaQuery.of(context).size.width;
    NumberFormat customFormat = NumberFormat.decimalPattern('fr');

    const double maxWidth = 1920;
    const double minWidth = 1080;

    const double minBaseTextSize = 5;
    const double maxBaseTextSize = 15;
    double baseTextSize = (screenWidth - minWidth) /
            (maxWidth - minWidth) *
            (maxBaseTextSize - minBaseTextSize) +
        minBaseTextSize;
    baseTextSize = baseTextSize.clamp(minBaseTextSize, maxBaseTextSize);

    return Container(
      decoration: BoxDecoration(
          gradient:
              CustomBackgroundGradients.getMainMenuBackground(context, ref)),
      child: Stack(
        children: [
          CustomScrollView(
            controller: scrollController,
            slivers: [
              isWhiteSpaceNeeded 
              ? const SliverToBoxAdapter(
                child: SizedBox(height: 120), // Przestrzeń dla TopAppBar
              ) 
              : const SliverToBoxAdapter(
                child: SizedBox(height: 0), // Przestrzeń dla TopAppBar
              ),
              ref.watch(browseListProvider).when(
                    data: (filteredAdvertisements) {
                      if (filteredAdvertisements.isEmpty) {
                        return SliverToBoxAdapter(
                          child: Column(children: [
                            Center(
                              child: Text(
                                  'Upss... brak ogłoszeń w szybkim przeglądaniu.'.tr, // change to production                                            
                                  style: AppTextStyles.interLight16),
                            ),
                          ]),
                        );
                      }
                      return SliverGrid(
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          childAspectRatio: 2,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final feedAd = filteredAdvertisements[index];
                            final keyTag =
                                'browselist_portal${feedAd.id}${UniqueKey().toString()}';
                            String formattedPrice =
                                customFormat.format(feedAd.price);
            
                            final mainImageUrl = feedAd.images.isNotEmpty
                                ? feedAd.images[0]
                                : 'default_image_url';
            
                            return BrowseListCardWidget(
                                isHidden: isHidden,                                    
                                feedAd: feedAd,
                                keyTag: keyTag,
                                mainImageUrl: mainImageUrl,
                                formattedPrice: formattedPrice);
                          },
                          childCount: filteredAdvertisements.length,
                        ),
                      );
                    },
                    loading: () => const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()),
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
        ],
      ),
    );
  }
}
