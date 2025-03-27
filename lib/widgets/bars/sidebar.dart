import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/modules/leads/screens/lead_list.dart';
import 'package:hously_flutter/theme/icons.dart';
import 'package:hously_flutter/routing/route_constant.dart';
import 'package:hously_flutter/theme/design/button_style.dart';
import 'package:hously_flutter/theme/design/design.dart';
import 'package:hously_flutter/routing/navigation_history_provider.dart';
import 'package:hously_flutter/modules/chat/new_chat/chat_page.dart';
import 'package:hously_flutter/modules/notification/notification_screen.dart';
import 'package:hously_flutter/modules/ads_managment/pop_pages/view_pop_changer_page.dart';
import 'package:hously_flutter/utils/Keyboardshortcuts.dart';
import 'package:hously_flutter/api_services/auth.dart';
import 'package:hously_flutter/routing/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/utils/loading_widgets.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'dart:ui' as ui;
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';

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
                            icon: Transform.rotate(
                                          angle:
                                              -90 * 3.141592653589793238 / 180,
                              child: SvgPicture.asset(AppIcons.moreVertical,
                                              height: 25, width: 25, color: color),
                            ),
                            label: '',
                            onPressed: () {
                              SideMenuManager.toggleMenu(
                                  ref: ref, menuKey: widget.sideMenuKey);
                            },
                            currentRoute: currentRoute,
                          ),

                          if (isUserLoggedIn) 
                          const SizedBox(height: 105),
                          
                          if (!isUserLoggedIn)
                          const SizedBox(height: 15),
                        


                          // Dark mode button
                        ],
                      ),
                      Column(
                        children: [
                          BuildIconButton(
                            icon: SvgPicture.asset(AppIcons.home,
                                            height: 25, width: 25, color: color),
                            label: 'Dashboard',
                            onPressed: () {
                              ref
                                  .read(navigationService)
                                  .pushNamedReplacementScreen(Routes.leadsPanel);
                            },
                            currentRoute: currentRoute,
                          ),
                        
                          const SizedBox(height: 2.0),

                          BuildIconButton(
                            icon: SvgPicture.asset(AppIcons.arrowTrendUp,
                                            height: 25, width: 25, color: color),
                            label: 'Leads'.tr,
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
                          
                          const SizedBox(height: 2.0),

                          BuildIconButton(
                            icon: SvgPicture.asset(AppIcons.calendar,
                                            height: 25, width: 25, color: color),
                            label: 'calendar'.tr,
                            onPressed: () {
                              ref.read(navigationService)
                                  .pushNamedReplacementScreen(Routes.proCalendar);
                            },
                            currentRoute: currentRoute,
                          ),
                          
                          const SizedBox(height: 2.0),

                          BuildIconButton(
                            icon: SvgPicture.asset(AppIcons.task,
                                            height: 25, width: 25, color: color),
                            label: 'todo'.tr,
                            onPressed: () {
                              ref.read(navigationService)
                                  .pushNamedReplacementScreen(Routes.proTodo);
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
                                        IconButton(
                                            icon: SvgPicture.asset(
                                              AppIcons.sendAbove,
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

                                      ],
                                    ),
                                  ),
                                ),

                                          
                            BuildIconButton(
                            icon: SvgPicture.asset(AppIcons.notification,
                                            height: 25, width: 25, color: color),
                            label: '',
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
                                  ),);
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
                                                 Container(
                                                  width: 45, // ustaw szerokość
                                                  height: 45, // ustaw wysokość
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                                    image: DecorationImage(
                                                      image: userData.avatarUrl != null
                                                          ? CachedNetworkImageProvider(userData.avatarUrl!)
                                                          : AssetImage('assets/images/default_avatar.png') as ImageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                )

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
                                BuildIconButton(
                                  icon: SvgPicture.asset(AppIcons.person,
                                            height: 25, width: 25, color: color),
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

  final Widget icon; // <-- zmiana tutaj
  final String label;
  final VoidCallback onPressed;
  final String currentRoute;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isActive = false; // Jeśli chcesz mieć aktywność, musisz porównać route inaczej

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
              icon, // <-- teraz to widget
              if (label.isNotEmpty) ...[
                const SizedBox(height: 5.0),                
              ],
            ],
          ),
        ),
      ),
    );
  }
}
