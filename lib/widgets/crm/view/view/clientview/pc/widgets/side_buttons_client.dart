import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/const/colors.dart';
import 'package:hously_flutter/const/route_constant.dart';

import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';

class SideButtonsClient extends StatelessWidget {
  final WidgetRef ref;
  final bool isMapVisible;

  const SideButtonsClient({
    super.key,
    required this.ref,
    required this.isMapVisible,
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
              const SizedBox(height: 10),
              SideButtonsDashboard(
                  onPressed: () {
                    ref
                        .read(navigationService)
                        .pushNamedScreen(Routes.proAddClient);
                  },
                  icon: Icons.map,
                  text: 'Mapa'.tr),
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

    final clientTilecolor = theme.clientTilecolor;
    return ElevatedButton(
      style: buttonSideDashboard.copyWith(
          backgroundColor: WidgetStatePropertyAll(colorscheme ==
                  FlexScheme.blackWhite
              ? Theme.of(context).colorScheme.onSecondary.withOpacity(0.5)
              : clientTilecolor)), // Użycie przekazanego lub domyślnego stylu
      onPressed: onPressed,
      child: Column(
        children: [
          Icon(
            icon,
            color: colorscheme == FlexScheme.blackWhite
                ? theme.whitewhiteblack
                : theme.whitewhiteblack,
            size: 25,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(text,
              style: AppTextStyles.interMedium10.copyWith(
                color:  colorscheme == FlexScheme.blackWhite
                ? theme.whitewhiteblack
                : theme.whitewhiteblack,
              ))
        ],
      ),
    );
  }
}
