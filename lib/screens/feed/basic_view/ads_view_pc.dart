import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/models/ad/ad_list_view_model.dart';
import 'package:hously_flutter/portal/browselist/components/list.dart';
import 'package:hously_flutter/portal/browselist/widget/pc.dart';
import 'package:hously_flutter/screens/feed/components/cards/selected_card.dart';
import 'package:hously_flutter/state_managers/data/filter_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/utils/pie_menu/feed.dart';
import 'package:hously_flutter/widgets/appbar/hously/pc/appbar.dart';
import 'package:hously_flutter/widgets/loading/loading_widgets.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/sidebar/sidebar.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pie_menu/pie_menu.dart';

import 'package:hously_flutter/state_managers/data/Keyboardshortcuts.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';
import 'package:hously_flutter/screens/feed/map/map_page.dart';
import 'package:hously_flutter/screens/pop_pages/view_pop_changer_page.dart';


class AdsViewPage extends ConsumerStatefulWidget {
  const AdsViewPage({super.key});

  @override
  AdsViewPageState createState() => AdsViewPageState();
}


class AdsViewPageState extends ConsumerState<AdsViewPage> {
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

    final cardType = ref.read(selectedCardProvider);

    double cardRatio = cardType.aspectRatio;
    double baseWidth = cardType.baseWidth;
    double paddingByCard = cardType.basePadding;


  int grid;
  if (screenWidth >= 1440) {
    grid = math.max(1, (screenWidth / baseWidth).ceil());
  } else if (screenWidth >= 1080) {
    // Tu w zależności od typu karty
    grid =  3;
    // grid = (cardType == CardType.alex) ? 3 : 2;
  } else if (screenWidth >= 600) {
    grid =  2;
    // grid = (cardType == CardType.alex) ? 2 : 1;
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
        KeyBoardShortcuts().filterpop(event, ref, context);
        KeyBoardShortcuts().sortpopup(event, ref, context);

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
                        flex: 4,
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
                                    childAspectRatio: cardRatio,
                                    crossAxisSpacing: paddingByCard,
                                    mainAxisSpacing: paddingByCard,
                                  ),
                                  builderDelegate: PagedChildBuilderDelegate<
                                      AdsListViewModel>(
                                    itemBuilder:
                                        (context, advertisement, index) {
                                      return  BuildAdvertisementsList(
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
                      BrowseListPcWidget(isWhiteSpaceNeeded: true)
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
        final tag = 'basicviewpc${ad.id}${UniqueKey().toString()}';
        final cardRatio = ref.watch(selectedCardProvider).aspectRatio;

        final mainImageUrl = ad.images.isNotEmpty ? ad.images[0] : 'default_image_url';
        final isPro = ad.isPro;

        return SelectedCardWidget(
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
          buildPieMenuActions: buildPieMenuActions(ref, ad, context),
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




class MapView extends ConsumerWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Define the aspect ratio
    const double aspectRatio = 1288 / 159;
    final double width =
        MediaQuery.of(context).size.width - 32; // Subtract horizontal margin
    final double height = width / aspectRatio;

    return Center(
      child: Container(
        height: height,
        width: width,
        margin: const EdgeInsets.symmetric(horizontal: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: [Colors.blueGrey.shade900, Colors.teal.shade700],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: MapPage(onFilteredAdsListViewsChanged: (a) {}),
            ),
            Positioned(
              bottom: 8,
              left: 8,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.8),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  ref.read(navigationService).pushNamedScreen(Routes.mapView);
                  ref.read(selectedFeedViewProvider.notifier).state =
                      Routes.mapView;
                },
                child: const Text("Show on Map"),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
