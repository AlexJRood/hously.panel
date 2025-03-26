import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/screens/network_monitoring/network_home_page/network_home_new/screens/widgets/real_state_and_home_for_sale_card.dart';
import 'package:hously_flutter/state_managers/data/home_page/listing_provider.dart';
import 'package:hously_flutter/widgets/loading/loading_widgets.dart';
import 'dart:ui';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:hously_flutter/utils/pie_menu/feed.dart';


import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/data/network_monitoring/search_page/filters_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/widgets/loading/loading_widgets.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:hously_flutter/models/ad/monitoring_ads_model.dart';

import 'package:intl/intl.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/utils/pie_menu/feed.dart';



class SavedSearchGridView extends ConsumerStatefulWidget {
  final bool isMobile;
  const SavedSearchGridView({super.key,this.isMobile = false});

  @override
  SavedSearchGridViewState createState() => SavedSearchGridViewState();
}

class SavedSearchGridViewState extends ConsumerState<SavedSearchGridView> {
    static const int _pageSize = 20;
    final PagingController<int, MonitoringAdsModel> _pagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
      try {
        final listingProvider = await ref.read(networkMonitoringFilterProvider.notifier)
            .fetchAdvertisementsNM(pageKey, _pageSize, ref);

        final isLastPage = listingProvider.length < _pageSize;
        if (isLastPage) {
          _pagingController.appendLastPage(listingProvider);
        } else {
          final nextPageKey = pageKey + 1;
          _pagingController.appendPage(listingProvider, nextPageKey);
        }
      } catch (error) {
        _pagingController.error = error;
      }
    }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    ref.listen(networkMonitoringFilterProvider, (_, __) => _pagingController.refresh());    
    double screenWidth = MediaQuery.of(context).size.width;
    final scrollController = ScrollController();


      
    int grid;
    if (screenWidth >= 1440) {
      grid = math.max(1, (screenWidth / 800).ceil());
    } else if (screenWidth >= 1080) {
      grid = 3;
    } else if (screenWidth >= 600) {
      grid = 2;
    } else {
      grid = 1;
    }

    const double maxWidth = 1920;
    const double minWidth = 1080;

    const double maxDynamicPadding = 40;
    const double minDynamicPadding = 15;

    double dynamicPadding = (screenWidth - minWidth) / (maxWidth - minWidth) * (maxDynamicPadding - minDynamicPadding) + minDynamicPadding;
    dynamicPadding = dynamicPadding.clamp(minDynamicPadding, maxDynamicPadding);

    const double minBaseTextSize = 5;
    const double maxBaseTextSize = 15;
    double baseTextSize = (screenWidth - minWidth) / (maxWidth - minWidth) * (maxBaseTextSize - minBaseTextSize) + minBaseTextSize;
    baseTextSize = baseTextSize.clamp(minBaseTextSize, maxBaseTextSize);

    
    final adFiledSize = (((screenWidth) - (dynamicPadding * 2)) - 80);
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: PagedGridView<int, MonitoringAdsModel>(
                  pagingController: _pagingController,
                  padding: EdgeInsets.symmetric(horizontal: dynamicPadding, vertical: 65),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: grid,
                    childAspectRatio: 1,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  builderDelegate: PagedChildBuilderDelegate<MonitoringAdsModel>(
                    itemBuilder: (context, advertisement, index) {
                      return BuildAdvertisementsList(
                        adFiledSize: adFiledSize,
                        scrollController: ScrollController(),
                        buildShimmerPlaceholder:
                            ShimmerPlaceholderWidget(
                                scrollController: scrollController,
                                adFiledSize: adFiledSize,
                                crossAxisCount: 1),
                        networkMonitoringFilterProvider: [advertisement],
                      );
                    },
                    firstPageProgressIndicatorBuilder: (_) =>
                        ShimmerPlaceholderWidget(
                      scrollController: scrollController,
                      adFiledSize: adFiledSize,
                      crossAxisCount: grid,
                    ),
                    newPageProgressIndicatorBuilder: (_) =>
                        ShimmerPlaceholderWidget(
                      scrollController: scrollController,
                      adFiledSize: adFiledSize,
                      crossAxisCount: 1,
                    ),
                    noItemsFoundIndicatorBuilder: (_) => Center(
                      child: Text(
                        'Upss... brak wyników wyszukiwania.',
                        style: AppTextStyles.interLight16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


class BuildAdvertisementsList extends ConsumerWidget {
  final List<MonitoringAdsModel> networkMonitoringFilterProvider;
  final ScrollController scrollController;
  final Widget buildShimmerPlaceholder;
  final double adFiledSize;
  final bool isMobile;

  const BuildAdvertisementsList({
      super.key,
      required this.networkMonitoringFilterProvider,
      required this.scrollController,
      required this.buildShimmerPlaceholder,
      required this.adFiledSize,
      this.isMobile = true,
      });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themecolors = ref.watch(themeColorsProvider);
    final currentthememode = ref.watch(themeProvider);

    final textFieldColor = currentthememode == ThemeMode.system ? Colors.black : Colors.white;
    final textColor = themecolors.themeTextColor;
    final color = Theme.of(context).primaryColor;
    final isDefaultDarkSystem = ref.watch(isDefaultDarkSystemProvider);

    return Column(
      children: List.generate(networkMonitoringFilterProvider.length, (index) {
        final ad = networkMonitoringFilterProvider[index];
        final tag = 'fullSize${ad.id}';

        final mainImageUrl = ad.images.isNotEmpty ? ad.images[0] : 'default_image_url';

        return AspectRatio(
                  aspectRatio: 1,
                  child: PieMenu(
                    onPressedWithDevice: (kind) {
                      if (kind == PointerDeviceKind.mouse || kind == PointerDeviceKind.touch) {
                        handleDisplayedAction(ref, ad.id, context);
                        ref.read(navigationService).pushNamedScreen(
                          '${Routes.networkMonitoring}/${ad.id}',
                          data: {'tag': tag, 'ad': ad},
                        );
                      }
                    },            
                    actions: buildPieMenuActions(ref, ad, context),
                    child: Hero(
                      tag: tag,
                      child: RealStateAndHomeForSaleCard(
                      imageUrl: ad.images.last,
                      location: ad.address?.city,
                      address: ad.address?.state,
                      size: ad.squareFootage.toString(),
                      rooms: ad.rooms.toString(),
                      bath: ad.bathrooms.toString(),
                      price: ad.price.toString(),
                      isMobile: isMobile,
                    ),
                  ),
                  ),
                );
      }),
    );
  }
}

class ShimmerPlaceholderWidget extends StatelessWidget {
  final ScrollController scrollController;
  final double adFiledSize;
  final int crossAxisCount;

  const ShimmerPlaceholderWidget({
    super.key,
    required this.scrollController,
    required this.adFiledSize,
    required this.crossAxisCount,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: adFiledSize,
      width: adFiledSize,
      child: ShimmerAdvertisementGrid(
        scrollController: scrollController,
        crossAxisCount: crossAxisCount,
      ),
    );
  }
}
