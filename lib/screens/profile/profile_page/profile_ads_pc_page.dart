import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/data/profile/profile_page/profile_ad_provider.dart';
import 'package:hously_flutter/state_managers/data/user_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/pie_menu/feed_your_ads.dart';
import 'package:hously_flutter/widgets/appbar/hously/pc/appbar.dart';
import 'package:hously_flutter/widgets/screens/user_card_pc.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/sidebar/sidebar.dart';
import 'package:intl/intl.dart';
import 'package:pie_menu/pie_menu.dart';

import '../../../widgets/side_menu/slide_rotate_menu.dart';

class ProfileAdsPcPage extends ConsumerWidget {
  const ProfileAdsPcPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ScrollController scrollController = ScrollController();
    NumberFormat customFormat = NumberFormat.decimalPattern('fr');
    final userAsyncValue = ref.watch(userProvider);
    final sideMenuKey = GlobalKey<SideMenuState>();

    return PieCanvas(
      theme: const PieTheme(
        rightClickShowsMenu: true,
        leftClickShowsMenu: false,
        buttonTheme: PieButtonTheme(
          backgroundColor: CrmColors.buttonGradient1,
          iconColor: Colors.white,
        ),
        buttonThemeHovered: PieButtonTheme(
          backgroundColor: Color.fromARGB(96, 58, 58, 58),
          iconColor: Colors.white,
        ),
      ),
      child: Scaffold(
        body: SideMenuManager.sideMenuSettings(
          menuKey: sideMenuKey,
          child: Stack(
            children: [
              Row(
                children: [
                  Sidebar(
                    sideMenuKey: sideMenuKey,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          gradient:
                              CustomBackgroundGradients.getMainMenuBackground(
                                  context, ref)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 70,
                                    height: double.infinity,
                                  ),
                                  Expanded(
                                    flex: 5,
                                    child: GestureDetector(
                                      onPanUpdate: (details) {
                                        scrollController.jumpTo(
                                          scrollController.offset -
                                              details.delta.dy,
                                        );
                                      },
                                      child:
                                          ref.watch(yourAdsFilterProvider).when(
                                                data: (yourAdvertisements) {
                                                  if (yourAdvertisements
                                                      .isEmpty) {
                                                    return Column(
                                                      children: [
                                                        const SizedBox(
                                                            height: 60),
                                                        const Spacer(),
                                                        Text(
                                                            'Nie posiadasz aktywnych ogłoszeń.'
                                                                .tr,
                                                            style: AppTextStyles
                                                                .interLight16),
                                                        const SizedBox(
                                                          height: 15,
                                                        ),
                                                        ElevatedButton(
                                                            onPressed: () {
                                                              ref
                                                                  .read(
                                                                      navigationService)
                                                                  .pushNamedReplacementScreen(
                                                                      Routes
                                                                          .add);
                                                            },
                                                            child: Text(
                                                                'Dodaj ogłoszenie'
                                                                    .tr,
                                                                style: AppTextStyles
                                                                    .interLight
                                                                    .copyWith(
                                                                        color: AppColors
                                                                            .dark))),
                                                        const Spacer(),
                                                      ],
                                                    );
                                                  }
                                                  return CustomScrollView(
                                                    controller:
                                                        scrollController,
                                                    slivers: [
                                                      const SliverToBoxAdapter(
                                                        child: SizedBox(
                                                          height: 65,
                                                        ),
                                                      ),
                                                      SliverGrid(
                                                        gridDelegate:
                                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 3,
                                                          childAspectRatio: 1.0,
                                                          mainAxisSpacing: 5.0,
                                                          crossAxisSpacing: 5.0,
                                                        ),
                                                        delegate:
                                                            SliverChildBuilderDelegate(
                                                          (context, index) {
                                                            final yourAd =
                                                                yourAdvertisements[
                                                                    index];
                                                            final keyTag =
                                                                'yourAdKey${yourAd.id}-${UniqueKey().toString()}';

                                                            final mainImageUrl = yourAd
                                                                    .images
                                                                    .isNotEmpty
                                                                ? yourAd
                                                                    .images[0]
                                                                : 'default_image_url';
                                                            String
                                                                formattedPrice =
                                                                customFormat
                                                                    .format(yourAd
                                                                        .price);

                                                            return PieMenu(
                                                              onPressedWithDevice:
                                                                  (kind) {
                                                                if (kind ==
                                                                    PointerDeviceKind
                                                                        .mouse) {
                                                                  ref
                                                                      .read(
                                                                          navigationService)
                                                                      .pushNamedScreen(
                                                                    '${Routes.profile}/${yourAd.id}',
                                                                    data: {
                                                                      'tag':
                                                                          keyTag,
                                                                      'ad':
                                                                          yourAd
                                                                    },
                                                                  );
                                                                }
                                                              },
                                                              actions:
                                                                  buildPieMenuYourAds(
                                                                      ref,
                                                                      yourAd,
                                                                      context),
                                                              child: Hero(
                                                                tag: keyTag,
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  child: Stack(
                                                                    children: [
                                                                      AspectRatio(
                                                                        aspectRatio:
                                                                            1,
                                                                        child:
                                                                            FittedBox(
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          child:
                                                                              Image.network(
                                                                            mainImageUrl,
                                                                            errorBuilder: (context, error, stackTrace) =>
                                                                                Container(
                                                                              color: Colors.grey,
                                                                              alignment: Alignment.center,
                                                                              child: Text('Brak obrazu'.tr, style: const TextStyle(color: Colors.white)),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Positioned(
                                                                        left: 2,
                                                                        bottom:
                                                                            2,
                                                                        child:
                                                                            Container(
                                                                          padding: const EdgeInsets
                                                                              .only(
                                                                              top: 5,
                                                                              bottom: 5,
                                                                              right: 8,
                                                                              left: 8),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.black.withOpacity(0.4),
                                                                            borderRadius:
                                                                                BorderRadius.circular(8),
                                                                          ),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                '$formattedPrice ${yourAd.currency}',
                                                                                style: AppTextStyles.interBold.copyWith(
                                                                                  fontSize: 18,
                                                                                  shadows: [
                                                                                    Shadow(
                                                                                      offset: const Offset(5.0, 5.0),
                                                                                      blurRadius: 10.0,
                                                                                      color: Colors.black.withOpacity(1),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                yourAd.title,
                                                                                style: AppTextStyles.interSemiBold.copyWith(
                                                                                  fontSize: 14,
                                                                                  shadows: [
                                                                                    Shadow(
                                                                                      offset: const Offset(5.0, 5.0),
                                                                                      blurRadius: 10.0,
                                                                                      color: Colors.black.withOpacity(1),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                '${yourAd.city}, ${yourAd.street}',
                                                                                style: AppTextStyles.interRegular.copyWith(
                                                                                  fontSize: 12,
                                                                                  shadows: [
                                                                                    Shadow(
                                                                                      offset: const Offset(5.0, 5.0),
                                                                                      blurRadius: 10.0,
                                                                                      color: Colors.black.withOpacity(1),
                                                                                    ),
                                                                                  ],
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
                                                            );
                                                          },
                                                          childCount:
                                                              yourAdvertisements
                                                                  .length,
                                                        ),
                                                      ),
                                                      const SliverToBoxAdapter(
                                                        child: SizedBox(
                                                          height: 5,
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                                loading: () => const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                error: (error, stack) => Center(
                                                  child: Text(
                                                      'Wystąpił błąd: $error'
                                                          .tr),
                                                ),
                                              ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: userAsyncValue.when(
                                        data: (userData) {
                                          if (userData != null) {
                                            try {
                                              final int userId =
                                                  int.parse(userData.userId);
                                              return UserCard(
                                                userId: userId,
                                                onTap: () {
                                                  // Handle onTap
                                                },
                                              );
                                            } catch (e) {
                                              return const Text(
                                                  'Invalid userId format');
                                            }
                                          } else {
                                            return const SizedBox
                                                .shrink(); // Use SizedBox.shrink() when userData is null
                                          }
                                        },
                                        loading: () => const Center(
                                          child: SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: CircularProgressIndicator(
                                              color: AppColors.light,
                                              strokeWidth: 2,
                                            ),
                                          ),
                                        ),
                                        error: (error, stack) =>
                                            Text('Error: $error'),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Positioned(top: 0, right: 0, child: TopAppBar()),
            ],
          ),
        ),
      ),
    );
  }
}
