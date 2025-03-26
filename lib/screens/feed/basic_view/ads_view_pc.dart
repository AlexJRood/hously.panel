import 'dart:math' as math;
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/state_managers/data/Keyboardshortcuts.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart'; // Optional for localization
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/button_style.dart'; // Button styling
import 'package:hously_flutter/const/backgroundgradient.dart'; // Gradient styling

import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/data/filter_provider.dart'; // Make sure the path is correct
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/pie_menu/feed.dart';
import 'package:hously_flutter/widgets/appbar/hously/pc/appbar.dart';
import 'package:hously_flutter/widgets/loading/loading_widgets.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/sidebar/sidebar.dart';
import 'package:intl/intl.dart';
import 'package:pie_menu/pie_menu.dart';

import '../../../widgets/appbar/hously/pc/newappbar.dart';
import '../../../widgets/side_menu/slide_rotate_menu.dart';
import '../../pop_pages/view_pop_changer_page.dart';

class AdsViewPage extends ConsumerWidget {
  const AdsViewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = ScrollController();
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    final customFormat = NumberFormat.decimalPattern('fr');
    final _sideMenuKey = GlobalKey<SideMenuState>();

    int grid;
    if (screenWidth >= 1440) {
      grid = math.max(1, (screenWidth / 500).ceil());
    } else if (screenWidth >= 1080) {
      grid = 4;
    } else if (screenWidth >= 600) {
      grid = 3;
    } else {
      grid = 2;
    }

    const maxWidth = 1920;
    const minWidth = 1080;

    const maxDynamicPadding = 40;
    const minDynamicPadding = 15;

    var dynamicPadding = (screenWidth - minWidth) /
            (maxWidth - minWidth) *
            (maxDynamicPadding - minDynamicPadding) +
        minDynamicPadding;
    dynamicPadding =
        dynamicPadding.clamp(minDynamicPadding, maxDynamicPadding) as double;

    const minBaseTextSize = 5.0;
    const maxBaseTextSize = 15.0;
    var baseTextSize = (screenWidth - minWidth) /
            (maxWidth - minWidth) *
            (maxBaseTextSize - minBaseTextSize) +
        minBaseTextSize;
    baseTextSize =
        baseTextSize.clamp(minBaseTextSize, maxBaseTextSize) as double;

    final sideMenuKey = GlobalKey<SideMenuState>();

    final color = Theme.of(context).primaryColor;
    final isDefaultDarkSystem = ref.watch(isDefaultDarkSystemProvider);
    final themecolors = ref.watch(themeColorsProvider);
    final currentthememode = ref.watch(themeProvider);
    final textFieldColor =
        currentthememode == ThemeMode.system ? Colors.black : Colors.white;

    final textcolor = themecolors.themeTextColor;
    return KeyboardListener(
      focusNode: FocusNode()..requestFocus(),
      onKeyEvent: (KeyEvent event) {
        if (event.logicalKey == ref.watch(filterKeyProvider) &&
            event is KeyDownEvent) {
          ref.read(navigationService).pushNamedScreen(Routes.filters);
        }
        if (event.logicalKey == ref.watch(sortKeyProvider) &&
            event is KeyDownEvent) {
          ref.read(navigationService).pushNamedScreen(Routes.sortPop);
        }
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
            child: Row(
              children: [
                Sidebar(
                  sideMenuKey: sideMenuKey,
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(color: Color(0xff000000)),
                    child: Column(
                      children: [
                        ClipRRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: CustomBackgroundGradients
                                    .backgroundGradientRight1(context, ref),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    color: Colors.black,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ButtonTextRow(),
                                        TopAppBar(),
                                      ],
                                    ),
                                  ),
                                  adsViewTopAppBar(context, ref),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 322,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: dynamicPadding,
                                  ),
                                  child: CustomScrollView(
                                    controller: scrollController,
                                    slivers: [
                                      SliverToBoxAdapter(
                                        child: Text(
                                          'Real Estate & Homes For Sale',
                                          style: GoogleFonts.inter(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SliverToBoxAdapter(
                                        child: SizedBox(
                                          height: 12,
                                        ),
                                      ),
                                      SliverToBoxAdapter(
                                        child: MapView(),
                                      ),
                                      const SliverToBoxAdapter(
                                        child: SizedBox(
                                          height: 12,
                                        ),
                                      ),
                                      SliverToBoxAdapter(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Best options',
                                                  style: GoogleFonts.inter(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  '46189 result',
                                                  style: GoogleFonts.inter(
                                                    color: Colors.grey,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Sort by:',
                                                  style: GoogleFonts.inter(
                                                    color: Colors.grey,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.grey[850],
                                                    // Background color
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 12,
                                                        vertical: 6),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8), // Rounded corners
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    // Handle button press
                                                    print(
                                                        "Sort by: Price(Highest-Low) clicked");
                                                  },
                                                  child: Text(
                                                    'Price(Highest-Low)',
                                                    style: GoogleFonts.inter(
                                                      color: Colors.white,
                                                      // Text color
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SliverToBoxAdapter(
                                        child: SizedBox(height: 70),
                                      ),
                                      ref.watch(filterProvider).when(
                                            data: (filteredAdvertisements) {
                                              if (filteredAdvertisements
                                                  .isEmpty) {
                                                return SliverToBoxAdapter(
                                                  child: SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height -
                                                            100,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          'Upss... brak wyników wyszukiwania. Poszerz kryteria wyszukiwania.'
                                                              .tr,
                                                          style:
                                                              GoogleFonts.inter(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }
                                              return SliverGrid(
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: grid,
                                                  childAspectRatio: .54,
                                                  mainAxisSpacing: 12,
                                                  crossAxisSpacing: 12,
                                                ),
                                                delegate:
                                                    SliverChildBuilderDelegate(
                                                  (context, index) {
                                                    final feedAd =
                                                        filteredAdvertisements[
                                                            index];
                                                    final keyTag =
                                                        'feedAdKey${feedAd.id}-${UniqueKey().toString()}';
                                                    String formattedPrice =
                                                        customFormat.format(
                                                            feedAd.price);

                                                    final mainImageUrl = feedAd
                                                            .images.isNotEmpty
                                                        ? feedAd.images[0]
                                                        : 'default_image_url';

                                                    return Container(
                                                      width: 307,
                                                      margin:
                                                          const EdgeInsets.all(
                                                              7),
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xff1E1E1E),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.2),
                                                            blurRadius: 6,
                                                            offset:
                                                                const Offset(
                                                                    0, 4),
                                                          ),
                                                        ],
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Stack(
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          6),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          6),
                                                                ),
                                                                child: SizedBox(
                                                                  height: 210,
                                                                  width: double
                                                                      .infinity,
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    imageUrl:
                                                                        mainImageUrl,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    placeholder:
                                                                        (context,
                                                                                url) =>
                                                                            const Center(
                                                                      child: ShimmerPlaceholder(
                                                                          width:
                                                                              0,
                                                                          height:
                                                                              0),
                                                                    ),
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        Container(
                                                                      color: Colors
                                                                          .grey,
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child: const Icon(
                                                                          Icons
                                                                              .error,
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Positioned(
                                                                top: 8,
                                                                right: 8,
                                                                child:
                                                                    Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .symmetric(
                                                                    horizontal:
                                                                        8,
                                                                    vertical: 4,
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.7),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                  ),
                                                                  child: Text(
                                                                    'Sponsored',
                                                                    style: GoogleFonts
                                                                        .inter(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(12.0),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  'Warszawa, Mokotów, Poland',
                                                                  style:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    color: const Color(
                                                                        0xffC8C8C8),
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 4),
                                                                Text(
                                                                  'Biały Kamień Street',
                                                                  style:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 8),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Icon(
                                                                            Icons
                                                                                .square_foot,
                                                                            color:
                                                                                Colors.grey[400],
                                                                            size: 16),
                                                                        const SizedBox(
                                                                            width:
                                                                                4),
                                                                        Text(
                                                                          '98 m²',
                                                                          style:
                                                                              GoogleFonts.inter(
                                                                            color:
                                                                                Colors.grey[400],
                                                                            fontSize:
                                                                                13,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Icon(
                                                                            Icons
                                                                                .king_bed,
                                                                            color:
                                                                                Colors.grey[400],
                                                                            size: 16),
                                                                        const SizedBox(
                                                                            width:
                                                                                4),
                                                                        Text(
                                                                          '2 Rooms',
                                                                          style:
                                                                              GoogleFonts.inter(
                                                                            color:
                                                                                Colors.grey[400],
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        Icon(
                                                                            Icons
                                                                                .bathtub,
                                                                            color:
                                                                                Colors.grey[400],
                                                                            size: 16),
                                                                        const SizedBox(
                                                                            width:
                                                                                4),
                                                                        Text(
                                                                          '2 Bath',
                                                                          style:
                                                                              GoogleFonts.inter(
                                                                            color:
                                                                                Colors.grey[400],
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                    height: 4),
                                                                Divider(
                                                                    color: Colors
                                                                            .grey[
                                                                        700]),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      'FOR SALE',
                                                                      style: GoogleFonts
                                                                          .inter(
                                                                        color: Colors
                                                                            .grey,
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      '\$$formattedPrice',
                                                                      style: GoogleFonts
                                                                          .inter(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            24,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  childCount:
                                                      filteredAdvertisements
                                                          .length,
                                                ),
                                              );
                                            },
                                            loading: () => SliverFillRemaining(
                                              child: Center(
                                                child: ShimmerAdvertisementGrid(
                                                  scrollController:
                                                      scrollController,
                                                  crossAxisCount: grid,
                                                ),
                                              ),
                                            ),
                                            error: (error, stack) =>
                                                SliverFillRemaining(
                                              child: Center(
                                                child: Text(
                                                  'Wystąpił błąd: $error'.tr,
                                                  style: GoogleFonts.inter(),
                                                ),
                                              ),
                                            ),
                                          ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 103,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 30.0),
                                  child: SavedItemsSidebar(),
                                ),
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
            menuKey: sideMenuKey,
          ),
        ),
      ),
    );
  }
}

class MapView extends ConsumerWidget {
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
        // Dynamically calculate height based on width and aspect ratio
        width: width,
        margin: const EdgeInsets.symmetric(horizontal: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: [Colors.blueGrey.shade900, Colors.teal.shade700],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ), // Use gradient for testing
        ),
        child: Stack(
          children: [
            // Replace this with an actual map image or widget
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/images/road-map-of-Poland.webp',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Positioned(
              bottom: 8,
              left: 8,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.8),
                  // Button style
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
                  ref.read(navigationService).pushNamedScreen(
                        Routes.mapView,
                      );
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

class SavedItemsSidebar extends StatelessWidget {
  ScrollController yourScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xff212020),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
            bottomLeft: Radius.circular(6),
            bottomRight: Radius.circular(6),
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 14.0, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Saved Items",
                      style: TextStyle(color: Colors.white, fontSize: 18)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.close,
                        color: Color(0xff5A5A5A),
                      )),
                ],
              ),
            ),

            const SavedItemCard(
              image: "https://example.com/image1.jpg",
              title: "Parker Rd, Allentown",
              price: "\$165.00 / 1700 sq.ft",
              imageUrl: '',
              size: '',
            ),
            const SavedItemCard(
              image: "https://example.com/image1.jpg",
              title: "Parker Rd, Allentown",
              price: "\$165.00 / 1700 sq.ft",
              imageUrl: '',
              size: '',
            ),
            const SavedItemCard(
              image: "https://example.com/image1.jpg",
              title: "Parker Rd, Allentown",
              price: "\$165.00 / 1700 sq.ft",
              imageUrl: '',
              size: '',
            ),
            const SavedItemCard(
              image: "https://example.com/image1.jpg",
              title: "Parker Rd, Allentown",
              price: "\$165.00 / 1700 sq.ft",
              imageUrl: '',
              size: '',
            ),
            const SavedItemCard(
              image: "https://example.com/image1.jpg",
              title: "Parker Rd, Allentown",
              price: "\$165.00 / 1700 sq.ft",
              imageUrl: '',
              size: '',
            ),
            const SavedItemCard(
              image: "https://example.com/image1.jpg",
              title: "Parker Rd, Allentown",
              price: "\$165.00 / 1700 sq.ft",
              imageUrl: '',
              size: '',
            ),
            // Add more saved items
          ],
        ),
      ),
    );
  }
}

class SavedItemCard extends StatelessWidget {
  final String image, title, price, imageUrl, size;

  const SavedItemCard({
    required this.image,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    const double aspectRatio = 372 / 206;
    const double containerWidth = 372;
    final double containerHeight = containerWidth / aspectRatio;

    return Container(
      height: containerHeight,
      width: containerWidth,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          const BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: SizedBox(
              height: containerHeight * 0.9,
              width: double.infinity,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      size,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
