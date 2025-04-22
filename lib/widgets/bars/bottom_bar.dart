import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/routing/route_constant.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/theme/design/button_style.dart';
import 'package:hously_flutter/routing/navigation_history_provider.dart';
import 'package:hously_flutter/api_services/auth.dart';
import 'package:hously_flutter/routing/navigation_service.dart';
import 'package:hously_flutter/api_services/api_services.dart';
import 'package:hously_flutter/theme/icons2.dart';
import 'package:hously_flutter/utils/loading_widgets.dart';
import 'dart:ui' as ui;

class BottomBarMobile extends ConsumerWidget {
  const BottomBarMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(userProvider);
    final isUserLoggedIn = ApiServices.isUserLoggedIn();
    final navigationHistory = ref.watch(navigationHistoryProvider);
    final currentRoute =
        navigationHistory.isNotEmpty ? navigationHistory.last : '/homepage';
    final currentthememode = ref.watch(themeProvider);
    double screenWidth = MediaQuery.of(context).size.width;

    final double dynamicPadding = screenWidth / 9;

    return Container(
      height: 55.0,
      width: MediaQuery.of(context).size.width,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 50, sigmaY: 50),
          child: Container(
            decoration: BoxDecoration(
                color: currentthememode == ThemeMode.system ||
                        currentthememode == ThemeMode.light
                    ? Colors.black.withOpacity(0.1)
                    : Colors.white.withOpacity(0.1)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: dynamicPadding),
                Container(
                  width: 60,
                  height: 55,
                            child: BuildIconButton(
                              icon: AppIcons.home(),
                              onPressed: () {
                      ref
                          .read(navigationHistoryProvider.notifier)
                          .addPage(Routes.leadsPanel);
                      ref
                          .read(navigationService)
                          .pushNamedScreen(Routes.leadsPanel);
                    },
                    currentRoute: currentRoute,
                  ),
                ),
                Container(
                  width: 60,
                  height: 55,
                            child: BuildIconButton(
                              icon: AppIcons.arrowTrendUp(),
                              onPressed: () {
                   
                    },
                    currentRoute: currentRoute,
                  ),
                ),
                if (isUserLoggedIn) ...[
                  Container(
                    width: 60,
                    height: 55,
                            child: BuildIconButton(
                              icon: AppIcons.magic(),
                              onPressed: () {
                        // ref.read(navigationService).pushNamedScreen(Routes.fav);
                      },
                      currentRoute: currentRoute,
                    ),
                  ),
                ],
                Container(
                  width: 60,
                  height: 55,
                            child: BuildIconButton(
                              icon: AppIcons.message(),
                              onPressed: () {
                      ref.read(navigationService).pushNamedScreen(Routes.emailView);
                    },
                    currentRoute: currentRoute,
                  ),
                ),
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    if (isUserLoggedIn) {
                      return Row(
                        children: [
                          userAsyncValue.when(
                            data: (userData) => userData != null
                                ? Container(
                                    width: 60,
                                    height: 55,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        ref
                                            .read(navigationService)
                                            .pushNamedScreen(Routes.profile);
                                      },
                                      style: elevatedButtonStyleRounded10,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircleAvatar(
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                                .withOpacity(0.9),
                                            backgroundImage: NetworkImage(userData
                                                    .avatarUrl ??
                                                'assets/images/default_avatar.webp'),
                                            radius: 12.5,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(),
                            loading: () => const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ShimmerPlaceholdercircle(
                                  radius: 12.5,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                ShimmerPlaceholder(
                                  width: 30,
                                  height: 8,
                                  radius: 0,
                                )
                              ],
                            ),
                            error: (error, stack) => Text('Error: $error'),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 60,
                            height: 55,
                            child: BuildIconButton(
                              icon: AppIcons.person(),
                              onPressed: () {
                                ref
                                    .read(navigationService)
                                    .pushNamedScreen(Routes.login);
                              },
                              currentRoute: currentRoute,
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
                SizedBox(width: dynamicPadding),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BuildIconButton extends ConsumerWidget {
  const BuildIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.currentRoute,
  });

  final Widget icon;
  final VoidCallback onPressed;
  final String currentRoute;

  @override
  Widget build(BuildContext context, ref) {

    return ElevatedButton(
      style: elevatedButtonStyleRounded10,
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
        ],
      ),
    );
  }

}
