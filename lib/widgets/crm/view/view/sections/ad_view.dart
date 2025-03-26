import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/error/custom_error_handler.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/secure_storage.dart';
import 'package:hously_flutter/widgets/screens/feed/map/map_ad.dart';
import 'package:intl/intl.dart';

void copyToClipboard(BuildContext context, String listingUrl) {
  Clipboard.setData(ClipboardData(text: listingUrl)).then((_) {
    final successSnackBar = Customsnackbar().showSnackBar(
      "success",
      'Link skopiowany do schowka!'.tr,
      "success",
      () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    );
    ScaffoldMessenger.of(context).showSnackBar(successSnackBar);
  });
}

class AdViewClient extends ConsumerStatefulWidget {
  final dynamic adFeedPop;

  const AdViewClient({super.key, required this.adFeedPop});

  @override
  AdViewClientState createState() => AdViewClientState();
}

class AdViewClientState extends ConsumerState<AdViewClient> {
  late String mainImageUrl;
  final secureStorage = SecureStorage();

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
    double screenWidth = MediaQuery.of(context).size.width;
    double mainImageWidth = screenWidth * 0.625;
    double mainImageHeight = mainImageWidth * (650 / 1200);
    double pricePerSquareMeter =
        widget.adFeedPop.price / widget.adFeedPop.squareFootage;
    const double maxWidth = 1920;
    const double minWidth = 480;
    const double maxLogoSize = 30;
    const double minLogoSize = 16;
    double logoSize = (screenWidth - minWidth) /
            (maxWidth - minWidth) *
            (maxLogoSize - minLogoSize) +
        minLogoSize;
    logoSize = logoSize.clamp(minLogoSize, maxLogoSize);

    NumberFormat customFormat = NumberFormat.decimalPattern('fr');
    String formattedPrice = customFormat.format(widget.adFeedPop.price);

    return Expanded(
      child: Center(
        child: Stack(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          ref.read(navigationService).pushNamedScreen(
                            Routes.fullImage,
                            data: {
                              'tag': widget.adFeedPop,
                              'images': widget.adFeedPop.images,
                              'initialPage': widget.adFeedPop.images.indexOf(
                                mainImageUrl,
                              ),
                            },
                          );
                        },
                        child: Image.network(
                          mainImageUrl,
                          width: mainImageWidth,
                          height: mainImageHeight,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: mainImageWidth,
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.adFeedPop.images.length,
                          itemBuilder: (context, index) {
                            String imageUrl = widget.adFeedPop.images[index];
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  mainImageUrl = imageUrl;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: index == 0 ? 0 : 10.0,
                                  right:
                                      index == imageUrl.length - 1 ? 0 : 10.0,
                                ),
                                child: Image.network(imageUrl,
                                    width: 120, height: 120, fit: BoxFit.cover),
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
                                      .copyWith(fontSize: 26),
                                ),
                                const Spacer(),
                                Text(
                                  '${NumberFormat.decimalPattern().format(pricePerSquareMeter)} ${widget.adFeedPop.currency}/m²',
                                  style: AppTextStyles.interRegular16,
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
                                        .copyWith(fontSize: 22)),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                  '${widget.adFeedPop.street}, ${widget.adFeedPop.city}, ${widget.adFeedPop.state}',
                                  style: AppTextStyles.interRegular16),
                            ),
                            // Opis, szczegóły
                            const SizedBox(height: 50),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                      Text(widget.adFeedPop.description,
                                          style: AppTextStyles.interRegular14),
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
                                              style:
                                                  AppTextStyles.interRegular14),
                                          const Spacer(),
                                          Text(
                                              '${widget.adFeedPop.squareFootage} m²',
                                              style:
                                                  AppTextStyles.interRegular14),
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
                                              style: AppTextStyles.interRegular
                                                  .copyWith(fontSize: 14)),
                                          const Spacer(),
                                          Text('${widget.adFeedPop.bathrooms}',
                                              style: AppTextStyles.interRegular
                                                  .copyWith(fontSize: 14)),
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
                                              style: AppTextStyles.interRegular
                                                  .copyWith(fontSize: 14)),
                                          const Spacer(),
                                          Text('${widget.adFeedPop.rooms}',
                                              style: AppTextStyles.interRegular
                                                  .copyWith(fontSize: 14)),
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
                                              style: AppTextStyles.interRegular
                                                  .copyWith(fontSize: 14)),
                                          const Spacer(),
                                          Text(
                                              '${widget.adFeedPop.floor}/${widget.adFeedPop.totalFloors}',
                                              style: AppTextStyles.interRegular
                                                  .copyWith(fontSize: 14)),
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
                                              style: AppTextStyles.interRegular
                                                  .copyWith(fontSize: 14)),
                                          const Spacer(),
                                          Text(widget.adFeedPop.marketType,
                                              style: AppTextStyles.interRegular
                                                  .copyWith(fontSize: 14)),
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
                                              style: AppTextStyles.interRegular
                                                  .copyWith(fontSize: 14)),
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
                                      latitude: widget.adFeedPop.latitude,
                                      longitude: widget.adFeedPop.longitude,
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
                            const SizedBox(height: 50),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                              style: AppTextStyles.interRegular
                                                  .copyWith(fontSize: 14)),
                                          const Spacer(),
                                          Text(
                                              '${widget.adFeedPop.squareFootage} m²',
                                              style: AppTextStyles.interRegular
                                                  .copyWith(fontSize: 14)),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      const Divider(
                                          color: AppColors.dark, thickness: 1),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Text('Liczba łazienek'.tr,
                                              style: AppTextStyles.interRegular
                                                  .copyWith(fontSize: 14)),
                                          const Spacer(),
                                          Text('${widget.adFeedPop.bathrooms}',
                                              style: AppTextStyles.interRegular
                                                  .copyWith(fontSize: 14)),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      const Divider(
                                          color: AppColors.dark, thickness: 1),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Text('Liczba pokoi'.tr,
                                              style: AppTextStyles.interRegular
                                                  .copyWith(fontSize: 14)),
                                          const Spacer(),
                                          Text('${widget.adFeedPop.rooms}',
                                              style: AppTextStyles.interRegular
                                                  .copyWith(fontSize: 14)),
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
                                              style: AppTextStyles.interRegular
                                                  .copyWith(fontSize: 14)),
                                          const Spacer(),
                                          Text(
                                              '${widget.adFeedPop.floor}/${widget.adFeedPop.totalFloors}',
                                              style: AppTextStyles.interRegular
                                                  .copyWith(fontSize: 14)),
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      const Divider(
                                          color: AppColors.dark, thickness: 1),
                                      const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          Text('Forma własności'.tr,
                                              style: AppTextStyles.interRegular
                                                  .copyWith(fontSize: 14)),
                                          const Spacer(),
                                          Text(widget.adFeedPop.marketType,
                                              style: AppTextStyles.interRegular
                                                  .copyWith(fontSize: 14)),
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
                                              style: AppTextStyles.interRegular
                                                  .copyWith(fontSize: 14)),
                                          const Spacer(),
                                          // Text(widget.adFeedPop., style: AppTextStyles.interRegular.copyWith(fontSize: 14)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const Expanded(flex: 1, child: SizedBox()),
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
                                              style: AppTextStyles.interRegular
                                                  .copyWith(fontSize: 14)),
                                          const Spacer(),
                                          Text(
                                              '${widget.adFeedPop.squareFootage} m²',
                                              style: AppTextStyles.interRegular
                                                  .copyWith(fontSize: 14)),
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
                                              style: AppTextStyles.interRegular
                                                  .copyWith(fontSize: 14)),
                                          const Spacer(),
                                          Text('${widget.adFeedPop.bathrooms}',
                                              style: AppTextStyles.interRegular
                                                  .copyWith(fontSize: 14)),
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
                                              style: AppTextStyles.interRegular
                                                  .copyWith(fontSize: 14)),
                                          const Spacer(),
                                          Text('${widget.adFeedPop.rooms}',
                                              style: AppTextStyles.interRegular
                                                  .copyWith(fontSize: 14)),
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
                                              style: AppTextStyles.interRegular
                                                  .copyWith(fontSize: 14)),
                                          const Spacer(),
                                          Text(
                                              '${widget.adFeedPop.floor}/${widget.adFeedPop.totalFloors}',
                                              style: AppTextStyles.interRegular
                                                  .copyWith(fontSize: 14)),
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
                                              style: AppTextStyles.interRegular
                                                  .copyWith(fontSize: 14)),
                                          const Spacer(),
                                          Text(widget.adFeedPop.marketType,
                                              style: AppTextStyles.interRegular
                                                  .copyWith(fontSize: 14)),
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
                                              style: AppTextStyles.interRegular
                                                  .copyWith(fontSize: 14)),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
              right: 10,
              child: ElevatedButton(
                onPressed: () => ref.read(navigationService).pushNamedScreen(
                  Routes.crmEditSell,
                  data: {'offerId': widget.adFeedPop.id},
                ),
                child: Text('edit', style: AppTextStyles.interMedium16dark),
              ),
            ),
          ],
        ),
      ),
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
