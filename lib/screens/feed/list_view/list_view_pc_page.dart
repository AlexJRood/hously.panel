import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/models/ad/ad_list_view_model.dart';
import 'package:hously_flutter/portal/browselist/widget/pc.dart';
import 'package:hously_flutter/state_managers/data/filter_provider.dart'; // Upewnij się, że ścieżka jest poprawna
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/utils/pie_menu/feed.dart';
import 'package:hously_flutter/widgets/appbar/hously/pc/appbar.dart';
import 'package:hously_flutter/widgets/appbar/hously/pc/newappbar.dart';
import 'package:hously_flutter/widgets/loading/loading_widgets.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/sidebar/sidebar.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:pie_menu/pie_menu.dart';

import '../../../widgets/side_menu/slide_rotate_menu.dart';

class ListViewWebPc extends ConsumerStatefulWidget {
  const ListViewWebPc({super.key});

  @override
  ConsumerState<ListViewWebPc> createState() => _ListViewWebPcState();
}

class _ListViewWebPcState extends ConsumerState<ListViewWebPc> {
  static const int _pageSize = 10; // Number of items per page
  final PagingController<int, AdsListViewModel> _pagingController =
      PagingController(firstPageKey: 1);
  final sideMenuKey = GlobalKey<SideMenuState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final advertisements = await ref
          .read(filterProvider.notifier)
          .fetchAdvertisements(pageKey, _pageSize, ref);

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
    ref.listen(filterProvider, (_, __) => _pagingController.refresh());
    final ScrollController scrollController = ScrollController();
    double screenWidth = MediaQuery.of(context).size.width;

    const double maxWidth = 2600;
    const double minWidth = 800;
    // Ustawienie maksymalnego i minimalnego rozmiaru czcionki
    const double maxDynamicPadding = 750;
    const double minDynamicPadding = 10;
    // Obliczenie odpowiedniego rozmiaru czcionki
    double padding = (screenWidth - minWidth) /
            (maxWidth - minWidth) *
            (maxDynamicPadding - minDynamicPadding) +
        minDynamicPadding;
    // Ograniczenie rozmiaru czcionki do zdefiniowanych minimum i maksimum
    padding = padding.clamp(minDynamicPadding, maxDynamicPadding);
    // Oblicz proporcję szerokości
print ('padding size $padding');

  double listSize = screenWidth - (padding *2);

    return PieCanvas(
      theme: const PieTheme(
        rightClickShowsMenu: true,
        leftClickShowsMenu: false,
        buttonTheme: PieButtonTheme(
          backgroundColor: AppColors.buttonGradient1,
          iconColor: Colors.white,
        ),
        buttonThemeHovered: PieButtonTheme(
          backgroundColor: Color.fromARGB(96, 58, 58, 58),
          iconColor: Colors.white,
        ),
      ),
      child: Scaffold(
        body: SideMenuManager.sideMenuSettings(
          menuKey: sideMenuKey,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: CustomBackgroundGradients.getbuttonGradient1(
                        context, ref)),
                child: Row(
                  children: [
                    Sidebar(
                      sideMenuKey: sideMenuKey,
                    ),
                    Expanded(
                      child: Container(
                        
                        decoration: BoxDecoration(
                            gradient:
                                CustomBackgroundGradients.getMainMenuBackground(
                                    context, ref)),
                        child: Column(
                          children: [
                            Expanded(
                              child: PagedListView<int, AdsListViewModel>(
                                pagingController: _pagingController,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 65),
                                builderDelegate:
                                    PagedChildBuilderDelegate<AdsListViewModel>(
                                  itemBuilder: (context, advertisement, index) {
                                    return SingleChildScrollView(
                                      controller: scrollController,
                                      child: Center(
                                        child: BuildAdvertisementsList(
                                          scrollController: scrollController,
                                          listSize: listSize,
                                          filteredAdvertisements: [
                                            advertisement
                                          ],
                                          adFiledSize: listSize,
                                        ),
                                      ),
                                    );
                                  },
                                  firstPageProgressIndicatorBuilder: (_) =>
                                      Center(
                                    child: ShimmerPlaceholderWidget(
                                        adFiledSize: listSize,
                                        dynamicPadding: padding),
                                  ),
                                  newPageProgressIndicatorBuilder: (_) =>
                                      Center(
                                    child: ShimmerPlaceholderWidget(
                                        adFiledSize: listSize,
                                        dynamicPadding: padding),
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
                  BrowseListPcWidget(isWhiteSpaceNeeded: true)
                  ],
                ),
              ),
              const Positioned(top: 0, right: 0, child: TopAppBar()),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildAdvertisementsList extends ConsumerWidget {
  const BuildAdvertisementsList({
    super.key,
    required this.adFiledSize,
    required this.filteredAdvertisements,
    required this.scrollController,
    required this.listSize,
  });

  final double adFiledSize;
  final List<AdsListViewModel> filteredAdvertisements;
  final ScrollController scrollController;
  final dynamic listSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themecolors = ref.watch(themeColorsProvider);
    final textColor = themecolors.themeTextColor;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(filteredAdvertisements.length, (index) {
        final fullSizeAd = filteredAdvertisements[index];
        final tag = 'fullSize${fullSizeAd.id}-${UniqueKey().toString()}';
        final mainImageUrl = fullSizeAd.images.isNotEmpty
            ? fullSizeAd.images[0]
            : 'default_image_url';
        final isPro = fullSizeAd.isPro;

        return SizedBox(
                width: listSize,
          child: AspectRatio(
            aspectRatio: 14 / 4,
            child: PieMenu(
              onPressedWithDevice: (kind) {
                if (kind == PointerDeviceKind.mouse ||
                    kind == PointerDeviceKind.touch) {
                  handleDisplayedAction(ref, fullSizeAd.id, context);
                  ref.read(navigationService).pushNamedScreen(
                    '${Routes.listview}/${fullSizeAd.id}',
                    data: {'tag': tag, 'ad': fullSizeAd},
                  );
                }
              },
              actions: buildPieMenuActions(ref, fullSizeAd, context),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: CustomBackgroundGradients.getaddpagebackground(
                      context,
                      ref,
                    ),
                  ),
                  child: Row(
                    children: [
                      // Image with conditional border and sponsored badge
                      Hero(
                        tag: tag,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: isPro
                                ? Border.all(color: Colors.white, width: 5.0)
                                : null,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Stack(
                              children: [
                                AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: FittedBox(
                                    fit: BoxFit.cover,
                                    child: CachedNetworkImage(
                                      imageUrl: mainImageUrl,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const ShimmerPlaceholder(
                                              width: 0, height: 0),
                                      errorWidget: (context, url, error) =>
                                          Container(
                                        color: Colors.grey,
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Brak obrazu'.tr,
                                          style: TextStyle(color: textColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                if (isPro)
                                  Positioned(
                                    right: 8,
                                    top: 8,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4, horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: AppColors.light,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        'Sponsored',
                                        style: AppTextStyles.interMedium12dark,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      // Advertisement details
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            '${fullSizeAd.city}, ${fullSizeAd.street}',
                            style: AppTextStyles.interLight
                                .copyWith(fontSize: 12, color: textColor),
                          ),
                          const SizedBox(height: 0),
                          Text(
                            '${NumberFormat.decimalPattern().format(fullSizeAd.price)} ${fullSizeAd.currency}',
                            style: AppTextStyles.interBold
                                .copyWith(fontSize: 20, color: textColor),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: adFiledSize / 2.12,
                            child: Text(
                              fullSizeAd.title,
                              style: AppTextStyles.interSemiBold.copyWith(
                                fontSize: 18,
                                color: textColor,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: adFiledSize / 2.12,
                            child: Text(
                              fullSizeAd.description,
                              style: AppTextStyles.interLight
                                  .copyWith(fontSize: 12, color: textColor),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
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
  final double dynamicPadding;

  const ShimmerPlaceholderWidget({
    super.key,
    required this.adFiledSize,
    required this.dynamicPadding,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: adFiledSize,
      width: adFiledSize,
      child: ShimmerAdvertisementsListPc(
        adFiledSize: adFiledSize,
        scrollController: ScrollController(),
        dynamicPadding: dynamicPadding,
      ),
    );
  }
}
