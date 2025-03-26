import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/icons.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/routes/navigation_history_provider.dart';
import 'package:hously_flutter/screens/chat/new_chat/chat_page.dart';
import 'package:hously_flutter/screens/pop_pages/view_pop_changer_page.dart';
import 'package:hously_flutter/state_managers/data/user_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/widgets/screens/ai/ai_page.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';

import '../side_menu/slide_rotate_menu.dart';

class SidebarAgentCrm extends ConsumerWidget {
  final GlobalKey<SideMenuState> sideMenuKey;
  const SidebarAgentCrm({super.key,
  required this.sideMenuKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final userAsyncValue = ref.watch(userProvider);
    final isUserLoggedIn = ApiServices.isUserLoggedIn();
    final navigationHistory = ref.watch(navigationHistoryProvider);
    final currentRoute =
        navigationHistory.isNotEmpty ? navigationHistory.last : '/homepage';
    final isActive = currentRoute == '/ai';
    final color = isActive
        ? Theme.of(context).iconTheme.color
        : Theme.of(context).iconTheme.color!.withOpacity(0.5);

    return InkWell(
        onTap:(){  
        SideMenuManager.toggleMenu(
            ref: ref, menuKey: sideMenuKey);
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
              BuildIconButton(
                icon: Icons.more_horiz,
                label: '',
                onPressed: () {
                  SideMenuManager.toggleMenu(ref:ref,menuKey: sideMenuKey);
                },
                currentRoute: currentRoute,
              ),
              const SizedBox(height: 5.0),
              if(isUserLoggedIn)
              ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (_, __, ___) => const AiPage(),
                    transitionsBuilder: (_, anim, __, child) {
                      return FadeTransition(opacity: anim, child: child);
                    },
                  ),
                ),
                style: elevatedButtonStyleRounded10,
                child: Text(
                  'AI',
                  style: AppTextStyles.interLight
                      .copyWith(fontSize: 18, color: color),
                ),
              ),
              const SizedBox(height: 35),
            ],
          ),
          Column(
            children: [
              BuildIconButton(
                icon: Icons.home_outlined,
                label: 'Dashboard',
                onPressed: () {
                  ref
                      .read(navigationHistoryProvider.notifier)
                      .addPage(Routes.proDashboard);
                  ref
                    .read(navigationService)
                    .pushNamedReplacementScreen(Routes.proDashboard);},
                currentRoute: currentRoute,
              ),
              const SizedBox(height: 15.0),
              BuildIconButton(
                icon: Icons.pie_chart,
                label: 'Finanse',
                onPressed: (){
                  ref
                      .read(navigationHistoryProvider.notifier)
                      .addPage(Routes.proDraggable);
                  ref
                    .read(navigationService)
                    .pushNamedReplacementScreen(Routes.proDraggable);},
                currentRoute: currentRoute,
              ),
              const SizedBox(height: 15.0),
              BuildIconButton(
                icon: Icons.calendar_month,
                label: 'Kalendarz'.tr,
                onPressed: (){
                  ref
                      .read(navigationHistoryProvider.notifier)
                      .addPage(Routes.proCalendar);
                  ref
                    .read(navigationService)
                    .pushNamedReplacementScreen(Routes.proCalendar);},
                currentRoute: currentRoute,
              ),
              const SizedBox(height: 15.0),
              BuildIconButton(
                icon: Icons.task_alt_rounded,
                label: 'To do',
                onPressed: () {
                  ref
                      .read(navigationHistoryProvider.notifier)
                      .addPage(Routes.proTodo);
                  ref
                    .read(navigationService)
                    .pushNamedReplacementScreen(Routes.proTodo);},
                currentRoute: currentRoute,
              ),
              const SizedBox(height: 15.0),
              BuildIconButton(
                icon: Icons.book,
                label: 'Klienci'.tr,
                onPressed: () {
                  ref
                      .read(navigationHistoryProvider.notifier)
                      .addPage(Routes.proClients);
                  ref
                    .read(navigationService)
                    .pushNamedReplacementScreen(Routes.proClients);},
                currentRoute: currentRoute,
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
                            .read(navigationHistoryProvider.notifier)
                            .addPage(Routes.chatWrapper);
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
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    BuildIconButton(
                      icon: Icons.notifications_none_rounded,
                      label: '',
                      onPressed: (){
                        ref
                            .read(navigationHistoryProvider.notifier)
                            .addPage(Routes.entry);
                        ref
                          .read(navigationService)
                          .pushNamedReplacementScreen(Routes.entry);},
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
                      onPressed: (){
                        ref
                            .read(navigationHistoryProvider.notifier)
                            .addPage(Routes.login);
                        ref
                          .read(navigationService)
                          .pushNamedReplacementScreen(Routes.login);},
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
    final color = isActive
        ? Theme.of(context).iconTheme.color
        : Theme.of(context).iconTheme.color!.withOpacity(0.5);

    return ElevatedButton(
      onPressed: onPressed,
      style: elevatedButtonStyleRounded10,
      child: Column(
        children: [
          Icon(icon, color: color, size: 25.0),
          if (label.isNotEmpty) ...[
            const SizedBox(height: 5.0),
            Text(label,
                style: AppTextStyles.interRegular10.copyWith(color: color)),
          ],
        ],
      ),
    );
  }

  String _getPageRouteForIcon(IconData icon, WidgetRef ref) {
    String selectedFeedView = ref.read(selectedFeedViewProvider);
    switch (icon) {
      case Icons.home_outlined:
        return '/pro/dashboard';
      case Icons.pie_chart:
        return '/pro/finance/draggable';
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
}
