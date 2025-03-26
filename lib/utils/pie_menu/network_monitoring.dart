// lib/providers/ad_provider.dart
import 'package:flutter/foundation.dart'; // Importujemy dla kIsWeb
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Importujemy dla schowka
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/state_managers/data/network_monitoring/displayed/provider.dart';
import 'package:hously_flutter/state_managers/data/network_monitoring/fav/provider.dart';
import 'package:hously_flutter/state_managers/data/network_monitoring/hide/provider.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:pie_menu/pie_menu.dart';
import 'package:share_plus/share_plus.dart';
import 'package:universal_io/io.dart';
import 'package:hously_flutter/platforms/html_utils_stub.dart'
if (dart.library.html) 'package:hously_flutter/platforms/html_utils_web.dart';

class ActionModel {
  final int id;
  ActionModel({required this.id});
}

List<PieAction> buildPieMenuActionsNM(
    WidgetRef ref, dynamic action, BuildContext context) {
  final isFavorite = ref.watch(nMFavAdsProvider).maybeWhen(
        data: (ads) => ads.any((ad) => ad.id == action.id),
        orElse: () => false,
      );
  final isHidden = ref.watch(nMHideAdsProvider).maybeWhen(
        data: (ads) => ads.any((ad) => ad.id == action.id),
        orElse: () => false,
      );

  return [
    PieAction(
      tooltip:  Text('Dodaj do ulubionych'.tr),
      onSelect: () {
        handleFavoriteActionNM(ref, action.id, context);
      },
      child: FaIcon(
        isFavorite ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
      ),
    ),
    PieAction(
      tooltip:  Text('Ukryj ogłoszenie'.tr),
      onSelect: () {
        handleHideActionNM(ref, action.id, context);
      },
      child: FaIcon(
        isHidden ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
      ),
    ),
    PieAction(
      tooltip: const Text('Udostępnij ogłoszenie'),
      onSelect: () {
        handleShareActionNM(action.id, context);
      },
      child: const FaIcon(FontAwesomeIcons.shareAlt),
    ),
  ];
}

Future<void> handleFavoriteActionNM(
    WidgetRef ref, int adId, BuildContext context) async {
    final isUserLoggedIn = ApiServices.isUserLoggedIn();
  if (isUserLoggedIn) {
    final notifier = ref.read(nMFavAdsProvider.notifier);
    final isFav = await notifier.isFavoriteNM(adId);
    if (isFav) {
      await notifier.removeFromFavoritesNM(adId);
      context.showSnackBarLikeSection('Usunięto z ulubionych'.tr);
    } else {
      await notifier.addToFavoritesNM(adId);
      context.showSnackBarLikeSection('Dodano do ulubionych'.tr);
    }
    ref.invalidate(nMFavAdsProvider);
  } else {
    context.showSnackBarLikeSection(
        'Musisz być zalogowany, aby dodać ogłoszenie do ulubionych'.tr);
  }
}

Future<void> handleHideActionNM(
    WidgetRef ref, int adId, BuildContext context) async {
    final isUserLoggedIn = ApiServices.isUserLoggedIn();
  if (isUserLoggedIn) {
    final notifier = ref.read(nMHideAdsProvider.notifier);
    final isHide = await notifier.isHideNM(adId);
    if (isHide) {
      await notifier.removeFromHideNM(adId);
      context.showSnackBarLikeSection('Usunięto z ukrytych');
    } else {
      await notifier.addToHideNM(adId);
      context.showSnackBarLikeSection('Dodano do ukrytych');
    }
    ref.invalidate(nMHideAdsProvider);
  } else {
    context
        .showSnackBarLikeSection('Musisz być zalogowany, aby ukryć ogłoszenie');
  }
}

Future<void> handleDisplayedActionNM(
    WidgetRef ref, int adId, BuildContext context) async {
    final isUserLoggedIn = ApiServices.isUserLoggedIn();
  if (isUserLoggedIn) {
    final isDisplayed =
        await ref.read(nMDisplayedAdsProvider.notifier).isDisplayedNM(adId);
    if (isDisplayed) {
      await ref
          .read(nMDisplayedAdsProvider.notifier)
          .removeFromDisplayedNM(adId);
    } else {
      await ref.read(nMDisplayedAdsProvider.notifier).addToDisplayedNM(adId);
    }
    ref.refresh(nMDisplayedAdsProvider);
  }
}

Future<void> handleShareActionNM(int adId, BuildContext context) async {
  final url = 'hously.ai/network-monitoring/$adId';

  try {
    if (kIsWeb) {
      // Sprawdź, czy to przeglądarka mobilna
      if (await isMobileBrowser()) {
        debugPrint(
            'Wywoływanie natywnego ekranu udostępniania w przeglądarce mobilnej');
        await invokeWebShare(url);
      } else {
        debugPrint('Kopiowanie linku do schowka');
        await Clipboard.setData(ClipboardData(text: url));
        context.showSnackBarLikeSection('Link skopiowany do schowka');
      }
    } else if (Platform.isAndroid || Platform.isIOS) {
      debugPrint('Udostępnianie na Android/iOS');
      await Share.share('Sprawdź to ogłoszenie: $url');
    }
  } catch (e) {
    debugPrint('Błąd podczas udostępniania: $e');
    context.showSnackBarLikeSection('Błąd podczas udostępniania: $e');
  }
}



extension ContextExtension on BuildContext {
  void showSnackBarLikeSection(String message) {
    ScaffoldMessenger.of(this).removeCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
