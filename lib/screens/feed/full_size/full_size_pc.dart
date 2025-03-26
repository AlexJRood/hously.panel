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
import 'package:hously_flutter/screens/feed/components/cards/selected_card.dart';
import 'package:hously_flutter/state_managers/data/filter_provider.dart';
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

class FullSizePc extends ConsumerStatefulWidget {
  const FullSizePc({super.key});

  @override
  FullSizePcState createState() => FullSizePcState();
}

class FullSizePcState extends ConsumerState<FullSizePc> {
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
    double screenWidth = MediaQuery.of(context).size.width;
    final ScrollController scrollController = ScrollController();
    const double maxWidth = 1920;
    const double minWidth = 480;
    const double maxDynamicPadding = 40;
    const double minDynamicPadding = 10;

    double dynamicPadding = (screenWidth - minWidth) /
            (maxWidth - minWidth) *
            (maxDynamicPadding - minDynamicPadding) +
        minDynamicPadding;

    dynamicPadding = dynamicPadding.clamp(minDynamicPadding, maxDynamicPadding);
    double dynamicSizedBoxWidth = screenWidth / 8 <= 20 ? 20 : screenWidth / 8;

    final adFiledSize  =(((screenWidth) - (dynamicPadding * 2)) - 80);

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
                              child: PagedListView<int, AdsListViewModel>(
                                pagingController: _pagingController,
                                padding: EdgeInsets.symmetric(
                                    horizontal: dynamicSizedBoxWidth,
                                    vertical: 65),
                                builderDelegate:
                                    PagedChildBuilderDelegate<AdsListViewModel>(
                                  itemBuilder: (context, advertisement, index) {
                                    return BuildAdvertisementsList(
                                            adFiledSize: adFiledSize,
                                      scrollController: ScrollController(),
                                      // Scroll handled by PagedListView
                                      filteredAdvertisements: [
                                        advertisement
                                      ], // Single ad as the list
                                      buildShimmerPlaceholder:
                                                ShimmerPlaceholder(
                                                    width: adFiledSize,
                                                    height: adFiledSize),
                                    );
                                  },
                                  firstPageProgressIndicatorBuilder: (_) =>
                                      Center(
                                    child: ShimmerPlaceholderWidget(
                                        scrollController: scrollController,
                                        adFiledSize: (((screenWidth) -
                                                (dynamicPadding * 2)) -
                                            80)),
                                  ),
                                  newPageProgressIndicatorBuilder: (_) =>
                                      Center(
                                    child: ShimmerPlaceholderWidget(
                                        scrollController: scrollController,
                                        adFiledSize: (((screenWidth) -
                                                (dynamicPadding * 2)) -
                                            80)),
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
      required this.buildShimmerPlaceholder,
    required this.scrollController,
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

    
    final cardType = ref.read(selectedCardProvider);


    return Column(
      children: List.generate(filteredAdvertisements.length, (index) {
        final fullSizeAd = filteredAdvertisements[index];
        final tag = 'fullSize${fullSizeAd.id}-${UniqueKey().toString()}';
        final mainImageUrl = fullSizeAd.images.isNotEmpty
            ? fullSizeAd.images[0]
            : 'default_image_url';
        final isPro = fullSizeAd.isPro;
        
        return SelectedCardWidget(
          isMobile: false,
          aspectRatio: cardType.mapAspectRatio,
          ad: fullSizeAd, 
          tag: tag, 
          mainImageUrl: mainImageUrl, 
          isPro: isPro, 
          isDefaultDarkSystem: isDefaultDarkSystem, 
          color: color, 
          textColor: textColor, 
          textFieldColor: textFieldColor, 
          buildShimmerPlaceholder: buildShimmerPlaceholder, 
          buildPieMenuActions: buildPieMenuActions(ref, fullSizeAd, context),
          );
      }),
    );
  }
}

class ShimmerPlaceholderWidget extends StatelessWidget {
  final ScrollController scrollController;
  final double adFiledSize;

  const ShimmerPlaceholderWidget({
    super.key,
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
