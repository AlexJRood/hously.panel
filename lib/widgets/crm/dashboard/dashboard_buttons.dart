import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/routes/navigation_history_provider.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/widgets/crm/finance/features/expenses/add_expenses.dart';

class DashboardSideButtons extends StatelessWidget {
  final WidgetRef ref;

  const DashboardSideButtons({
    super.key,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SideButtonsDashboard(
                onPressed: () {
                  Navigator.pushNamed(context, '/pro/finance/costs/add');
                },
                icon: Icons.search,
                text: 'Szukaj'.tr),
            const SizedBox(height: 10),
            SideButtonsDashboard(
                onPressed: () {
                  Navigator.pushNamed(context, '/pro/finance/costs/add');
                },
                icon: Icons.sort,
                text: 'Sortuj'.tr),
            const SizedBox(height: 10),
            SideButtonsDashboard(
                onPressed: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (_, __, ___) => const CrmAddExpensesPopPc(),
                        transitionsBuilder: (_, anim, __, child) {
                          return FadeTransition(opacity: anim, child: child);
                        },
                      ),
                    );
                },
                icon: Icons.money_off,
                text: 'Dodaj koszt'.tr),
            const SizedBox(height: 10),
            SideButtonsDashboard(
                onPressed: () {
                  Navigator.pushNamed(context, '/pro/finance/revenue/add');
                },
                icon: Icons.monetization_on_outlined,
                text: 'Dodaj'.tr),
            const SizedBox(
              height: 10,
            ),
            SideButtonsDashboard(
                onPressed: () {},
                icon: Icons.view_carousel_sharp,
                text: 'Widok'.tr),
            const SizedBox(
              height: 10,
            ),
            SideButtonsDashboard(
                onPressed: () {
                  ref.read(navigationHistoryProvider.notifier)
                      .addPage(Routes.addClientForm);
                  ref.read(navigationService)
                      .pushNamedScreen(Routes.addClientFormDashboard);
                },
                icon: Icons.add_box_outlined,
                text: 'Dodaj'.tr),
          ],
        ),
      ),
    );
  }
}

class SideButtonsDashboard extends ConsumerWidget {
  final VoidCallback onPressed;
  final IconData icon;

  final String text;

  const SideButtonsDashboard({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    final colorscheme = ref.watch(colorSchemeProvider);
    return ElevatedButton(
      style: buttonSideDashboard.copyWith(
          backgroundColor: WidgetStatePropertyAll(
              colorscheme == FlexScheme.blackWhite
                  ? Theme.of(context).colorScheme.onSecondary.withOpacity(0.5)
                  : theme.textFieldColor.withOpacity(
                      0.5))), // Użycie przekazanego lub domyślnego stylu
      onPressed: onPressed,
      child: Column(
        children: [
          Icon(
            icon,
            color: colorscheme == FlexScheme.blackWhite
                ? theme.textFieldColor
                : Theme.of(context).iconTheme.color,
            size: 25,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(text,
              style: AppTextStyles.interMedium10.copyWith(
                color: colorscheme == FlexScheme.blackWhite
                    ? theme.textFieldColor
                    : Theme.of(context).iconTheme.color,
              ))
        ],
      ),
    );
  }
}
