// ignore_for_file: unused_element
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/models/ad/ad_list_view_model.dart';
import 'package:hously_flutter/state_managers/data/filter_provider.dart'; // Upewnij się, że ścieżka jest poprawna
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

class FullMobile extends ConsumerStatefulWidget {
  const FullMobile({super.key});

  @override
  ConsumerState<FullMobile> createState() => _FullMobileState();
}

class _FullMobileState extends ConsumerState<FullMobile> {
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
    double screenPadding = screenWidth / 430 * 15;

    const double maxWidth = 1920;
    const double minWidth = 480;
    // Ustawienie maksymalnego i minimalnego rozmiaru czcionki
    const double maxDynamicPadding = 40;
    const double minDynamicPadding = 0;
    // Obliczenie odpowiedniego rozmiaru czcionki
    double dynamicPadding = (screenWidth - minWidth) /
            (maxWidth - minWidth) *
            (maxDynamicPadding - minDynamicPadding) +
        minDynamicPadding;
    // Ograniczenie rozmiaru czcionki do zdefiniowanych minimum i maksimum
    dynamicPadding = dynamicPadding.clamp(minDynamicPadding, maxDynamicPadding);
    // Oblicz proporcję szerokości
    // double dynamicSizedBoxWidth = screenWidth / 20 <= 20 ? 20 : screenWidth / 20;

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
                    child: Column(
                      children: [
                        Expanded(
                          child: PagedListView<int, AdsListViewModel>(
                            pagingController: _pagingController,
                            padding: EdgeInsets.symmetric(
                                horizontal: dynamicPadding, vertical: 60),
                            builderDelegate:
                                PagedChildBuilderDelegate<AdsListViewModel>(
                              itemBuilder: (context, advertisement, index) {
                                return BuildAdvertisementsList(
                                  scrollController: ScrollController(),
                                  // Scroll handled by PagedListView
                                  filteredAdvertisements: [
                                    advertisement
                                  ], // Single ad as the list
                                );
                              },
                              firstPageProgressIndicatorBuilder: (_) =>
                                  ShimmerPlaceholderFull(
                                      adFiledSize: (((screenWidth) -
                                              (dynamicPadding * 2)) -
                                          80),
                                      scrollController: scrollController,
                                      dynamicPadding: dynamicPadding),
                              newPageProgressIndicatorBuilder: (_) =>
                                  ShimmerPlaceholderFull(
                                      adFiledSize: (((screenWidth) -
                                              (dynamicPadding * 2)) -
                                          80),
                                      scrollController: scrollController,
                                      dynamicPadding: dynamicPadding),
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

  // Widget _buildShimmerPlaceholder(
  //     {required double dynamicPadding,
  //     required ScrollController scrollController,
  //     required double adFiledSize}) {
  //   return SizedBox(
  //       height: adFiledSize,
  //       width: adFiledSize,
  //       child: ShimmerAdvertisementsListmobile(
  //           adFiledSize: adFiledSize,
  //           scrollController: scrollController,
  //           dynamicPadding: dynamicPadding));
  // }
}

class BuildAdvertisementsList extends ConsumerWidget {
  final List<AdsListViewModel> filteredAdvertisements;
  final ScrollController scrollController;

  const BuildAdvertisementsList({
    super.key,
    required this.filteredAdvertisements,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themecolors = ref.watch(themeColorsProvider);

    final textFieldColor = themecolors.textFieldColor;
    final textColor = themecolors.themeTextColor;
    final color = Theme.of(context).primaryColor;
    final isDefaultDarkSystem = ref.watch(isDefaultDarkSystemProvider);

    return Column(
      children: List.generate(filteredAdvertisements.length, (index) {
        final fullSizeAd = filteredAdvertisements[index];
        final tag = 'fullSize${fullSizeAd.id}-${UniqueKey().toString()}';
        final mainImageUrl = fullSizeAd.images.isNotEmpty
            ? fullSizeAd.images[0]
            : 'default_image_url';
        final isPro = fullSizeAd.isPro;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: GestureDetector(
            onTap: () {
              handleDisplayedAction(ref, fullSizeAd.id, context);
              ref.read(navigationService).pushNamedScreen(
                '${Routes.fullSize}/${fullSizeAd.id}',
                data: {'tag': tag, 'ad': fullSizeAd},
              );
            },
            onSecondaryTapDown: (details) {},
            child: Hero(
              tag: tag, // Ensure the tag is unique
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    // Main Image Container with conditional border if isPro is true
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: isPro
                            ? Border.all(color: Colors.white, width: 5.0)
                            : null,
                      ),
                      child: AspectRatio(
                        aspectRatio: 16 / 10,
                        child: CachedNetworkImage(
                          width: double.infinity,
                          imageUrl: mainImageUrl,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const ShimmerPlaceholderwithoutwidth(
                                  height: double.infinity),
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
                    ),

                    // Sponsored Badge (Appears only if isPro is true)
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

                    // Bottom Container with Price, Title, and Location
                    Positioned(
                      left: 7,
                      bottom: 7,
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
                            Text(
                              '${NumberFormat.decimalPattern().format(fullSizeAd.price)} ${fullSizeAd.currency}',
                              style: AppTextStyles.interBold.copyWith(
                                color: textColor,
                                fontSize: 18,
                                shadows: [
                                  Shadow(
                                    offset: const Offset(5.0, 5.0),
                                    blurRadius: 10.0,
                                    color: isDefaultDarkSystem
                                        ? textFieldColor.withOpacity(0.5)
                                        : color.withOpacity(0.5),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              fullSizeAd.title,
                              style: AppTextStyles.interSemiBold.copyWith(
                                color: textColor,
                                fontSize: 14,
                                shadows: [
                                  Shadow(
                                    offset: const Offset(5.0, 5.0),
                                    blurRadius: 10.0,
                                    color: isDefaultDarkSystem
                                        ? textFieldColor.withOpacity(0.5)
                                        : color.withOpacity(0.5),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '${fullSizeAd.city}, ${fullSizeAd.street}',
                              style: AppTextStyles.interRegular.copyWith(
                                color: textColor,
                                fontSize: 12,
                                shadows: [
                                  Shadow(
                                    offset: const Offset(5.0, 5.0),
                                    blurRadius: 10.0,
                                    color: isDefaultDarkSystem
                                        ? textFieldColor.withOpacity(0.5)
                                        : color.withOpacity(0.5),
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
          ),
        );
      }),
    );
  }
}

class ShimmerPlaceholderFull extends StatelessWidget {
  final double dynamicPadding;
  final ScrollController scrollController;
  final double adFiledSize;

  const ShimmerPlaceholderFull({
    super.key,
    required this.dynamicPadding,
    required this.scrollController,
    required this.adFiledSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: adFiledSize,
      width: adFiledSize,
      child: ShimmerAdvertisementlistFull(
        scrollController: scrollController,
      ),
    );
  }
}
