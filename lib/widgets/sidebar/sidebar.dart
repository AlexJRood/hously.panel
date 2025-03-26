import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/colors.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/routes/navigation_history_provider.dart';
import 'package:hously_flutter/screens/chat/new_chat/chat_page.dart';
import 'package:hously_flutter/screens/notification/notification_screen.dart';
import 'package:hously_flutter/screens/pop_pages/view_pop_changer_page.dart';
import 'package:hously_flutter/state_managers/data/Keyboardshortcuts.dart';
import 'package:hously_flutter/state_managers/data/user_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/widgets/loading/loading_widgets.dart';
import 'package:hously_flutter/widgets/screens/ai/ai_page.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'dart:ui' as ui;
import 'package:hously_flutter/theme/apptheme.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../side_menu/slide_rotate_menu.dart';

class Sidebar extends ConsumerStatefulWidget {
  final GlobalKey<SideMenuState> sideMenuKey;

  const Sidebar({super.key, required this.sideMenuKey});

  @override
  ConsumerState<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends ConsumerState<Sidebar> {
  @override
  Widget build(BuildContext context) {
    final userAsyncValue = ref.watch(userProvider);
    final GlobalKey coToMaRobicTopAppBar = GlobalKey();
    final isUserLoggedIn = ref.watch(authStateProvider);
    final navigationHistory = ref.watch(navigationHistoryProvider);
    final iconcolor = Theme.of(context).iconTheme.color;
    final theme = ref.watch(themeColorsProvider);

    final currentRoute =
        navigationHistory.isNotEmpty ? navigationHistory.last : '/homepage';
    final currentThemeMode = ref.watch(themeProvider);

    // Determine the color based on theme and route
    final Color color = currentThemeMode == ThemeMode.system
        ? (currentRoute == '/ai' ? Colors.white : Colors.grey.shade100)
        : currentThemeMode == ThemeMode.light
            ? (currentRoute == '/ai'
                ? Colors.white
                : Colors.white.withOpacity(0.5)) // Light theme
            : (currentRoute == '/ai'
                ? Colors.black
                : Colors.black.withOpacity(0.5)); // Dark theme

    return KeyboardListener(
      focusNode: FocusNode()..requestFocus(),
      onKeyEvent: (KeyEvent event) {
        final LogicalKeyboardKey? shiftKey = ref.watch(togglesidemenu1);
        final LogicalKeyboardKey? altKey = ref.watch(togglesidemenu2);

        // Check if both keys (Shift + Alt) are pressed simultaneously
        if (event is KeyDownEvent) {
          final Set<LogicalKeyboardKey> pressedKeys =
              HardwareKeyboard.instance.logicalKeysPressed;

          if (pressedKeys.contains(shiftKey) && pressedKeys.contains(altKey)) {
            SideMenuManager.toggleMenu(ref: ref, menuKey: widget.sideMenuKey);
          }
        }
      },
      child: InkWell(
        onTap: () {
          SideMenuManager.toggleMenu(ref: ref, menuKey: widget.sideMenuKey);
        },
        child: SizedBox(
          width: 60,
          height: double.infinity,
          child: ClipRRect(
            child: Stack(
              children: [
                BackdropFilter(
                  filter: ui.ImageFilter.blur(
                      sigmaX: 50, sigmaY: 50, tileMode: TileMode.repeated),
                  child: Container(
                    color: theme.adPopBackground.withOpacity(0.15),
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                SizedBox(
                  width: 60.0,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          BuildIconButton(
                            icon: Icons.more_horiz,
                            label: '',
                            onPressed: () {
                              SideMenuManager.toggleMenu(
                                  ref: ref, menuKey: widget.sideMenuKey);
                            },
                            currentRoute: currentRoute,
                          ),

                          if (isUserLoggedIn) ...[
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    opaque: false,
                                    pageBuilder: (_, __, ___) => const AiPage(),
                                    transitionsBuilder: (_, anim, __, child) {
                                      return FadeTransition(
                                          opacity: anim, child: child);
                                    },
                                  ),
                                );
                              },
                              style: elevatedButtonStyleRounded10,
                              child: SizedBox(
                                width: 60,
                                height: 45,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'AI',
                                        style: AppTextStyles.interLight
                                            .copyWith(
                                                fontSize: 18, color: color),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    opaque: false,
                                    pageBuilder: (_, __, ___) =>
                                        const NotificationScreen(),
                                    transitionsBuilder: (_, anim, __, child) {
                                      return FadeTransition(
                                          opacity: anim, child: child);
                                    },
                                  ),
                                );
                              },
                              style: elevatedButtonStyleRounded10,
                              child: SvgPicture.asset(AppIcons.notification,
                                  height: 22, width: 22, color: color),
                            ),
                          ],

                          const SizedBox(height: 60),
                          // Dark mode button
                        ],
                      ),
                      Column(
                        children: [
                          BuildIconButton(
                            icon: Icons.home_outlined,
                            label: 'Home',
                            onPressed: () {
                              ref
                                  .read(navigationHistoryProvider.notifier)
                                  .addPage(Routes.homepage);
                              ref
                                  .read(navigationService)
                                  .pushNamedReplacementScreen(Routes.homepage);
                            },
                            currentRoute: currentRoute,
                          ),
                          const SizedBox(height: 2.0),
                          BuildIconButton(
                            icon: Icons.add_box_outlined,
                            label: 'Dodaj'.tr,
                            onPressed: () {
                              ref
                                  .read(navigationHistoryProvider.notifier)
                                  .addPage(Routes.add);
                              ref
                                  .read(navigationService)
                                  .pushNamedReplacementScreen(Routes.add);
                            },
                            currentRoute: currentRoute,
                          ),
                          const SizedBox(height: 2.0),
                          BuildIconButton(
                            icon: Icons.search,
                            label: 'Szukaj'.tr,
                            onPressed: () {
                              String selectedFeedView = ref.read(
                                  selectedFeedViewProvider); // Odczytaj wybrany widok
                              ref
                                  .read(navigationHistoryProvider.notifier)
                                  .addPage(selectedFeedView);
                              ref
                                  .read(navigationService)
                                  .pushNamedReplacementScreen(selectedFeedView);
                            },
                            currentRoute: currentRoute,
                          ),
                        ],
                      ),
                      LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          if (isUserLoggedIn) {
                            return Column(
                              children: [
                                ElevatedButton(
                                  style: elevatedButtonStyleRounded10,
                                  onPressed: () {
                                    ref
                                        .read(
                                            navigationHistoryProvider.notifier)
                                        .addPage(Routes.chatWrapper);
                                    ref
                                        .read(navigationService)
                                        .pushNamedScreen(Routes.chatWrapper);
                                  },
                                  child: SizedBox(
                                    width: 60,
                                    height: 45,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Transform.rotate(
                                          angle:
                                              -30 * 3.141592653589793238 / 180,
                                          child: IconButton(
                                            icon: SvgPicture.asset(
                                              AppIcons.send,
                                              color: Theme.of(context)
                                                  .iconTheme
                                                  .color,
                                              height: 25.0,
                                              width: 25.0,
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                PageRouteBuilder(
                                                  opaque: false,
                                                  pageBuilder: (_, __, ___) =>
                                                      const ChatPage(),
                                                  transitionsBuilder:
                                                      (_, anim, __, child) {
                                                    return FadeTransition(
                                                        opacity: anim,
                                                        child: child);
                                                  },
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                BuildIconButton(
                                  icon: Icons.favorite_border,
                                  label: '',
                                  onPressed: () {
                                    ref
                                        .read(
                                            navigationHistoryProvider.notifier)
                                        .addPage(Routes.fav);
                                    ref
                                        .read(navigationService)
                                        .pushNamedReplacementScreen(Routes.fav);
                                  },
                                  currentRoute: currentRoute,
                                ),
                                userAsyncValue.when(
                                  data: (userData) => userData != null
                                      ? ElevatedButton(
                                          onPressed: () => ref
                                              .read(navigationService)
                                              .pushNamedReplacementScreen(
                                                  Routes.profile),
                                          style: elevatedButtonStyleRounded10,
                                          child: SizedBox(
                                            width: 60,
                                            height: 60,
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor:
                                                        ShimmerColors
                                                            .background(
                                                                context),
                                                    backgroundImage:
                                                        CachedNetworkImageProvider(
                                                      userData.avatarUrl ??
                                                          'assets/images/default_avatar.png',
                                                    ),
                                                    radius: 15,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  loading: () => const Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(5),
                                        child: ShimmerPlaceholdercircle(
                                          radius: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  error: (error, stack) =>
                                      Text('Error: $error'),
                                ),
                              ],
                            );
                          } else {
                            return Column(
                              children: [
                                const SizedBox(height: 45),
                                const SizedBox(height: 60),
                                BuildIconButton(
                                  icon: Icons.person,
                                  label: '',
                                  onPressed: () {
                                    ref
                                        .read(
                                            navigationHistoryProvider.notifier)
                                        .addPage(Routes.login);
                                    ref
                                        .read(navigationService)
                                        .pushNamedReplacementScreen(
                                            Routes.login);
                                  },
                                  currentRoute: currentRoute,
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
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
  Widget build(BuildContext context, WidgetRef ref) {
    final isActive = currentRoute == _getPageRouteForIcon(icon, ref);

    return ElevatedButton(
      onPressed: onPressed,
      style: elevatedButtonStyleRounded10,
      child: SizedBox(
        width: 60,
        height: label.isNotEmpty ? 60 : 45,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  color: isActive
                      ? Theme.of(context).iconTheme.color
                      : Theme.of(context).iconTheme.color!.withOpacity(0.5),
                  size: 25.0),
              if (label.isNotEmpty) ...[
                const SizedBox(height: 5.0),
                Text(
                  label,
                  style: AppTextStyles.interRegular.copyWith(
                      color: isActive
                          ? Theme.of(context).iconTheme.color
                          : Theme.of(context)
                              .iconTheme
                              .color!
                              .withOpacity(0.5)),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// Method to get the route for the icon
String _getPageRouteForIcon(IconData icon, WidgetRef ref) {
  String selectedFeedView = ref.read(selectedFeedViewProvider);
  switch (icon) {
    case Icons.home_outlined:
      return '/homepage';
    case Icons.add_box_outlined:
      return '/add';
    case Icons.search:
      return selectedFeedView; // Adjust this to the correct route if needed
    case Icons.favorite_border:
      return '/fav';
    case Icons.person:
      return '/login';
    default:
      return '';
  }
}
