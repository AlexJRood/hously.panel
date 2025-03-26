import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/models/ad/ad_list_view_model.dart';
import 'package:hously_flutter/state_managers/data/filter_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/utils/pie_menu/feed.dart';
import 'package:hously_flutter/widgets/appbar/hously/mobile/appbar_mobile.dart';
import 'package:hously_flutter/widgets/bottom_bar_mobile/bottom_bar.dart';
import 'package:hously_flutter/widgets/bottom_bar_mobile/feed_bar.dart';
import 'package:hously_flutter/widgets/bottom_bar_mobile/feed_bar_vertical.dart';
import 'package:hously_flutter/widgets/installpopup/install_popup.dart';
import 'package:hously_flutter/widgets/loading/loading_widgets.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:pie_menu/pie_menu.dart';

import '../../../widgets/side_menu/slide_rotate_menu.dart';

class ListViewMobile extends ConsumerStatefulWidget {
  const ListViewMobile({super.key});

  @override
  ConsumerState<ListViewMobile> createState() => _ListViewMobileState();
}

class _ListViewMobileState extends ConsumerState<ListViewMobile> {
  static const int _pageSize = 10; // Number of items per page
  final PagingController<int, AdsListViewModel> _pagingController =
      PagingController(firstPageKey: 1);
  final sideMenuKey = GlobalKey<SideMenuState>();

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

    const double maxWidth = 1920;
    const double minWidth = 800;
    // Ustawienie maksymalnego i minimalnego rozmiaru czcionki
    const double maxDynamicPadding = 480;
    const double minDynamicPadding = 0;
    // Obliczenie odpowiedniego rozmiaru czcionki
    double dynamicPadding = (screenWidth - minWidth) /
            (maxWidth - minWidth) *
            (maxDynamicPadding - minDynamicPadding) +
        minDynamicPadding;
    // Ograniczenie rozmiaru czcionki do zdefiniowanych minimum i maksimum
    dynamicPadding = dynamicPadding.clamp(minDynamicPadding, maxDynamicPadding);

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
      child: PopupListener(
        child: SafeArea(
          child: Scaffold(
            body: SideMenuManager.sideMenuSettings(
              menuKey: sideMenuKey,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        gradient:
                            CustomBackgroundGradients.getMainMenuBackground(
                                context, ref)),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: PagedListView<int, AdsListViewModel>(
                                  pagingController: _pagingController,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: dynamicPadding, vertical: 65),
                                  builderDelegate: PagedChildBuilderDelegate<
                                      AdsListViewModel>(
                                    itemBuilder:
                                        (context, advertisement, index) {
                                      return SingleChildScrollView(
                                        controller: scrollController,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: dynamicPadding),
                                          child: BuildAdvertisementsList(
                                            scrollController: scrollController,
                                            dynamicPadding: dynamicPadding,
                                            filteredAdvertisements: [
                                              advertisement
                                            ],
                                            adFiledSize: (((screenWidth) -
                                                    (dynamicPadding * 2)) -
                                                80),
                                          ),
                                        ),
                                      );
                                    },
                                    firstPageProgressIndicatorBuilder: (_) =>
                                        ShimmerPlaceholderWidget(
                                            scrollController: scrollController,
                                            adFiledSize: (((screenWidth) -
                                                    (dynamicPadding * 2)) -
                                                80),
                                            dynamicPadding: dynamicPadding),
                                    newPageProgressIndicatorBuilder: (_) =>
                                        Center(
                                      child: ShimmerPlaceholderWidget(
                                          scrollController: scrollController,
                                          adFiledSize: (((screenWidth) -
                                                  (dynamicPadding * 2)) -
                                              80),
                                          dynamicPadding: dynamicPadding),
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
                    ),
                  ),
                  if (ref.watch(bottomBarVisibilityProvider)) ...[
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: const BottomBarMobile(),
                    ),
                  ],

                  // Positioned(
                  //     bottom: ref.watch(bottomBarVisibilityProvider) ? 51 : 5,
                  //     left: screenPadding * 2,
                  //     right: screenPadding * 2,
                  //     child: FeedBarMobile(screenPadding: screenPadding, ref: ref)),

                  Positioned(
                      bottom: ref.watch(verticalBottomBarVisibilityProvider)
                          ? 51
                          : 5,
                      right: 5,
                      child: FeedBarVerticalMobile(ref: ref)),

                  Positioned(
                    top: 0,
                    right: 0,
                    child: AppBarMobile(
                      sideMenuKey: sideMenuKey,
                    ),
                  ),
                ],
              ),
            ),
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
    required this.dynamicPadding,
  });

  final double adFiledSize;
  final List<AdsListViewModel> filteredAdvertisements;
  final ScrollController scrollController;
  final dynamic dynamicPadding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themecolors = ref.watch(themeColorsProvider);
    final textColor = themecolors.themeTextColor;

    return Column(
      children: List.generate(filteredAdvertisements.length, (index) {
        final fullSizeAd = filteredAdvertisements[index];
        final tag = 'fullSize${fullSizeAd.id}';
        final mainImageUrl = fullSizeAd.images.isNotEmpty
            ? fullSizeAd.images[0]
            : 'default_image_url';
        final isPro = fullSizeAd.isPro;

        return AspectRatio(
          aspectRatio: 12 / 4,
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
              padding: const EdgeInsets.only(bottom: 5),
              child: Container(
                decoration: BoxDecoration(
                  gradient: CustomBackgroundGradients.getaddpagebackground(
                      context, ref),
                ),
                child: Row(
                  children: [
                    // Image with border and sponsored badge if isPro is true
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
                    const SizedBox(width: 8),
                    // Textual details about the ad
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Text(
                          '${fullSizeAd.city}, ${fullSizeAd.street}',
                          style: AppTextStyles.interLight
                              .copyWith(fontSize: 10, color: textColor),
                        ),
                        const SizedBox(height: 0),
                        Text(
                          '${NumberFormat.decimalPattern().format(fullSizeAd.price)} ${fullSizeAd.currency}',
                          style: AppTextStyles.interBold
                              .copyWith(fontSize: 16, color: textColor),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: adFiledSize / 2.10 - dynamicPadding,
                          child: Text(
                            fullSizeAd.title,
                            style: AppTextStyles.interSemiBold
                                .copyWith(fontSize: 12, color: textColor),
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: adFiledSize / 2.10 - dynamicPadding,
                          child: ClipRRect(
                            clipBehavior: Clip.hardEdge,
                            child: Text(
                              fullSizeAd.description,
                              style: AppTextStyles.interLight
                                  .copyWith(fontSize: 10, color: textColor),
                              softWrap: true,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
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
  final ScrollController scrollController;

  const ShimmerPlaceholderWidget({
    super.key,
    required this.adFiledSize,
    required this.dynamicPadding,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: adFiledSize,
      child: ShimmerAdvertisementsListmobile(
        adFiledSize: adFiledSize,
        scrollController: scrollController,
        dynamicPadding: dynamicPadding,
        scrollPhysics: const NeverScrollableScrollPhysics(),
      ),
    );
  }
}
