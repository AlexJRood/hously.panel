import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/network_monitoring/components/cards/selected_card.dart';
import 'package:hously_flutter/network_monitoring/state_managers/search_page/filters_provider.dart';
import 'package:hously_flutter/widgets/loading/loading_widgets.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:hously_flutter/models/ad/monitoring_ads_model.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/utils/pie_menu/network_monitoring.dart';



class GridNMPcPage extends ConsumerStatefulWidget {
  const GridNMPcPage({super.key});

  @override
  GridPcPageState createState() => GridPcPageState();
}

class GridPcPageState extends ConsumerState<GridNMPcPage> {
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
        final advertisements = await ref.read(networkMonitoringFilterProvider.notifier)
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
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(networkMonitoringFilterProvider, (_, __) => _pagingController.refresh());
    double screenWidth = MediaQuery.of(context).size.width;
    final ScrollController scrollController = ScrollController();
    final cardProvider = ref.watch(selectedCardProviderNM);

      
    int grid;
    // if (screenWidth >= 1440) {
      grid = math.max(1, (screenWidth / 900).ceil());
    // } else if (screenWidth >= 800) {
    //   grid = 2;
    // } else {
    //   grid = 1;
    // }

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
                    crossAxisSpacing: cardProvider.basePadding,
                    mainAxisSpacing: cardProvider.basePadding,
                  ),
                  builderDelegate: PagedChildBuilderDelegate<MonitoringAdsModel>(
                    itemBuilder: (context, advertisement, index) {
                      return BuildAdvertisementsList(
                        adFiledSize: adFiledSize,
                        scrollController: ScrollController(),
                        buildShimmerPlaceholder:
                            ShimmerPlaceholderWidget(
                                adFiledSize: adFiledSize,
                                crossAxisCount: 1),
                        networkMonitoringFilterProvider: [advertisement],
                      );
                    },
                    firstPageProgressIndicatorBuilder: (_) =>
                        ShimmerPlaceholderWidget(
                      adFiledSize: adFiledSize,
                      crossAxisCount: grid,
                    ),
                    newPageProgressIndicatorBuilder: (_) =>
                        ShimmerPlaceholderWidget(
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

  const BuildAdvertisementsList({
      super.key,
      required this.networkMonitoringFilterProvider,
      required this.scrollController,
      required this.buildShimmerPlaceholder,
      required this.adFiledSize
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
        final tag = 'networkAd${ad.id}-${UniqueKey().toString()}';
        final cardRatio = ref.watch(selectedCardProviderNM).aspectRatio;

        final mainImageUrl = ad.images.isNotEmpty ? ad.images[0] : 'default_image_url';
        final isPro = ad.isPro;

        return SelectedCardWidgetNM(
          isMobile: false,
          aspectRatio: cardRatio,
          ad: ad, 
          tag: tag, 
          mainImageUrl: mainImageUrl, 
          isPro: isPro, 
          isDefaultDarkSystem: isDefaultDarkSystem, 
          color: color, 
          textColor: textColor, 
          textFieldColor: textFieldColor, 
          buildShimmerPlaceholder: buildShimmerPlaceholder, 
          buildPieMenuActions: buildPieMenuActionsNM(ref, ad, context),
          );
      }));
        }
      }

class ShimmerPlaceholderWidget extends StatelessWidget {
  final double adFiledSize;
  final int crossAxisCount;

  const ShimmerPlaceholderWidget({
    super.key,
    required this.adFiledSize,
    required this.crossAxisCount,
  });

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
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