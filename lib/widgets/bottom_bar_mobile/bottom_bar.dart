import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/const/colors.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/platforms/html_utils_stub.dart'
 if (dart.library.html) 'package:hously_flutter/platforms/html_utils_web.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/routes/navigation_history_provider.dart';
import 'package:hously_flutter/screens/pop_pages/view_pop_changer_page.dart';
import 'package:hously_flutter/state_managers/data/user_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/widgets/loading/loading_widgets.dart';
import 'dart:ui' as ui;
import 'package:hously_flutter/theme/apptheme.dart';



class BottomBarMobile extends ConsumerWidget {
  const BottomBarMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(userProvider);
    final isUserLoggedIn = ApiServices.isUserLoggedIn();
    final navigationHistory = ref.watch(navigationHistoryProvider);
    final currentRoute = navigationHistory.isNotEmpty ? navigationHistory.last : '/homepage';
    final currentthememode = ref.watch(themeProvider);
    double screenWidth = MediaQuery.of(context).size.width;

    final double dynamicPadding = screenWidth/ 8;

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
                    width: 60,height: 55,
                          child: BuildIconButton(
                                        icon: Icons.home_outlined,
                                        label: 'Home',
                                        onPressed: () {
                                          ref.read(navigationHistoryProvider.notifier)
                                              .addPage(Routes.homepage);
                                          ref.read(navigationService).pushNamedScreen(Routes.homepage);
                                        },
                                        currentRoute: currentRoute,
                          ),
                        ),
                        Container(
                    width: 60,height: 55,
                          child: BuildIconButton(
                                        icon: Icons.add,
                                        label: 'Szukaj'.tr,
                                        onPressed: () {
                                          String selectedFeedView =
                                          ref.read(selectedFeedViewProvider); // Odczytaj wybrany widok
                                          ref.read(navigationHistoryProvider.notifier).addPage(selectedFeedView);
                                          ref.read(navigationService).pushNamedScreen(selectedFeedView);
                                        },
                                        currentRoute: currentRoute,
                          ),
                        ),
                        if (isUserLoggedIn) ...[
              Container(
                    width: 60,height: 55,
                child: BuildIconButton(
                  icon: Icons.favorite_border,
                  label: 'Ulubione'.tr,
                  onPressed: () {
                    ref.read(navigationService).pushNamedScreen(Routes.fav);
                  },
                  currentRoute: currentRoute,
                ),
              ),
                        ],
                        Container(
                    width: 60,height: 55,
                          child: BuildIconButton(
                                        icon: Icons.add_box_outlined,
                                        label: 'Dodaj'.tr,
                                        onPressed: () {
                                          ref.read(navigationService).pushNamedScreen(Routes.add);
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
                    width: 60,height: 55,
                              child: ElevatedButton(
                                  onPressed: () {
                                    ref.read(navigationService).pushNamedScreen(Routes.profile);
                                  },
                                  style: elevatedButtonStyleRounded10,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: shimmercolor,
                                        backgroundImage: NetworkImage(userData
                                                .avatarUrl ?? 'assets/images/default_avatar.webp'),
                                        radius: 12.5,
                                      ),
                                      const SizedBox(height: 3.0),
                                      Text('Profil'.tr,
                                          style: const TextStyle(
                                              fontSize: 10, color: Colors.white)),
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
                            SizedBox(height: 8,),
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
                    width: 60,height: 55,
                        child: BuildIconButton(
                          icon: Icons.person,
                          label: 'Login',
                          onPressed: () {
                            ref.read(navigationService).pushNamedScreen(Routes.login);
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
      case Icons.add:
        return '/feedview';
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
