import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/theme/icons.dart';
import 'package:hously_flutter/theme/design/design.dart';
import 'package:hously_flutter/utils/custom_error_handler.dart';
import 'package:hously_flutter/routing/navigation_history_provider.dart';
import 'package:hously_flutter/modules/chat/new_chat/chat_page.dart';
import 'package:hously_flutter/modules/chat/new_chat/provider/chat_room_provider.dart';
import 'package:hously_flutter/modules/ads_managment/feed/feed_pop/full_screen_image.dart';
import 'package:hously_flutter/utils/Keyboardshortcuts.dart';
import 'package:hously_flutter/api_services/auth.dart';
import 'package:hously_flutter/routing/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/utils/secure_storage.dart';
import 'package:hously_flutter/widgets/card/seller_card.dart';

import 'package:hously_flutter/utils/drad_scroll_widget.dart';
import 'package:hously_flutter/utils/loading_widgets.dart';
import 'package:hously_flutter/modules/ads_managment/widgets/map/map_ad.dart';
import 'package:intl/intl.dart';
import 'package:pie_menu/pie_menu.dart';


void copyToClipboard(BuildContext context, String listingUrl) {
  Clipboard.setData(ClipboardData(text: listingUrl)).then((_) {
    final snackBar = Customsnackbar().showSnackBar(
        "Success", "Link skopiowany do schowka!".tr, "success", () {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    });
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  });
}

class FeedPopFull extends ConsumerStatefulWidget {
  final dynamic adFeedPop;
  final String tagFeedPop;

  const FeedPopFull(
      {super.key, required this.adFeedPop, required this.tagFeedPop});

  @override
  FeedPopFullState createState() => FeedPopFullState();
}

class FeedPopFullState extends ConsumerState<FeedPopFull> {
  late String mainImageUrl;
  final SecureStorage secureStorage = SecureStorage();
  // final _chatPageState = const ChatPc().createState();

  bool _isMapActivated = false; // Stan aktywacji mapy

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
  }

  @override
  Widget build(BuildContext context) {
    final userAsyncValue = ref.watch(userProvider);
    final lastPage = ref.read(navigationHistoryProvider.notifier).lastPage;
    bool _hasPopped = false; // Flaga kontrolująca pojedyncze wywołanie beamPop


    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double mainImageWidth = screenWidth * 0.625;
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
    ScrollController _scrollController = ScrollController();
    ScrollController _scrollController2 = ScrollController();
    final customFormat = NumberFormat.decimalPattern('fr');
    final formattedPrice = customFormat.format(widget.adFeedPop.price);
    final theme = ref.watch(themeColorsProvider);
    return userAsyncValue.when(
      data: (user) {
        // String userId = user?.userId ?? '';
        return KeyboardListener(
            focusNode: FocusNode()..requestFocus(),
            onKeyEvent: (KeyEvent event) {
              // Check if the pressed key matches the stored pop key
              if (event.logicalKey == ref.read(popKeyProvider) &&
                  event is KeyDownEvent) {
                if (Navigator.canPop(context)) {
                  ref.read(navigationService).beamPop();
                }
              }
              KeyBoardShortcuts()
                  .handleKeyEvent(event, _scrollController, 200, 50);
              KeyBoardShortcuts()
                  .handleKeyEvent2(event, _scrollController2, 50, 100);
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
                backgroundColor: Colors.transparent,
                body: Stack(
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
                    Positioned(
                      top: 20,
                      left: 20,
                      child: SizedBox(
                        width: 300,
                        height: screenHeight - 40,
                        child: Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                  icon: SvgPicture.asset(AppIcons.iosArrowLeft,
                                      color: theme.popUpIconColor),
                                  onPressed: () =>
                                      ref.read(navigationService).beamPop(),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: DragScrollPop(
                        scrollcontroller: _scrollController,
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 75),
                              Hero(
                                  tag: widget.tagFeedPop,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        PageRouteBuilder(
                                          opaque: false,
                                          pageBuilder: (_, animation, __) =>
                                              FadeTransition(
                                            opacity: animation,
                                            child: FullScreenImageView(
                                              tag: widget.tagFeedPop,
                                              images: widget.adFeedPop.images,
                                              initialPage: widget
                                                  .adFeedPop.images
                                                  .indexOf(mainImageUrl),
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
                                        height: mainImageHeight,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Stack(
                                        children: [
                                          ShimmerPlaceholder(
                                            width: mainImageWidth,
                                            height: mainImageHeight,
                                          ),
                                          const Center(
                                            child: Material(
                                              color: Colors.transparent,
                                              child: Text(
                                                'no image found',
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: mainImageWidth,
                                height: 120,
                                // Ensure the height is sufficient for both ListView scenarios
                                child: widget.adFeedPop.images.isNotEmpty
                                    ? DragScrollView(
                                        controller: _scrollController2,
                                        child: ListView.builder(
                                          controller: _scrollController2,
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              widget.adFeedPop.images.length,
                                          itemBuilder: (context, index) {
                                            String imageUrl =
                                                widget.adFeedPop.images[index];
                                            return GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  mainImageUrl =
                                                      imageUrl; // Update the main image on click
                                                });
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: index == 0 ? 0 : 10.0,
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
                                                child: CachedNetworkImage(
                                                  imageUrl: imageUrl,
                                                  width: 120,
                                                  height: 120,
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) =>
                                                      const ShimmerPlaceholder(
                                                    width: 120,
                                                    height: 120,
                                                    radius: 0,
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          const Stack(
                                                    children: [
                                                      ShimmerPlaceholder(
                                                          width: 120,
                                                          height: 120),
                                                      Center(
                                                        child: Material(
                                                          color: Colors
                                                              .transparent,
                                                          child:
                                                              Icon(Icons.error),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    : ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            10, // Show 10 placeholder items
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                              left: index == 0 ? 0 : 10.0,
                                              // No padding for the first item
                                              right: index == 9
                                                  ? 0
                                                  : 10.0, // No padding for the last item
                                            ),
                                            child: const Stack(
                                              children: [
                                                ShimmerPlaceholder(
                                                    width: 120, height: 120),
                                                Padding(
                                                  padding: EdgeInsets.all(50),
                                                  child: Icon(Icons.error,
                                                      color: Colors.red),
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
                                          style: AppTextStyles.interBold
                                              .copyWith(
                                                  fontSize: 26,
                                                  color: theme.popUpIconColor),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '${NumberFormat.decimalPattern().format(pricePerSquareMeter)} ${widget.adFeedPop.currency}/m²',
                                          style: AppTextStyles.interRegular
                                              .copyWith(
                                                  fontSize: 16,
                                                  color: theme.popUpIconColor),
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
                                        child: Text(widget.adFeedPop.title,
                                            style: AppTextStyles.interBold
                                                .copyWith(
                                                    fontSize: 22,
                                                    color:
                                                        theme.popUpIconColor)),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                          '${widget.adFeedPop.street}, ${widget.adFeedPop.city}, ${widget.adFeedPop.state}',
                                          style: AppTextStyles.interRegular
                                              .copyWith(
                                                  fontSize: 16,
                                                  color: theme.popUpIconColor)),
                                    ),
                                    // Opis, szczegóły
                                    const SizedBox(height: 50),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Opis
                                        Expanded(
                                          flex: 6,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Opis".tr,
                                                  style: AppTextStyles.interBold
                                                      .copyWith(
                                                          fontSize: 20,
                                                          color: theme
                                                              .popUpIconColor)),
                                              const SizedBox(height: 10),
                                              Text(widget.adFeedPop.description,
                                                  style: AppTextStyles
                                                      .interRegular
                                                      .copyWith(
                                                          fontSize: 14,
                                                          color: theme
                                                              .popUpIconColor)),
                                            ],
                                          ),
                                        ),
                                        const Expanded(
                                          flex: 1,
                                          child: SizedBox(),
                                        ),
                                        // Szczegóły
                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Szczegóły ogłoszenia".tr,
                                                  style: AppTextStyles.interBold
                                                      .copyWith(
                                                          fontSize: 20,
                                                          color: theme
                                                              .popUpIconColor)),
                                              const SizedBox(height: 20),
                                              Row(
                                                children: [
                                                  Text('Powierzchnia'.tr,
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: theme
                                                                  .popUpIconColor)),
                                                  const Spacer(),
                                                  Text(
                                                      '${widget.adFeedPop.squareFootage} m²',
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: theme
                                                                  .popUpIconColor)),
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Divider(
                                                color: theme.popUpIconColor,
                                                thickness: 1,
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Text('Liczba łazienek'.tr,
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: theme
                                                                  .popUpIconColor)),
                                                  const Spacer(),
                                                  Text(
                                                      '${widget.adFeedPop.bathrooms}',
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: theme
                                                                  .popUpIconColor)),
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Divider(
                                                color: theme.popUpIconColor,
                                                thickness: 1,
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Text('Liczba pokoi'.tr,
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: theme
                                                                  .popUpIconColor)),
                                                  const Spacer(),
                                                  Text(
                                                      '${widget.adFeedPop.rooms}',
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: theme
                                                                  .popUpIconColor)),
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Divider(
                                                color: theme.popUpIconColor,
                                                thickness: 1,
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Text('Piętro'.tr,
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: theme
                                                                  .popUpIconColor)),
                                                  const Spacer(),
                                                  Text(
                                                      '${widget.adFeedPop.floor}/${widget.adFeedPop.totalFloors}',
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: theme
                                                                  .popUpIconColor)),
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Divider(
                                                color: theme.popUpIconColor,
                                                thickness: 1,
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Text('Forma własności'.tr,
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: theme
                                                                  .popUpIconColor)),
                                                  const Spacer(),
                                                  Text(
                                                      widget
                                                          .adFeedPop.marketType,
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: theme
                                                                  .popUpIconColor)),
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Divider(
                                                color: theme.popUpIconColor,
                                                thickness: 1,
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Text('Miejsce parkingowe'.tr,
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
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

                                    //Mapa
                                    const SizedBox(
                                      height: 70,
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
                                              latitude:
                                                  widget.adFeedPop.latitude,
                                              longitude:
                                                  widget.adFeedPop.longitude,
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
                                          flex: 4,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Informacje dodatkowe".tr,
                                                  style: AppTextStyles.interBold
                                                      .copyWith(
                                                          fontSize: 20,
                                                          color: theme
                                                              .popUpIconColor)),
                                              const SizedBox(height: 20),
                                              Row(
                                                children: [
                                                  Text('Powierzchnia'.tr,
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: theme
                                                                  .popUpIconColor)),
                                                  const Spacer(),
                                                  Text(
                                                      '${widget.adFeedPop.squareFootage} m²',
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: theme
                                                                  .popUpIconColor)),
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Divider(
                                                  color: theme.popUpIconColor,
                                                  thickness: 1),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Text('Liczba łazienek'.tr,
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: theme
                                                                  .popUpIconColor)),
                                                  const Spacer(),
                                                  Text(
                                                      '${widget.adFeedPop.bathrooms}',
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: theme
                                                                  .popUpIconColor)),
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Divider(
                                                  color: theme.popUpIconColor,
                                                  thickness: 1),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Text('Liczba pokoi'.tr,
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: theme
                                                                  .popUpIconColor)),
                                                  const Spacer(),
                                                  Text(
                                                      '${widget.adFeedPop.rooms}',
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: theme
                                                                  .popUpIconColor)),
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Divider(
                                                color: theme.popUpIconColor,
                                                thickness: 1,
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Text('Piętro'.tr,
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: theme
                                                                  .popUpIconColor)),
                                                  const Spacer(),
                                                  Text(
                                                      '${widget.adFeedPop.floor}/${widget.adFeedPop.totalFloors}',
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: theme
                                                                  .popUpIconColor)),
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Divider(
                                                  color: theme.popUpIconColor,
                                                  thickness: 1),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Text('Forma własności'.tr,
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: theme
                                                                  .popUpIconColor)),
                                                  const Spacer(),
                                                  Text(
                                                      widget
                                                          .adFeedPop.marketType,
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: theme
                                                                  .popUpIconColor)),
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Divider(
                                                color: theme.popUpIconColor,
                                                thickness: 1,
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Text('Miejsce parkingowe'.tr,
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: theme
                                                                  .popUpIconColor)),
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
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("",
                                                  style: AppTextStyles.interBold
                                                      .copyWith(fontSize: 24)),
                                              const SizedBox(height: 20),
                                              Row(
                                                children: [
                                                  Text('Powierzchnia'.tr,
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: theme
                                                                  .popUpIconColor)),
                                                  const Spacer(),
                                                  Text(
                                                      '${widget.adFeedPop.squareFootage} m²',
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: theme
                                                                  .popUpIconColor)),
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Divider(
                                                color: theme.popUpIconColor,
                                                thickness: 1,
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Text('Liczba łazienek'.tr,
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: theme
                                                                  .popUpIconColor)),
                                                  const Spacer(),
                                                  Text(
                                                      '${widget.adFeedPop.bathrooms}',
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: theme
                                                                  .popUpIconColor)),
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Divider(
                                                color: theme.popUpIconColor,
                                                thickness: 1,
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Text('Liczba pokoi'.tr,
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: theme
                                                                  .popUpIconColor)),
                                                  const Spacer(),
                                                  Text(
                                                      '${widget.adFeedPop.rooms}',
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: theme
                                                                  .popUpIconColor)),
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Divider(
                                                color: theme.popUpIconColor,
                                                thickness: 1,
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Text('Piętro'.tr,
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: theme
                                                                  .popUpIconColor)),
                                                  const Spacer(),
                                                  Text(
                                                      '${widget.adFeedPop.floor}/${widget.adFeedPop.totalFloors}',
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: theme
                                                                  .popUpIconColor)),
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Divider(
                                                color: theme.popUpIconColor,
                                                thickness: 1,
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Text('Forma własności'.tr,
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: theme
                                                                  .popUpIconColor)),
                                                  const Spacer(),
                                                  Text(
                                                      widget
                                                          .adFeedPop.marketType,
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
                                                              color: theme
                                                                  .popUpIconColor)),
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Divider(
                                                color: theme.popUpIconColor,
                                                thickness: 1,
                                              ),
                                              const SizedBox(height: 5),
                                              Row(
                                                children: [
                                                  Text('Miejsce parkingowe'.tr,
                                                      style: AppTextStyles
                                                          .interRegular
                                                          .copyWith(
                                                              fontSize: 14,
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
                                      height: 100,
                                    ),
                              
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: 20,
                      child: SizedBox(
                        width: 300,
                        height: screenHeight - 40,
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: TextButton(
                                    onPressed: () {
                                      BetterFeedback.of(context).show(
                                        (feedback) async {
                                          // upload to server, share whatever
                                          // for example purposes just show it to the user
                                          // alertFeedbackFunction(
                                          // context,
                                          // feedback,
                                          // );
                                        },
                                      );
                                    },
                                    child: Text(
                                      'HOUSLY.AI',
                                      style: AppTextStyles.houslyAiLogo
                                          .copyWith(
                                              fontSize: logoSize,
                                              color: theme.popUpIconColor),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 60,
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: SellerCard(
                                    sellerId: widget.adFeedPop.sellerId,
                                    onTap: () {},
                                  ),
                                ),
                              ],
                            ),
                           
                            const Column(
                              children: [
                                Spacer(),
                                SizedBox(height: 20),
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: IntrinsicWidth(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    const Spacer(),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                                  theme.textFieldColor)),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor:
                                                  theme.popUpIconColor,
                                              title: Text(
                                                'Numer telefonu'.tr,
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .iconTheme
                                                        .color),
                                              ),
                                              content: Text(
                                                widget.adFeedPop.phoneNumber
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .iconTheme
                                                        .color),
                                              ), // Wyświetlanie numeru telefonu
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () => ref
                                                      .read(navigationService)
                                                      .beamPop(),
                                                  child: Text('Zamknij'.tr,
                                                      style: TextStyle(
                                                          color:
                                                              Theme.of(context)
                                                                  .iconTheme
                                                                  .color)),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      child: Text('Zadzwoń'.tr,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color)), // Może wymagać zmiany na bardziej odpowiedni tekst
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                                  theme.textFieldColor)),
                                      onPressed: () {
                                        final userId =
                                            ref.read(userStateProvider)?.userId;
                                        if (userId != null) {
                                          final currentContext =
                                              context; // Capture context before async operation

                                          ref
                                              .read(fetchRoomsProvider.notifier)
                                              .createRoom(widget.adFeedPop.id)
                                              .whenComplete(() {
                                            if (currentContext.mounted) {
                                              Navigator.of(currentContext).push(
                                                PageRouteBuilder(
                                                  opaque: false,
                                                  pageBuilder: (_, __, ___) =>
                                                      const ChatPage(),
                                                  transitionsBuilder:
                                                      (_, anim, __, child) {
                                                    return FadeTransition(
                                                        opacity: anim,
                                                        child: child);
                                                  },
                                                ),
                                              );
                                            }
                                          });
                                        }
                                      },
                                      child: Text('Wyślij wiadomość'.tr,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color)),
                                    ),
                                  ],
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
            ));
      },
      loading: () => SizedBox(
          height: 30,
          width: 30,
          child: Center(child: CircularProgressIndicator())),
      error: (error, stack) => Text('Błąd: $error'.tr),
    );
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
