// ignore_for_file: use_build_context_synchronously

import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/theme/design/design.dart';
import 'package:hously_flutter/routing/navigation_history_provider.dart';
import 'package:hously_flutter/api_services/auth.dart';
import 'package:hously_flutter/routing/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/api_services/api_services.dart';
import 'package:hously_flutter/utils/secure_storage.dart';
import 'package:hously_flutter/widgets/appbar/appbar_mobile.dart';
import 'package:hously_flutter/widgets/card/seller_card_mobile.dart';
import 'package:hously_flutter/modules/ads_managment/feed/feed_pop/full_screen_image.dart';
import 'package:hously_flutter/utils/install_popup.dart';
import 'package:hously_flutter/utils/loading_widgets.dart';
import 'package:hously_flutter/modules/ads_managment/widgets/map/map_ad.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';
import 'package:intl/intl.dart';
import 'package:pie_menu/pie_menu.dart';


class FeedPopMobile extends ConsumerStatefulWidget {
  final dynamic adFeedPop;
  final String tagFeedPop;

  const FeedPopMobile(
      {super.key, required this.adFeedPop, required this.tagFeedPop});

  @override
  FeedPopMobileState createState() => FeedPopMobileState();
}

class FeedPopMobileState extends ConsumerState<FeedPopMobile> {
  final ScrollController _scrollController = ScrollController();
  bool _atTop = true; // Flaga wskazująca, czy jesteśmy na szczycie
  double _dragDistance = 0.0; // Kumulowana odległość przeciągnięcia
  final double _requiredDragDistance = 100.0;
  late String mainImageUrl;
  final SecureStorage secureStorage = SecureStorage();

  bool _isMapActivated = false; // Stan aktywacji mapy
  final sideMenuKey = GlobalKey<SideMenuState>();


  void _activateMap() {
    if (!_isMapActivated) {
      setState(() {
        _isMapActivated =
            true; // Zmienia stan na aktywny, co pozwala na interakcje z mapą
      });
    }
  }

  @override
  void initState() {
    super.initState();
    mainImageUrl =
        widget.adFeedPop.images.isNotEmpty ? widget.adFeedPop.images[0] : '';
    _scrollController.addListener(_updateTopStatus);
  }


  void _updateTopStatus() {
    final atTop = _scrollController.position.pixels <=
        _scrollController.position.minScrollExtent;
    if (_atTop != atTop) {
      setState(() {
        _atTop = atTop;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userAsyncValue = ref.watch(userProvider);
    final lastPage = ref.read(navigationHistoryProvider.notifier).lastPage;
    bool _hasPopped = false; // Flaga kontrolująca pojedyncze wywołanie beamPop

    NumberFormat customFormat = NumberFormat.decimalPattern('fr');

    double screenWidth = MediaQuery.of(context).size.width;
    double mainImageWidth = screenWidth * 0.97;
    double mainImageHeight = mainImageWidth * (650 / 1200);
    double pricePerSquareMeter =
        widget.adFeedPop.price / widget.adFeedPop.squareFootage;
    // Ustawienie maksymalnej i minimalnej szerokości ekranu
    const double maxWidth = 1920;
    const double minWidth = 480;
    // Ustawienie maksymalnego i minimalnego rozmiaru czcionki
    const double maxLogoSize = 30;
    const double minLogoSize = 16;
    // Obliczenie odpowiedniego rozmiaru czcionki
    double logoSize = (screenWidth - minWidth) /
            (maxWidth - minWidth) *
            (maxLogoSize - minLogoSize) +
        minLogoSize;
    // Ograniczenie rozmiaru czcionki do zdefiniowanych minimum i maksimum
    logoSize = logoSize.clamp(minLogoSize, maxLogoSize);
    const double maxPhotoListSize = 120;
    const double minPhotoListSize = 75;
    // Obliczenie odpowiedniego rozmiaru czcionki
    double photoListSize = (screenWidth - minWidth) /
            (maxWidth - minWidth) *
            (maxPhotoListSize - minPhotoListSize) +
        minPhotoListSize;
    String formattedPrice = customFormat.format(widget.adFeedPop.price);
    final theme = ref.watch(themeColorsProvider);
    return userAsyncValue.when(
      data: (user) {
        // String userId = user?.userId ?? '';
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
                backgroundColor: Colors.transparent,
                body: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (notification) {
                    if (notification.leading) {
                      notification.disallowIndicator();
                    }
                    return true;
                  },
                  child: NotificationListener<OverscrollNotification>(
                    onNotification: (OverscrollNotification notification) {
                      if (_atTop && notification.overscroll < 0) {
                        _dragDistance -= notification.overscroll;
                        if (_dragDistance >= _requiredDragDistance && !_hasPopped) {
                          _hasPopped = true; // Ustawiamy flagę, żeby zapobiec ponownemu wywołaniu
                          ref.read(navigationService).beamPop();
                        }
                      } else {
                        _dragDistance = 0.0; // Resetujemy kumulowaną odległość, jeśli nie jesteśmy na szczycie
                      }
                      return true;
                    },
                    child: Stack(
                      children: [
                        // Ta część odpowiada za efekt rozmycia tła
                        BackdropFilter(
                          filter: ui.ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                          child: Container(
                            color: theme.adPopBackground.withOpacity(0.85),
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                        // Obsługa dotknięcia w dowolnym miejscu aby zamknąć modal
                        GestureDetector(
                          onTap: () => ref.read(navigationService).beamPop(),
                        ),

                        // Zawartość modalu

                        Column(
                          children: [
                            AppBarMobile(sideMenuKey: sideMenuKey,),
                            Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5.0, right: 5),
                                  child: SingleChildScrollView(
                                    controller: _scrollController,
                                    physics: const ClampingScrollPhysics(),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Hero(
                                            tag: widget.tagFeedPop,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                  PageRouteBuilder(
                                                    opaque: false,
                                                    pageBuilder:
                                                        (_, animation, __) =>
                                                            FadeTransition(
                                                      opacity: animation,
                                                      child: FullScreenImageView(
                                                        tag: widget.tagFeedPop,
                                                        images: widget
                                                            .adFeedPop.images,
                                                        initialPage: widget
                                                            .adFeedPop.images
                                                            .indexOf(
                                                                mainImageUrl),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: CachedNetworkImage(
                                                  imageUrl: mainImageUrl,
                                                  width: mainImageWidth,
                                                  height: mainImageHeight,
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) =>
                                                      ShimmerPlaceholder(
                                                          width: mainImageWidth,
                                                          height:
                                                              mainImageHeight),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Stack(
                                                            children: [
                                                              ShimmerPlaceholder(
                                                                  width:
                                                                      mainImageWidth,
                                                                  height:
                                                                      mainImageHeight),
                                                              const Center(
                                                                child: Material(
                                                                  color: Colors
                                                                      .transparent,
                                                                  child: Text(
                                                                    'no image found',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .red),
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          )),
                                            ),
                                          ),
                                          const SizedBox(height: 15),
                                          SizedBox(
                                            width: mainImageWidth,
                                            height: 120,
                                            // Ensure the height is sufficient for both ListView scenarios
                                            child: widget
                                                    .adFeedPop.images.isNotEmpty
                                                ? ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: widget
                                                        .adFeedPop.images.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      String imageUrl = widget
                                                          .adFeedPop
                                                          .images[index];
                                                      return GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            mainImageUrl =
                                                                imageUrl; // Update the main image on click
                                                          });
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            left: index == 0
                                                                ? 0
                                                                : 10.0,
                                                            // No padding for the first image
                                                            right: index ==
                                                                    widget
                                                                            .adFeedPop
                                                                            .images
                                                                            .length -
                                                                        1
                                                                ? 0
                                                                : 10.0, // No padding for the last image
                                                          ),
                                                          child:
                                                              CachedNetworkImage(
                                                            imageUrl: imageUrl,
                                                            width: 120,
                                                            height: 120,
                                                            fit: BoxFit.cover,
                                                            placeholder: (context,
                                                                    url) =>
                                                                const ShimmerPlaceholder(
                                                              width: 120,
                                                              height: 120,
                                                            ),
                                                            errorWidget: (context,
                                                                    url, error) =>
                                                                const Stack(
                                                              children: [
                                                                ShimmerPlaceholder(
                                                                    width: 120,
                                                                    height: 120),
                                                                Center(
                                                                  child: Material(
                                                                    color: Colors
                                                                        .transparent,
                                                                    child: Icon(
                                                                        Icons
                                                                            .error),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount:
                                                        10, // Show 10 placeholder items
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding: EdgeInsets.only(
                                                          left: index == 0
                                                              ? 0
                                                              : 10.0,
                                                          // No padding for the first item
                                                          right: index == 9
                                                              ? 0
                                                              : 10.0, // No padding for the last item
                                                        ),
                                                        child: const Stack(
                                                          children: [
                                                            ShimmerPlaceholder(
                                                                width: 120,
                                                                height: 120),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets.all(
                                                                      50),
                                                              child: Icon(
                                                                  Icons.error,
                                                                  color:
                                                                      Colors.red),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  ),
                                          ),
                                          const SizedBox(height: 20),
                                          SizedBox(
                                            width: mainImageWidth,
                                            child: Column(
                                              children: [
                                                // Cena, cena za m²
                                                Row(
                                                  children: [
                                                    Text(
                                                      '$formattedPrice ${widget.adFeedPop.currency}',
                                                      style: AppTextStyles
                                                          .interBold
                                                          .copyWith(
                                                              fontSize: 22,
                                                              color: theme
                                                                  .popUpIconColor),
                                                    ),
                                                    const Spacer(),
                                                    Text(
                                                      '${NumberFormat.decimalPattern().format(pricePerSquareMeter)} ${widget.adFeedPop.currency}/m²',
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: theme
                                                                  .popUpIconColor),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    child: Text(
                                                        widget.adFeedPop.title,
                                                        style: AppTextStyles
                                                            .interBold
                                                            .copyWith(
                                                                fontSize: 18,
                                                                color: theme
                                                                    .popUpIconColor)),
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                      '${widget.adFeedPop.street}, ${widget.adFeedPop.city}, ${widget.adFeedPop.state}',
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: theme
                                                                  .popUpIconColor)),
                                                ),
                                                // Opis, szczegóły
                                                const SizedBox(height: 50),

                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              "Szczegóły ogłoszenia"
                                                                  .tr,
                                                              style: AppTextStyles
                                                                  .interBold
                                                                  .copyWith(
                                                                      fontSize:
                                                                          20,
                                                                      color: theme
                                                                          .popUpIconColor)),
                                                          const SizedBox(
                                                              height: 20),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  'Powierzchnia'
                                                                      .tr,
                                                                  style: AppTextStyles
                                                                      .interRegular
                                                                      .copyWith(
                                                                          fontSize:
                                                                              14,
                                                                          color: theme
                                                                              .popUpIconColor)),
                                                              const Spacer(),
                                                              Text(
                                                                  '${widget.adFeedPop.squareFootage} m²',
                                                                  style: AppTextStyles
                                                                      .interRegular
                                                                      .copyWith(
                                                                          fontSize:
                                                                              14,
                                                                          color: theme
                                                                              .popUpIconColor)),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 5),
                                                          Divider(
                                                            color: theme
                                                                .popUpIconColor,
                                                            thickness: 1,
                                                          ),
                                                          const SizedBox(
                                                              height: 5),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  'Liczba łazienek'
                                                                      .tr,
                                                                  style: AppTextStyles
                                                                      .interRegular
                                                                      .copyWith(
                                                                          fontSize:
                                                                              14,
                                                                          color: theme
                                                                              .popUpIconColor)),
                                                              const Spacer(),
                                                              Text(
                                                                  '${widget.adFeedPop.bathrooms}',
                                                                  style: AppTextStyles
                                                                      .interRegular
                                                                      .copyWith(
                                                                          fontSize:
                                                                              14,
                                                                          color: theme
                                                                              .popUpIconColor)),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 5),
                                                          Divider(
                                                            color: theme
                                                                .popUpIconColor,
                                                            thickness: 1,
                                                          ),
                                                          const SizedBox(
                                                              height: 5),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  'Liczba pokoi'
                                                                      .tr,
                                                                  style: AppTextStyles
                                                                      .interRegular
                                                                      .copyWith(
                                                                          fontSize:
                                                                              14,
                                                                          color: theme
                                                                              .popUpIconColor)),
                                                              const Spacer(),
                                                              Text(
                                                                  '${widget.adFeedPop.rooms}',
                                                                  style: AppTextStyles
                                                                      .interRegular
                                                                      .copyWith(
                                                                          fontSize:
                                                                              14,
                                                                          color: theme
                                                                              .popUpIconColor)),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 5),
                                                          Divider(
                                                            color: theme
                                                                .popUpIconColor,
                                                            thickness: 1,
                                                          ),
                                                          const SizedBox(
                                                              height: 5),
                                                          Row(
                                                            children: [
                                                              Text('Piętro'.tr,
                                                                  style: AppTextStyles
                                                                      .interRegular
                                                                      .copyWith(
                                                                          fontSize:
                                                                              14,
                                                                          color: theme
                                                                              .popUpIconColor)),
                                                              const Spacer(),
                                                              Text(
                                                                  '${widget.adFeedPop.floor}/${widget.adFeedPop.totalFloors}',
                                                                  style: AppTextStyles
                                                                      .interRegular
                                                                      .copyWith(
                                                                          fontSize:
                                                                              14,
                                                                          color: theme
                                                                              .popUpIconColor)),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 5),
                                                          Divider(
                                                            color: theme
                                                                .popUpIconColor,
                                                            thickness: 1,
                                                          ),
                                                          const SizedBox(
                                                              height: 5),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  'Forma własności'
                                                                      .tr,
                                                                  style: AppTextStyles
                                                                      .interRegular
                                                                      .copyWith(
                                                                          fontSize:
                                                                              14,
                                                                          color: theme
                                                                              .popUpIconColor)),
                                                              const Spacer(),
                                                              Text(
                                                                  widget.adFeedPop
                                                                      .marketType,
                                                                  style: AppTextStyles
                                                                      .interRegular
                                                                      .copyWith(
                                                                          fontSize:
                                                                              14)),
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 5),
                                                          Divider(
                                                            color: theme
                                                                .popUpIconColor,
                                                            thickness: 1,
                                                          ),
                                                          const SizedBox(
                                                              height: 5),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                  'Miejsce parkingowe'
                                                                      .tr,
                                                                  style: AppTextStyles
                                                                      .interRegular
                                                                      .copyWith(
                                                                          fontSize:
                                                                              14,
                                                                          color: theme
                                                                              .popUpIconColor)),
                                                              const Spacer(),
                                                              // Text(widget.adFeedPop., style: AppTextStyles.interRegular.copyWith(fontSize: 14)),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 50,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text("Opis".tr,
                                                              style: AppTextStyles
                                                                  .interBold
                                                                  .copyWith(
                                                                      fontSize:
                                                                          20,
                                                                      color: theme
                                                                          .popUpIconColor)),
                                                          const SizedBox(
                                                              height: 10),
                                                          Text(
                                                              widget.adFeedPop
                                                                  .description,
                                                              style: AppTextStyles
                                                                  .interRegular
                                                                  .copyWith(
                                                                      fontSize:
                                                                          14,
                                                                      color: theme
                                                                          .popUpIconColor)),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                //Mapa
                                                const SizedBox(
                                                  height: 50,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        height: 400,
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  20.0), // Zaokrąglone rogi
                                                          // Dodaj inne dekoracje, jak tło, jeśli potrzebujesz
                                                        ),
                                                        child: MapAd(
                                                          latitude: widget
                                                              .adFeedPop.latitude,
                                                          longitude: widget
                                                              .adFeedPop
                                                              .longitude,
                                                          onMapActivated: () {
                                                            if (!_isMapActivated) {
                                                              _activateMap();
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                const SizedBox(
                                                  height: 50,
                                                ),

                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              "Informacje dodatkowe"
                                                                  .tr,
                                                              style: AppTextStyles
                                                                  .interBold
                                                                  .copyWith(
                                                                      fontSize:
                                                                          20,
                                                                      color: theme
                                                                          .popUpIconColor)),
                                                          const SizedBox(
                                                              height: 20),
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Expanded(
                                                                flex: 4,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                            'Powierzchnia'
                                                                                .tr,
                                                                            style: AppTextStyles.interRegular.copyWith(
                                                                                fontSize: 14,
                                                                                color: theme.popUpIconColor)),
                                                                        const Spacer(),
                                                                        Text(
                                                                            '${widget.adFeedPop.squareFootage} m²',
                                                                            style: AppTextStyles.interRegular.copyWith(
                                                                                fontSize: 14,
                                                                                color: theme.popUpIconColor)),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            5),
                                                                    Divider(
                                                                        color: theme
                                                                            .popUpIconColor,
                                                                        thickness:
                                                                            1),
                                                                    const SizedBox(
                                                                        height:
                                                                            5),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                            'Liczba łazienek'
                                                                                .tr,
                                                                            style: AppTextStyles.interRegular.copyWith(
                                                                                fontSize: 14,
                                                                                color: theme.popUpIconColor)),
                                                                        const Spacer(),
                                                                        Text(
                                                                            '${widget.adFeedPop.bathrooms}',
                                                                            style: AppTextStyles.interRegular.copyWith(
                                                                                fontSize: 14,
                                                                                color: theme.popUpIconColor)),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            5),
                                                                    Divider(
                                                                        color: theme
                                                                            .popUpIconColor,
                                                                        thickness:
                                                                            1),
                                                                    const SizedBox(
                                                                        height:
                                                                            5),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                            'Liczba pokoi'
                                                                                .tr,
                                                                            style: AppTextStyles.interRegular.copyWith(
                                                                                fontSize: 14,
                                                                                color: theme.popUpIconColor)),
                                                                        const Spacer(),
                                                                        Text(
                                                                            '${widget.adFeedPop.rooms}',
                                                                            style: AppTextStyles.interRegular.copyWith(
                                                                                fontSize: 14,
                                                                                color: theme.popUpIconColor)),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            5),
                                                                    Divider(
                                                                      color: theme
                                                                          .popUpIconColor,
                                                                      thickness:
                                                                          1,
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            5),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                            'Piętro'
                                                                                .tr,
                                                                            style: AppTextStyles.interRegular.copyWith(
                                                                                fontSize: 14,
                                                                                color: theme.popUpIconColor)),
                                                                        const Spacer(),
                                                                        Text(
                                                                            '${widget.adFeedPop.floor}/${widget.adFeedPop.totalFloors}',
                                                                            style: AppTextStyles.interRegular.copyWith(
                                                                                fontSize: 14,
                                                                                color: theme.popUpIconColor)),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            5),
                                                                    Divider(
                                                                        color: theme
                                                                            .popUpIconColor,
                                                                        thickness:
                                                                            1),
                                                                    const SizedBox(
                                                                        height:
                                                                            5),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                            'Forma własności'
                                                                                .tr,
                                                                            style: AppTextStyles.interRegular.copyWith(
                                                                                fontSize: 14,
                                                                                color: theme.popUpIconColor)),
                                                                        const Spacer(),
                                                                        Text(
                                                                            widget
                                                                                .adFeedPop
                                                                                .marketType,
                                                                            style: AppTextStyles.interRegular.copyWith(
                                                                                fontSize: 14,
                                                                                color: theme.popUpIconColor)),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            5),
                                                                    Divider(
                                                                      color: theme
                                                                          .popUpIconColor,
                                                                      thickness:
                                                                          1,
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            5),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                            'Miejsce parkingowe'
                                                                                .tr,
                                                                            style: AppTextStyles.interRegular.copyWith(
                                                                                fontSize: 14,
                                                                                color: theme.popUpIconColor)),
                                                                        const Spacer(),
                                                                        // Text(widget.adFeedPop., style: AppTextStyles.interRegular.copyWith(fontSize: 14)),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),

                                                              const Expanded(
                                                                flex: 1,
                                                                child: SizedBox(),
                                                              ),

                                                              // Szczegóły
                                                              Expanded(
                                                                flex: 4,
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                            'Powierzchnia'
                                                                                .tr,
                                                                            style: AppTextStyles.interRegular.copyWith(
                                                                                fontSize: 14,
                                                                                color: theme.popUpIconColor)),
                                                                        const Spacer(),
                                                                        Text(
                                                                            '${widget.adFeedPop.squareFootage} m²',
                                                                            style: AppTextStyles.interRegular.copyWith(
                                                                                fontSize: 14,
                                                                                color: theme.popUpIconColor)),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            5),
                                                                    Divider(
                                                                      color: theme
                                                                          .popUpIconColor,
                                                                      thickness:
                                                                          1,
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            5),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                            'Liczba łazienek'
                                                                                .tr,
                                                                            style: AppTextStyles.interRegular.copyWith(
                                                                                fontSize: 14,
                                                                                color: theme.popUpIconColor)),
                                                                        const Spacer(),
                                                                        Text(
                                                                            '${widget.adFeedPop.bathrooms}',
                                                                            style: AppTextStyles.interRegular.copyWith(
                                                                                fontSize: 14,
                                                                                color: theme.popUpIconColor)),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            5),
                                                                    Divider(
                                                                      color: theme
                                                                          .popUpIconColor,
                                                                      thickness:
                                                                          1,
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            5),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                            'Liczba pokoi'
                                                                                .tr,
                                                                            style: AppTextStyles.interRegular.copyWith(
                                                                                fontSize: 14,
                                                                                color: theme.popUpIconColor)),
                                                                        const Spacer(),
                                                                        Text(
                                                                            '${widget.adFeedPop.rooms}',
                                                                            style: AppTextStyles.interRegular.copyWith(
                                                                                fontSize: 14,
                                                                                color: theme.popUpIconColor)),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            5),
                                                                    Divider(
                                                                      color: theme
                                                                          .popUpIconColor,
                                                                      thickness:
                                                                          1,
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            5),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                            'Piętro'
                                                                                .tr,
                                                                            style: AppTextStyles.interRegular.copyWith(
                                                                                fontSize: 14,
                                                                                color: theme.popUpIconColor)),
                                                                        const Spacer(),
                                                                        Text(
                                                                            '${widget.adFeedPop.floor}/${widget.adFeedPop.totalFloors}',
                                                                            style: AppTextStyles.interRegular.copyWith(
                                                                                fontSize: 14,
                                                                                color: theme.popUpIconColor)),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            5),
                                                                    Divider(
                                                                      color: theme
                                                                          .popUpIconColor,
                                                                      thickness:
                                                                          1,
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            5),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                            'Forma własności'
                                                                                .tr,
                                                                            style: AppTextStyles.interRegular.copyWith(
                                                                                fontSize: 14,
                                                                                color: theme.popUpIconColor)),
                                                                        const Spacer(),
                                                                        Text(
                                                                            widget
                                                                                .adFeedPop
                                                                                .marketType,
                                                                            style: AppTextStyles.interRegular.copyWith(
                                                                                fontSize: 14,
                                                                                color: theme.popUpIconColor)),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            5),
                                                                    Divider(
                                                                      color: theme
                                                                          .popUpIconColor,
                                                                      thickness:
                                                                          1,
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            5),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                            'Miejsce parkingowe'
                                                                                .tr,
                                                                            style: AppTextStyles.interRegular.copyWith(
                                                                                fontSize: 14,
                                                                                color: theme.popUpIconColor)),
                                                                        const Spacer(),
                                                                        // Text(widget.adFeedPop., style: AppTextStyles.interRegular.copyWith(fontSize: 14)),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                const SizedBox(height: 25),
                                                const Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(child: SizedBox()),
                                                    // Opis
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 75,
                                                ),
                                                SellerCardMobile(
                                                    sellerId:
                                                        widget.adFeedPop.sellerId,
                                                    onTap: () {}),

                                                const SizedBox(height: 75),
                                              ],
                                            ),
                                          ),
                                        ]),
                                  ),
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
            ),
          ),
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => Text('Błąd: $error'.tr),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateTopStatus);
    _scrollController.dispose();
    super.dispose();
  }
}

extension ContextExtension on BuildContext {
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).removeCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
