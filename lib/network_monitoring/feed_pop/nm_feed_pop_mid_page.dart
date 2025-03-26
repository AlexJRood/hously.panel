// ignore_for_file: use_build_context_synchronously

import 'dart:ui' as ui;

import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/state_managers/data/Keyboardshortcuts.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/const/values.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/network_monitoring/state_managers/fav/provider.dart';
import 'package:hously_flutter/state_managers/data/user_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/utils/secure_storage.dart';
import 'package:hously_flutter/widgets/network_monitoring/like/nm_like_section_mid.dart';
import 'package:hously_flutter/widgets/screens/feed/map/map_ad.dart';
import 'package:intl/intl.dart';

class NMFeedPopMidPage extends ConsumerStatefulWidget {
  final dynamic adNetworkPop;
  final String tagFeedPop;

  const NMFeedPopMidPage(
      {super.key, required this.adNetworkPop, required this.tagFeedPop});

  @override
  NMFeedPopMidState createState() => NMFeedPopMidState();
}

class NMFeedPopMidState extends ConsumerState<NMFeedPopMidPage> {
  late String mainImageUrl;
  final SecureStorage secureStorage = SecureStorage();

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
        widget.adNetworkPop.images.isNotEmpty ? widget.adNetworkPop.images[0] : '';
  }

  Future<void> handleFavoriteAction(
      WidgetRef ref, int adId, BuildContext context) async {
    final isUserLoggedIn = ApiServices.isUserLoggedIn();
    if (isUserLoggedIn) {
      final isFav =
          await ref.read(nMFavAdsProvider.notifier).isFavoriteNM(adId);
      if (isFav) {
        await ref.read(nMFavAdsProvider.notifier).removeFromFavoritesNM(adId);
        context.showSnackBar('Usunięto z ulubionych'.tr);
      } else {
        await ref.read(nMFavAdsProvider.notifier).addToFavoritesNM(adId);
        context.showSnackBar('Dodano do ulubionych'.tr);
      }
      // ignore: unused_result
      ref.refresh(nMFavAdsProvider);
    } else {
      context.showSnackBar(
          'Musisz być zalogowany, aby dodać ogłoszenie do ulubionych'.tr);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userAsyncValue = ref.watch(userProvider);

    NumberFormat customFormat = NumberFormat.decimalPattern('fr');

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double mainImageWidth = screenWidth * 0.75;
    double mainImageHeight = mainImageWidth * (650 / 1200);
    double pricePerSquareMeter =
        widget.adNetworkPop.price / widget.adNetworkPop.squareFootage;
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
    String formattedPrice = customFormat.format(widget.adNetworkPop.price);

    return userAsyncValue.when(
      data: (user) {
        // String userId = user?.userId ?? '';
        return KeyboardListener(
            focusNode: FocusNode()..requestFocus(),
            onKeyEvent: (KeyEvent event) {
              // Check if the pressed key matches the stored pop key
              if (event.logicalKey == ref.read(popKeyProvider) &&
                  event is KeyDownEvent) {
                ref.read(navigationService).pushNamedScreen(Routes.filters);
              }
            },
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                children: [
                  // Ta część odpowiada za efekt rozmycia tła
                  BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      color: Colors.black.withOpacity(0.85),
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  // Obsługa dotknięcia w dowolnym miejscu aby zamknąć modal
                  GestureDetector(
                    onTap: () => ref.read(navigationService).beamPop(),
                  ),
                  // Zawartość modalu

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 75),
                            Hero(
                              tag: widget.tagFeedPop,
                              child: GestureDetector(
                                onTap: () =>
                                    ref.read(navigationService).pushNamedScreen(
                                  Routes.imageView,
                                  data: {
                                    'tag': widget.tagFeedPop,
                                    'images': widget.adNetworkPop.images,
                                    'initialPage': widget.adNetworkPop.images.indexOf(
                                      mainImageUrl,
                                    ),
                                  },
                                ),
                                child: Image.network(
                                  mainImageUrl,
                                  width: mainImageWidth,
                                  height: mainImageHeight,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width:
                                  mainImageWidth, // Ograniczenie szerokości kontenera miniatur do szerokości głównego obrazu
                              height:
                                  120, // Ustaw wysokość kontenera dla miniatur
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.adNetworkPop.images.length,
                                itemBuilder: (context, index) {
                                  String imageUrl =
                                      widget.adNetworkPop.images[index];
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        mainImageUrl =
                                            imageUrl; // Aktualizacja głównego obrazu na kliknięty obraz
                                      });
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: index == 0
                                            ? 0
                                            : 10.0, // Nie dodawaj paddingu po lewej stronie pierwszego obrazu
                                        right: index == imageUrl.length - 1
                                            ? 0
                                            : 10.0, // Nie dodawaj paddingu po prawej stronie ostatniego obrazu
                                      ),
                                      child: Image.network(imageUrl,
                                          width: 120,
                                          height: 120,
                                          fit: BoxFit.cover),
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
                                        '$formattedPrice ${widget.adNetworkPop.currency}',
                                        style: AppTextStyles.interBold
                                            .copyWith(fontSize: 26),
                                      ),
                                      const Spacer(),
                                      Text(
                                        '${NumberFormat.decimalPattern().format(pricePerSquareMeter)} ${widget.adNetworkPop.currency}/m²',
                                        style: AppTextStyles.interRegular
                                            .copyWith(fontSize: 16),
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
                                      child: Text(widget.adNetworkPop.title,
                                          style: AppTextStyles.interBold
                                              .copyWith(fontSize: 22)),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        '${widget.adNetworkPop.address.street}, ${widget.adNetworkPop.address.city}, ${widget.adNetworkPop.address.state}',
                                        style: AppTextStyles.interRegular
                                            .copyWith(fontSize: 16)),
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
                                                    .copyWith(fontSize: 20)),
                                            const SizedBox(height: 10),
                                            Text(widget.adNetworkPop.description,
                                                style: AppTextStyles
                                                    .interRegular
                                                    .copyWith(fontSize: 14)),
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
                                                    .copyWith(fontSize: 20)),
                                            const SizedBox(height: 20),
                                            Row(
                                              children: [
                                                Text('Powierzchnia'.tr,
                                                    style: AppTextStyles.interRegular.copyWith(fontSize: 14)),
                                                const Spacer(),
                                                Text(
                                                    '${widget.adNetworkPop.squareFootage} m²',
                                                    style: AppTextStyles.interRegular.copyWith(fontSize: 14)),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            const Divider(
                                              color: AppColors.dark,
                                              thickness: 1,
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Text('Liczba łazienek'.tr,
                                                    style: AppTextStyles.interRegular.copyWith(fontSize: 14)),
                                                const Spacer(),
                                                Text(
                                                    '${widget.adNetworkPop.bathrooms}',
                                                    style: AppTextStyles.interRegular.copyWith(fontSize: 14)),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            const Divider(
                                              color: AppColors.dark,
                                              thickness: 1,
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Text('Liczba pokoi'.tr,
                                                    style: AppTextStyles.interRegular.copyWith(fontSize: 14)),
                                                const Spacer(),
                                                Text(
                                                    '${widget.adNetworkPop.rooms}',
                                                    style: AppTextStyles.interRegular.copyWith(fontSize: 14)),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            const Divider(
                                              color: AppColors.dark,
                                              thickness: 1,
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Text('Piętro'.tr,
                                                    style: AppTextStyles.interRegular.copyWith(fontSize: 14)),
                                                const Spacer(),
                                                Text(
                                                    '${widget.adNetworkPop.floor}/${widget.adNetworkPop.totalFloors}',
                                                    style: AppTextStyles.interRegular.copyWith(fontSize: 14)),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            const Divider(
                                              color: AppColors.dark,
                                              thickness: 1,
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Text('Forma własności'.tr,
                                                    style: AppTextStyles.interRegular.copyWith(fontSize: 14)),
                                                const Spacer(),
                                                Text(
                                                    widget.adNetworkPop.marketType,
                                                    style: AppTextStyles.interRegular.copyWith(fontSize: 14)),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            const Divider(
                                              color: AppColors.dark,
                                              thickness: 1,
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Text('Miejsce parkingowe'.tr,
                                                    style: AppTextStyles.interRegular.copyWith(fontSize: 14)),
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
                                            borderRadius: BorderRadius.circular(
                                                20.0), // Zaokrąglone rogi
                                            // Dodaj inne dekoracje, jak tło, jeśli potrzebujesz
                                          ),
                                          child: MapAd(
                                            latitude: widget.adNetworkPop.address.lat,
                                            longitude: widget.adNetworkPop.address.lon,
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
                                                    .copyWith(fontSize: 20)),
                                            const SizedBox(height: 20),
                                            Row(
                                              children: [
                                                Text('Powierzchnia'.tr,
                                                    style: AppTextStyles.interRegular.copyWith(fontSize: 14)),
                                                const Spacer(),
                                                Text(
                                                    '${widget.adNetworkPop.squareFootage} m²',
                                                    style: AppTextStyles.interRegular.copyWith(fontSize: 14)),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            const Divider(
                                                color: AppColors.dark,
                                                thickness: 1),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Text('Liczba łazienek'.tr,
                                                    style: AppTextStyles.interRegular.copyWith(fontSize: 14)),
                                                const Spacer(),
                                                Text(
                                                    '${widget.adNetworkPop.bathrooms}',
                                                    style: AppTextStyles.interRegular.copyWith(fontSize: 14)),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            const Divider(
                                                color: AppColors.dark,
                                                thickness: 1),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Text('Liczba pokoi'.tr,
                                                    style: AppTextStyles.interRegular.copyWith(fontSize: 14)),
                                                const Spacer(),
                                                Text(
                                                    '${widget.adNetworkPop.rooms}',
                                                    style: AppTextStyles.interRegular.copyWith(fontSize: 14)),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            const Divider(
                                              color: AppColors.dark,
                                              thickness: 1,
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Text('Piętro'.tr,
                                                    style: AppTextStyles.interRegular.copyWith(fontSize: 14)),
                                                const Spacer(),
                                                Text(
                                                    '${widget.adNetworkPop.floor}/${widget.adNetworkPop.totalFloors}',
                                                    style: AppTextStyles.interRegular.copyWith(fontSize: 14)),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            const Divider(
                                                color: AppColors.dark,
                                                thickness: 1),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Text('Forma własności'.tr,
                                                    style: AppTextStyles.interRegular.copyWith(fontSize: 14)),
                                                const Spacer(),
                                                Text(
                                                    widget.adNetworkPop.marketType,
                                                    style: AppTextStyles.interRegular.copyWith(fontSize: 14)),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            const Divider(
                                              color: AppColors.dark,
                                              thickness: 1,
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Text('Miejsce parkingowe'.tr,
                                                    style: AppTextStyles.interRegular.copyWith(fontSize: 14)),
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
                                                    style: AppTextStyles.interRegular.copyWith(fontSize: 14)),
                                                const Spacer(),
                                                Text(
                                                    '${widget.adNetworkPop.squareFootage} m²',
                                                    style: AppTextStyles.interRegular.copyWith(fontSize: 14)),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            const Divider(
                                              color: AppColors.dark,
                                              thickness: 1,
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Text('Liczba łazienek'.tr,
                                                    style: AppTextStyles.interRegular.copyWith(fontSize: 14)),
                                                const Spacer(),
                                                Text(
                                                    '${widget.adNetworkPop.bathrooms}',
                                                    style: AppTextStyles.interRegular.copyWith(fontSize: 14)),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            const Divider(
                                              color: AppColors.dark,
                                              thickness: 1,
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Text('Liczba pokoi'.tr,
                                                    style: AppTextStyles.interRegular.copyWith(fontSize: 14)),
                                                const Spacer(),
                                                Text(
                                                    '${widget.adNetworkPop.rooms}',
                                                    style: AppTextStyles.interRegular.copyWith(fontSize: 14)),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            const Divider(
                                              color: AppColors.dark,
                                              thickness: 1,
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Text('Piętro'.tr,
                                                    style: AppTextStyles.interRegular.copyWith(fontSize: 14)),
                                                const Spacer(),
                                                Text(
                                                    '${widget.adNetworkPop.floor}/${widget.adNetworkPop.totalFloors}',
                                                    style: AppTextStyles.interRegular.copyWith(fontSize: 14)),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            const Divider(
                                              color: AppColors.dark,
                                              thickness: 1,
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Text('Forma własności'.tr,
                                                    style: AppTextStyles.interRegular.copyWith(fontSize: 14)),
                                                const Spacer(),
                                                Text(
                                                    widget.adNetworkPop.marketType,
                                                    style: AppTextStyles.interRegular.copyWith(fontSize: 14)),
                                              ],
                                            ),
                                            const SizedBox(height: 5),
                                            const Divider(
                                              color: AppColors.dark,
                                              thickness: 1,
                                            ),
                                            const SizedBox(height: 5),
                                            Row(
                                              children: [
                                                Text('Miejsce parkingowe'.tr,
                                                    style: AppTextStyles.interRegular.copyWith(fontSize: 14)),
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

                                  const SizedBox(height: 75),
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
                                        .copyWith(fontSize: logoSize),
                                  ),
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                          Column(
                            children: [
                              const Spacer(),
                              Row(
                                children: [
                                  const Spacer(),
                                  IntrinsicWidth(
                                      child: MidLikeSectionFeedPopNM(
                                          adFeedPop: widget.adNetworkPop,
                                          ref: ref,
                                          context: context)),
                                ],
                              ),
                              const Spacer(),
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
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Spacer(),
                                  ElevatedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Numer telefonu'.tr),
                                            content: Text(widget
                                                .adNetworkPop.phoneNumber
                                                .toString()), // Wyświetlanie numeru telefonu
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () {
                                                  ref
                                                      .read(navigationService)
                                                      .beamPop(); // Zamknięcie okna dialogowego
                                                },
                                                child: Text('Zamknij'.tr),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Text('Zadzwoń'
                                        .tr), // Może wymagać zmiany na bardziej odpowiedni tekst
                                  ),
                                  const SizedBox(
                                    height: 15,
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
            ));
      },
      loading: () => const CircularProgressIndicator(),
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
