import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/colors.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/models/ad/ad_list_view_model.dart';
import 'package:hously_flutter/state_managers/data/filter_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/utils/pie_menu/feed.dart';
import 'package:hously_flutter/widgets/appbar/hously/mobile/appbar_mobile.dart';
import 'package:hously_flutter/widgets/bottom_bar_mobile/feed_bar_vertical.dart';
import 'package:hously_flutter/widgets/loading/loading_widgets.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:pie_menu/pie_menu.dart';
import 'dart:math' as math;
import '../../../widgets/side_menu/side_menu_manager.dart';
import '../../../widgets/side_menu/slide_rotate_menu.dart';
import 'package:hously_flutter/widgets/installpopup/install_popup.dart';
import 'package:hously_flutter/widgets/bottom_bar_mobile/bottom_bar.dart';
import 'package:hously_flutter/widgets/bottom_bar_mobile/feed_bar.dart';

class GridMobilePage extends ConsumerStatefulWidget {
  const GridMobilePage({super.key});

  @override
  GridMobilePageState createState() => GridMobilePageState();
}

class GridMobilePageState extends ConsumerState<GridMobilePage> {
  static const int _pageSize = 10;
  final PagingController<int, AdsListViewModel> _pagingController =
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
    final sideMenuKey = GlobalKey<SideMenuState>();

    int grid;
    if (screenWidth >= 1440) {
      grid = math.max(1, (screenWidth / 500).ceil());
    } else if (screenWidth >= 1080) {
      grid = 3;
    } else if (screenWidth >= 600) {
      grid = 2;
    } else {
      grid = 1;
    }

    const double maxWidth = 1080;
    const double minWidth = 350;
    const double maxDynamicPadding = 15;
    const double minDynamicPadding = 5;
    double dynamicPadding = (screenWidth - minWidth) /
            (maxWidth - minWidth) *
            (maxDynamicPadding - minDynamicPadding) +
        minDynamicPadding;
    final adFiledSize = (((screenWidth) - (dynamicPadding * 2)));

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
        child: SideMenuManager.sideMenuSettings(
          menuKey: sideMenuKey,
          child: SafeArea(
            child: Scaffold(
              body: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: CustomBackgroundGradients.getMainMenuBackground(
                          context, ref),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: PagedGridView<int, AdsListViewModel>(
                            pagingController: _pagingController,
                            padding: EdgeInsets.symmetric(
                                horizontal: dynamicPadding, vertical: 65),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: grid,
                              childAspectRatio: 1,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                            ),
                            builderDelegate: PagedChildBuilderDelegate<AdsListViewModel>(
                              itemBuilder: (context, advertisement, index) {
                                return BuildAdvertisementsList(
                                  adFiledSize: adFiledSize,
                                  scrollController: ScrollController(),
                                  buildShimmerPlaceholder: ShimmerPlaceholder(
                                      width: adFiledSize, height: adFiledSize),
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
                                  AspectRatio(
                                aspectRatio: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Stack(
                                    children: [
                                      const ShimmerPlaceholder(
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                      Positioned(
                                        left: 2,
                                        bottom: 2,
                                        child: Container(
                                          width: 300, // Ensure width is full
                                          height:
                                              75, // Increase height for visibility
                                          padding: const EdgeInsets.only(
                                              top: 15, left: 5),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.4),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: const Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ShimmerPlaceholder(
                                                  width: 100, height: 12),
                                              SizedBox(height: 10),
                                              ShimmerPlaceholder(
                                                  width: 280, height: 10),
                                              SizedBox(height: 8),
                                              ShimmerPlaceholder(
                                                  width: 120, height: 7),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
                  if (ref.watch(bottomBarVisibilityProvider)) ...[
                    const Positioned(
                      bottom: 0,
                      right: 0,
                      child: BottomBarMobile(),
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

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}

class BuildAdvertisementsList extends ConsumerWidget {
  final List<AdsListViewModel> filteredAdvertisements;
  final ScrollController scrollController;
  final Widget buildShimmerPlaceholder;
  final double adFiledSize;

  const BuildAdvertisementsList({
    super.key,
    required this.filteredAdvertisements,
    required this.scrollController,
    required this.buildShimmerPlaceholder,
    required this.adFiledSize,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themecolors = ref.watch(themeColorsProvider);
    final currentthememode = ref.watch(themeProvider);

    final textFieldColor =
        currentthememode == ThemeMode.system ? Colors.black : Colors.white;
    final textColor = themecolors.themeTextColor;
    final color = Theme.of(context).primaryColor;
    final isDefaultDarkSystem = ref.watch(isDefaultDarkSystemProvider);

    return Column(
      children: List.generate(filteredAdvertisements.length, (index) {
        final ad = filteredAdvertisements[index];
        final tag = 'mobileSize${ad.id}-${UniqueKey().toString()}';
        final mainImageUrl =
            ad.images.isNotEmpty ? ad.images[0] : 'default_image_url';
        final isPro = ad.isPro;

        return AspectRatio(
          aspectRatio: 1,
          child: PieMenu(
            onPressedWithDevice: (kind) {
              if (kind == PointerDeviceKind.mouse ||
                  kind == PointerDeviceKind.touch) {
                handleDisplayedAction(ref, ad.id, context);
                ref.read(navigationService).pushNamedScreen(
                  '${Routes.feedView}/${ad.id}',
                  data: {'tag': tag, 'ad': ad},
                );
              }
            },
            actions: buildPieMenuActions(ref, ad, context),
            child: Hero(
              tag: tag,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: isPro
                            ? Border.all(color: AppColors.light, width: 5.0)
                            : Border.all(),
                      ),
                      child: CachedNetworkImage(
                        height: adFiledSize,
                        width: double.infinity,
                        imageUrl: mainImageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => ShimmerPlaceholder(
                            width: double.infinity, height: adFiledSize),
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
                      right: -2,
                      top: -2,
                      child: isPro
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 8),
                              decoration: BoxDecoration(
                                color: AppColors.light,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                spacing: 10,
                                children: [
                                  Text(
                                    'Sponsored',
                                    style: AppTextStyles.interMedium12dark,
                                  ),
                                ],
                              ),
                            )
                          : Container(),
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
                                style: AppTextStyles.interSemiBold.copyWith(
                                  color: textColor,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Material(
                              color: Colors.transparent,
                              child: Text(
                                '${ad.city}, ${ad.street}',
                                style: AppTextStyles.interRegular.copyWith(
                                  color: textColor,
                                  fontSize: 12,
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
      ),
    );
  }
}
