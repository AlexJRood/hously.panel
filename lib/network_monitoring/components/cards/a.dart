import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/network_monitoring/browselist/utils/pie_menu.dart';
import 'package:hously_flutter/utils/middle_mouse_gesture.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/pie_menu/feed.dart';
import 'package:intl/intl.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:flutter/gestures.dart';

// Przykładowe importy (dopasuj do swojego projektu):
// import 'your_project/app_text_styles.dart';
// import 'your_project/colors/app_colors.dart';
// import 'your_project/navigation/navigation_service.dart';
// import 'your_project/navigation/routes.dart';
// import 'your_project/models/ad.dart';
// import 'your_project/widgets/pie_menu.dart';
// ... i inne, jeśli potrzebne.

class NetworkMonitoringAlexCardWidget extends ConsumerWidget {
  /// Model ogłoszenia – dostosuj do własnej klasy.
  final dynamic ad;

  /// Hero tag – unikatowe ID (np. 'ad-123').
  final String tag;

  /// Główny obrazek do wyświetlenia (URL).
  final String mainImageUrl;

  /// Czy ogłoszenie jest typu „Pro”.
  final bool isPro;

  /// Czy systemowe tło jest ciemne (np. theme brightness).
  final bool isDefaultDarkSystem;

  /// Kolor tła (np. jasne tło w trybie light).
  final Color color;

  /// Kolor tekstu w danym trybie (jasne/ciemne).
  final Color textColor;

  /// Kolor pola tekstowego (używany przy ciemnym motywie).
  final Color textFieldColor;

  /// Placeholder używany przez CachedNetworkImage w trakcie ładowania.
  /// Możesz tu przekazać np. dowolny widget shimmer.
  final Widget buildShimmerPlaceholder;

  /// Funkcja budująca listę akcji w PieMenu.
  /// Przykład: `buildPieMenuActions(ref, ad, context)`.
  final buildPieMenuActions;

  final double aspectRatio;
  final bool isMobile;

  const NetworkMonitoringAlexCardWidget({
    Key? key,
    required this.ad,
    required this.tag,
    required this.mainImageUrl,
    required this.isPro,
    required this.isDefaultDarkSystem,
    required this.color,
    required this.textColor,
    required this.textFieldColor,
    required this.buildShimmerPlaceholder,
    required this.buildPieMenuActions,
    required this.aspectRatio,
    required this.isMobile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPath = ref.read(navigationService).currentPath;
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: MiddleClickDetector(
        onMiddleClick: () {
          debugPrint('Middle click detected!');
          // Wywołaj akcję dodania do browse list, tylko przy prawdziwym middle-clicku.
          handleBrowseListRemoveActionNM(ref, ad, context);
        },
        child: PieMenu(
          onPressedWithDevice: (kind) {
            if (kind == PointerDeviceKind.mouse || kind == PointerDeviceKind.touch) {
            handleDisplayedActionNM(ref, ad.id, context);
            ref.read(navigationService).pushNamedScreen(
              '${currentPath}/offer/${ad.id}',
              data: {'tag': tag, 'ad': ad},
            );
            }
          },
          actions: buildPieMenuActions,
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
                    // Główne zdjęcie
                    AspectRatio(
                      aspectRatio: aspectRatio,
                      child: CachedNetworkImage(
                        imageUrl: mainImageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => buildShimmerPlaceholder,
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
                    // Napis "Sponsored" dla PRO
                    Positioned(
                      right: -2,
                      top: -2,
                      child: isPro
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 2,
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.light,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'Sponsored',
                                    style: AppTextStyles.interMedium12dark,
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                    // Cena i opis (lewy dolny róg)
                    Positioned(
                      left: 2,
                      bottom: 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 8,
                        ),
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
                                '${NumberFormat.decimalPattern('fr').format(ad.price)} ${ad.currency}',
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
                                    '${ad.address?.city != null ? 'city' : ad.address!.city}, ${ad.address?.street != null ? 'street' : ad.address!.street}',
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
      ),
    );
  }
}
