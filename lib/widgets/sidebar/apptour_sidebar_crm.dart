import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/screens/chat/new_chat/chat_page.dart';
import 'package:hously_flutter/state_managers/data/Keyboardshortcuts.dart';
import 'package:hously_flutter/const/route_constant.dart';

import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/values.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/routes/navigation_history_provider.dart';
import 'package:hously_flutter/screens/pop_pages/view_pop_changer_page.dart';
import 'package:hously_flutter/state_managers/data/user_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:showcaseview/showcaseview.dart';
import '../../language/language_provider.dart';
import '../side_menu/slide_rotate_menu.dart';
import 'sidebar_crm.dart';

class ApptourSidebarCrm extends ConsumerWidget {
  final GlobalKey<SideMenuState> sideMenuKey;
  const ApptourSidebarCrm({super.key, required this.sideMenuKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(userProvider);
    final isUserLoggedIn = ApiServices.isUserLoggedIn();
    final navigationHistory = ref.watch(navigationHistoryProvider);
    final currentRoute =
        navigationHistory.isNotEmpty ? navigationHistory.last : '/homepage';
    final isActive = currentRoute == '/ai';

    final one = ref.watch(crm1);
    final two = ref.watch(crm2);
    final three = ref.watch(crm3);
    final four = ref.watch(crm4);
    final five = ref.watch(crm5);
    final six = ref.watch(crm6);
    final seven = ref.watch(crm7);
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
            SideMenuManager.toggleMenu(ref: ref, menuKey: sideMenuKey);
          }
        }
      },
      child: Container(
        width: 60.0,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(top: 25, bottom: 10.0),
        decoration: BoxDecoration(
          gradient: CustomBackgroundGradients.customcrmSideMenu(context, ref),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                CustomShowcaseWidget(
                  ref: ref,
                  title: "PRO",
                  description:
                      "Unlock premium features and take your experience to the next level with the Pro version. Enjoy advanced tools and exclusive benefits.",
                  onSkip: () => ShowCaseWidget.of(context).next(),
                  showkey: seven,
                  child: BuildIconButton(
                    icon: Icons.more_horiz,
                    label: '',
                    onPressed: () {
                      SideMenuManager.toggleMenu(
                          ref: ref, menuKey: sideMenuKey);
                    },
                    currentRoute: currentRoute,
                  ),
                ),
                const SizedBox(height: 5.0),
                CustomShowcaseWidget(
                  ref: ref,
                  title: "AI",
                  description:
                      "Harness AI to automate tasks, gain insights, and make smarter decisions with ease.",
                  onSkip: () => ShowCaseWidget.of(context).next(),
                  showkey: six,
                  child: Text(
                    'AI',
                    style: AppTextStyles.interLight.copyWith(
                        fontSize: 18,
                        color: isActive
                            ? Theme.of(context).iconTheme.color
                            : Theme.of(context)
                                .iconTheme
                                .color!
                                .withOpacity(0.3)),
                  ),
                ),
                const SizedBox(height: 35),
              ],
            ),
            Column(
              children: [
                CustomShowcaseWidget(
                  ref: ref,
                  title: "Home",
                  description:
                      "Your central hub for managing customer relationships, tracking sales, and viewing key business metrics. Stay organized and make informed decisions with ease.",
                  onSkip: () => ShowCaseWidget.of(context).next(),
                  showkey: one,
                  child: BuildIconButton(
                    icon: Icons.home_outlined,
                    label: 'Dashboard',
                    onPressed: () => ref
                        .read(navigationService)
                        .pushNamedReplacementScreen(Routes.proDashboard),
                    currentRoute: currentRoute,
                  ),
                ),
                const SizedBox(height: 15.0),
                CustomShowcaseWidget(
                  ref: ref,
                  title: "Finance",
                  description:
                      "Quick access to your financial overview. Keep track of profits, losses, and other key financial metrics to make informed business decisions.",
                  onSkip: () => ShowCaseWidget.of(context).next(),
                  showkey: two,
                  child: BuildIconButton(
                    icon: Icons.pie_chart,
                    label: 'Finanse',
                    onPressed: () => ref
                        .read(navigationService)
                        .pushNamedReplacementScreen(Routes.proDraggable),
                    currentRoute: currentRoute,
                  ),
                ),
                const SizedBox(height: 15.0),
                CustomShowcaseWidget(
                  ref: ref,
                  title: "Calendar",
                  description:
                      "Stay on top of your schedule with an intuitive calendar. Easily manage meetings, deadlines, and tasks to boost your productivity.",
                  onSkip: () => ShowCaseWidget.of(context).next(),
                  showkey: three,
                  child: BuildIconButton(
                    icon: Icons.calendar_month,
                    label: 'Kalendarz'.tr,
                    onPressed: () => ref
                        .read(navigationService)
                        .pushNamedReplacementScreen(Routes.proCalendar),
                    currentRoute: currentRoute,
                  ),
                ),
                const SizedBox(height: 15.0),
                CustomShowcaseWidget(
                  ref: ref,
                  title: "Tasks",
                  description:
                      "Keep track of your to-do list and never miss a task. Prioritize your daily responsibilities and stay organized.",
                  onSkip: () => ShowCaseWidget.of(context).next(),
                  showkey: four,
                  child: BuildIconButton(
                    icon: Icons.task_alt_rounded,
                    label: 'To do',
                    onPressed: () => ref
                        .read(navigationService)
                        .pushNamedReplacementScreen(Routes.proTodo),
                    currentRoute: currentRoute,
                  ),
                ),
                const SizedBox(height: 15.0),
                CustomShowcaseWidget(
                  ref: ref,
                  title: "Clients",
                  description:
                      "Manage your customer relationships, keep track of client communications, and foster strong business relationships.",
                  onSkip: () => ShowCaseWidget.of(context).next(),
                  showkey: five,
                  child: BuildIconButton(
                    icon: Icons.book,
                    label: 'Klienci'.tr,
                    onPressed: () => ref
                        .read(navigationService)
                        .pushNamedReplacementScreen(Routes.proClients),
                    currentRoute: currentRoute,
                  ),
                ),
                // _buildIconButton(context, ref, Icons.task_alt_rounded, 'to do', () {
                //   String selectedFeedView = ref.read(selectedFeedViewProvider); // Odczytaj wybrany widok
                //   navigateToPage(context, ref, selectedFeedView); // Użyj wybranego widoku do nawigacji
                // }),
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
                                      pageBuilder: (_, __, ___) =>
                                          const ChatPage(),
                                      transitionsBuilder: (_, anim, __, child) {
                                        return FadeTransition(
                                            opacity: anim, child: child);
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      BuildIconButton(
                        icon: Icons.notifications_none_rounded,
                        label: '',
                        onPressed: () => ref
                            .read(navigationService)
                            .pushNamedReplacementScreen(Routes.entry),
                        currentRoute: currentRoute,
                      ),
                      const SizedBox(height: 5),
                      userAsyncValue.when(
                        data: (userData) => userData != null
                            ? ElevatedButton(
                                onPressed: () => ref
                                    .read(navigationService)
                                    .pushNamedReplacementScreen(Routes.profile),
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
                        loading: () => const CircularProgressIndicator(),
                        error: (error, stack) => Text('Error: $error'),
                      ),
                      const SizedBox(height: 10),
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
                        onPressed: () => ref
                            .read(navigationService)
                            .pushNamedReplacementScreen(Routes.login),
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
    );
  }
}

String _getPageRouteForIcon(IconData icon, WidgetRef ref) {
  String selectedFeedView = ref.read(selectedFeedViewProvider);
  switch (icon) {
    case Icons.home_outlined:
      return '/pro/dashboard';
    case Icons.pie_chart:
      return '/pro/finance-draggable';
    case Icons.search:
      return selectedFeedView; // Adjust this to the correct route
    case Icons.calendar_month:
      return '/pro/calendar';
    case Icons.task_alt_rounded:
      return '/pro/todo';
    case Icons.book:
      return '/pro/clients';
    case Icons.person:
      return '/profile';
    default:
      return '';
  }
}

class CustomShowcaseWidget extends StatelessWidget {
  final String title;
  final String description;
  final bool isCrm;
  final VoidCallback onSkip;
  final GlobalKey showkey;
  final Widget child;
  final WidgetRef ref;

  const CustomShowcaseWidget({
    Key? key,
    required this.title,
    this.isCrm = true,
    required this.description,
    required this.onSkip,
    required this.showkey,
    required this.child,
    required this.ref,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeColorsProvider);
    return Showcase.withWidget(
      targetPadding: const EdgeInsets.all(5),
      targetBorderRadius: BorderRadius.circular(5),

      key: showkey,
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 2,
      container: Container(
        width: 250,
        height: 250,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: isCrm
              ? CustomBackgroundGradients.customcrmright(context, ref)
              : CustomBackgroundGradients.getMainMenuBackground(context, ref),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Theme.of(context).iconTheme.color,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12), // Space between title and description
            // Description text
            Text(
              description,
              style: TextStyle(
                color: Theme.of(context).iconTheme.color,
              ),
            ),
            const Spacer(), // Push the button to the bottom
            // Skip Button
            Row(
              children: [
                Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: theme.fillColor,
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () => ShowCaseWidget.of(context).dismiss(),
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        color: theme.textFieldColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor:theme.fillColor,
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: onSkip, // Function passed to skip button
                    child:  Text(
                      "next",
                      style: TextStyle(
                        color:theme.textFieldColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      child: child, // Passing the child widget
    );
  }
}

class CustomShowcaseWidgetmobile extends StatelessWidget {
  final String title;
  final String description;
  final bool isCrm;
  final VoidCallback onSkip;
  final GlobalKey showkey;
  final Widget child;
  final WidgetRef ref;
  final BuildContext cont;
  const CustomShowcaseWidgetmobile({
    Key? key,
    required this.title,
    required this.cont,
    this.isCrm = true,
    required this.description,
    required this.onSkip,
    required this.showkey,
    required this.child,
    required this.ref,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double vw = MediaQuery.of(context).size.width / 100;
    double desiredFontSize = 20 * vw;

    // Get the current width of the screen
    double currentWidth = MediaQuery.of(context).size.width;

    // Default container size
    double containerWidth = 250;
    double containerHeight = 250;

    if (currentWidth < 500) {
      containerWidth = containerWidth * 0.75;
      containerHeight = containerHeight * 0.75;
    }

    double buttonFontSize = containerWidth * 0.06;
    double buttonPaddingVertical = containerWidth * 0.05;
    double buttonPaddingHorizontal = containerWidth * 0.09;

    return Showcase.withWidget(
      targetPadding: const EdgeInsets.all(6),
      targetBorderRadius: BorderRadius.circular(5),
      key: showkey,
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 2,
      container: Container(
        width: containerWidth,
        height: containerHeight,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: isCrm
              ? CustomBackgroundGradients.customcrmright(context, ref)
              : CustomBackgroundGradients.getMainMenuBackground(context, ref),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double maxWidth = constraints.maxWidth;

            double titleFontSize = maxWidth * 0.1;
            double descriptionFontSize = maxWidth * 0.07;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: titleFontSize,
                      ),
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: descriptionFontSize,
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            vertical: buttonPaddingVertical,
                            horizontal: buttonPaddingHorizontal,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(desiredFontSize),
                          ),
                        ),
                        onPressed: () {
                          ShowCaseWidget.of(cont).dismiss();
                        },
                        child: Text(
                          "skip",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: buttonFontSize,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Center(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            vertical: buttonPaddingVertical,
                            horizontal: buttonPaddingHorizontal,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(desiredFontSize),
                          ),
                        ),
                        onPressed: () {
                          ShowCaseWidget.of(cont).next();
                        },
                        child: Text(
                          "next",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: buttonFontSize,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
      child: child,
    );
  }
}
