import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/screens/filters/filters_page.dart';
import 'package:hously_flutter/screens/pop_pages/sort_pop_mobile_page.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/data/design/button_style.dart';
import 'package:hously_flutter/data/design/design.dart';
import 'package:hously_flutter/widgets/filter_monitoring_widget.dart';




final verticalBottomBarVisibilityProvider = StateProvider<bool>((ref) => true);

class NetworkMonitoringFeedBarVerticalMobile extends ConsumerWidget {
  final WidgetRef ref;

  const NetworkMonitoringFeedBarVerticalMobile({
    super.key,
    required this.ref,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    final iconColor = Theme.of(context).iconTheme.color;
    final currentthememode = ref.watch(themeProvider);

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
            icon: Icons.search,
            label: 'Filtruj'.tr,
            onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.black,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(16)),
                          ),
                          isScrollControlled: true,
                          builder: (context) {
                            return FractionallySizedBox(
                              heightFactor: 5 / 6,
                              widthFactor: MediaQuery.of(context).size.width,
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                child: const FilterMonitoringWidget(),
                              ),
                            );
                          },
                        );
                      },
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
              icon: Icons.sort,
              label: 'Sortuj'.tr,
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
              icon: Icons.sort,
              label: 'Sortuj'.tr,
              onTap: () => 
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (_, __, ___) => const SortPopMobilePage(), // change to production
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
            tag: 'searchBar',
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
