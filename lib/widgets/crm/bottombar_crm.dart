import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/routes/navigation_history_provider.dart';
import 'package:hously_flutter/state_managers/data/user_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';

class BottombarCrm extends ConsumerWidget {
  const BottombarCrm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsyncValue = ref.watch(userProvider);
    final isUserLoggedIn = ref.watch(authStateProvider); // Zastąp odpowiednią logiką sprawdzania statusu logowania
    final navigationHistory = ref.watch(navigationHistoryProvider);
    final currentRoute =
        navigationHistory.isNotEmpty ? navigationHistory.last : '/homepage';

    return Container(
      height: 60.0,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 8, bottom: 2.0),
      decoration: BoxDecoration(
          gradient: CustomBackgroundGradients.customcrmSideMenu(context, ref)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //dark and white mode
          const SizedBox(width: 10),
          BuildIconButton(
            icon: Icons.home,
            label: 'Home',
            onPressed: () => ref
                .read(navigationService)
                .pushNamedScreen(Routes.proDashboard),
            currentRoute: currentRoute,
          ),
          const SizedBox(height: 15.0),
          BuildIconButton(
            icon: Icons.pie_chart,
            label: 'Finanse',
            onPressed: () => ref
                .read(navigationService)
                .pushNamedScreen(Routes.proDraggable),
            currentRoute: currentRoute,
          ),
          const SizedBox(height: 15.0),
          BuildIconButton(
            icon: Icons.calendar_month,
            label: 'Kalendarz'.tr,
            onPressed: () => ref
                .read(navigationService)
                .pushNamedScreen(Routes.proCalendar),
            currentRoute: currentRoute,
          ),
          const SizedBox(height: 15.0),
          BuildIconButton(
            icon: Icons.task_alt_rounded,
            label: 'To do',
            onPressed: () => ref
                .read(navigationService)
                .pushNamedScreen(Routes.proTodo),
            currentRoute: currentRoute,
          ),
          const SizedBox(height: 15.0),
          BuildIconButton(
            icon: Icons.book,
            label: 'Klienci'.tr,
            onPressed: () => ref
                .read(navigationService)
                .pushNamedScreen(Routes.proClients),
            currentRoute: currentRoute,
          ),
          const SizedBox(width: 10),
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
        ? (isActive ? Colors.white : Colors.grey.shade100)
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
        return '/pro/dashboard';
      case Icons.add_box_outlined:
        return '/pro/finance/draggable';
      case Icons.search:
        return '/pro/calendar'; // Adjust this to the correct route
      case Icons.favorite_border:
        return '/pro/todo';
      case Icons.person:
        return '/pro/clients';
      default:
        return '';
    }
  }
}
