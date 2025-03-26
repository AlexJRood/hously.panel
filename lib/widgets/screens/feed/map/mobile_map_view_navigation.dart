import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';

class NavigationBarMapMobile extends ConsumerWidget {
  const NavigationBarMapMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BuildNavigationOption(
          tag: 'FilterMobile',
          icon: Icons.search,
          label: 'Filtruj'.tr,
          onTap: () =>
              ref.read(navigationService).pushNamedScreen(Routes.filters),
        ),
        const SizedBox(height: 15),
        BuildNavigationOption(
          tag: 'SortMobile',
          icon: Icons.sort,
          label: 'Sortuj'.tr,
          onTap: () =>
              ref.read(navigationService).pushNamedScreen(Routes.sortPopMobile),
        ),
      ],
    );
  }
}

class BuildNavigationOption extends StatelessWidget {
  const BuildNavigationOption({
    super.key,
    required this.tag,
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final String tag;
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: elevatedButtonStyleRounded10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Hero(
            tag: tag,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon, color: AppColors.dark, size: 30),
                const SizedBox(height: 2),
                Text(label,
                    style: AppTextStyles.interMedium
                        .copyWith(fontSize: 10, color: AppColors.dark)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
