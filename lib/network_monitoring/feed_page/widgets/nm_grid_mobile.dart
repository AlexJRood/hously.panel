import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/models/ad/monitoring_ads_model.dart';
import 'package:hously_flutter/network_monitoring/components/cards/real_state_and_home_for_sale_card.dart';
import 'package:hously_flutter/network_monitoring/components/cards/va.dart';
import 'package:hously_flutter/network_monitoring/state_managers/search_page/filters_provider.dart';
import 'package:hously_flutter/widgets/loading/loading_widgets.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'dart:math' as math;


import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';





class NMGridViewMobile extends ConsumerStatefulWidget {
  const NMGridViewMobile({super.key});

  @override
  NMGridViewMobileState createState() => NMGridViewMobileState();
}

class NMGridViewMobileState extends ConsumerState<NMGridViewMobile> {
  static const int _pageSize = 10;
  final PagingController<int, MonitoringAdsModel> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }


  Future<void> _fetchPage(int pageKey) async {
    try {
      final advertisements = await ref
          .read(networkMonitoringFilterProvider.notifier)
          .fetchAdvertisementsNM(pageKey, _pageSize, ref);

      final isLastPage = advertisements.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(advertisements);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(advertisements, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(networkMonitoringFilterProvider, (_, __) => _pagingController.refresh());
    final ScrollController scrollController = ScrollController();
    double screenWidth = MediaQuery.of(context).size.width;
    final sideMenuKey = GlobalKey<SideMenuState>();

    int grid = (screenWidth >= 1440)
        ? math.max(1, (screenWidth / 500).ceil())
        : (screenWidth >= 1080)
            ? 3
            : (screenWidth >= 600)
                ? 2
                : 1;

    grid = grid < 1 ? 1 : grid; // Zapewnienie poprawnej wartości

    const double maxWidth = 1080;
    const double minWidth = 350;
    const double maxDynamicPadding = 15;
    const double minDynamicPadding = 5;
    double dynamicPadding = ((screenWidth - minWidth) /
                (maxWidth - minWidth) *
                (maxDynamicPadding - minDynamicPadding) +
            minDynamicPadding)
        .clamp(minDynamicPadding, maxDynamicPadding);

    final adFiledSize = screenWidth - (dynamicPadding * 2);

    return Column(
      children: [
            Expanded(
              child: PagedGridView<int, MonitoringAdsModel>(
                pagingController: _pagingController,
                padding: EdgeInsets.symmetric(
                    horizontal: dynamicPadding, vertical: 65),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: grid,
                  childAspectRatio: 1,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                builderDelegate: PagedChildBuilderDelegate<MonitoringAdsModel>(
                  itemBuilder: (context, advertisement, index) {
                    return BuildAdvertisementsList(
                      adFiledSize: adFiledSize,
                      scrollController: ScrollController(),
                      buildShimmerPlaceholder: ShimmerPlaceholder(
                        width: adFiledSize,
                        height: adFiledSize,
                      ),
                      filteredAdvertisements: [advertisement],
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
                    crossAxisCount: grid,
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
        );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}










class BuildAdvertisementsList extends ConsumerWidget {
  final List<MonitoringAdsModel> filteredAdvertisements;
  final ScrollController scrollController;
  final Widget buildShimmerPlaceholder;
  final double adFiledSize;
  final bool isMobile;

  const BuildAdvertisementsList({
    super.key,
    required this.filteredAdvertisements,
    required this.scrollController,
    required this.buildShimmerPlaceholder,
    required this.adFiledSize,
    this.isMobile = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final themecolors = ref.watch(themeColorsProvider);
    // final currentthememode = ref.watch(themeProvider);

    // final textFieldColor =
    //     currentthememode == ThemeMode.system ? Colors.black : Colors.white;
    // final textColor = themecolors.themeTextColor;
    // final color = Theme.of(context).primaryColor;
    // final isDefaultDarkSystem = ref.watch(isDefaultDarkSystemProvider);

    return Column(
          children: List.generate(filteredAdvertisements.length, (index) {
            final ad = filteredAdvertisements[index];
            final tag = 'mobileSize${ad.id}-${UniqueKey().toString()}';
            
            return RealStateAndHomeForSaleCard(
              ad: ad,
              keyTag: tag,
              isMobile: true,
            );
          }
        ),
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
      ),
    );
  }
}
