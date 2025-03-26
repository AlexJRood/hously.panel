import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/data/profile/fav/fav_provider.dart';
import 'package:hously_flutter/state_managers/data/profile/hide/hide_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/pie_menu/feed.dart';

class MobileLikeSectionFeedPop extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final adFeedPopId;
  final WidgetRef ref;
  final BuildContext context;

  const MobileLikeSectionFeedPop({
    super.key,
    required this.adFeedPopId,
    required this.ref,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 61.0,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            width: 20,
          ),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: elevatedButtonStyleRounded10,
              onPressed: () {
                ref.read(navigationService).beamPop();
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FutureBuilder<bool>(
                  future:
                      ref.read(favAdsProvider.notifier).isFavorite(adFeedPopId),
                  builder: (context, snapshot) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 40,
                          child: Icon(
                            Icons.phone,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text('Zadzoń'.tr,
                            style: AppTextStyles.interMedium.copyWith(
                                fontSize: 8,
                                color: AppColors.light.withOpacity(0.35)))
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: elevatedButtonStyleRounded10,
              onPressed: () {
                ref.read(navigationService).beamPop();
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FutureBuilder<bool>(
                  future:
                      ref.read(favAdsProvider.notifier).isFavorite(adFeedPopId),
                  builder: (context, snapshot) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 40,
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text('Wiadomość'.tr,
                            style: AppTextStyles.interMedium.copyWith(
                                fontSize: 8,
                                color: AppColors.light.withOpacity(0.35)))
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: elevatedButtonStyleRounded10,
              onPressed: () {
                handleShareAction(adFeedPopId, context);
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    const SizedBox(
                      width: 40,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.share,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text('Udostępnij'.tr,
                        style: AppTextStyles.interMedium.copyWith(
                            fontSize: 8,
                            color: AppColors.light.withOpacity(0.35)))
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: elevatedButtonStyleRounded10,
              onPressed: () {
                handleFavoriteAction(ref, adFeedPopId, context);
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FutureBuilder<bool>(
                  future:
                      ref.watch(hideAdsProvider.notifier).isHide(adFeedPopId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Column(
                        children: [
                          SizedBox(
                            width: 40,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  snapshot.data!
                                      ? FontAwesomeIcons.eye
                                      : FontAwesomeIcons.eyeSlash,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text('Ukryj'.tr,
                              style: AppTextStyles.interMedium.copyWith(
                                  fontSize: 8,
                                  color: AppColors.light.withOpacity(0.35)))
                        ],
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: elevatedButtonStyleRounded10,
              onPressed: () {
                handleFavoriteAction(ref, adFeedPopId, context);
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FutureBuilder<bool>(
                  future: ref
                      .watch(favAdsProvider.notifier)
                      .isFavorite(adFeedPopId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Column(
                        children: [
                          SizedBox(
                            width: 40,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FaIcon(
                                  snapshot.data!
                                      ? FontAwesomeIcons.solidHeart
                                      : FontAwesomeIcons.heart,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text('Ulubione'.tr,
                              style: AppTextStyles.interMedium.copyWith(
                                  fontSize: 8,
                                  color: AppColors.light.withOpacity(0.35)))
                        ],
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}
