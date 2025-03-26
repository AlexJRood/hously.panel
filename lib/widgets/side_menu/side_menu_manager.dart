import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/routes/navigation_history_provider.dart';

import 'package:hously_flutter/screens/settings/components/pc/components/settings_provider.dart';
import 'package:hously_flutter/screens/settings/provider/settings_mobile_provider.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/data/user_provider.dart'; // Upewnij się, że ścieżka do user_provider jest poprawna';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';

import '../../language/language_provider.dart';

class SideMenuManager {
  /// Toggles the side menu based on its current state
  static void toggleMenu({
    required GlobalKey<SideMenuState> menuKey,
    required WidgetRef ref,
  }) {
    final state = menuKey.currentState;
    if (state != null && state.isOpened) {
      _refreshMenuData(ref);
      state.openSideMenu();
      ref.read(visibilityProvider.notifier).toggleVisibility();
    } else {
      _refreshMenuData(ref);
      state?.openSideMenu();
      ref.read(visibilityProvider.notifier).toggleVisibility();
    }
  }

  /// Refresh menu data (e.g., invalidate provider)
  static void _refreshMenuData(WidgetRef ref) {
    ref.invalidate(isProProvider);
  }

  /// Wraps the child widget with the `SideMenu`
  static Widget sideMenuSettings({
    required Widget child,
    required GlobalKey<SideMenuState> menuKey,
  }) {
    return SideMenu(
      key: menuKey, // Unique key for this instance
      menu: SideMenuOpen(
        sideMenuKey: menuKey,
      ),
      child: child,
    );
  }
}

class SideMenuOpen extends ConsumerWidget {
  final GlobalKey<SideMenuState> sideMenuKey;
  const SideMenuOpen({super.key, required this.sideMenuKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(userProvider);
    final isUserLoggedIn = ref.watch(authStateProvider);
    final isProUser = ref.watch(isProProvider);
    double screenWidth = MediaQuery.of(context).size.width;
    double dynamicFontSize = screenWidth > 600 ? 11 : 9;
    double dynamicSizedBox = 5;
    final themecolors = ref.watch(themeColorsProvider);
    final textFieldColor = themecolors.textFieldColor;
    double radiusSize = 60;

    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          bottom: 0,
          child: SizedBox(
            width: screenWidth,
            child: Padding(
              padding: EdgeInsets.only(
                  left: dynamicSizedBox,
                  bottom: dynamicFontSize,
                  top: dynamicSizedBox),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Container(
                      width: 60,
                      height: 60,
                      child: IconButton(
                        style: elevatedButtonStyleRounded10,
                        icon: Icon(Icons.arrow_forward_ios_rounded,
                            size: 25, color: Theme.of(context).iconTheme.color),
                        onPressed: () {
                          sideMenuKey.currentState?.closeSideMenu();
                        },
                      ),
                    ),
                  ]),
                  const SizedBox(height: 60),
                  const Spacer(),
                  IntrinsicWidth(
                    child: Column(
                      children: [
                        ElevatedButton(
                          style: elevatedButtonStyleRounded10,
                          onPressed: () {
                            ref
                                .read(navigationHistoryProvider.notifier)
                                .addPage(Routes.homepage);
                            ref
                                .read(navigationService)
                                .pushNamedReplacementScreen(Routes.homepage);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.panorama_horizontal_rounded,
                                    size: 25,
                                    color: Theme.of(context).iconTheme.color),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text('Portal',
                                      style: AppTextStyles.interRegular
                                          .copyWith(
                                              fontSize: dynamicFontSize,
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: dynamicSizedBox),
                        ElevatedButton(
                          style: elevatedButtonStyleRounded10,
                          onPressed: () {
                            ref
                                .read(navigationService)
                                .pushNamedReplacementScreen(Routes.reports);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.bar_chart_rounded,
                                    size: 25,
                                    color: Theme.of(context).iconTheme.color),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    'Raporty'.tr,
                                    style: AppTextStyles.interRegular.copyWith(
                                        fontSize: dynamicFontSize,
                                        color:
                                            Theme.of(context).iconTheme.color),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (isUserLoggedIn && isProUser) ...[
                          SizedBox(height: dynamicSizedBox),
                          ElevatedButton(
                            style: elevatedButtonStyleRounded10,
                            onPressed: () {
                              ref
                                  .read(navigationHistoryProvider.notifier)
                                  .addPage(Routes.homeNetworkMonitoring);
                              ref
                                  .read(navigationService)
                                  .pushNamedReplacementScreen(Routes.homeNetworkMonitoring);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                spacing: 5,
                                children: [
                                  Icon(Icons.settings,
                                      size: 25,
                                      color: Theme.of(context).iconTheme.color),
                                  Expanded(
                                    child: Text(
                                      'Network monitoring',
                                      style: AppTextStyles.interRegular
                                          .copyWith(
                                              fontSize: dynamicFontSize,
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: dynamicSizedBox),
                          ElevatedButton(
                            style: elevatedButtonStyleRounded10,
                            onPressed: () {
                              ref
                                  .read(navigationHistoryProvider.notifier)
                                  .addPage(Routes.proDashboard);
                              ref
                                  .read(navigationService)
                                  .pushNamedReplacementScreen(
                                      Routes.proDashboard);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.chrome_reader_mode_outlined,
                                      size: 25,
                                      color: Theme.of(context).iconTheme.color),
                                  const SizedBox(width: 10),
                                  Text('Hously.pro'.tr,
                                      style: AppTextStyles.interRegular
                                          .copyWith(fontSize: dynamicFontSize)),
                                ],
                              ),
                            ),
                          ),
                        ] else ...[
                          SizedBox(height: dynamicSizedBox),
                          ElevatedButton(
                            style: elevatedButtonStyleRounded10,
                            onPressed: () {
                              ref
                                  .read(navigationService)
                                  .pushNamedReplacementScreen(Routes.goPro);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Icon(Icons.verified,
                                      size: 25, color: AppColors.superbee),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text('Przejdź na pro'.tr,
                                        style: AppTextStyles.interRegular
                                            .copyWith(
                                                fontSize: dynamicFontSize,
                                                color: AppColors.superbee)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const Spacer(),
                  IntrinsicWidth(
                    child: Column(
                      children: [
                        ElevatedButton(
                          style: elevatedButtonStyleRounded10,
                          onPressed: () {
                            ref
                                .read(navigationService)
                                .pushNamedReplacementScreen(Routes.learnCenter);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              spacing: 5,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.emoji_objects_outlined,
                                    size: 25,
                                    color: Theme.of(context).iconTheme.color),
                                Expanded(
                                  child: Text('Learn center'.tr,
                                      style: AppTextStyles.interRegular
                                          .copyWith(fontSize: dynamicFontSize)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: dynamicSizedBox),
                        ElevatedButton(
                          style: elevatedButtonStyleRounded10,
                          onPressed: () {
                            ref
                                .read(navigationService);
                            ref
                                .read(selectedIndexProvidermobile.notifier)
                                .setIndex(-1);
                            ref
                                .read(selectedIndexProviderPC.notifier)
                                .updateIndex(0);
                            ref
                                .read(navigationService)
                                .pushNamedReplacementScreen(Routes.settings);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(Icons.settings,
                                    size: 25,
                                    color: Theme.of(context).iconTheme.color),
                                const SizedBox(width: 10),
                                Text('Ustawienia'.tr,
                                    style: AppTextStyles.interRegular.copyWith(
                                        fontSize: dynamicFontSize,
                                        color:
                                            Theme.of(context).iconTheme.color)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: dynamicSizedBox),
                  SizedBox(
                    height: radiusSize,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        userAsyncValue.when(
                          data: (userData) => userData != null
                              ? Row(
                                  children: [
                                    SizedBox(
                                      height: radiusSize,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shadowColor: Colors.transparent,
                                          foregroundColor: Colors.transparent,
                                          backgroundColor: Colors.transparent,
                                          surfaceTintColor: AppColors.dark,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                              topLeft:
                                                  Radius.circular(radiusSize),
                                              bottomLeft:
                                                  Radius.circular(radiusSize),
                                              topRight:
                                                  const Radius.circular(10),
                                              bottomRight:
                                                  const Radius.circular(10),
                                            ),
                                          ),
                                          elevation: 0,
                                        ),
                                        onPressed: () {},
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                userData.avatarUrl ??
                                                    'assets/images/default_avatar.webp',
                                              ),
                                              radius: radiusSize / 2,
                                            ),
                                            const SizedBox(width: 20),
                                            Text(
                                              "${userData.firstName} ${userData.lastName}",
                                              style: AppTextStyles.interLight16
                                                  .copyWith(
                                                fontSize: dynamicFontSize + 4,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    SizedBox(
                                      height: radiusSize,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          ref
                                              .read(authStateProvider.notifier)
                                              .logOut(ref).whenComplete(
                                            () {
                                              ref.invalidate(userProvider);
                                              ref
                                                  .read(navigationService)
                                                  .pushNamedReplacementScreen(
                                                  Routes.login);
                                            },
                                          );
                                        },
                                        style: logoutButton,
                                        child: Text(
                                          'Wyloguj'.tr,
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    SizedBox(width: dynamicFontSize),
                                    ElevatedButton(
                                      style: loginButton,
                                      onPressed: () {
                                        ref
                                            .read(navigationService)
                                            .pushNamedReplacementScreen(
                                                Routes.login);
                                      },
                                      child: Text(
                                        'Zaloguj się'.tr,
                                        style: TextStyle(
                                            color: textFieldColor,
                                            fontSize: dynamicFontSize),
                                      ),
                                    ),
                                  ],
                                ),
                          loading: () => Center(
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColor,
                                strokeWidth: 2,
                              ),
                            ),
                          ),
                          error: (error, stack) => Text('Error: $error'),
                        ),
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
