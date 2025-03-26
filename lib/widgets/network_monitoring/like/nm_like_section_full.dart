import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/network_monitoring/state_managers/fav/provider.dart';
import 'package:hously_flutter/network_monitoring/state_managers/hide/provider.dart';
import 'package:hously_flutter/utils/pie_menu/network_monitoring.dart';

class FullLikeSectionFeedPopNM extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final dynamic adFeedPop;
  final WidgetRef ref;
  final BuildContext context;

  const FullLikeSectionFeedPopNM({
    super.key,
    required this.adFeedPop,
    required this.ref,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            style: elevatedButtonStyleRounded10,
            onPressed: () {
              handleFavoriteActionNM(ref, adFeedPop.id, context);
            },
            child: FutureBuilder<bool>(
              future: ref
                  .watch(nMFavAdsProvider.notifier)
                  .isFavoriteNM(adFeedPop.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Dodaj do ulubionych'.tr,
                          style: AppTextStyles.interMedium.copyWith(
                            fontSize: 12,
                            color: AppColors.light.withOpacity(0.35),
                          ),
                        ),
                        const SizedBox(width: 15),
                        SizedBox(
                          width: 40,
                          child: Column(
                            children: [
                              FaIcon(
                                  snapshot.data!
                                      ? FontAwesomeIcons.heartCircleCheck
                                      : FontAwesomeIcons.heart,
                                  color: AppColors.light),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ),
        const SizedBox(height: 15),
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            style: elevatedButtonStyleRounded10,
            onPressed: () {
              handleHideActionNM(ref, adFeedPop.id, context);
            },
            child: FutureBuilder<bool>(
              future:
                  ref.watch(nMHideAdsProvider.notifier).isHideNM(adFeedPop.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Ukryj'.tr,
                          style: AppTextStyles.interMedium.copyWith(
                            fontSize: 12,
                            color: AppColors.light.withOpacity(0.35),
                          ),
                        ),
                        const SizedBox(width: 15),
                        SizedBox(
                          width: 40,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                  snapshot.data!
                                      ? FontAwesomeIcons.eyeSlash
                                      : FontAwesomeIcons.eye,
                                  color: AppColors.light),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ),
        const SizedBox(height: 15),
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            style: elevatedButtonStyleRounded10,
            onPressed: () {
              handleShareActionNM(adFeedPop.id, context);
            },
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Udostępnij'.tr,
                    style: AppTextStyles.interMedium.copyWith(
                      fontSize: 12,
                      color: AppColors.light.withOpacity(0.35),
                    ),
                  ),
                  const SizedBox(width: 15),
                  const SizedBox(
                    width: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.share, color: AppColors.light),
                      ],
                    ),
                  ),
                ],
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
