import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:hously_flutter/const/route_constant.dart';

import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'package:hously_flutter/widgets/crm/clients/sort_by.dart';
import 'package:hously_flutter/widgets/invoice_pdf_generator/model/invoise_model.dart';
import 'package:hously_flutter/widgets/invoice_pdf_generator/preview/preview_invoice.dart';

class ClientsCrmSideButtons extends StatelessWidget {
  final WidgetRef ref;

  const ClientsCrmSideButtons({
    super.key,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IntrinsicWidth(
        child: SizedBox(
          width: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SideButtonsDashboard(
                  onPressed: () {
                    showSortPopup(context, ref);
                  },
                  icon: Icons.sort,
                  text: 'Sortuj'.tr),
              const SizedBox(height: 10),
              SideButtonsDashboard(
                  onPressed: () {
                    ref
                        .read(navigationService)
                        .pushNamedScreen(Routes.proAddClient);
                  },
                  icon: Icons.view_carousel_sharp,
                  text: 'Nowy klient'.tr),
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
                  onPressed: () {
                    Navigator.pushNamed(
                        context, '/pro/finance/revenue/add/AddViewerForm');
                  },
                  icon: Icons.add_box_outlined,
                  text: 'Dodaj'.tr),
              const SizedBox(
                height: 10,
              ),
              SideButtonsDashboard(
                  onPressed: () {
                    toggleBoolean(ref);
                  },
                  icon: Icons.add_box_outlined,
                  text: 'Dodaj'.tr),
            ],
          ),
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

class FinanceCrmSideButtons extends StatelessWidget {
  final WidgetRef ref;

  const FinanceCrmSideButtons({
    super.key,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IntrinsicWidth(
        child: SizedBox(
          width: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SideButtonsDashboard(
                  onPressed: () {
                    ref.read(navigationService).pushNamedScreen(
                          Routes.viewPopChanger,
                        );
                  },
                  icon: Icons.view_carousel_sharp,
                  text: 'widok'.tr),
              const SizedBox(height: 10),
              SideButtonsDashboard(
                  onPressed: () {
                    ref
                        .read(navigationService)
                        .pushNamedScreen(Routes.proPlans);
                  },
                  icon: Icons.monetization_on_outlined,
                  text: 'Plany finansowe'.tr),
              const SizedBox(height: 10),
              SideButtonsDashboard(
                  onPressed: () {
                    ref.read(navigationService).pushNamedScreen(
                          Routes.statusPopRevenue,
                        );
                  },
                  icon: Icons.edit,
                  text: 'Edytuj statusy'.tr),
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
                  onPressed: () {
                    Navigator.pushNamed(
                        context, '/pro/finance/revenue/add/AddViewerForm');
                  },
                  icon: Icons.add_box_outlined,
                  text: 'Dodaj'.tr),
            ],
          ),
        ),
      ),
    );
  }
}
