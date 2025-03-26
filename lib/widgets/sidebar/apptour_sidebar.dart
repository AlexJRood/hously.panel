import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/const/values.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/routes/navigation_history_provider.dart';
import 'package:hously_flutter/screens/chat/new_chat/chat_page.dart';
import 'package:hously_flutter/screens/pop_pages/view_pop_changer_page.dart';
import 'package:hously_flutter/state_managers/data/Keyboardshortcuts.dart';
import 'package:hously_flutter/state_managers/data/user_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/widgets/screens/ai/ai_page.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/sidebar/apptour_sidebar_crm.dart';
import 'package:showcaseview/showcaseview.dart';
import '../../screens/chat_ai/chat_ai_page.dart';
import '../side_menu/slide_rotate_menu.dart';

class Newsidebar extends ConsumerStatefulWidget {
  final GlobalKey<SideMenuState> sideMenuKey;
  const Newsidebar({super.key, required this.sideMenuKey});

  @override
  ConsumerState<Newsidebar> createState() => _NewsidebarState();
}

class _NewsidebarState extends ConsumerState<Newsidebar> {
  @override
  Widget build(BuildContext context) {
    final userAsyncValue = ref.watch(userProvider);
    final isUserLoggedIn = ApiServices.isUserLoggedIn();
    final navigationHistory = ref.watch(navigationHistoryProvider);
    final currentRoute =
        navigationHistory.isNotEmpty ? navigationHistory.last : '/homepage';

    final currentThemeMode = ref.watch(themeProvider);
    final one = ref.watch(home1);
    final two = ref.watch(home2);
    final three = ref.watch(home3);
    final four = ref.watch(home4);
    final five = ref.watch(home5);

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

            if (pressedKeys.contains(shiftKey) &&
                pressedKeys.contains(altKey)) {

              SideMenuManager.toggleMenu(ref: ref, menuKey: widget.sideMenuKey);
            }
          }
        },
        child: InkWell(
          onTap: () {
                  SideMenuManager.toggleMenu(
                      ref: ref, menuKey: widget.sideMenuKey);
          },
          child: Container(
          width: 60.0,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          decoration: BoxDecoration(
              gradient: CustomBackgroundGradients.getSideMenuBackgroundcustom(
                  context, ref)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CustomShowcaseWidget(
                    title: 'Sidebar',
                    description:
                        ' sidebar for quick access to login/logout, profile settings, streamlining navigation and account management',
                    showkey: five,
                    onSkip: () {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ShowCaseWidget.of(context).next();
                      });
                    },
                    ref: ref,
                    isCrm: false,
                    child: BuildIconButton(
                      icon: Icons.more_horiz,
                      label: '',
                      onPressed: () {
                        SideMenuManager.toggleMenu(
                            ref: ref, menuKey: widget.sideMenuKey);
                      },
                      currentRoute: currentRoute,
                    ),
                  ),
                 if(isUserLoggedIn)...[
                   const SizedBox(height: 5.0),
                   CustomShowcaseWidget(
                     title: 'Ai',
                     description:
                     'Explore advanced AI tools to simplify your property search. Get tailored insights and smart recommendations effortlessly.',
                     ref: ref,
                     onSkip: () {
                       WidgetsBinding.instance.addPostFrameCallback((_) {
                         ShowCaseWidget.of(context).next();
                       });
                     },
                     isCrm: false,
                     showkey: four,
                     child: ElevatedButton(
                       onPressed: () {
                         Navigator.of(context).push(
                           PageRouteBuilder(
                             opaque: false,
                             pageBuilder: (_, __, ___) => const ChatAiPage(),
                             transitionsBuilder: (_, anim, __, child) {
                               return FadeTransition(
                                   opacity: anim, child: child);
                             },
                           ),
                         );
                       },
                       style: elevatedButtonStyleRounded10,
                       child: Text(
                         'AI',
                         style: AppTextStyles.interLight
                             .copyWith(fontSize: 18, color: color),
                       ),
                     ),
                   ),
                   const SizedBox(height: 35),
                 ]
                  // Dark mode button
                ],
              ),
              Column(
                children: [
                  CustomShowcaseWidget(
                    isCrm: false,
                    ref: ref,
                    showkey: one,
                    title: 'Home',
                    description:
                        'Discover key features and navigate effortlessly through the real estate portal, starting here on the homepage',
                    onSkip: () {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ShowCaseWidget.of(context).next();
                      });
                    },
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
                      },
                      currentRoute: currentRoute,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  CustomShowcaseWidget(
                    ref: ref,
                    showkey: two,
                    title: 'Add',
                    description:
                        'Easily Add your property by tapping here and following a few simple steps.',
                    onSkip: () {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ShowCaseWidget.of(context).next();
                      });
                    },
                    isCrm: false,
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
                      },
                      currentRoute: currentRoute,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  CustomShowcaseWidget(
                    isCrm: false,
                    title: 'Search',
                    description:
                        'Find your ideal property by exploring the feed tailored to your preferences.',
                    onSkip: () {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ShowCaseWidget.of(context).next();
                      });
                    },
                    ref: ref,
                    showkey: three,
                    child: BuildIconButton(
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
                  ),
                ],
              ),
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  if (isUserLoggedIn) {
                    return Column(
                      children: [
                        ElevatedButton(
                          style: elevatedButtonStyleRounded10,
                          onPressed: () {
                            ref
                                .read(navigationService)
                                .pushNamedScreen(Routes.chatWrapper);
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Transform.rotate(
                                angle: -30 * 3.141592653589793238 / 180,
                                child: IconButton(icon:SvgPicture.asset(AppIcons.send,
                                    color: Theme.of(context).iconTheme.color,
                                    height: 25.0,
                                    width: 25.0,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    PageRouteBuilder(
                                      opaque: false,
                                      pageBuilder: (_, __, ___) => const ChatPage(),
                                      transitionsBuilder: (_, anim, __, child) {
                                        return FadeTransition(
                                            opacity: anim, child: child);
                                      },
                                    ),
                                  );
                                },
                                )
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        const SizedBox(height: 10),
                        BuildIconButton(
                          icon: Icons.favorite_border,
                          label: '',
                          onPressed: () {
                            ref
                                .read(navigationHistoryProvider.notifier)
                                .addPage(Routes.fav);
                            ref
                                .read(navigationService)
                                .pushNamedReplacementScreen(Routes.fav);
                          },
                          currentRoute: currentRoute,
                        ),
                        const SizedBox(height: 5),
                        userAsyncValue.when(
                          data: (userData) => userData != null
                              ? ElevatedButton(
                                  onPressed: () => ref
                                      .read(navigationService)
                                      .pushNamedReplacementScreen(
                                          Routes.profile),
                                  style: elevatedButtonStyleRounded10,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(userData
                                                  .avatarUrl ??
                                              'assets/images/default_avatar.png'),
                                          radius: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(),
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
                          error: (error, stack) => Text('Error: $error'),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        const SizedBox(height: 25),
                        const SizedBox(height: 25),
                        BuildIconButton(
                          icon: Icons.person,
                          label: '',
                          onPressed: () {
                            ref
                                .read(navigationHistoryProvider.notifier)
                                .addPage(Routes.login);
                            ref
                                .read(navigationService)
                                .pushNamedReplacementScreen(Routes.login);
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
        ));
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
      child: Column(
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
              style: AppTextStyles.interRegular.copyWith(fontSize: 11,
                  color: isActive
                      ? Theme.of(context).iconTheme.color
                      : Theme.of(context).iconTheme.color!.withOpacity(0.5)),
            ),
          ],
        ],
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
