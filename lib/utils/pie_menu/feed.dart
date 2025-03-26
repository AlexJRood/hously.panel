import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/state_managers/data/profile/displayed/displayed_provider.dart';
import 'package:hously_flutter/state_managers/data/profile/fav/fav_provider.dart';
import 'package:hously_flutter/state_managers/data/profile/hide/hide_provider.dart';
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

List<PieAction> buildPieMenuActions(
    WidgetRef ref, dynamic action, BuildContext context) {
  final isFavorite = ref.watch(favAdsProvider).maybeWhen(
        data: (ads) => ads.any((ad) => ad.id == action.id),
        orElse: () => false,
      );
  final isHidden = ref.watch(hideAdsProvider).maybeWhen(
        data: (ads) => ads.any((ad) => ad.id == action.id),
        orElse: () => false,
      );

  return [
    PieAction(
      tooltip: Text('Dodaj do ulubionych'.tr),
      onSelect: () {
        handleFavoriteAction(ref, action.id, context);
      },
      child: FaIcon(
        isFavorite ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
      ),
    ),
    PieAction(
      tooltip: Text('Ukryj ogłoszenie'.tr),
      onSelect: () {
        handleHideAction(ref, action.id, context);
      },
      child: FaIcon(
        isHidden ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
      ),
    ),
    PieAction(
      tooltip: const Text('Udostępnij ogłoszenie'),
      onSelect: () {
        handleShareAction(action.id, context);
      },
      child: const FaIcon(FontAwesomeIcons.shareAlt),
    ),
  ];
}

Future<void> handleFavoriteAction(
    WidgetRef ref, int adId, BuildContext context) async {
  final isUserLoggedIn = ApiServices.isUserLoggedIn();
  if (isUserLoggedIn) {
    final notifier = ref.read(favAdsProvider.notifier);
    final isFav = await notifier.isFavorite(adId);
    if (isFav) {
      await notifier.removeFromFavorites(adId);
      context.showSnackBarLikeSection('Usunięto z ulubionych'.tr);
    } else {
      await notifier.addToFavorites(adId);
      context.showSnackBarLikeSection('Dodano do ulubionych'.tr);
    }
    ref.invalidate(favAdsProvider);
  } else {
    context.showSnackBarLikeSection(
        'Musisz być zalogowany, aby dodać ogłoszenie do ulubionych'.tr);
  }
}

Future<void> handleHideAction(
    WidgetRef ref, int adId, BuildContext context) async {
  final isUserLoggedIn = ApiServices.isUserLoggedIn();
  if (isUserLoggedIn) {
    final notifier = ref.read(hideAdsProvider.notifier);
    final isHide = await notifier.isHide(adId);
    if (isHide) {
      await notifier.removeFromHide(adId);
      context.showSnackBarLikeSection('Usunięto z ukrytych');
    } else {
      await notifier.addToHide(adId);
      context.showSnackBarLikeSection('Dodano do ukrytych');
    }
    ref.invalidate(hideAdsProvider);
  } else {
    context
        .showSnackBarLikeSection('Musisz być zalogowany, aby ukryć ogłoszenie');
  }
}

Future<void> handleDisplayedAction(
    WidgetRef ref, int adId, BuildContext context) async {
  final isUserLoggedIn = ApiServices.isUserLoggedIn();
  if (isUserLoggedIn) {
    final isDisplayed =
        await ref.read(displayedAdsProvider.notifier).isDisplayed(adId);
    if (isDisplayed) {
      await ref.read(displayedAdsProvider.notifier).removeFromDisplayed(adId);
    } else {
      await ref.read(displayedAdsProvider.notifier).addToDisplayed(adId);
    }
  }
}

Future<void> handleShareAction(int adId, BuildContext context) async {
  final url = 'hously.ai/ad/$adId';

  try {
    if (kIsWeb) {
      // Sprawdź, czy to przeglądarka mobilna
      if (await isMobileBrowser()) {
        debugPrint(
            'Wywoływanie natywnego ekranu udostępniania w przeglądarce mobilnej');
        await invokeWebShareFeed(url);
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
