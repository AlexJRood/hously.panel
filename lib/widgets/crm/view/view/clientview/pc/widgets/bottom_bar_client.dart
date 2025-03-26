import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/screens/chat/new_chat/chat_page.dart';
import 'package:hously_flutter/screens/pop_pages/view_pop_changer_page.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';

import '../../../../../../../routes/navigation_history_provider.dart';


class SidebarClientAgentCrm extends ConsumerWidget {
  final Function(String) onTabSelected;
  final String activeSection;
  const SidebarClientAgentCrm({
    super.key,
    required this.onTabSelected,
    required this.activeSection,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRoute = activeSection;

    return Padding(
      padding: const EdgeInsets.only(
        left: 15.0,
        right: 15,
      ),
      child: Container(
        width: 70.0,
        height: MediaQuery.of(context).size.height * 0.88,
        padding: const EdgeInsets.only(top: 15, bottom: 15.0),
        decoration: BoxDecoration(
          gradient:  CustomBackgroundGradients.customcrmSideMenu(context, ref),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                BuildIconButton(
                  icon: Icons.home_outlined,
                  label: 'Dashboard'.tr,
                  onPressed: () => onTabSelected('Dashboard'),
                  currentRoute: currentRoute,
                ),
                const SizedBox(height: 15.0),
                BuildIconButton(
                  icon: Icons.pie_chart,
                  label: 'Transakcje'.tr,
                  onPressed: () => onTabSelected('Transakcje'),
                  currentRoute: currentRoute,
                ),
                const SizedBox(height: 15.0),
                BuildIconButton(
                  icon: Icons.search,
                  label: 'Wyszukiwania'.tr,
                  onPressed: () => onTabSelected('Wyszukiwania'),
                  currentRoute: currentRoute,
                ),
                const SizedBox(height: 15.0),
                BuildIconButton(
                  icon: Icons.document_scanner_outlined,
                  label: 'Docs',
                  onPressed: () => onTabSelected('Docs'),
                  currentRoute: currentRoute,
                ),
                const SizedBox(height: 15.0),
                BuildIconButton(
                  icon: Icons.apartment,
                  label: 'landlord',
                  onPressed: () => onTabSelected('docs'),
                  currentRoute: currentRoute,
                ),
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                  style: elevatedButtonStyleRounded10,
                  onPressed: () {
                    ref.read(navigationHistoryProvider.notifier)
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
                        child: IconButton(icon:Icon(Icons.send_rounded,
                            color: Theme.of(context).iconTheme.color,
                            size: 25.0),
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
                const SizedBox(height: 5),
              ],
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
        return 'dashboard';
      case Icons.pie_chart:
        return 'Transakcje';
      case Icons.search:
        return selectedFeedView; // Adjust this to the correct route
      case Icons.calendar_month:
        return 'docs';
      case Icons.task_alt_rounded:
        return 'todo';
      case Icons.book:
        return '/pro/clients';
      case Icons.person:
        return '/profile';
      default:
        return '';
    }
  }
}
