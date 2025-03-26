import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/const/route_constant.dart';
import 'package:hously_flutter/screens/filters/filters_page.dart';
import 'package:hously_flutter/screens/filters/filters_page_pop_mobile.dart';
import 'package:hously_flutter/screens/pop_pages/mobile_pop_appbar_page.dart';
import 'package:hously_flutter/screens/pop_pages/sort_pop_mobile_page.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/const/backgroundgradient.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/state_managers/services/navigation_service.dart';
import 'dart:ui' as ui;
import 'package:hously_flutter/theme/apptheme.dart';





final verticalBottomBarVisibilityProvider = StateProvider<bool>((ref) => true);

class FeedBarVerticalMobile extends ConsumerWidget {
  final WidgetRef ref;

  const FeedBarVerticalMobile({
    super.key,
    required this.ref,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    final iconColor = Theme.of(context).iconTheme.color;
    final currentthememode = ref.watch(themeProvider);
    final tag = 'searchBar-${UniqueKey().toString()}';

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      Container(
      width: 60,
      height:60,
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
          child: BuildNavigationOption(
              tag:  tag,
            icon: Icons.search,
            label: 'Filtruj'.tr,
            onTap: () => 
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (_, __, ___) => FiltersPage(tag: tag),
                        transitionsBuilder: (_, anim, __, child) {
                          return FadeTransition(opacity: anim, child: child);
                        },
                      ),
                    ),
            heroValue: '3',
          ),
        ),
        const SizedBox(height: 2),
        Container(
        width: 60,
        height:60,
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
            child: BuildNavigationOption(
              tag:  tag,
              icon: Icons.sort,
              label: 'view'.tr,
              onTap: () => 
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (_, __, ___) => const SortPopMobilePage(),
                        transitionsBuilder: (_, anim, __, child) {
                          return FadeTransition(opacity: anim, child: child);
                        },
                      ),
                    ),
              heroValue: '4',
            ),
          ),
          
        const SizedBox(height: 2),
        Container(
        width: 60,
        height:60,
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
            child: BuildNavigationOption(
              tag:  tag,
              heroValue: "sortPopFeedBarVertical",
              icon: Icons.view_comfortable_rounded,
              label: 'Sortuj'.tr,
              onTap: () => 
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (_, __, ___) => const MobilePopAppBarPage(),
                        transitionsBuilder: (_, anim, __, child) {
                          return FadeTransition(opacity: anim, child: child);
                        },
                      ),
                    ),
            ),
          ),
          
               
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
    required this.heroValue,
    required this.tag,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final String heroValue;
  final tag;

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
            tag: tag, // need to be change both sides of hero need the same tag 
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
