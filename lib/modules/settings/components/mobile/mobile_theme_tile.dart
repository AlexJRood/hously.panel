import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hously_flutter/theme/design/design.dart';
import 'package:hously_flutter/modules/settings/components/pro_theme_tile.dart';

import 'package:hously_flutter/modules/settings/components/settings_button.dart';
import 'package:hously_flutter/theme/apptheme.dart';
import 'package:hously_flutter/theme/coloschemepicker.dart';

class ThemetileMobile extends ConsumerWidget {
  final ThemeMode currentheme;
  final String title;
  final bool isSelected;
  final ThemeMode groupValue; // Added groupValue here
  final VoidCallback onTap;
  final Color containercolor;
  final Color secondcolor;
  final Gradient gradient;
  const ThemetileMobile({
    super.key,
    required this.gradient,
    required this.currentheme,
    required this.containercolor,
    required this.secondcolor,
    required this.title,
    required this.isSelected,
    required this.groupValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    final proTheme = ref.watch(isDefaultDarkSystemProvider);
    final colorscheme = ref.watch(colorSchemeProvider);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected
                  ? proTheme
                      ? theme.bordercolor
                      : colorscheme == FlexScheme.blackWhite
                          ? Colors.lightBlueAccent
                          : Theme.of(context).colorScheme.secondary
                  : theme.mobileTextcolor,
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Radio<ThemeMode>(
              value: currentheme,
              groupValue: groupValue,
              activeColor: theme.mobileTextcolor,
              onChanged: (_) => onTap(),
            ),
            const SizedBox(width: 5),
            Expanded(
              // Make sure the title does not overflow
              child: Text(
                title,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: theme.mobileTextcolor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomProThemeMobile extends ConsumerWidget {
  const CustomProThemeMobile({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final theme = ref.watch(themeColorsProvider);
    final customtheme = ref.watch(isDefaultDarkSystemProvider);
    final currentthememode = ref.watch(themeProvider);
    final colorscheme = ref.watch(colorSchemeProvider);
    final proTheme = ref.watch(isDefaultDarkSystemProvider);
    return Row(
      children: [
        Expanded(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 550,
              maxHeight: 550, // Avoid fixed heights
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: proTheme
                      ? theme.bordercolor
                      : colorscheme == FlexScheme.blackWhite
                          ? Theme.of(context).colorScheme.onSecondary
                          : Theme.of(context).colorScheme.secondary,
                ),
                borderRadius: BorderRadius.circular(12),
                color: Colors.transparent,
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Kolor niestandardowy'.tr,
                              style: TextStyle(
                                  color: theme.mobileTextcolor, fontSize: 20),
                            ),
                            const SizedBox(height: 13),
                            Text(
                              'Uzyskaj dostęp do zaawansowanej personalizacji w wersji Pro'
                                  .tr,
                              style: TextStyle(
                                fontSize: 12,
                                color: theme.mobileTextcolor.withOpacity(0.9),
                              ),
                            ),
                            const SizedBox(height: 9),
                            ThemetileMobile(
                              gradient:
                                  BackgroundGradients.backgroundGradientRight,
                              currentheme: currentthememode!,
                              containercolor: customtheme
                                  ? Colors.white
                                  : Theme.of(context).primaryColor,
                              secondcolor: customtheme
                                  ? Colors.lightBlueAccent
                                  : colorscheme == FlexScheme.blackWhite
                                      ? Theme.of(context)
                                          .colorScheme
                                          .onSecondary
                                      : Theme.of(context)
                                          .iconTheme
                                          .color!
                                          .withOpacity(0.8),
                              title: 'Motyw niestandardowy'.tr,
                              isSelected: customtheme ? true : false,
                              groupValue: currentthememode,
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.transparent,
                    ),
                    height: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Wybierz schemat kolorów".tr,
                            style: TextStyle(color: theme.mobileTextcolor)),
                        const SizedBox(height: 15),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                color: theme.fillColor,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: proTheme
                                        ? theme.bordercolor
                                        : colorscheme == FlexScheme.blackWhite
                                            ? Theme.of(context)
                                                .colorScheme
                                                .onSecondary
                                            : Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                    width: 2)),
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4, // Number of items per row
                                crossAxisSpacing: 10, // Space between columns
                                mainAxisSpacing: 10, // Space between rows
                                childAspectRatio:
                                    1.55, // Aspect ratio of each item
                              ),
                              itemCount: FlexScheme.values.length,
                              itemBuilder: (context, index) {
                                // Predefined color schemes
                                final scheme = FlexScheme.values[index];
                                final colors =
                                    currentthememode == ThemeMode.system ||
                                            currentthememode == ThemeMode.light
                                        ? FlexColor.schemes[scheme]?.light
                                        : FlexColor.schemes[scheme]?.dark;

                                if (colors == null) {
                                  // Log or handle the null case for debugging
                                  debugPrint(
                                      'Colors for scheme ${scheme.name} are null');
                                }

                                return GestureDetector(
                                  onTap: () async {
                                    ref.read(themeProvider.notifier).state =
                                        (currentthememode == ThemeMode.system ||
                                                currentthememode ==
                                                    ThemeMode.light)
                                            ? ThemeMode.light
                                            : ThemeMode.dark;
                                    // Update the color scheme provider
                                    await savecurrenttheme((ref
                                        .read(themeProvider.notifier)
                                        .state = (currentthememode ==
                                                ThemeMode.system ||
                                            currentthememode == ThemeMode.light)
                                        ? ThemeMode.light
                                        : ThemeMode.dark));
                                    ref
                                        .read(colorSchemeProvider.notifier)
                                        .state = scheme;
                                    await saveColorScheme(
                                        scheme, currentthememode);
                                    // Update the theme mode provider
                                  },
                                  child: ColorSchemeTile(
                                    containerColor:
                                        colors?.primary ?? Colors.blueAccent,
                                    secondColor: Theme.of(context)
                                            .iconTheme
                                            .color
                                            ?.withOpacity(0.8) ??
                                        Colors.black.withOpacity(0.8),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: Settingsbutton(
                            isborder: colorscheme == FlexScheme.blackWhite,
                            icon: Icons.auto_awesome,
                            hasIcon: true,
                            isPc: false,
                            buttonheight: 48,
                            onTap: () {},
                            text: "Upgrade to pro"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
