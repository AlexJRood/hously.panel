// ignore_for_file: use_build_context_synchronously

import 'dart:ui' as ui;

import 'package:feedback/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/data/profile/fav/fav_provider.dart';
import 'package:hously_flutter/state_managers/data/user_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/utils/secure_storage.dart';
import 'package:hously_flutter/widgets/card/seller_card.dart';
import 'package:hously_flutter/widgets/crm/view/view/clientview/pc/ad_view_client/like_section_mid.dart';

class ClientsViewMid extends ConsumerWidget {
  final dynamic clientViewPop;

  ClientsViewMid({super.key, required this.clientViewPop});

  late String mainImageUrl;
  final SecureStorage secureStorage = SecureStorage();

  // final _chatPageState = const ChatPc().createState();

  bool _isMapActivated = false; // Stan aktywacji mapy

  Future<void> handleFavoriteAction(
      WidgetRef ref, int adId, BuildContext context) async {
    final isUserLoggedIn = ApiServices.isUserLoggedIn();
    if (isUserLoggedIn) {
      final isFav = await ref.read(favAdsProvider.notifier).isFavorite(adId);
      if (isFav) {
        await ref.read(favAdsProvider.notifier).removeFromFavorites(adId);
        context.showSnackBar('Usunięto z ulubionych'.tr);
      } else {
        await ref.read(favAdsProvider.notifier).addToFavorites(adId);
        context.showSnackBar('Dodano do ulubionych'.tr);
      }
      // ignore: unused_result
      ref.refresh(favAdsProvider);
    } else {
      context.showSnackBar(
          'Musisz być zalogowany, aby dodać ogłoszenie do ulubionych'.tr);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(userProvider);

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // double mainImageWidth = screenWidth * 0.75;
    // double mainImageHeight = mainImageWidth * (650 / 1200);
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

    return userAsyncValue.when(
      data: (user) {
        // String userId = user?.userId ?? '';
        return Scaffold(
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
                          const SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: SellerCard(
                              sellerId: clientViewPop.id,
                              onTap: () {
                                // Navigacja do strony użytkownika
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) => UserProfilePage()),
                                // );
                              },
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
                                child: MidLikeSectionFeedPop(
                                    adFeedPop: clientViewPop,
                                    ref: ref,
                                    context: context),
                              ),
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
                      const Align(
                        alignment: Alignment.bottomRight,
                        child: IntrinsicWidth(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Spacer(),
                              SizedBox(
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
        );
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
