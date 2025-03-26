import 'dart:math' as math;
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/models/ad/ad_list_view_model.dart';
import 'package:hously_flutter/state_managers/data/filter_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/utils/pie_menu/feed.dart';
import 'package:hously_flutter/widgets/appbar/hously/pc/appbar.dart';
import 'package:hously_flutter/widgets/loading/loading_widgets.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/sidebar/sidebar.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:pie_menu/pie_menu.dart';

import '../../../state_managers/data/Keyboardshortcuts.dart';
import '../../../widgets/side_menu/slide_rotate_menu.dart';

class GridPcPage extends ConsumerStatefulWidget {
  const GridPcPage({super.key});

  @override
  GridPcPageState createState() => GridPcPageState();
}

class GridPcPageState extends ConsumerState<GridPcPage> {
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

    const double maxWidth = 1920;
    const double minWidth = 1080;
    const double maxDynamicPadding = 40;
    const double minDynamicPadding = 15;
    double dynamicPadding = (screenWidth - minWidth) /
            (maxWidth - minWidth) *
            (maxDynamicPadding - minDynamicPadding) +
        minDynamicPadding;
    final adFiledSize = (((screenWidth) - (dynamicPadding * 2)) - 80);

    dynamicPadding = dynamicPadding.clamp(minDynamicPadding, maxDynamicPadding);

    return KeyboardListener(
      focusNode: FocusNode()..requestFocus(),
      onKeyEvent: (KeyEvent event) {
        KeyBoardShortcuts().filterpop(event, ref);
        KeyBoardShortcuts().sortpopup(event, ref, context);

        KeyBoardShortcuts().handleBackspaceNavigation(event, ref);
        KeyBoardShortcuts().handleKeyEvent(event, scrollController, 50, 100);
        KeyBoardShortcuts().handleKeyNavigation(event, ref, context);
      },
      child: PieCanvas(
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
                    gradient: CustomBackgroundGradients.getMainMenuBackground(
                        context, ref),
                  ),
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
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                  ),
                                  builderDelegate: PagedChildBuilderDelegate<
                                      AdsListViewModel>(
                                    itemBuilder:
                                        (context, advertisement, index) {
                                      return BuildAdvertisementsList(
                                        adFiledSize: adFiledSize,
                                        scrollController: ScrollController(),
                                        buildShimmerPlaceholder:
                                            ShimmerPlaceholder(
                                                width: adFiledSize,
                                                height: adFiledSize),
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
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Positioned(
                  top: 0,
                  right: 0,
                  left: 60,
                  child: TopAppBar(),
                ),
              ],
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

  const BuildAdvertisementsList(
      {super.key,
      required this.filteredAdvertisements,
      required this.scrollController,
      required this.buildShimmerPlaceholder,
      required this.adFiledSize});

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
        final tag = 'fullSize${ad.id}-${UniqueKey().toString()}';

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
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  border: isPro
                      ? Border.all(color: AppColors.light, width: 3.0)
                      : Border.all(),
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
                          placeholder: (context, url) =>
                              buildShimmerPlaceholder,
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
