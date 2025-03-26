import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/network_monitoring/browselist/utils/api.dart';
import 'package:hously_flutter/network_monitoring/state_managers/displayed/provider.dart';
import 'package:hously_flutter/network_monitoring/state_managers/fav/provider.dart';
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

List<PieAction> browseListPieMenuActions(WidgetRef ref, dynamic action, BuildContext context) {
  final isFavorite = ref.watch(nMFavAdsProvider).maybeWhen(
        data: (ads) => ads.any((ad) => ad.id == action.id),
        orElse: () => false,
      );

  return [
    PieAction(
      tooltip: Text('Dodaj do ulubionych'.tr),
      onSelect: () {
        handleFavoriteActionNM(ref, action, context);
      },
      child: FaIcon(
        isFavorite ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
      ),
    ),
    PieAction(
      tooltip: Text('Udostępnij ogłoszenie'.tr),
      onSelect: () {
        handleShareActionNM(action.id, context);
      },
      child: const FaIcon(FontAwesomeIcons.shareAlt),
    ),
    PieAction(
      tooltip: Text('Usuń z listy przeglądania'.tr),
      onSelect: () {
        handleBrowseListRemoveActionNM(ref, action, context);
      },
      child: const FaIcon(FontAwesomeIcons.xmark),
    ),
  ];
}

Future<void> handleFavoriteActionNM(
    WidgetRef ref, dynamic ad, BuildContext context) async {
  final isUserLoggedIn = ApiServices.isUserLoggedIn();
  if (!isUserLoggedIn) {
    context.showSnackBarLikeSection(
        'Musisz być zalogowany, aby dodać ogłoszenie do ulubionych'.tr);
    return;
  }

  final notifier = ref.read(nMFavAdsProvider.notifier);
  await notifier.toggleFavorite(ad,context);
}




Future<void> handleDisplayedActionNM(
    WidgetRef ref, int adId, BuildContext context) async {
  final isUserLoggedIn = ApiServices.isUserLoggedIn();
  if (isUserLoggedIn) {
    final isDisplayed =
        await ref.read(nMDisplayedAdsProvider.notifier).isDisplayedNM(adId);
    if (isDisplayed) {
      await ref.read(nMDisplayedAdsProvider.notifier).removeFromDisplayedNM(adId);
    } else {
      await ref.read(nMDisplayedAdsProvider.notifier).addToDisplayedNM(adId);
    }
  }
}


Future<void> handleBrowseListRemoveActionNM(
    WidgetRef ref, dynamic ad, BuildContext context) async {
  final isUserLoggedIn = ApiServices.isUserLoggedIn();
  if (!isUserLoggedIn) {
    context.showSnackBarLikeSection(
        'Musisz być zalogowany, aby dodać ogłoszenie do ulubionych'.tr);
    return;
  }

  final notifier = ref.read(networkMonitoringBrowseListProvider.notifier);
  await notifier.toggleBrowseListNM(ad, context);
}





Future<void> handleShareActionNM(int adId, BuildContext context) async {
  final url = 'hously.ai/network-monitoring/$adId';

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
