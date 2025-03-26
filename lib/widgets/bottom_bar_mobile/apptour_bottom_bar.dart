import 'package:hously_flutter/platforms/html_utils_stub.dart'
if (dart.library.html) 'package:hously_flutter/platforms/html_utils_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/values.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/routes/navigation_history_provider.dart';
import 'package:hously_flutter/screens/pop_pages/view_pop_changer_page.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/widgets/sidebar/apptour_sidebar_crm.dart';
import 'package:hously_flutter/state_managers/data/user_provider.dart';

import 'package:showcaseview/showcaseview.dart';




class NewBottomBar extends ConsumerWidget {
  const NewBottomBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isUserLoggedIn = ApiServices.isUserLoggedIn();
    final userAsyncValue = ref.watch(userProvider);
    final navigationHistory = ref.watch(navigationHistoryProvider);
    final currentRoute =
        navigationHistory.isNotEmpty ? navigationHistory.last : '/homepage';
    final one = ref.watch(home1);
    final two = ref.watch(home2);
    final three = ref.watch(home3);

    return Container(
      height: 55.0,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 8, bottom: 2.0),
      decoration: BoxDecoration(
          gradient: CustomBackgroundGradients.getSideMenuBackgroundmobile(
              context, ref)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 20),
          // Home Showcase
          CustomShowcaseWidgetmobile(
            cont: context,
            ref: ref,
            showkey: one,
            title: 'Home',
            description:
                "Discover key features and navigate effortlessly through the real estate portal, starting here on the homepage",
            isCrm: false,
            onSkip: () => ShowCaseWidget.of(context).next(),
            child: BuildIconButton(
              icon: Icons.home_outlined,
              label: 'Home',
              onPressed: () {
                ref
                    .read(navigationHistoryProvider.notifier)
                    .addPage(Routes.homepage);
                ref
                    .read(navigationService)
                    .pushNamedReplacementScreen(Routes.homepage);
               requestFullScreen();
              },
              currentRoute: currentRoute,
            ),
          ),
          // Search Showcase
          CustomShowcaseWidgetmobile(
            cont: context,
            ref: ref,
            showkey: two,
            title: 'Search',
            description:
                "Find your ideal property by exploring the feed tailored to your preferences.",
            isCrm: false,
            onSkip: () => ShowCaseWidget.of(context).next(),
            child: BuildIconButton(
              icon: Icons.search,
              label: 'Szukaj'.tr,
              onPressed: () {
                String selectedFeedView = ref.read(selectedFeedViewProvider);
                ref
                    .read(navigationHistoryProvider.notifier)
                    .addPage(selectedFeedView);
                ref
                    .read(navigationService)
                    .pushNamedReplacementScreen(selectedFeedView);
                requestFullScreen();
              },
              currentRoute: currentRoute,
            ),
          ),
          if (isUserLoggedIn) ...[
            // Favourites Showcase
            BuildIconButton(
              icon: Icons.favorite_border,
              label: 'Ulubione'.tr,
              onPressed: () {
                ref
                    .read(navigationHistoryProvider.notifier)
                    .addPage(Routes.fav);
                ref
                    .read(navigationService)
                    .pushNamedReplacementScreen(Routes.fav);
                requestFullScreen();
              },
              currentRoute: currentRoute,
            ),
          ],
          // Add Showcase
          CustomShowcaseWidgetmobile(
            cont: context,
            ref: ref,
            showkey: three,
            title: 'Add',
            description:
                "Easily add your property by tapping here and following a few simple steps.",
            isCrm: false,
            onSkip: () => ShowCaseWidget.of(context).next(),
            child: BuildIconButton(
              icon: Icons.add_box_outlined,
              label: 'Dodaj'.tr,
              onPressed: () {
                ref
                    .read(navigationHistoryProvider.notifier)
                    .addPage(Routes.add);
                ref
                    .read(navigationService)
                    .pushNamedReplacementScreen(Routes.add);
                requestFullScreen();
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
                          ? ElevatedButton(
                              onPressed: () {
                                ref
                                    .read(navigationHistoryProvider.notifier)
                                    .addPage(Routes.profile);
                                ref
                                    .read(navigationService)
                                    .pushNamedReplacementScreen(Routes.profile);
                                requestFullScreen();
                              },
                              style: elevatedButtonStyleRounded10,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(userData
                                            .avatarUrl ??
                                        'assets/images/default_avatar.webp'),
                                    radius: 12.5,
                                  ),
                                  const SizedBox(height: 3.0),
                                  Text('Profil'.tr,
                                      style: const TextStyle(
                                          fontSize: 10, color: Colors.white)),
                                ],
                              ),
                            )
                          : Container(),
                      loading: () => const CircularProgressIndicator(),
                      error: (error, stack) => Text('Error: $error'),
                    ),
                    const SizedBox(height: 10),
                  ],
                );
              } else {
                return Column(
                  children: [
                    BuildIconButton(
                      icon: Icons.person,
                      label: 'Login',
                      onPressed: () {
                        ref
                            .read(navigationHistoryProvider.notifier)
                            .addPage(Routes.login);
                        ref
                            .read(navigationService)
                            .pushNamedReplacementScreen(Routes.login);
                        requestFullScreen();
                      },
                      currentRoute: currentRoute,
                    ),
                  ],
                );
              }
            },
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}

class BuildIconButton extends ConsumerWidget {
  const BuildIconButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.currentRoute,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final String currentRoute;

  @override
  Widget build(BuildContext context, ref) {
    final isActive = currentRoute == _getPageRouteForIcon(icon);
    final currentthememode = ref.watch(themeProvider); // Current theme mode

    // Define color settings based on theme mode and selection state
    final Color color = currentthememode == ThemeMode.system
        ? (isActive ? Colors.white : Colors.grey.shade400)
        : currentthememode == ThemeMode.light
            ? (isActive
                ? Colors.white
                : Colors.white.withOpacity(0.5)) // Light theme
            : (isActive
                ? Colors.black
                : Colors.black.withOpacity(0.5)); // Dark theme

    return ElevatedButton(
      onPressed: onPressed,
      style: elevatedButtonStyleRounded10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 25.0),
          const SizedBox(height: 3.0),
          Text(label, style: TextStyle(fontSize: 10, color: color)),
        ],
      ),
    );
  }

  String _getPageRouteForIcon(IconData icon) {
    switch (icon) {
      case Icons.home_outlined:
        return '/homepage';
      case Icons.add_box_outlined:
        return '/add';
      case Icons.search:
        return '/search'; // Adjust this to the correct route
      case Icons.favorite_border:
        return '/fav';
      case Icons.person:
        return '/login';
      default:
        return '';
    }
  }
}
