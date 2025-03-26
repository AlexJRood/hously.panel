import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/portal/browselist/utils/api.dart';
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
  final isOnBrowseList = ref.watch(browseListProvider).maybeWhen(
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
        handleFavoriteAction(ref, action, context);
      },
      child: FaIcon(
        isFavorite ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
      ),
    ),
    PieAction(
      tooltip: Text('Dodaj do listy przeglądania'.tr),
      onSelect: () {
        handleBrowseListAction(ref, action, context);
      },
      child: FaIcon(
        isOnBrowseList ? FontAwesomeIcons.list : FontAwesomeIcons.listCheck,
      ),
    ),
    PieAction(
      tooltip: Text('Ukryj ogłoszenie'.tr),
      onSelect: () {
        handleHideAction(ref, action, context);
      },
      child: FaIcon(
        isHidden ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
      ),
    ),
    PieAction(
      tooltip: const Text('Udostępnij ogłoszenie'),
      onSelect: () {
        handleShareAction(action, context, ref);
      },
      child: const FaIcon(FontAwesomeIcons.shareAlt),
    ),
  ];
}

Future<void> handleFavoriteAction(
    WidgetRef ref, dynamic ad, BuildContext context) async {
  final isUserLoggedIn = ApiServices.isUserLoggedIn();
  if (!isUserLoggedIn) {
    context.showSnackBarLikeSection(
        'Musisz być zalogowany, aby dodać ogłoszenie do ulubionych'.tr);
    return;
  }

  final notifier = ref.read(favAdsProvider.notifier);
  await notifier.toggleFavorite(ad, context);
}


Future<void> handleBrowseListAction(
    WidgetRef ref, dynamic ad, BuildContext context) async {
  final isUserLoggedIn = ApiServices.isUserLoggedIn();
  if (!isUserLoggedIn) {
    context.showSnackBarLikeSection(
        'Musisz być zalogowany, aby dodać ogłoszenie do listy przeglądania'.tr);
    return;
  }

  final notifier = ref.read(browseListProvider.notifier);
  await notifier.toggleBrowseList(ad,context);
}


Future<void> handleHideAction(
    WidgetRef ref, dynamic ad, BuildContext context) async {
  final isUserLoggedIn = ApiServices.isUserLoggedIn();
  if (!isUserLoggedIn) {
    context.showSnackBarLikeSection(
        'Musisz być zalogowany, aby ukryć ogłoszenie'.tr);
    return;
  }

  final notifier = ref.read(hideAdsProvider.notifier);
  await notifier.toggleHide(ad.id,context);
}


Future<void> handleDisplayedAction(
    WidgetRef ref, dynamic ad, BuildContext context) async {
  final isUserLoggedIn = ApiServices.isUserLoggedIn();
  if (isUserLoggedIn) {
    final isDisplayed =
        await ref.read(displayedAdsProvider.notifier).isDisplayed(ad.id);
    if (isDisplayed) {
      await ref.read(displayedAdsProvider.notifier).removeFromDisplayed(ad.id);
    } else {
      await ref.read(displayedAdsProvider.notifier).addToDisplayed(ad.id);
    }
  }
}

Future<void> handleShareAction(dynamic ad, BuildContext context, WidgetRef ref) async {
  final url = 'hously.pro/offer/${ad.id}';

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
