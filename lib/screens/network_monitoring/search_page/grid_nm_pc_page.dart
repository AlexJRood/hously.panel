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
          child: Container(
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
        final tag = 'networkAd${ad.id}';

        final mainImageUrl = ad.images.isNotEmpty ? ad.images[0] : 'default_image_url';

        return AspectRatio(
          aspectRatio: 1,
          child: PieMenu(
            onPressedWithDevice: (kind) {
              if (kind == PointerDeviceKind.mouse || kind == PointerDeviceKind.touch) {
                handleDisplayedActionNM(ref, ad.id, context);
                ref.read(navigationService).pushNamedScreen(
                  '${Routes.networkMonitoring}/${ad.id}',
                  data: {'tag': tag, 'ad': ad},
                );
              }
            },            
            actions: buildPieMenuActionsNM(ref, ad, context),
            child: Hero(
              tag: tag,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: CachedNetworkImage(
                          imageUrl: mainImageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => buildShimmerPlaceholder,
                          errorWidget: (context, url, error) => Container(
                            color: Colors.grey,
                            alignment: Alignment.center,
                            child: const Text(
                              'Brak obrazu',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 2,
                        bottom: 2,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 8),
                          decoration: BoxDecoration(
                            color: isDefaultDarkSystem
                                ? textFieldColor.withOpacity(0.5)
                                : color.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Material(
                                color: Colors.transparent,
                                child: Text(
                                  '${NumberFormat.decimalPattern().format(ad.price)} ${ad.currency}',
                                  style: AppTextStyles.interBold.copyWith(
                                    fontSize: 18,
                                    color: textColor,
                                  ),
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: Text(
                                  ad.title,
                                  style: AppTextStyles.interSemiBold.copyWith(color: textColor, fontSize: 14),
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                child: Text(
                                  '${ad.address!.city}, ${ad.address!.street}',
                                  style: AppTextStyles.interRegular.copyWith(color: textColor, fontSize: 12),
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
    );
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