import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/data/profile/fav/fav_provider.dart';
import 'package:hously_flutter/state_managers/data/profile/hide/hide_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/pie_menu/feed.dart';

class MobileLikeSectionFeedPop extends ConsumerWidget {
  final dynamic adFeedPop;

  const MobileLikeSectionFeedPop({
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

    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 5),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 20),

          // **📞 Call Button**
          ActionButton(
            icon: Icons.phone,
            label: 'Zadzoń'.tr,
            theme: theme,
            onPressed: () {
              ref.read(navigationService).beamPop();
            },
          ),

          // **💬 Message Button**
          ActionButton(
            icon: Icons.send,
            label: 'Wiadomość'.tr,
            theme: theme,
            onPressed: () {
              ref.read(navigationService).beamPop();
            },
          ),

          // **🔗 Share Button**
          ActionButton(
            icon: FontAwesomeIcons.share,
            label: 'Udostępnij'.tr,
            theme: theme,
            onPressed: () {
              handleShareAction(adFeedPop, context, ref);
            },
          ),

          // **👁️ Hide/Show Button**
          ActionButton(
            icon: isHidden ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
            label: 'Ukryj'.tr,
            theme: theme,
            onPressed: () {
              handleHideAction(ref, adFeedPop, context);
            },
          ),

          // **❤️ Favorite Button**
          ActionButton(
            icon: isFavorite ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
            label: 'Ulubione'.tr,
            theme: theme,
            onPressed: () {
              handleFavoriteAction(ref, adFeedPop, context);
            },
          ),

          const SizedBox(width: 20),
        ],
      ),
    );
  }
}

/// **✅ StatelessWidget for Action Buttons**
class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final dynamic theme;
  final VoidCallback onPressed;

  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.theme,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ElevatedButton(
        style: elevatedButtonStyleRounded10,
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              SizedBox(
                width: 40,
                child: Icon(icon, color: theme.popUpIconColor),
              ),
              const SizedBox(height: 5),
              Text(
                label,
                style: AppTextStyles.interMedium.copyWith(
                  fontSize: 8,
                  color: theme.popUpIconColor.withOpacity(0.35),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
