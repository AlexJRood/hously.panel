import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/screens/filters/filters_page.dart';
import 'package:hously_flutter/screens/pop_pages/sort_pop_mobile_page.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'dart:ui' as ui;




final bottomBarVisibilityProvider = StateProvider<bool>((ref) => true);

class FeedBarMobile extends ConsumerWidget {
  final double screenPadding;
  final WidgetRef ref;

  const FeedBarMobile({
    super.key,
    required this.screenPadding,
    required this.ref,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentthememode = ref.watch(themeProvider);
   
    return Container(
      height: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],),
      child: ClipRRect(
        child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 50, sigmaY: 50),
            child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: currentthememode == ThemeMode.system ||
                        currentthememode == ThemeMode.light
                    ? Colors.black.withOpacity(0.1)
                    : Colors.white.withOpacity(0.1)),
            child: const NavigationBarContent(),
            ),),),
    );
  }
}

class NavigationBarContent extends ConsumerWidget {
  const NavigationBarContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final iconColor = Theme.of(context).iconTheme.color;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 35),
        const Spacer(flex: 3),
        BuildNavigationOption(
          icon: Icons.search,
          label: 'Filtruj'.tr,
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (_, __, ___) =>
                  const FiltersPage(),
                  transitionsBuilder: (_, anim, __, child) {
                    return FadeTransition(opacity: anim, child: child);
                  },
                ),
              );
            }
        ),
        const SizedBox(width: 5),
        BuildNavigationOption(
          icon: Icons.sort,
          label: 'Sortuj'.tr,
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                opaque: false,
                pageBuilder: (_, __, ___) =>
                    const SortPopMobilePage(),
                transitionsBuilder: (_, anim, __, child) {
                  return FadeTransition(opacity: anim, child: child);
                },
              ),
            );
          }
        ),
        const SizedBox(width: 5),
        BuildNavigationOption(
          icon: Icons.map,
          label: 'Mapa'.tr,
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (_, __, ___) =>
                  const SortPopMobilePage(),
                  transitionsBuilder: (_, anim, __, child) {
                    return FadeTransition(opacity: anim, child: child);
                  },
                ),
              );
            }
        ),
        // const Spacer(flex: 2),
        // _buildNavigationOption(
        //   context,
        //   icon: Icons.manage_search_sharp,
        //   label: 'filtruj',
        //   onTap: () => _navigateToPage(context, ResponsiveFiltersPage()),
        // ),
        // const Spacer(flex: 2),
        // _buildNavigationOption(
        //   context,
        //   icon: Icons.map_rounded,
        //   label: 'mapa',
        //   onTap: () => _navigateToPage(context, ResponsiveFiltersPage()),
        // ),
        const Spacer(flex: 3),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform.rotate(
              angle: ref.watch(bottomBarVisibilityProvider)
                  ? 270 * 3.14159 / 180
                  : 90 * 3.14159 / 180,
              child: IconButton(
                onPressed: () {
                  ref.read(bottomBarVisibilityProvider.notifier).state =
                      !ref.read(bottomBarVisibilityProvider);
                },
                icon: Icon(Icons.arrow_back_ios_new_rounded,
                    size: 25, color: iconColor),
              ),
            ),
          ],
        ),
        const SizedBox(width: 10),
      ],
    );
  }
}

class BuildNavigationOption extends ConsumerWidget {
  const BuildNavigationOption({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, ref) {
    final themecolors = ref.watch(themeColorsProvider);
    final textColor = themecolors.themeTextColor;
    final iconColor = Theme.of(context).iconTheme.color;

    return ElevatedButton(
      onPressed: onTap,
      style: elevatedButtonStyleRounded10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Hero(
            tag: 'searchBar-6',
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon, color: iconColor, size: 25),
                const SizedBox(height: 2),
                Text(label,
                    style: AppTextStyles.interMedium
                        .copyWith(fontSize: 8, color: textColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
