import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/const/route_constant.dart';

import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/models/ad/ad_list_view_model.dart';
import 'package:hously_flutter/screens/feed/map/map_page.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/utils/pie_menu/feed.dart';
import 'package:hously_flutter/widgets/appbar/hously/pc/appbar_map.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/sidebar/sidebar.dart';
import 'package:intl/intl.dart';
import 'package:pie_menu/pie_menu.dart';

import '../../../state_managers/data/filter_provider.dart';
import '../../../widgets/side_menu/slide_rotate_menu.dart';

class MapViewPcPage extends ConsumerStatefulWidget {
  const MapViewPcPage({super.key});

  @override
  MapViewPageState createState() => MapViewPageState();
}

class MapViewPageState extends ConsumerState<MapViewPcPage> {
  List<AdsListViewModel> filteredAds = [];
  final sideMenuKey = GlobalKey<SideMenuState>();

  void updateFilteredAds(List<AdsListViewModel> ads) {
    setState(() {
      filteredAds = ads;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final ScrollController scrollController = ScrollController();

    final themecolors = ref.watch(themeColorsProvider);
    final textColor = themecolors.themeTextColor;

    final textFieldColor = themecolors.textFieldColor;
    final color = Theme.of(context).primaryColor;
    final isDefaultDarkSystem = ref.watch(isDefaultDarkSystemProvider);
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
          iconColor: Colors.red,
        ),
      ),
      child: Scaffold(
        body: SideMenuManager.sideMenuSettings(
          menuKey: sideMenuKey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Sidebar(
                sideMenuKey: sideMenuKey,
              ),
              Expanded(
                child: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                      gradient:
                          CustomBackgroundGradients.backgroundGradientRight1(
                              context, ref)),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        child: SizedBox(
                          width: screenWidth * 0.625,
                          height: double.infinity,
                          child: MapPage(
                            onFilteredAdsListViewsChanged: updateFilteredAds,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 10,
                        child: ShaderMask(
                          shaderCallback: (bounds) =>
                              CustomBackgroundGradients.appBarGradientcustom(
                                      context, ref)
                                  .createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                          ),
                          child: Text(
                            'HOUSLY.AI',
                            style: AppTextStyles.houslyAiLogo30.copyWith(
                                color: isDefaultDarkSystem ? textColor : color),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: screenWidth * 0.4,
                        child: const TopAppBarMap(),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: screenWidth * 0.4,
                          height: MediaQuery.of(context).size.height,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                            ),
                          ),
                          child: GestureDetector(
                            onVerticalDragUpdate: (details) {
                              scrollController.jumpTo(
                                  scrollController.offset - details.delta.dy);
                            },
                            child: ListView.builder(
                              controller: scrollController,
                              itemCount: filteredAds.length,
                              itemBuilder: (context, index) {
                                final ad = filteredAds[index];
                                final tag = 'mapView${ad.id}';
                                return MouseRegion(
                                  onEnter: (_) {
                                    ref.read(hoveredPropertyProvider.notifier).state = ad; // Use the global provider
                                  },
                                  onExit: (_) {
                                    ref.read(hoveredPropertyProvider.notifier).state = null; // Use the global provider
                                  },
                                  child: SizedBox(
                                    child: PieMenu(
                                      onPressedWithDevice: (kind) {
                                        if (kind == PointerDeviceKind.mouse ||
                                            kind == PointerDeviceKind.touch) {
                                          handleDisplayedAction(ref, ad.id, context);
                                          ref.read(navigationService).pushNamedScreen(
                                            '${Routes.add}/${ad.id}', // Using HEAD's route as primary
                                            data: {'tag': tag, 'ad': ad},
                                          );
                                        }
                                      },
                                      actions: buildPieMenuActions(ref, ad, context),
                                      child: Hero(
                                        tag: tag,
                                        child: Container(
                                          margin: const EdgeInsets.only(bottom: 10),
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            gradient: CustomBackgroundGradients.getaddpagebackground(
                                              context,
                                              ref,
                                            ),
                                          ),
                                          child: AspectRatio(
                                            aspectRatio: 16 / 9,
                                            child: Stack(
                                              children: [
                                                // Container with border wrapping the image
                                                Positioned.fill(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      border: ad.isPro
                                                          ? Border.all(color: Colors.white, width: 5.0)
                                                          : null,
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(10),
                                                      child: Image.network(
                                                        ad.images.isNotEmpty ? ad.images[0] : 'default_image_url',
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                // Sponsored badge for pro ads
                                                if (ad.isPro)
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
                                                // Bottom info container
                                                Positioned(
                                                  left: 2,
                                                  bottom: 2,
                                                  child: Container(
                                                    padding: const EdgeInsets.only(
                                                        top: 5, bottom: 5, right: 8, left: 8),
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
                                                          '${NumberFormat.decimalPattern().format(ad.price)} ${ad.currency}',
                                                          style: AppTextStyles.interBold.copyWith(
                                                            fontSize: 18,
                                                            color: textColor,
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
                                                          ad.title,
                                                          style: AppTextStyles.interSemiBold.copyWith(
                                                            fontSize: 14,
                                                            color: textColor,
                                                            shadows: [
                                                              Shadow(
                                                                offset: const Offset(5.0, 5.0),
                                                                blurRadius: 10.0,
                                                                color: Colors.black.withOpacity(1),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Text(
                                                          '${ad.city}, ${ad.street}',
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
                                  ),
                                );
                              },
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
      ),
    );
  }
}
