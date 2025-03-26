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
import 'package:hously_flutter/state_managers/data/user_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/utils/api_services.dart';
import 'package:hously_flutter/widgets/screens/ai/ai_page.dart';
import 'package:hously_flutter/widgets/side_menu/side_menu_manager.dart';
import 'package:hously_flutter/widgets/side_menu/slide_rotate_menu.dart';

class SidebarNetworkMonitoring extends ConsumerWidget {
  final GlobalKey<SideMenuState> sideMenuKey;
  const SidebarNetworkMonitoring({super.key, required this.sideMenuKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(userProvider);
    final isUserLoggedIn = ApiServices.isUserLoggedIn();
    final navigationHistory = ref.watch(navigationHistoryProvider);
    final currentRoute =
        navigationHistory.isNotEmpty ? navigationHistory.last : '/homepage';

    return InkWell(
        onTap:(){  
        SideMenuManager.toggleMenu(
            ref: ref, menuKey: sideMenuKey);
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
              BuildIconButton(
                icon: Icons.more_horiz,
                label: '',
                onPressed: () {
                  SideMenuManager.toggleMenu(ref: ref, menuKey: sideMenuKey);
                },
                currentRoute: currentRoute,
              ),
              const SizedBox(height: 5.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (_, __, ___) => const AiPage(),
                      transitionsBuilder: (_, anim, __, child) {
                        return FadeTransition(opacity: anim, child: child);
                      },
                    ),
                  );
                },
                style: elevatedButtonStyleRounded10,
                child: Text(
                  'AI',
                  style: AppTextStyles.interLight.copyWith(
                    fontSize: 18,
                    color: currentRoute == '/ai'
                        ? AppColors.light
                        : AppColors.light50,
                  ),
                ),
              ),
              const SizedBox(height: 35),
            ],
          ),
          Column(
            children: [
              BuildIconButton(
                icon: Icons.connected_tv_outlined,
                label: 'Home',
                onPressed: () {
                  ref
                      .read(navigationHistoryProvider.notifier)
                      .addPage(Routes.homeNetworkMonitoring);
                  ref
                      .read(navigationService)
                      .pushNamedReplacementScreen(Routes.homeNetworkMonitoring);
                },
                currentRoute: currentRoute,
              ),
              const SizedBox(height: 10.0),
              BuildIconButton(
                icon: Icons.save,
                label: 'Save',
                onPressed: () {
                  ref
                      .read(navigationHistoryProvider.notifier)
                      .addPage(Routes.saveNetworkMonitoring);
                  ref
                      .read(navigationService)
                      .pushNamedReplacementScreen(Routes.saveNetworkMonitoring);
                },
                currentRoute: currentRoute,
              ),
              const SizedBox(height: 10.0),
              BuildIconButton(
                icon: Icons.search,
                label: 'Szukaj'.tr,
                onPressed: () {
                  ref
                      .read(navigationHistoryProvider.notifier)
                      .addPage(Routes.networkMonitoring);
                  ref
                      .read(navigationService)
                      .pushNamedReplacementScreen(Routes.networkMonitoring);
                },
                currentRoute: currentRoute,
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
                        ref.read(navigationService).pushNamedScreen(
                              Routes.chatWrapper,
                            );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Transform.rotate(
                            angle: -30 * 3.141592653589793238 / 180,
                            child: IconButton(
                              icon: SvgPicture.asset(AppIcons.send,
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
                      icon: Icons.favorite_border,
                      label: '',
                      onPressed: () => ref
                          .read(navigationService)
                          .pushNamedReplacementScreen(Routes.fav),
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
      ),),
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
              style: AppTextStyles.interRegular.copyWith(
                color: isActive
                    ? Theme.of(context).iconTheme.color
                    : Theme.of(context).iconTheme.color!.withOpacity(0.5),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _getPageRouteForIcon(IconData icon, WidgetRef ref) {
    switch (icon) {
      case Icons.connected_tv_outlined:
        return '/home-network-monitoring';
      case Icons.save:
        return '/save-network-monitoring';
      case Icons.search:
        return '/network-monitoring';
      default:
        return '';
    }
  }
}
