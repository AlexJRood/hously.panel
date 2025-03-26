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
import 'package:hously_flutter/widgets/appbar/hously/mobile/appbar_mobile.dart';
import 'package:hously_flutter/widgets/bottom_bar_mobile/bottom_bar.dart';
import 'package:hously_flutter/widgets/installpopup/install_popup.dart';
import 'package:hously_flutter/widgets/screens/user_card_mobile.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:intl/intl.dart';
import 'package:pie_menu/pie_menu.dart';

import '../../../widgets/side_menu/slide_rotate_menu.dart';

class ProfileAdsMobilePage extends ConsumerWidget {
  const ProfileAdsMobilePage({super.key});

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
      child: PopupListener(
        child: SafeArea(
          child: Scaffold(
            body: SideMenuManager.sideMenuSettings(
              menuKey: sideMenuKey,
              child: Stack(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          gradient:
                              CustomBackgroundGradients.getMainMenuBackground(
                                  context, ref)),
                      child: Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 0, right: 0),
                              child: GestureDetector(
                                onPanUpdate: (details) {
                                  scrollController.jumpTo(
                                    scrollController.offset - details.delta.dy,
                                  );
                                },
                                child: ref.watch(yourAdsFilterProvider).when(
                                      data: (yourAdvertisements) {
                                        if (yourAdvertisements.isEmpty) {
                                          return Column(
                                            children: [
                                              const Spacer(),
                                              Text(
                                                  'Nie posiadasz aktywnych ogłoszeń.'
                                                      .tr,
                                                  style:
                                                      AppTextStyles.interLight16),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    ref
                                                        .read(navigationService)
                                                        .pushNamedReplacementScreen(
                                                            Routes.add);
                                                  },
                                                  child: Text(
                                                      'Dodaj ogłoszenie'.tr,
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
                                          controller: scrollController,
                                          slivers: [

                                        const SliverToBoxAdapter(
                                          child: SizedBox(
                                            height: 60,
                                          ),
                                        ),
                                            SliverToBoxAdapter(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    userAsyncValue.when(
                                                      data: (userData) {
                                                        if (userData != null) {
                                                          try {
                                                            final int userId =
                                                                int.parse(userData
                                                                    .userId);
                                                            return UserCardMobile(
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
                                                          child:
                                                              CircularProgressIndicator(
                                                            color:
                                                                AppColors.light,
                                                            strokeWidth: 2,
                                                          ),
                                                        ),
                                                      ),
                                                      error: (error, stack) =>
                                                          Text('Error: $error'),
                                                    ),
                                                    const SizedBox(
                                                      height: 45,
                                                    ),
                                                    Text('Moje ogłoszenia'.tr,
                                                        style: AppTextStyles
                                                            .interMedium18),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SliverGrid(
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                childAspectRatio: 1.0,
                                                mainAxisSpacing: 0.0,
                                                crossAxisSpacing: 0.0,
                                              ),
                                              delegate:
                                                  SliverChildBuilderDelegate(
                                                (context, index) {
                                                  final yourAd =
                                                      yourAdvertisements[index];
                                                  final keyTag =
                                                      'yourAdKey${yourAd.id}-${UniqueKey().toString()}';

                                                  final mainImageUrl =
                                                      yourAd.images.isNotEmpty
                                                          ? yourAd.images[0]
                                                          : 'default_image_url';
                                                  String formattedPrice =
                                                      customFormat
                                                          .format(yourAd.price);

                                                  return PieMenu(
                                                    onPressedWithDevice: (kind) {
                                                      if (kind ==
                                                          PointerDeviceKind
                                                              .touch) {
                                                        ref
                                                            .read(
                                                                navigationService)
                                                            .pushNamedScreen(
                                                          '${Routes.profile}/${yourAd.id}',
                                                          data: {
                                                            'tag': keyTag,
                                                            'ad': yourAd
                                                          },
                                                        );
                                                      }
                                                    },
                                                    actions: buildPieMenuYourAds(
                                                        ref, yourAd, context),
                                                    child: Hero(
                                                      tag: keyTag,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                0),
                                                        child: Stack(
                                                          children: [
                                                            AspectRatio(
                                                              aspectRatio: 1,
                                                              child: FittedBox(
                                                                fit: BoxFit.cover,
                                                                child:
                                                                    Image.network(
                                                                  mainImageUrl,
                                                                  errorBuilder: (context,
                                                                          error,
                                                                          stackTrace) =>
                                                                      Container(
                                                                    color: Colors
                                                                        .grey,
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child: Text(
                                                                        'Brak obrazu'
                                                                            .tr,
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.white)),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Positioned(
                                                              left: 2,
                                                              bottom: 2,
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top: 5,
                                                                        bottom: 5,
                                                                        right: 8,
                                                                        left: 8),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.4),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                ),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      '${yourAd.city}, ${yourAd.street}',
                                                                      style: AppTextStyles
                                                                          .interRegular
                                                                          .copyWith(
                                                                        fontSize:
                                                                            10,
                                                                        shadows: [
                                                                          Shadow(
                                                                            offset: const Offset(
                                                                                5.0,
                                                                                5.0),
                                                                            blurRadius:
                                                                                10.0,
                                                                            color: Colors
                                                                                .black
                                                                                .withOpacity(1),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      '$formattedPrice ${yourAd.currency}',
                                                                      style: AppTextStyles
                                                                          .interBold
                                                                          .copyWith(
                                                                        fontSize:
                                                                            14,
                                                                        shadows: [
                                                                          Shadow(
                                                                            offset: const Offset(
                                                                                5.0,
                                                                                5.0),
                                                                            blurRadius:
                                                                                10.0,
                                                                            color: Colors
                                                                                .black
                                                                                .withOpacity(1),
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
                                                childCount: yourAdvertisements.length,
                                              ),
                                            ),
                                        const SliverToBoxAdapter(
                                          child: SizedBox(
                                            height: 55,
                                          ),
                                        ),
                                          ],
                                        );
                                      },
                                      loading: () => const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      error: (error, stack) => Center(
                                        child: Text('Wystąpił błąd: $error'.tr),
                                      ),
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Positioned(
                    bottom: 0,
                    right: 0,
                    child:
                  BottomBarMobile(),),

                  Positioned(
                    top: 0,
                    right: 0,
                    child: AppBarMobile(sideMenuKey: sideMenuKey,),),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
