import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/state_managers/data/profile/fav/fav_provider.dart';
import 'package:hously_flutter/state_managers/data/profile/hide/hide_provider.dart';
import 'package:hously_flutter/utils/pie_menu/feed.dart';

class MidLikeSectionFeedPop extends ConsumerWidget {
  final dynamic adFeedPop;

  const MidLikeSectionFeedPop({
    super.key,
    required this.adFeedPop,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeColorsProvider);

    // **✅ Real-time state watch instead of FutureBuilder**
    final isFavorite = ref.watch(favAdsProvider).maybeWhen(
      data: (ads) => ads.any((ad) => ad.id == adFeedPop.id),
      orElse: () => false,
    );

    final isHidden = ref.watch(hideAdsProvider).maybeWhen(
      data: (ads) => ads.any((ad) => ad.id == adFeedPop.id),
      orElse: () => false,
    );

    return Column(
      children: [
        // **❤️ Favorite Button**
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            style: elevatedButtonStyleRounded10,
            onPressed: () {
              handleFavoriteAction(ref, adFeedPop, context);
            },
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FaIcon(
                isFavorite ? FontAwesomeIcons.heartCircleCheck : FontAwesomeIcons.heart,
                color: theme.popUpIconColor,
                size: 40,
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),

        // **👁️ Hide Button**
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            style: elevatedButtonStyleRounded10,
            onPressed: () {
              handleHideAction(ref, adFeedPop, context);
            },
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FaIcon(
                isHidden ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
                color: theme.popUpIconColor,
                size: 40,
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),

        // **🔗 Share Button**
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            style: elevatedButtonStyleRounded10,
            onPressed: () {
              handleShareAction(adFeedPop, context, ref);
            },
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FaIcon(
                FontAwesomeIcons.share,
                color: theme.popUpIconColor,
                size: 40,
              ),
            ),
          ),
        ),
      ],
    );
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
