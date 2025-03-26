import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/models/ad/monitoring_ads_model.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/network_monitoring/browselist/utils/pie_menu.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:hously_flutter/utils/middle_mouse_gesture.dart';

class BrowseListCardWidget extends ConsumerWidget {
  final MonitoringAdsModel ad;   // Model oferty
  final String keyTag;             // Klucz/tag dla Hero
  final String mainImageUrl;       // URL głównego zdjęcia
  final String formattedPrice;     // Sformatowana cena (np. "12,00")
  final bool isHidden;

  const BrowseListCardWidget({
    Key? key,
    required this.isHidden,
    required this.ad,
    required this.keyTag,
    required this.mainImageUrl,
    required this.formattedPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPath = ref.read(navigationService).currentPath;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: AspectRatio(
        aspectRatio: 1,
        child: MiddleClickDetector(
          onMiddleClick: () {
            debugPrint('Middle click detected!');
            // Akcja usuwania z browselist przy środkowym kliknięciu.
            handleBrowseListRemoveActionNM(ref, ad, context);
          },
          child: Stack(
            children: [
              // Obszar interaktywny otwierający widok ogłoszenia
              PieMenu(
                onPressedWithDevice: (PointerDeviceKind kind) {
                  if (kind == PointerDeviceKind.mouse ||
                      kind == PointerDeviceKind.touch) {
                    handleDisplayedActionNM(ref, ad.id, context);
                    ref.read(navigationService).pushNamedScreen(
                      '${currentPath}/offer/${ad.id}',
                      data: {'tag': keyTag, 'ad': ad},
                    );
                  }
                },
                actions: browseListPieMenuActions(ref, ad, context),
                child: Hero(
                  tag: keyTag,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Stack(
                      children: [
                        // Zdjęcie ogłoszenia
                        AspectRatio(
                          aspectRatio: 2,
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Image.network(
                              mainImageUrl,
                              errorBuilder: (context, error, stackTrace) => Container(
                                color: Colors.grey,
                                alignment: Alignment.center,
                                child: const Text(
                                  'Brak obrazu',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Opis i cena (widoczne tylko gdy nie jest ukryte)
                        if (!isHidden)
                          Positioned(
                            left: 2,
                            bottom: 2,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Material(
                                    color: Colors.transparent,
                                    child: Text(
                                      '${ad.address!.city}, ${ad.address!.street}',
                                      style: AppTextStyles.interRegular.copyWith(fontSize: 12),
                                    ),
                                  ),
                                  Material(
                                    color: Colors.transparent,
                                    child: Text(
                                      '$formattedPrice ${ad.currency}',
                                      style: AppTextStyles.interBold.copyWith(fontSize: 16),
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
              // Przycisk "X" do usunięcia z browselist – umieszczony poza PieMenu
              if (!isHidden)
                Positioned(
                  right: 8,
                  top: 0,
                  child: Container(
                    height: 30,
                    width: 30,
                    child: ElevatedButton(
                      style: elevatedButtonStyleRounded5Transparent,
                      onPressed: () {
                        // Tylko usuń element, nie otwierając widoku ogłoszenia.
                        handleBrowseListRemoveActionNM(ref, ad, context);
                      },
                      child: const Icon(Icons.close, size: 20),
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
